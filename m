Return-Path: <andrew.murray@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 277C62C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 03:41:02 +1100 (EST)
Date: Wed, 12 Dec 2012 16:37:50 +0000
From: Andrew Murray <Andrew.Murray@arm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20121212163749.GA17371@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Michal Simek <monstr@monstr.eu>,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Liviu Dudau <liviu.dudau@arm.com>, Rob Herring <rob.herring@calxeda.com>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DT bindings for PCI host bridges often use the ranges property to describe
memory and IO ranges - this binding tends to be the same across architectur=
es
yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicate
functionality provided by drivers/of/address.c.

This patch provides a common iterator-based parser for the ranges property,=
 it
is hoped this will reduce DT representation differences between architectur=
es
and that architectures will migrate in part to this new parser.

It is also hoped (and the motativation for the patch) that this patch will
reduce duplication of code when writing host bridge drivers that are suppor=
ted
by multiple architectures.

This patch provides struct resources from a device tree node, e.g.:

=09u32 *last =3D NULL;
=09struct resource res;
=09while ((last =3D of_pci_process_ranges(np, res, last))) {
=09=09//do something with res
=09}

Platforms with quirks can then do what they like with the resource or migra=
te
common quirk handling to the parser. In an ideal world drivers can just req=
uest
the obtained resources and pass them on (e.g. pci_add_resource_offset).

Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/of/address.c       |   53 ++++++++++++++++++++++++++++++++++++++++=
+++-
 include/linux/of_address.h |    7 +++++
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 7e262a6..03bfe61 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -219,6 +219,57 @@ int of_pci_address_to_resource(struct device_node *dev=
, int bar,
 =09return __of_address_to_resource(dev, addrp, size, flags, NULL, r);
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
+
+const __be32 *of_pci_process_ranges(struct device_node *node,
+=09=09=09=09    struct resource *res, const __be32 *from)
+{
+=09const __be32 *start, *end;
+=09int na, ns, np, pna;
+=09int rlen;
+=09struct of_bus *bus;
+=09WARN_ON(!res);
+
+=09bus =3D of_match_bus(node);
+=09bus->count_cells(node, &na, &ns);
+=09if (!OF_CHECK_COUNTS(na, ns)) {
+=09=09pr_err("Bad cell count for %s\n", node->full_name);
+=09=09return NULL;
+=09}
+
+=09pna =3D of_n_addr_cells(node);
+=09np =3D pna + na + ns;
+
+=09start =3D of_get_property(node, "ranges", &rlen);
+=09if (start =3D=3D NULL)
+=09=09return NULL;
+
+=09end =3D start + rlen;
+
+=09if (!from)
+=09=09from =3D start;
+
+=09while (from + np <=3D end) {
+=09=09u64 cpu_addr, size;
+
+=09=09cpu_addr =3D of_translate_address(node, from + na);
+=09=09size =3D of_read_number(from + na + pna, ns);
+=09=09res->flags =3D bus->get_flags(from);
+=09=09from +=3D np;
+
+=09=09if (cpu_addr =3D=3D OF_BAD_ADDR || size =3D=3D 0)
+=09=09=09continue;
+
+=09=09res->name =3D node->full_name;
+=09=09res->start =3D cpu_addr;
+=09=09res->end =3D res->start + size - 1;
+=09=09res->parent =3D res->child =3D res->sibling =3D NULL;
+=09=09return from;
+=09}
+
+=09return NULL;
+}
+EXPORT_SYMBOL_GPL(of_pci_process_ranges);
+
 #endif /* CONFIG_PCI */
=20
 /*
@@ -421,7 +472,7 @@ u64 __of_translate_address(struct device_node *dev, con=
st __be32 *in_addr,
 =09=09goto bail;
 =09bus =3D of_match_bus(parent);
=20
-=09/* Cound address cells & copy address locally */
+=09/* Count address cells & copy address locally */
 =09bus->count_cells(dev, &na, &ns);
 =09if (!OF_CHECK_COUNTS(na, ns)) {
 =09=09printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 01b925a..4582b20 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,8 @@ static inline unsigned long pci_address_to_pio(phys_addr_=
t addr) { return -1; }
 #define pci_address_to_pio pci_address_to_pio
 #endif
=20
+const __be32 *of_pci_process_ranges(struct device_node *node,
+=09=09=09=09    struct resource *res, const __be32 *from);
 #else /* CONFIG_OF_ADDRESS */
 static inline int of_address_to_resource(struct device_node *dev, int inde=
x,
 =09=09=09=09=09 struct resource *r)
@@ -48,6 +50,11 @@ static inline const u32 *of_get_address(struct device_no=
de *dev, int index,
 {
 =09return NULL;
 }
+const __be32 *of_pci_process_ranges(struct device_node *node,
+=09=09=09=09    struct resource *res, const __be32 *from)
+{
+=09return NULL;
+}
 #endif /* CONFIG_OF_ADDRESS */
=20
=20
--=20
1.7.0.4

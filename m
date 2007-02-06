Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts20-srv.bellnexxia.net (tomts20.bellnexxia.net
	[209.226.175.74]) by ozlabs.org (Postfix) with ESMTP id 65FDDDDEDB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 12:03:36 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts20-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070206010332.XJTQ24907.tomts20-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 20:03:32 -0500
Date: Mon, 5 Feb 2007 20:03:31 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Powerpc move of_irq_to_resource from prom.h to prom_parse.c
Message-ID: <20070206010331.GA22667@Krystal>
References: <20070205142905.GA31392@Krystal>
	<1170706469.2620.124.camel@localhost.localdomain>
	<20070205205636.GA14589@Krystal>
	<17863.52596.791276.129355@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <17863.52596.791276.129355@cargo.ozlabs.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc move of_irq_to_resource from prom.h to prom_parse.c

Sorry for the lack of information, it got cut in the previous messages.
Let's start all over again :

In the powerpc architecture, of_irq_to_resource, currently sitting in
prom.h, needs irq_of_parse_and_map and NO_IRQ from asm-powerpc/irq.h.
The solution suggested by Benjamin Herrenschmidt is to move it to
arch/powerpc/kernel/prom_parse.c.

It applies on 2.6.20.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -1003,3 +1003,18 @@ int of_irq_map_one(struct device_node *device, int i=
ndex, struct of_irq *out_irq
 	return res;
 }
 EXPORT_SYMBOL_GPL(of_irq_map_one);
+
+int of_irq_to_resource(struct device_node *dev, int index, struct resource=
 *r)
+{
+	int irq =3D irq_of_parse_and_map(dev, index);
+
+	/* Only dereference the resource if both the
+	 * resource and the irq are valid. */
+	if (r && irq !=3D NO_IRQ) {
+		r->start =3D r->end =3D irq;
+		r->flags =3D IORESOURCE_IRQ;
+	}
+
+	return irq;
+}
+EXPORT_SYMBOL_GPL(of_irq_to_resource);
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -19,6 +19,7 @@
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
 #include <asm/atomic.h>
+#include <asm/irq.h>
=20
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
@@ -334,20 +335,8 @@ extern int of_irq_map_one(struct device_node *device, =
int index,
 struct pci_dev;
 extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
=20
-static inline int of_irq_to_resource(struct device_node *dev, int index, s=
truct resource *r)
-{
-	int irq =3D irq_of_parse_and_map(dev, index);
-
-	/* Only dereference the resource if both the
-	 * resource and the irq are valid. */
-	if (r && irq !=3D NO_IRQ) {
-		r->start =3D r->end =3D irq;
-		r->flags =3D IORESOURCE_IRQ;
-	}
-
-	return irq;
-}
-
+extern int of_irq_to_resource(struct device_node *dev, int index,
+			struct resource *r);
=20
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

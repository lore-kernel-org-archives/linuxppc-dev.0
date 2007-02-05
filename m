Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts10-srv.bellnexxia.net (tomts10.bellnexxia.net
	[209.226.175.54]) by ozlabs.org (Postfix) with ESMTP id B7E10DDE31
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 07:56:41 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts10-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070205205639.UXJD17401.tomts10-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 15:56:39 -0500
Date: Mon, 5 Feb 2007 15:56:36 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Missing include in include/asm-powerpc/prom.h
Message-ID: <20070205205636.GA14589@Krystal>
References: <20070205142905.GA31392@Krystal>
	<1170706469.2620.124.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1170706469.2620.124.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> On Mon, 2007-02-05 at 09:29 -0500, Mathieu Desnoyers wrote:
> > Missing include in include/asm-powerpc/prom.h
> >=20
> > include/asm-powerpc/prom.h needs to include asm/irq.h because it uses
> > irq_of_parse_and_map and NO_IRQ. It applies on 2.6.20.
>=20
> I'd rather not do that.... better to move of_irq_to_resource() to
> prom_parse.c=20
>=20

Thanks, this patch should apply on top of the previous patch in this thread.

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
@@ -335,20 +335,8 @@ extern int of_irq_map_one(struct device_node *device, =
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

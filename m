Return-Path: <krafft@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8631DDDF4A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 01:32:46 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3OFWefL048316
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 15:32:40 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3OFWev23592396
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 17:32:40 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3OFWdUo007940
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 17:32:40 +0200
Date: Tue, 24 Apr 2007 17:32:02 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: uninline of_iomap function
Message-ID: <20070424173202.15e5ce42@localhost>
In-Reply-To: <1177378533.14873.48.camel@localhost.localdomain>
References: <20070423193538.576702568@arndb.de>
	<20070423193913.119032752@arndb.de>
	<1177378533.14873.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_X.Oc+Y7.gA6.0UP_Qn55wkd;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_X.Oc+Y7.gA6.0UP_Qn55wkd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

From: Christian Krafft <krafft@de.ibm.com>
There is no big reason to have that function inlined.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux-2.6.21-rc4/arch/powerpc/kernel/prom_parse.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc4.orig/arch/powerpc/kernel/prom_parse.c
+++ linux-2.6.21-rc4/arch/powerpc/kernel/prom_parse.c
@@ -1042,3 +1042,15 @@ const void *of_get_mac_address(struct de
 }
 EXPORT_SYMBOL(of_get_mac_address);
=20
+void __iomem *of_iomap(struct device_node *np, int index)
+{
+	struct resource res;
+
+	if (of_address_to_resource(np, index, &res))
+		return NULL;
+
+	return ioremap(res.start, 1 + res.end - res.start);
+}
+EXPORT_SYMBOL(of_iomap);
+
+
Index: linux-2.6.21-rc4/include/asm-powerpc/prom.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.21-rc4.orig/include/asm-powerpc/prom.h
+++ linux-2.6.21-rc4/include/asm-powerpc/prom.h
@@ -19,7 +19,6 @@
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
 #include <asm/atomic.h>
-#include <asm/io.h>
=20
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
@@ -352,16 +351,14 @@ static inline int of_irq_to_resource(str
 	return irq;
 }
=20
-static inline void __iomem *of_iomap(struct device_node *np, int index)
-{
-	struct resource res;
-
-	if (of_address_to_resource(np, index, &res))
-		return NULL;
-
-	return ioremap(res.start, 1 + res.end - res.start);
-}
-
+/**
+ * of_iomap - Maps the memory mapped IO for a given device_node
+ * @device:	the device whose io range will be mapped
+ * @index:	index of the io range
+ *
+ * Returns a pointer to the mapped memory
+ */
+extern void __iomem *of_iomap(struct device_node *device, int index);
=20
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Johann Weihen
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_X.Oc+Y7.gA6.0UP_Qn55wkd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLiMS6rqK4qDx+dcRAhm8AJ464H/5VaoYIGXoHDQp/3SsKLPylwCfQviV
EpGjN3AF9+H55S8NYx9sHLs=
=lJYO
-----END PGP SIGNATURE-----

--Sig_X.Oc+Y7.gA6.0UP_Qn55wkd--

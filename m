Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2268167A2C
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Jan 2005 08:20:38 +1100 (EST)
Date: Sat, 22 Jan 2005 22:20:32 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: Guido Guenther <agx@sigxcpu.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Message-ID: <20050122212032.GA31025@Redstar.dorchain.net>
References: <20050119101448.GA1374@Redstar.dorchain.net>
	<20050120095546.GD5810@bogon.ms20.nix>
	<20050120105026.GG27077@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <20050120105026.GG27077@Redstar.dorchain.net>
Subject: [PATCH] nvram driver as module (was Re: nvram driver not possible
	as a module)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 20, 2005 at 11:50:26AM +0100, Joerg Dorchain wrote:
> > Does this help:
> [...]
>=20
> Most likely, if there wasn't a specific reason to use bootmem.
>=20
> I'll try tonight.

Well, it did not crash. The following does even work ;-)

Signed-off-by: Joerg Dorchain <joerg@dorchain.net>

--- ./include/asm-ppc/system.h.orig	2005-01-22 21:30:19.000000000 +0100
+++ ./include/asm-ppc/system.h	2005-01-22 21:28:48.335018120 +0100
@@ -69,7 +69,7 @@
 #define _set_L3CR(val)	do { } while(0)
 #endif
 extern void via_cuda_init(void);
-extern void pmac_nvram_init(void);
+extern int pmac_nvram_init(void);
 extern void read_rtc_time(void);
 extern void pmac_find_display(void);
 extern void giveup_fpu(struct task_struct *);
--- arch/ppc/platforms/pmac_nvram.c.orig	2005-01-22 20:46:21.000000000 +0100
+++ arch/ppc/platforms/pmac_nvram.c	2005-01-22 22:15:10.000000000 +0100
@@ -75,8 +75,8 @@
  * Read and write the non-volatile RAM on PowerMacs and CHRP machines.
  */
 static int nvram_naddrs;
-static volatile unsigned char *nvram_addr;
-static volatile unsigned char *nvram_data;
+static volatile unsigned char *nvram_addr =3D NULL;
+static volatile unsigned char *nvram_data =3D NULL;
 static int nvram_mult, is_core_99;
 static int core99_bank =3D 0;
 static int nvram_partitions[3];
@@ -88,7 +88,7 @@
 static int (*core99_write_bank)(int bank, u8* datas);
 static int (*core99_erase_bank)(int bank);
=20
-static char *nvram_image __pmacdata;
+static char *nvram_image __pmacdata =3D NULL;
=20
=20
 static unsigned char __pmac core99_nvram_read_byte(int addr)
@@ -467,7 +467,7 @@
 #endif
 }
=20
-void __init pmac_nvram_init(void)
+int __init pmac_nvram_init(void)
 {
 	struct device_node *dp;
=20
@@ -476,7 +476,7 @@
 	dp =3D find_devices("nvram");
 	if (dp =3D=3D NULL) {
 		printk(KERN_ERR "Can't find NVRAM device\n");
-		return;
+		return -ENODEV;
 	}
 	nvram_naddrs =3D dp->n_addrs;
 	is_core_99 =3D device_is_compatible(dp, "nvram,flash");
@@ -486,12 +486,16 @@
=20
 		if (nvram_naddrs < 1) {
 			printk(KERN_ERR "nvram: no address\n");
-			return;
+			return -ENODEV;
 		}
+#ifdef MODULE
+		nvram_image =3D kmalloc(NVRAM_SIZE, GFP_KERNEL);
+#else
 		nvram_image =3D alloc_bootmem(NVRAM_SIZE);
+#endif
 		if (nvram_image =3D=3D NULL) {
 			printk(KERN_ERR "nvram: can't allocate ram image\n");
-			return;
+			return -ENODEV;
 		}
 		nvram_data =3D ioremap(dp->addrs[0].address, NVRAM_SIZE*2);
 		nvram_naddrs =3D 1; /* Make sure we get the correct case */
@@ -550,8 +554,10 @@
 	} else {
 		printk(KERN_ERR "Don't know how to access NVRAM with %d addresses\n",
 		       nvram_naddrs);
+		return -ENODEV;
 	}
 	lookup_partitions();
+	return 0;
 }
=20
 int __pmac pmac_get_partition(int partition)
@@ -579,6 +585,29 @@
 	ppc_md.nvram_write_val(xpaddr + offset, data);
 }
=20
+static void pmac_nvram_exit(void)
+{
+#ifdef MODULE
+	if (ppc_md.nvram_sync)
+		ppc_md.nvram_sync();
+	if (nvram_addr)
+		iounmap(nvram_addr);
+	if (nvram_data)
+		iounmap(nvram_data);
+	if (nvram_image)
+		kfree(nvram_image);
+	nvram_addr=3DNULL;
+	nvram_data=3DNULL;
+	nvram_image=3DNULL;
+	ppc_md.nvram_read_val	=3D NULL;
+	ppc_md.nvram_write_val	=3D NULL;
+	ppc_md.nvram_sync	=3D NULL;
+#endif
+}
+
+MODULE_LICENSE("GPL");
+module_exit(pmac_nvram_exit);
+module_init(pmac_nvram_init);
 EXPORT_SYMBOL(pmac_get_partition);
 EXPORT_SYMBOL(pmac_xpram_read);
 EXPORT_SYMBOL(pmac_xpram_write);

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB8sOgjY4+4PdzvOARAis+AJ9exyt0gmb1wRuvxCM4t8NJR86lCACfcb7X
O+PBUu/QaQ2JE4CQHHhCLtI=
=5NWh
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

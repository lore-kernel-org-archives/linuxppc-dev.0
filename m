Return-Path: <waite@skycomputers.com>
Received: from sky.skycomputers.com (sky.skycomputers.com [198.4.246.2])
	by ozlabs.org (Postfix) with ESMTP id DD8EB67A7B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Mar 2005 02:18:05 +1100 (EST)
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@ozlabs.org, Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Mar 2005 10:06:11 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2237864.ZTfXa9Vo6t";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200503241006.15603.waite@skycomputers.com>
Subject: [PATCH] ppc32: fix broken compile on Sky Computers HDPU platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart2237864.ZTfXa9Vo6t
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46ix broken compile on Sky Computers HDPU platform.

Signed-off-by: Brian Waite <waite@skycomputers.com>

This fixes some compile errors in Sky Computers HDPU platform that were cre=
ated by a bad patch.

=3D=3D=3D=3D=3D arch/ppc/platforms/hdpu.c 1.2 vs edited =3D=3D=3D=3D=3D
=2D-- 1.2/arch/ppc/platforms/hdpu.c	2005-03-18 15:51:33 -05:00
+++ edited/arch/ppc/platforms/hdpu.c	2005-03-24 09:52:37 -05:00
@@ -57,7 +57,6 @@
 			   unsigned long r6, unsigned long r7);
 static void hdpu_set_l1pe(void);
 static void hdpu_cpustate_set(unsigned char new_state);
=2Dstatic void hdpu_cpustate_set(unsigned char new_state);
 #ifdef CONFIG_SMP
 static spinlock_t timebase_lock =3D SPIN_LOCK_UNLOCKED;
 static unsigned int timebase_upper =3D 0, timebase_lower =3D 0;
@@ -252,8 +251,6 @@
 		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
 #endif
 	}
=2D	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_PCI);
=2D
=20
 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_PCI);
=20
@@ -262,7 +259,17 @@
 	pci_dram_offset =3D 0;	/* System mem at same addr on PCI & cpu bus */
 	ppc_md.pci_swizzle =3D common_swizzle;
 	ppc_md.pci_map_irq =3D hdpu_map_irq;
=2D	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_INIT_REG);
+
+	mv64x60_set_bus(&bh, 0, 0);
+	bh.hose_a->first_busno =3D 0;
+	bh.hose_a->last_busno =3D 0xff;
+	bh.hose_a->last_busno =3D pciauto_bus_scan(bh.hose_a, 0);
+
+	bh.hose_b->first_busno =3D bh.hose_a->last_busno + 1;
+	mv64x60_set_bus(&bh, 1, bh.hose_b->first_busno);
+	bh.hose_b->last_busno =3D 0xff;
+	bh.hose_b->last_busno =3D pciauto_bus_scan(bh.hose_b,
+		bh.hose_b->first_busno);
=20
 	ppc_md.pci_exclude_device =3D mv64x60_pci_exclude_device;
=20
@@ -333,6 +340,10 @@
 		pdata->default_baud =3D ppcboot_bd.bi_baudrate;
 	else
 		pdata->default_baud =3D HDPU_DEFAULT_BAUD;
+	pdata->brg_clk_src =3D HDPU_MPSC_CLK_SRC;
+	pdata->brg_clk_freq =3D HDPU_MPSC_CLK_FREQ;
+}
+
 #if defined(CONFIG_HDPU_FEATURES)
 static void __init hdpu_fixup_cpustate_pdata(struct platform_device *pd)
 {
@@ -342,10 +353,6 @@
 }
 #endif
=20
=2D	pdata->brg_clk_src =3D HDPU_MPSC_CLK_SRC;
=2D	pdata->brg_clk_freq =3D HDPU_MPSC_CLK_FREQ;
=2D}
=2D
 static int __init hdpu_platform_notify(struct device *dev)
 {
 	static struct {
@@ -354,14 +361,14 @@
 	} dev_map[] =3D {
 		{
 		MPSC_CTLR_NAME ".0", hdpu_fixup_mpsc_pdata},
=2D#if defined(CONFIG_HDPU_FEATURES)
=2D		{
=2D		HDPU_CPUSTATE_NAME ".0", hdpu_fixup_cpustate_pdata},
=2D#endif
 #if defined(CONFIG_MV643XX_ETH)
 		{
 		MV643XX_ETH_NAME ".0", hdpu_fixup_eth_pdata},
 #endif
+#if defined(CONFIG_HDPU_FEATURES)
+		{
+		HDPU_CPUSTATE_NAME ".0", hdpu_fixup_cpustate_pdata},
+#endif
 	};
 	struct platform_device *pdev;
 	int i;
@@ -421,7 +428,6 @@
 #endif
=20
 	printk("SKY HDPU Compute Blade \n");
=2D	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_OK);
=20
 	if (ppc_md.progress)
 		ppc_md.progress("hdpu_setup_arch: exit", 0);
@@ -460,8 +466,6 @@
 	return mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
 				    MV64x60_TYPE_MV64360);
 }
=2D	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_RESET);
=2D
=20
 static void hdpu_reset_board(void)
 {
@@ -506,8 +510,6 @@
 	hdpu_reset_board();
=20
 	while (i-- > 0) ;
=2D	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_HALT);
=2D
 	panic("restart failed\n");
 }
=20
@@ -737,7 +739,7 @@
 		iounmap(cpu_count_reg);
 	}
=20
=2D	/* Validate the bits in the CPLD. If we could not map the reg, return 2.
+	/* Validate the bits in the CPLD. If we could not map the reg, return 2.=
=20
 	 * If the register reported 0 or 3, return 2.
 	 * Older CPLD revisions set these bits to all ones (val =3D 3).
 	 */
@@ -776,8 +778,6 @@
 			mv64x60_write(&bh, MV64360_CPU1_DOORBELL, 1 << msg);
 		break;
 	}
=2D	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_CPU1_KICK);
=2D
 }
=20
 static void smp_hdpu_kick_cpu(int nr)
@@ -842,9 +842,6 @@
 {
 	if (cpu_nr =3D=3D 0) {
 		if (ppc_md.progress)
=2D		hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR |
=2D				  CPUSTATE_KERNEL_CPU1_OK);
=2D
 			ppc_md.progress("smp_hdpu_setup_cpu 0", 0);
 		mv64x60_write(&bh, MV64360_CPU0_DOORBELL_CLR, 0xff);
 		mv64x60_write(&bh, MV64360_CPU0_DOORBELL_MASK, 0xff);
@@ -959,13 +956,6 @@
 	platform_notify =3D hdpu_platform_notify;
 #endif
 	return;
=2Dstatic void hdpu_cpustate_set(unsigned char new_state)
=2D{
=2D	unsigned int state =3D (new_state << 21);
=2D	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, (0xff << 21));
=2D	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, state);
=2D}
=2D
 }
=20
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(CONFIG_SERIAL_MPSC_CONSOL=
E)
@@ -1006,6 +996,27 @@
 	 .mask_flags =3D 0,
 	 },{
 	 .name =3D "bootEnv",
+	 .size =3D 0x00040000,
+	 .offset =3D 0x03EC0000,
+	 .mask_flags =3D 0,
+	 },{
+	 .name =3D "bootROM",
+	 .size =3D 0x00100000,
+	 .offset =3D 0x03F00000,
+	 .mask_flags =3D 0,
+	 }
+};
+
+static int __init hdpu_setup_mtd(void)
+{
+
+	physmap_set_partitions(hdpu_partitions, 5);
+	return 0;
+}
+
+arch_initcall(hdpu_setup_mtd);
+#endif
+
 #ifdef CONFIG_HDPU_FEATURES
=20
 static struct resource hdpu_cpustate_resources[] =3D {
@@ -1049,24 +1060,3 @@
=20
 arch_initcall(hdpu_add_pds);
 #endif
=2D	 .size =3D 0x00040000,
=2D	 .offset =3D 0x03EC0000,
=2D	 .mask_flags =3D 0,
=2D	 },{
=2D	 .name =3D "bootROM",
=2D	 .size =3D 0x00100000,
=2D	 .offset =3D 0x03F00000,
=2D	 .mask_flags =3D 0,
=2D	 }
=2D};
=2D
=2Dstatic int __init hdpu_setup_mtd(void)
=2D{
=2D
=2D	physmap_set_partitions(hdpu_partitions, 5);
=2D	return 0;
=2D}
=2D
=2Darch_initcall(hdpu_setup_mtd);
=2D#endif
=2D

--nextPart2237864.ZTfXa9Vo6t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCQtdnmxLCz0u+Ko8RAk7eAKC91sLatDA0XiwqsRqlXcDJ9NqrpgCggtCM
L5fBOM7h4GrWlJKVmn6RPsg=
=Cfn8
-----END PGP SIGNATURE-----

--nextPart2237864.ZTfXa9Vo6t--

Message-ID: <3C0CF638.1030204@acm.org>
Date: Tue, 04 Dec 2001 10:13:44 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Changes to PPC Linux required for GCC 3.1
Content-Type: multipart/mixed;
 boundary="------------040107010904060804020300"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040107010904060804020300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've been working on getting Linux PPC running on GCC 3.1, and I'm
sending it from my Mac whose operating system was just compiled with a
current GCC 3.1 tree (Hurray!)

I've had to patch the kernel a little, there were a few violations and
some problems with interactions with optimizations.  I had to do the
following:

* In include/asm-ppc/prom.h, the calculations for the relocations were
offseting a large constant with a string.  This results in bogus
optimizations in GCC, and a comment in GCC seems to say that you
shouldn't do this.  I've fixed it by calling a function to do the
calculation.  I've posted something on the GCC newsgroup about this,
too, we'll see what they say.

* In drivers/video/aty/atyfb_base.c, there were some "const __init"
declarations, which are not allowed.

* In include/linux/sunrpc/clnt.h, I removed a bogus function declaration
which was messing up inlining.

The patch is attached, but you will need some GCC patches that are still
not in the tree to actually compile it with 3.1.

-Corey


--------------040107010904060804020300
Content-Type: text/plain;
 name="gcc3-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc3-1.patch"

--- arch/ppc/kernel/prom.c.old	Mon Dec  3 20:46:42 2001
+++ arch/ppc/kernel/prom.c	Mon Dec  3 20:30:21 2001
@@ -1993,3 +1993,9 @@
 	for (;;)
 		prom_exit();
 }
+
+unsigned long
+prom_add_offset(unsigned long x, long offset)
+{
+    return x + offset;
+}
--- drivers/video/aty/atyfb_base.c.old	Wed Nov 28 15:17:25 2001
+++ drivers/video/aty/atyfb_base.c	Wed Nov 28 15:32:08 2001
@@ -251,7 +251,7 @@
 static int default_mclk __initdata = 0;

 #ifndef MODULE
-static const char *mode_option __initdata = NULL;
+static char *mode_option __initdata = NULL;
 #endif

 #ifdef CONFIG_PPC
@@ -271,33 +271,33 @@
 static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
 #endif

-static const char m64n_gx[] __initdata = "mach64GX (ATI888GX00)";
-static const char m64n_cx[] __initdata = "mach64CX (ATI888CX00)";
-static const char m64n_ct[] __initdata = "mach64CT (ATI264CT)";
-static const char m64n_et[] __initdata = "mach64ET (ATI264ET)";
-static const char m64n_vta3[] __initdata = "mach64VTA3 (ATI264VT)";
-static const char m64n_vta4[] __initdata = "mach64VTA4 (ATI264VT)";
-static const char m64n_vtb[] __initdata = "mach64VTB (ATI264VTB)";
-static const char m64n_vt4[] __initdata = "mach64VT4 (ATI264VT4)";
-static const char m64n_gt[] __initdata = "3D RAGE (GT)";
-static const char m64n_gtb[] __initdata = "3D RAGE II+ (GTB)";
-static const char m64n_iic_p[] __initdata = "3D RAGE IIC (PCI)";
-static const char m64n_iic_a[] __initdata = "3D RAGE IIC (AGP)";
-static const char m64n_lt[] __initdata = "3D RAGE LT";
-static const char m64n_ltg[] __initdata = "3D RAGE LT-G";
-static const char m64n_gtc_ba[] __initdata = "3D RAGE PRO (BGA, AGP)";
-static const char m64n_gtc_ba1[] __initdata = "3D RAGE PRO (BGA, AGP, 1x only)";
-static const char m64n_gtc_bp[] __initdata = "3D RAGE PRO (BGA, PCI)";
-static const char m64n_gtc_pp[] __initdata = "3D RAGE PRO (PQFP, PCI)";
-static const char m64n_gtc_ppl[] __initdata = "3D RAGE PRO (PQFP, PCI, limited 3D)";
-static const char m64n_xl[] __initdata = "3D RAGE (XL)";
-static const char m64n_ltp_a[] __initdata = "3D RAGE LT PRO (AGP)";
-static const char m64n_ltp_p[] __initdata = "3D RAGE LT PRO (PCI)";
-static const char m64n_mob_p[] __initdata = "3D RAGE Mobility (PCI)";
-static const char m64n_mob_a[] __initdata = "3D RAGE Mobility (AGP)";
+static char m64n_gx[] __initdata = "mach64GX (ATI888GX00)";
+static char m64n_cx[] __initdata = "mach64CX (ATI888CX00)";
+static char m64n_ct[] __initdata = "mach64CT (ATI264CT)";
+static char m64n_et[] __initdata = "mach64ET (ATI264ET)";
+static char m64n_vta3[] __initdata = "mach64VTA3 (ATI264VT)";
+static char m64n_vta4[] __initdata = "mach64VTA4 (ATI264VT)";
+static char m64n_vtb[] __initdata = "mach64VTB (ATI264VTB)";
+static char m64n_vt4[] __initdata = "mach64VT4 (ATI264VT4)";
+static char m64n_gt[] __initdata = "3D RAGE (GT)";
+static char m64n_gtb[] __initdata = "3D RAGE II+ (GTB)";
+static char m64n_iic_p[] __initdata = "3D RAGE IIC (PCI)";
+static char m64n_iic_a[] __initdata = "3D RAGE IIC (AGP)";
+static char m64n_lt[] __initdata = "3D RAGE LT";
+static char m64n_ltg[] __initdata = "3D RAGE LT-G";
+static char m64n_gtc_ba[] __initdata = "3D RAGE PRO (BGA, AGP)";
+static char m64n_gtc_ba1[] __initdata = "3D RAGE PRO (BGA, AGP, 1x only)";
+static char m64n_gtc_bp[] __initdata = "3D RAGE PRO (BGA, PCI)";
+static char m64n_gtc_pp[] __initdata = "3D RAGE PRO (PQFP, PCI)";
+static char m64n_gtc_ppl[] __initdata = "3D RAGE PRO (PQFP, PCI, limited 3D)";
+static char m64n_xl[] __initdata = "3D RAGE (XL)";
+static char m64n_ltp_a[] __initdata = "3D RAGE LT PRO (AGP)";
+static char m64n_ltp_p[] __initdata = "3D RAGE LT PRO (PCI)";
+static char m64n_mob_p[] __initdata = "3D RAGE Mobility (PCI)";
+static char m64n_mob_a[] __initdata = "3D RAGE Mobility (AGP)";


-static const struct {
+static struct {
     u16 pci_id, chip_type;
     u8 rev_mask, rev_val;
     const char *name;
@@ -357,24 +357,24 @@
 #endif /* CONFIG_FB_ATY_CT */
 };

-static const char ram_dram[] __initdata = "DRAM";
-static const char ram_vram[] __initdata = "VRAM";
-static const char ram_edo[] __initdata = "EDO";
-static const char ram_sdram[] __initdata = "SDRAM";
-static const char ram_sgram[] __initdata = "SGRAM";
-static const char ram_wram[] __initdata = "WRAM";
-static const char ram_off[] __initdata = "OFF";
-static const char ram_resv[] __initdata = "RESV";
+static char ram_dram[] __initdata = "DRAM";
+static char ram_vram[] __initdata = "VRAM";
+static char ram_edo[] __initdata = "EDO";
+static char ram_sdram[] __initdata = "SDRAM";
+static char ram_sgram[] __initdata = "SGRAM";
+static char ram_wram[] __initdata = "WRAM";
+static char ram_off[] __initdata = "OFF";
+static char ram_resv[] __initdata = "RESV";

 #ifdef CONFIG_FB_ATY_GX
-static const char *aty_gx_ram[8] __initdata = {
+static char *aty_gx_ram[8] __initdata = {
     ram_dram, ram_vram, ram_vram, ram_dram,
     ram_dram, ram_vram, ram_vram, ram_resv
 };
 #endif /* CONFIG_FB_ATY_GX */

 #ifdef CONFIG_FB_ATY_CT
-static const char *aty_ct_ram[8] __initdata = {
+static char *aty_ct_ram[8] __initdata = {
     ram_off, ram_dram, ram_edo, ram_edo,
     ram_sdram, ram_sgram, ram_wram, ram_resv
 };
--- include/asm-ppc/prom.h.old	Mon Dec  3 20:22:11 2001
+++ include/asm-ppc/prom.h	Mon Dec  3 20:30:38 2001
@@ -104,9 +104,16 @@
  */
 extern unsigned long reloc_offset(void);

-#define PTRRELOC(x)	((typeof(x))((unsigned long)(x) + offset))
-#define PTRUNRELOC(x)	((typeof(x))((unsigned long)(x) - offset))
-#define RELOC(x)	(*PTRRELOC(&(x)))
+/* If you index into a constant string beyond the range of the string,
+   as the RELOC functions do, GCC thinks you are a loser and does wierd
+   calculations.  This function avoids that, it must be called to do the
+   addition for the pointer relocation. */
+extern unsigned long prom_add_offset(unsigned long x, long offset)
+    __attribute__ ((noinline));
+
+#define PTRRELOC(x)   ((typeof(x))prom_add_offset((unsigned long)(x), +offset))
+#define PTRUNRELOC(x) ((typeof(x))prom_add_offset((unsigned long)(x), -offset))
+#define RELOC(x)      (*PTRRELOC(&(x)))

 #endif /* _PPC_PROM_H */
 #endif /* __KERNEL__ */
--- include/linux/sunrpc/clnt.h.old	Mon Dec  3 21:05:34 2001
+++ include/linux/sunrpc/clnt.h	Mon Dec  3 21:05:44 2001
@@ -136,7 +136,6 @@
 	xprt_set_timeout(&clnt->cl_timeout, retr, incr);
 }

-extern void rpciod_tcp_dispatcher(void);
 extern void rpciod_wake_up(void);

 /*


--------------040107010904060804020300--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

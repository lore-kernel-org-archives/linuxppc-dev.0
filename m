Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 01F32DDE16
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:06:19 +1000 (EST)
Received: from [192.168.1.37] (node106.72.251.72.1dial.com [72.251.72.106])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m3UN4PuZ026379
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 16:06:02 -0700 (PDT)
Message-ID: <48190627.7010402@hypersurf.com>
Date: Wed, 30 Apr 2008 16:52:07 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: mucking with cputable ...
Content-Type: multipart/mixed; boundary="------------090605080708080406040506"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090605080708080406040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

	I'm trying to monkey with cputable. It is hanging after printing:

Preparing BATs

on the console (PowerMac 8600 with PowerLogix 750GX card, 2.6.24 YDL 4.0).

	I am guessing I am doing this PTRRELOC() thing wrong? Can someone 
explain what is going on here:

	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;

Up above both s and t needed reloccing? This is from identify_cpu(). 
Does this have something to do with data items in different sections 
(i.e. initdata)?

	I also welcome comments on where else the data I'm trying to graft into 
cputable might go (i.e. cpu_freq driver).

Thanks!

kevin

--------------090605080708080406040506
Content-Type: text/plain;
 name="cputable.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cputable.c.diff"

--- cputable-old_c	2008-02-25 18:24:23.000000000 -0800
+++ cputable-new_c	2008-04-30 14:31:37.000000000 -0700
@@ -38,11 +38,13 @@
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750cx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750fx(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_750gx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_7400(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_7410(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
+
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
@@ -70,8 +72,25 @@
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
 
+#ifdef CONFIG_PPC32
+static struct ppc_misc_750fgx __initdata ppc_misc_750fx={
+	.misc_cp=ppc_misc_cp_750fgx,
+	.min_ratio=2,		/* min bus ratio */
+	.max_ratio=20,		/* max bus ratio */
+	.min_core=400000,	/* min core frequency per spec */
+	.max_core=800000,	/* max core frequency per spec */
+};
+static struct ppc_misc_750fgx __initdata ppc_misc_750gx={
+	.misc_cp=ppc_misc_cp_750fgx,
+	.min_ratio=2,		/* min bus ratio */
+	.max_ratio=20,		/* max bus ratio */
+	.min_core=500000,	/* min core frequency per spec */
+	.max_core=1000000,	/* max core frequency per spec */
+};
+#endif /* CONFIG_PPC32 */
+
 static struct cpu_spec __initdata cpu_specs[] = {
 #ifdef CONFIG_PPC64
 	{	/* Power3 */
 		.pvr_mask		= 0xffff0000,
@@ -590,8 +609,9 @@
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.misc			= (void *) &ppc_misc_750fx,
 		.platform		= "ppc750",
 	},
 	{	/* 750FX rev 2.0 must disable HID0[DPM] */
 		.pvr_mask		= 0xffffffff,
@@ -602,8 +622,9 @@
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750,
+		.misc			= (void *) &ppc_misc_750fx,
 		.platform		= "ppc750",
 	},
 	{	/* 750FX (All revs except 2.0) */
 		.pvr_mask		= 0xffff0000,
@@ -614,20 +635,48 @@
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750fx,
+		.misc			= (void *) &ppc_misc_750fx,
 		.platform		= "ppc750",
 	},
-	{	/* 750GX */
+	{	/* 750GX rev 1.x */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x70020000,
 		.cpu_name		= "750GX",
 		.cpu_features		= CPU_FTRS_750GX,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750fx,
+		.cpu_setup		= __setup_cpu_750gx,
+		.misc			= (void *) &ppc_misc_750gx,
+		.platform		= "ppc750",
+	},
+	{	/* 750GX (rev 2.3, as used on PowerLogix 750GX upgrade card */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x00080203,
+		.cpu_name		= "750GX",
+		.cpu_features		= CPU_FTRS_750GX,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750gx,
+		.misc			= (void *) &ppc_misc_750gx,
+		.platform		= "ppc750",
+	},
+	{	/* 750GX (All revs >= 2.0) */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x70020200,
+		.cpu_name		= "750GX",
+		.cpu_features		= CPU_FTRS_750GX,
+		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750gx,
+		.misc			= (void *) &ppc_misc_750gx,
 		.platform		= "ppc750",
 	},
 	{	/* 740/750 (L2CR bit need fixup for 740) */
 		.pvr_mask		= 0xffff0000,
@@ -1331,8 +1380,34 @@
 #endif /* CONFIG_PPC32 */
 };
 
 static struct cpu_spec the_cpu_spec;
+#ifdef CONFIG_PPC32
+/*
+ * Used to hold misc data structure
+ */
+static int ppc_misc_space[4];
+
+void * __init ppc_misc_cp_750fgx(void *miscp)
+{
+struct ppc_misc_750fgx *s=(struct ppc_misc_750fgx *)miscp;
+struct ppc_misc_750fgx *t=(struct ppc_misc_750fgx *)&ppc_misc_space;
+
+	/*
+	 * Make sure we have enough static space!
+	 */
+	if(sizeof(struct ppc_misc_750fgx)>sizeof(ppc_misc_space)) return NULL;
+
+	s=PTRRELOC(s);
+//	t=PTRRELOC(t);
+
+	*t=*s;
+	t->misc_cp=NULL;
+
+	return &ppc_misc_space;
+}
+
+#endif /* CONFIG_PPC32 */
 
 struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 {
 	struct cpu_spec *s = cpu_specs;
@@ -1373,8 +1448,17 @@
 			if (s->cpu_setup) {
 				s->cpu_setup(offset, s);
 			}
 #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
+#if 0
+			if(s->misc) *PTRRELOC(&t->misc)=((struct ppc_misc_any *)
+				(s->misc))->misc_cp(s->misc);
+			else *PTRRELOC(&t->misc)=NULL;
+#else
+			if(s->misc) t->misc=((struct ppc_misc_any *)
+				(s->misc))->misc_cp(s->misc);
+			else t->misc=NULL;
+#endif
 			return s;
 		}
 	BUG();
 	return NULL;

--------------090605080708080406040506
Content-Type: text/plain;
 name="cputable.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cputable.h.diff"

--- cputable-old_h	2008-02-25 18:24:47.000000000 -0800
+++ cputable-new_h	2008-04-30 06:45:14.000000000 -0700
@@ -56,8 +56,20 @@
 	PPC_PMC_IBM = 1,
 	PPC_PMC_PA6T = 2,
 };
 
+struct ppc_misc_any {
+	void * (*misc_cp)(void *);
+};
+
+struct ppc_misc_750fgx {
+	void * (*misc_cp)(void *);
+	unsigned short min_ratio;
+	unsigned short max_ratio;
+	int min_core;
+	int max_core;
+};
+
 /* NOTE WELL: Update identify_cpu() if fields are added or removed! */
 struct cpu_spec {
 	/* CPU is matched via (PVR & pvr_mask) == pvr_value */
 	unsigned int	pvr_mask;
@@ -96,8 +108,12 @@
 	unsigned long	oprofile_mmcra_clear;
 
 	/* Name of processor class, for the ELF AT_PLATFORM entry */
 	char		*platform;
+
+	/* miscellaneous catch all for various data (like min and max core
+	 * frequencies for dual pll cpus) */
+	void *misc;
 };
 
 extern struct cpu_spec		*cur_cpu_spec;
 
@@ -249,9 +265,9 @@
 #define CPU_FTRS_750FX1	(CPU_FTRS_750 | CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM)
 #define CPU_FTRS_750FX2	(CPU_FTRS_750 | CPU_FTR_NO_DPM)
 #define CPU_FTRS_750FX	(CPU_FTRS_750 | CPU_FTR_DUAL_PLL_750FX | \
 		CPU_FTR_HAS_HIGH_BATS)
-#define CPU_FTRS_750GX	(CPU_FTRS_750FX)
+#define CPU_FTRS_750GX	(CPU_FTRS_750FX | CPU_FTR_DUAL_PLL_750FX)
 #define CPU_FTRS_7400_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)

--------------090605080708080406040506--

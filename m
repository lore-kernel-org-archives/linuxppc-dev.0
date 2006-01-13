Return-Path: <anton@ozlabs.org>
Date: Fri, 13 Jan 2006 23:05:44 +1100
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc oprofile G4 clashes with wacom driver
Message-ID: <20060113120543.GF26421@krispykreme>
References: <20060112144437.GA15923@shadowen.org>
	<65FBDB60-D4A5-40DF-BA73-AB6388A9368B@kernel.crashing.org>
	<43C67B3F.3080301@shadowen.org>
	<17351.28313.858572.825928@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17351.28313.858572.825928@cargo.ozlabs.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I think there needs to be a prefix, but I have no idea what POT_ would
> be (oh, I guess it's Powerpc Oprofile Type, I suppose).  Something
> like PPC_OPROFILE_ would be better, if it's not too long.

Makes sense. How does this look? Only built on powerpc-64 so far.

Anton

--

Rename powerpc_oprofile_type enum, the old names were way too generic.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/cputable.c
===================================================================
--- build.orig/arch/powerpc/kernel/cputable.c	2006-01-10 13:53:24.000000000 +1100
+++ build/arch/powerpc/kernel/cputable.c	2006-01-13 22:39:38.000000000 +1100
@@ -79,7 +79,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/power3",
-		.oprofile_type		= RS64,
+		.oprofile_type		= PPC_OPROFILE_RS64,
 	},
 	{	/* Power3+ */
 		.pvr_mask		= 0xffff0000,
@@ -92,7 +92,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/power3",
-		.oprofile_type		= RS64,
+		.oprofile_type		= PPC_OPROFILE_RS64,
 	},
 	{	/* Northstar */
 		.pvr_mask		= 0xffff0000,
@@ -105,7 +105,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= RS64,
+		.oprofile_type		= PPC_OPROFILE_RS64,
 	},
 	{	/* Pulsar */
 		.pvr_mask		= 0xffff0000,
@@ -118,7 +118,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= RS64,
+		.oprofile_type		= PPC_OPROFILE_RS64,
 	},
 	{	/* I-star */
 		.pvr_mask		= 0xffff0000,
@@ -131,7 +131,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= RS64,
+		.oprofile_type		= PPC_OPROFILE_RS64,
 	},
 	{	/* S-star */
 		.pvr_mask		= 0xffff0000,
@@ -144,7 +144,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
-		.oprofile_type		= RS64,
+		.oprofile_type		= PPC_OPROFILE_RS64,
 	},
 	{	/* Power4 */
 		.pvr_mask		= 0xffff0000,
@@ -157,7 +157,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power4",
-		.oprofile_type		= POWER4,
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 	},
 	{	/* Power4+ */
 		.pvr_mask		= 0xffff0000,
@@ -170,7 +170,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power4",
-		.oprofile_type		= POWER4,
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 	},
 	{	/* PPC970 */
 		.pvr_mask		= 0xffff0000,
@@ -184,7 +184,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
-		.oprofile_type		= POWER4,
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 	},
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_PPC64) || defined(CONFIG_POWER4)
@@ -204,7 +204,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
-		.oprofile_type		= POWER4,
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 	},
 #endif /* defined(CONFIG_PPC64) || defined(CONFIG_POWER4) */
 #ifdef CONFIG_PPC64
@@ -219,7 +219,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
-		.oprofile_type		= POWER4,
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 	},
 	{	/* Power5 GR */
 		.pvr_mask		= 0xffff0000,
@@ -232,7 +232,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power5",
-		.oprofile_type		= POWER4,
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 	},
 	{	/* Power5 GS */
 		.pvr_mask		= 0xffff0000,
@@ -245,7 +245,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power5+",
-		.oprofile_type		= POWER4,
+		.oprofile_type		= PPC_OPROFILE_POWER4,
 	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
@@ -521,7 +521,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7450 2.1 */
 		.pvr_mask		= 0xffffffff,
@@ -534,7 +534,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7450 2.3 and newer */
 		.pvr_mask		= 0xffff0000,
@@ -547,7 +547,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7455 rev 1.x */
 		.pvr_mask		= 0xffffff00,
@@ -560,7 +560,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7455 rev 2.0 */
 		.pvr_mask		= 0xffffffff,
@@ -573,7 +573,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7455 others */
 		.pvr_mask		= 0xffff0000,
@@ -586,7 +586,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7447/7457 Rev 1.0 */
 		.pvr_mask		= 0xffffffff,
@@ -599,7 +599,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7447/7457 Rev 1.1 */
 		.pvr_mask		= 0xffffffff,
@@ -612,7 +612,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7447/7457 Rev 1.2 and later */
 		.pvr_mask		= 0xffff0000,
@@ -625,7 +625,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7447A */
 		.pvr_mask		= 0xffff0000,
@@ -638,7 +638,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 7448 */
 		.pvr_mask		= 0xffff0000,
@@ -651,7 +651,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
-		.oprofile_type		= G4,
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 		.pvr_mask		= 0x7fff0000,
@@ -976,7 +976,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
-		.oprofile_type		= BOOKE,
+		.oprofile_type		= PPC_OPROFILE_BOOKE,
 	},
 	{	/* e500v2 */
 		.pvr_mask		= 0xffff0000,
@@ -991,7 +991,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
-		.oprofile_type		= BOOKE,
+		.oprofile_type		= PPC_OPROFILE_BOOKE,
 	},
 #endif
 #if !CLASSIC_PPC
Index: build/arch/powerpc/oprofile/common.c
===================================================================
--- build.orig/arch/powerpc/oprofile/common.c	2006-01-10 13:53:24.000000000 +1100
+++ build/arch/powerpc/oprofile/common.c	2006-01-13 22:39:57.000000000 +1100
@@ -140,19 +140,19 @@ int __init oprofile_arch_init(struct opr
 
 	switch (cur_cpu_spec->oprofile_type) {
 #ifdef CONFIG_PPC64
-		case RS64:
+		case PPC_OPROFILE_RS64:
 			model = &op_model_rs64;
 			break;
-		case POWER4:
+		case PPC_OPROFILE_POWER4:
 			model = &op_model_power4;
 			break;
 #else
-		case G4:
+		case PPC_OPROFILE_G4:
 			model = &op_model_7450;
 			break;
 #endif
 #ifdef CONFIG_FSL_BOOKE
-		case BOOKE:
+		case PPC_OPROFILE_BOOKE:
 			model = &op_model_fsl_booke;
 			break;
 #endif
Index: build/include/asm-powerpc/cputable.h
===================================================================
--- build.orig/include/asm-powerpc/cputable.h	2006-01-10 13:53:25.000000000 +1100
+++ build/include/asm-powerpc/cputable.h	2006-01-13 22:40:23.000000000 +1100
@@ -31,11 +31,11 @@ struct cpu_spec;
 typedef	void (*cpu_setup_t)(unsigned long offset, struct cpu_spec* spec);
 
 enum powerpc_oprofile_type {
-	INVALID = 0,
-	RS64 = 1,
-	POWER4 = 2,
-	G4 = 3,
-	BOOKE = 4,
+	PPC_OPROFILE_INVALID = 0,
+	PPC_OPROFILE_RS64 = 1,
+	PPC_OPROFILE_POWER4 = 2,
+	PPC_OPROFILE_G4 = 3,
+	PPC_OPROFILE_BOOKE = 4,
 };
 
 struct cpu_spec {

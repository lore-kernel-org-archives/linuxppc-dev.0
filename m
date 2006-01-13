Return-Path: <apw@shadowen.org>
Received: from localhost.localdomain (81-179-252-66.dsl.pipex.com
	[81.179.252.66]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 370776893D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 00:11:29 +1100 (EST)
Date: Fri, 13 Jan 2006 12:35:49 +0000
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc oprofile G4 clashes with wacom driver
Message-ID: <20060113123549.GA27087@shadowen.org>
References: <17351.28313.858572.825928@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Andy Whitcroft <apw@shadowen.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: oprofile G4 clashes with wacom driver

In 2.6.15-git6 a change was commited in the oprofile support in
the powerpc architecture.  It introduced the powerpc_oprofile_type
which contains the define G4.  This causes a name clash with the
existing wacom usb tablet driver.

      CC [M]  drivers/usb/input/wacom.o
    drivers/usb/input/wacom.c:98: error: conflicting types for `G4'
    include/asm/cputable.h:37: error: previous declaration of `G4'
      CC [M]  drivers/usb/mon/mon_text.o
    make[3]: *** [drivers/usb/input/wacom.o] Error 1
    make[2]: *** [drivers/usb/input] Error 2

The elements of an enum declared in global scope are effectivly
global identifiers themselves.  As such we need to ensure the names
are unique.  This patch updates the later oprofile support to use
unique names.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 arch/powerpc/kernel/cputable.c |   52 ++++++++++++++++++++---------------------
 arch/powerpc/oprofile/common.c |    8 +++---
 include/asm-powerpc/cputable.h |   10 +++----
 3 files changed, 35 insertions(+), 35 deletions(-)
diff -upN reference/arch/powerpc/kernel/cputable.c current/arch/powerpc/kernel/cputable.c
--- reference/arch/powerpc/kernel/cputable.c
+++ current/arch/powerpc/kernel/cputable.c
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
diff -upN reference/arch/powerpc/oprofile/common.c current/arch/powerpc/oprofile/common.c
--- reference/arch/powerpc/oprofile/common.c
+++ current/arch/powerpc/oprofile/common.c
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
diff -upN reference/include/asm-powerpc/cputable.h current/include/asm-powerpc/cputable.h
--- reference/include/asm-powerpc/cputable.h
+++ current/include/asm-powerpc/cputable.h
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

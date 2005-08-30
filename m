Return-Path: <a.othieno@bluewin.ch>
Received: from mail14.bluewin.ch (mail14.bluewin.ch [195.186.19.62])
	by ozlabs.org (Postfix) with ESMTP id 3FE1C68111
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 09:42:28 +1000 (EST)
Date: Tue, 30 Aug 2005 19:42:27 -0400
To: akpm@osdl.org
Message-ID: <20050830234227.GB16375@mars>
References: <20050830233759.GA16375@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050830233759.GA16375@mars>
From: a.othieno@bluewin.ch (Arthur Othieno)
Cc: gc-linux-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/2] ppc32: Re-order cputable for 750CXe DD2.4 entry
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


"745/755" (pvr_value:0x00083000) is a catch-all entry.
Since arch/ppc/kernel/misc.S:identify_cpu() returns on first match,
move this lower in the table so 750CXe DD2.4 (pvr_value:0x00083214)
may be correctly enumerated.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 cputable.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff -uprN a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2005-08-30 15:29:31.000000000 -0400
+++ b/arch/ppc/kernel/cputable.c	2005-08-30 18:18:28.000000000 -0400
@@ -198,20 +198,6 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750
 	},
-	{	/* 745/755 */
-		.pvr_mask		= 0xfffff000,
-		.pvr_value		= 0x00083000,
-		.cpu_name		= "745/755",
-		.cpu_features		= CPU_FTR_COMMON |
-			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
-			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
-			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
-		.cpu_user_features	= COMMON_PPC,
-		.icache_bsize		= 32,
-		.dcache_bsize		= 32,
-		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750
-	},
 	{	/* 750CX (80100 and 8010x?) */
 		.pvr_mask		= 0xfffffff0,
 		.pvr_value		= 0x00080100,
@@ -254,6 +240,20 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 4,
 		.cpu_setup		= __setup_cpu_750cx
 	},
+	{	/* 745/755 */
+		.pvr_mask		= 0xfffff000,
+		.pvr_value		= 0x00083000,
+		.cpu_name		= "745/755",
+		.cpu_features		= CPU_FTR_COMMON |
+			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
+			CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU |
+			CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP,
+		.cpu_user_features	= COMMON_PPC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.num_pmcs		= 4,
+		.cpu_setup		= __setup_cpu_750
+	},
 	{	/* 750FX rev 1.x */
 		.pvr_mask		= 0xffffff00,
 		.pvr_value		= 0x70000100,

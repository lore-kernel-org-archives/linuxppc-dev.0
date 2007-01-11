Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 69437DDF19
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Jan 2007 09:28:00 +1100 (EST)
To: mporter@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 Jan 2007 14:18:13 -0800
Message-ID: <adalkk9dx7e.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add a cputable entry for revision B of the AMCC 440SPe.  When adding
this entry, we need to adjust the entry for 440SP Rev. A so that it
matches more bits of the PVR, since the 440SPe Rev. B has PVR
53421891, which would match the old 440SP PVR pattern of 53xxx891.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
I'm still working on cleaning up the PCI Express changes for 440SPe
Rev. B support but I think we might as well queue this up at least.

I haven't heard from Matt in a while so maybe you could pick this up
directly Paul?

Thanks,
  Roland

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b742013..869d5fe 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1123,8 +1123,8 @@ static struct cpu_spec cpu_specs[] = {
 		.platform		= "ppc440",
 	},
 	{ /* 440SP Rev. A */
-		.pvr_mask		= 0xff000fff,
-		.pvr_value		= 0x53000891,
+		.pvr_mask		= 0xfff00fff,
+		.pvr_value		= 0x53200891,
 		.cpu_name		= "440SP Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
@@ -1133,8 +1133,8 @@ static struct cpu_spec cpu_specs[] = {
 		.platform		= "ppc440",
 	},
 	{ /* 440SPe Rev. A */
-		.pvr_mask		= 0xff000fff,
-		.pvr_value		= 0x53000890,
+		.pvr_mask		= 0xfff00fff,
+		.pvr_value		= 0x53400890,
 		.cpu_name		= "440SPe Rev. A",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
@@ -1142,6 +1142,16 @@ static struct cpu_spec cpu_specs[] = {
 		.dcache_bsize		= 32,
 		.platform		= "ppc440",
 	},
+	{ /* 440SPe Rev. B */
+		.pvr_mask		= 0xfff00fff,
+		.pvr_value		= 0x53400891,
+		.cpu_name		= "440SPe Rev. B",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.platform		= "ppc440",
+	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_FSL_BOOKE
 	{	/* e200z5 */

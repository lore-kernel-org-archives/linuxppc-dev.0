Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 5E36ADDFAC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 05:36:37 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 15 Jun 2007 12:36:32 -0700
In-Reply-To: <18034.6787.951861.623265@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Fri, 15 Jun 2007 14:50:11 +1000")
Message-ID: <adawsy5ggcf.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When adding the cputable entry for 440SPe Rev. B, we also need to
adjust the existing entries for 440SP Rev. A and 440SPe Rev. B so that
they look more bits of the PVR.  The 440SPe Rev. B has PVR 53421891,
which would match the current 440SP Rev. A pattern of 53xxx891.  To
distinguish between 440SP and 440SPe, we need to use the first three
digits of the PVR, which are respectively 532 and 534.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
Here's a patch I've had for a while -- I think it may as well go in,
although I haven't had a chance to put much work into moving
Yucca/Katmai 440SPe support to arch/powerpc, so I'll probably miss
2.6.23 for the rest of it.

 arch/powerpc/kernel/cputable.c   |   20 +++-
 arch/ppc/syslib/ppc440spe_pcie.c |  219 +++++++++++++++++++++++++++-----------
 2 files changed, 172 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b2b5d66..157e6e3 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1178,8 +1178,8 @@ static struct cpu_spec cpu_specs[] = {
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
@@ -1188,9 +1188,19 @@ static struct cpu_spec cpu_specs[] = {
 		.platform		= "ppc440",
 	},
 	{ /* 440SPe Rev. A */
-		.pvr_mask		= 0xff000fff,
-		.pvr_value		= 0x53000890,
-		.cpu_name		= "440SPe Rev. A",
+		.pvr_mask               = 0xfff00fff,
+		.pvr_value              = 0x53400890,
+		.cpu_name               = "440SPe Rev. A",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features      = COMMON_USER_BOOKE,
+		.icache_bsize           = 32,
+		.dcache_bsize           = 32,
+		.platform               = "ppc440",
+	},
+	{ /* 440SPe Rev. B */
+		.pvr_mask		= 0xfff00fff,
+		.pvr_value		= 0x53400891,
+		.cpu_name		= "440SPe Rev. B",
 		.cpu_features		= CPU_FTRS_44X,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,

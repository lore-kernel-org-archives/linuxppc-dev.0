Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BD2D7DDEDE
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 17:24:37 +1100 (EST)
Date: Mon, 26 Feb 2007 00:35:14 -0600
To: paulus@samba.org
Subject: [PATCH] No DEEPNAP on 970MP 1.0
Message-ID: <20070226063514.GA16700@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

970MP rev 1.0 is reported to have nonworking DEEPNAP support, we've had
bug reports of lockups on those machines. Appearantly Apple used them
on some dual-core dual-cpu systems. Rev 1.1 is OK, and that's the one
that all 4-way systems seem to use.


Signed-off-by: Olof Johansson <olof@lixom.net>

---
Paul, please consider for 2.6.21 and 2.6.20-stable, we've seen bugreports
on this from users.


diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 7ec4ac7..e4006dc 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -225,6 +225,22 @@ #ifdef CONFIG_PPC64
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
 	},
+	{	/* PPC970MP DD1.0 - no DEEPNAP, use regular 970 init */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x00440100,
+		.cpu_name		= "PPC970MP",
+		.cpu_features		= CPU_FTRS_PPC970,
+		.cpu_user_features	= COMMON_USER_POWER4 |
+			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_ppc970,
+		.cpu_restore		= __restore_cpu_ppc970,
+		.oprofile_cpu_type	= "ppc64/970MP",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.platform		= "ppc970",
+	},
 	{	/* PPC970MP */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00440000,

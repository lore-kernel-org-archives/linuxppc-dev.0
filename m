Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 40008679F6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 11:20:12 +1000 (EST)
Date: Mon, 6 Jun 2005 18:20:09 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050607012009.GB16387@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: add 405EP cpu_spec entry
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

the following patch adds definition for PPC 405EP which was lost 
somehow during 2.4 -> 2.6 transition.

Recent change to arch/ppc/kernel/misc.S ("Fix incorrect CPU_FTR fixup 
usage for unified caches") triggered this bug and 405EP boards don't 
boot anymore.

Please, consider applying this patch before 2.6.12 release.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -838,6 +838,17 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 	},
+	{	/* 405EP */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x51210000,
+		.cpu_name		= "405EP",
+		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
+			CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+	},
 
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x

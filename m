Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id B4188B7BC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 03:32:14 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 13/22] powerpc: broadway processor support
Date: Sat, 12 Dec 2009 17:31:46 +0100
Message-Id: <1260635515-7478-14-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
References: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch extends the cputable entry of the 750CL to also match
the 750CL-based "Broadway" cpu found on the Nintendo Wii.

As of this patch, the following "Broadway" design revision levels have
been seen in the wild:
- DD1.2 (87102)
- DD2.0 (87200)

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/cputable.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 03c862b..2fc82ba 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -697,9 +697,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
 	},
-	{	/* 750CL */
-		.pvr_mask		= 0xfffff0f0,
-		.pvr_value		= 0x00087010,
+	{	/* 750CL (and "Broadway") */
+		.pvr_mask		= 0xfffff0e0,
+		.pvr_value		= 0x00087000,
 		.cpu_name		= "750CL",
 		.cpu_features		= CPU_FTRS_750CL,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
-- 
1.6.3.3

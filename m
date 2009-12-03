Return-Path: <albert_herranz@yahoo.es>
Received: from smtp136.mail.ukl.yahoo.com (smtp136.mail.ukl.yahoo.com
	[77.238.184.67]) by ozlabs.org (Postfix) with SMTP id A3330B7BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 09:47:40 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 3/6] powerpc: broadway processor support
Date: Thu,  3 Dec 2009 23:47:24 +0100
Message-Id: <1259880447-5008-4-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
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
---
v1 -> v2
- Don't reorder the table. Suggestion by Grant Likely.

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

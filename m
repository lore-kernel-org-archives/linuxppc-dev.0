Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401msX1tpNzDrFs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 09:41:04 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EMYXB3057675
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:41:01 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gq9mfepu2-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:41:01 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 18:41:00 -0400
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [PATCH v3 4/5] rfi-flush: Differentiate enabled and patched flush
 types
Date: Wed, 14 Mar 2018 19:40:41 -0300
In-Reply-To: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1521067243-19520-5-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the rfi-flush messages print 'Using <type> flush' for all
enabled_flush_types, but that is not necessarily true -- as now the
fallback flush is always enabled on pseries, but the fixup function
overwrites its nop/branch slot with other flush types, if available.

So, replace the 'Using <type> flush' messages with '<type> flush is
available'.

Also, print the patched flush types in the fixup function, so users
can know what is (not) being used (e.g., the slower, fallback flush,
or no flush type at all if flush is disabled via the debugfs switch).

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---

P.S.: Michael, you suggested only hunk 1. please feel free to discard
      hunk 2 if you don't like it.

 arch/powerpc/kernel/setup_64.c    | 6 +++---
 arch/powerpc/lib/feature-fixups.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d60e2f7..4ec4a27 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -884,15 +884,15 @@ static void init_fallback_flush(void)
 void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
 	if (types & L1D_FLUSH_FALLBACK) {
-		pr_info("rfi-flush: Using fallback displacement flush\n");
+		pr_info("rfi-flush: fallback displacement flush available\n");
 		init_fallback_flush();
 	}
 
 	if (types & L1D_FLUSH_ORI)
-		pr_info("rfi-flush: Using ori type flush\n");
+		pr_info("rfi-flush: ori type flush available\n");
 
 	if (types & L1D_FLUSH_MTTRIG)
-		pr_info("rfi-flush: Using mttrig type flush\n");
+		pr_info("rfi-flush: mttrig type flush available\n");
 
 	enabled_flush_types = types;
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 73697c4..35f80ab 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -153,7 +153,14 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 		patch_instruction(dest + 2, instrs[2]);
 	}
 
-	printk(KERN_DEBUG "rfi-flush: patched %d locations\n", i);
+	printk(KERN_DEBUG "rfi-flush: patched %d locations (%s flush)\n", i,
+		(types == L1D_FLUSH_NONE)       ? "no" :
+		(types == L1D_FLUSH_FALLBACK)   ? "fallback displacement" :
+		(types &  L1D_FLUSH_ORI)        ? (types & L1D_FLUSH_MTTRIG)
+							? "ori+mttrig type"
+							: "ori type" :
+		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
+						: "unknown");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-- 
2.7.4

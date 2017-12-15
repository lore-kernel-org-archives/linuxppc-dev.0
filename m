Return-Path: <srs0=gpzr=dl=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz3mX4MHKzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 08:42:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yz3mX2j2hz8tPT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 08:42:04 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yz3mW65Q2z9s84
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2017 08:42:03 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] Fix parse_args cycle limit check.
Date: Fri, 15 Dec 2017 22:41:49 +0100
Message-Id: <20171215214149.3692-1-msuchanek@suse.de>
In-Reply-To: <20171215214702.7c7afba1@kitsune.suse.cz>
References: <20171215214702.7c7afba1@kitsune.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Actually args are supposed to be renamed to next so both and args hold the
previous argument so both can be passed to the callback. This additionla patch
should fix up the rename.

---
 kernel/params.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 69ff58e69887..efb4dfaa6bc5 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -182,17 +182,18 @@ char *parse_args(const char *doing,
 
 	if (*args)
 		pr_debug("doing %s, parsing ARGS: '%s'\n", doing, args);
+	else
+		return err;
 
-	next = next_arg(args, &param, &val);
-	while (*next) {
+	do {
 		int ret;
 		int irq_was_disabled;
 
-		args = next;
 		next = next_arg(args, &param, &val);
+
 		/* Stop at -- */
 		if (!val && strcmp(param, "--") == 0)
-			return err ?: args;
+			return err ?: next;
 		irq_was_disabled = irqs_disabled();
 		ret = parse_one(param, val, args, next, doing, params, num,
 				min_level, max_level, arg, unknown);
@@ -215,9 +216,10 @@ char *parse_args(const char *doing,
 			       doing, val ?: "", param);
 			break;
 		}
-
 		err = ERR_PTR(ret);
-	}
+
+		args = next;
+	} while (*args);
 
 	return err;
 }
-- 
2.13.6

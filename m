Return-Path: <srs0=gpzr=dl=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz3xZ698XzDrvM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 08:49:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yz3xZ57Bpz8w62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 08:49:54 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yz3xZ0zlXz9sBW
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2017 08:49:53 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] Optimize final quote removal.
Date: Fri, 15 Dec 2017 22:49:41 +0100
Message-Id: <20171215214941.4871-1-msuchanek@suse.de>
In-Reply-To: <151075906562.14434.17655499193254963975.stgit@hbathini.in.ibm.com>
References: <151075906562.14434.17655499193254963975.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is additional patch that avoids the memmove when processing the quote on
the end of the parameter.

---
 lib/cmdline.c                                   | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index c5335a79a177..b1d8a0dc60fc 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -191,7 +191,13 @@ bool parse_option_str(const char *str, const char *option)
 	return false;
 }
 
+#define break_arg_end(i) { \
+	if (isspace(args[i]) && !in_quote && !backslash && !in_single) \
+		break; \
+	}
+
 #define squash_char { \
+	break_arg_end(i + 1); \
 	memmove(args + 1, args, i); \
 	args++; \
 	i--; \
@@ -209,8 +215,7 @@ char *next_arg(char *args, char **param, char **val)
 	char *next;
 
 	for (i = 0; args[i]; i++) {
-		if (isspace(args[i]) && !in_quote && !backslash && !in_single)
-			break;
+		break_arg_end(i);
 
 		if ((equals == 0) && (args[i] == '='))
 			equals = i;
-- 
2.13.6

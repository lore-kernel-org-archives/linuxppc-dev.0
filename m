Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [173.228.107.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5A28D2C0170
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 04:42:24 +1000 (EST)
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: make ftrace endian-safe.
Date: Fri, 20 Sep 2013 11:42:21 -0700
Message-Id: <1379702541-28372-2-git-send-email-ebs@ebshome.net>
In-Reply-To: <1379702541-28372-1-git-send-email-ebs@ebshome.net>
References: <1379702541-28372-1-git-send-email-ebs@ebshome.net>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Eugene Surovegin <surovegin@google.com>
---
 arch/powerpc/kernel/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 1fb7856..9b27b29 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -174,7 +174,11 @@ __ftrace_make_nop(struct module *mod,
 
 	pr_devel(" %08x %08x\n", jmp[0], jmp[1]);
 
+#ifdef __LITTLE_ENDIAN__
+	ptr = ((unsigned long)jmp[1] << 32) + jmp[0];
+#else
 	ptr = ((unsigned long)jmp[0] << 32) + jmp[1];
+#endif
 
 	/* This should match what was called */
 	if (ptr != ppc_function_entry((void *)addr)) {
-- 
1.8.1.5

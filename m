Return-Path: <kernelfans@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8AAFB2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 13:21:09 +1100 (EST)
Received: by mail-pa0-f52.google.com with SMTP id fb1so289005pad.25
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 18:21:05 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: ftrace: bugfix for test_24bit_addr
Date: Wed, 26 Feb 2014 10:23:01 +0800
Message-Id: <1393381381-30179-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The branch target should be the func addr, not the addr of func_descr_t.
So using ppc_function_entry() to generate the right target addr.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
This bug will make ftrace fail to work. It can be triggered when the kernel
size grows up.
---
 arch/powerpc/kernel/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 9b27b29..b0ded97 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -74,6 +74,7 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
  */
 static int test_24bit_addr(unsigned long ip, unsigned long addr)
 {
+	addr = ppc_function_entry((void *)addr);
 
 	/* use the create_branch to verify that this offset can be branched */
 	return create_branch((unsigned int *)ip, addr, 0);
-- 
1.8.1.4

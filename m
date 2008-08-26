Return-Path: <arjan@linux.intel.com>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by ozlabs.org (Postfix) with ESMTP id 41748DE30B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 06:33:16 +1000 (EST)
Message-ID: <48B46610.1010809@linux.intel.com>
Date: Tue, 26 Aug 2008 13:22:40 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] linux-next: Tree for August 26 - Badness at
	kernel/notifier.c:25
References: <20080826184008.6be39f19.sfr@canb.auug.org.au>
	<48B44B2D.8070809@linux.vnet.ibm.com>
In-Reply-To: <48B44B2D.8070809@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="------------060208080806030906010801"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060208080806030906010801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kamalesh Babulal wrote:
> Hi Stephen,
> 
> Badness warning is seen, while booting up the next-20080825/26 kernels on 
> the powerpc boxes
> 

this is fixed in the patch I sent to Ingo earlier today
(attached again for reference)

--------------060208080806030906010801
Content-Type: text/x-patch;
 name="0001-debug-add-notifier-chain-debugging.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-debug-add-notifier-chain-debugging.patch"

>From eafa461d187448998b1f66c9134e66b125db9531 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Tue, 26 Aug 2008 09:01:06 -0700
Subject: [PATCH] debug: add notifier chain debugging

during some development we suspected a case where we left something
in a notifier chain that was from a module that was unloaded already...
and that sort of thing is rather hard to track down.

This patch adds a very simple sanity check (which isn't all that
expensive) to make sure the notifier we're about to call is
actually from either the kernel itself of from a still-loaded
module, avoiding a hard-to-chase-down crash.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/kernel.h |    3 +++
 kernel/extable.c       |   16 ++++++++++++++++
 kernel/notifier.c      |    6 ++++++
 lib/vsprintf.c         |    2 +-
 4 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2651f80..4e1366b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -187,6 +187,9 @@ extern unsigned long long memparse(char *ptr, char **retptr);
 extern int core_kernel_text(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
+extern int func_ptr_is_kernel_text(void *ptr);
+extern void *dereference_function_descriptor(void *ptr);
+
 struct pid;
 extern struct pid *session_of_pgrp(struct pid *pgrp);
 
diff --git a/kernel/extable.c b/kernel/extable.c
index a26cb2e..adf0cc9 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -66,3 +66,19 @@ int kernel_text_address(unsigned long addr)
 		return 1;
 	return module_text_address(addr) != NULL;
 }
+
+/*
+ * On some architectures (PPC64, IA64) function pointers
+ * are actually only tokens to some data that then holds the
+ * real function address. As a result, to find if a function
+ * pointer is part of the kernel text, we need to do some
+ * special dereferencing first.
+ */
+int func_ptr_is_kernel_text(void *ptr)
+{
+	unsigned long addr;
+	addr = (unsigned long) dereference_function_descriptor(ptr);
+	if (core_kernel_text(addr))
+		return 1;
+	return module_text_address(addr) != NULL;
+}
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 823be11..522277c 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -82,6 +82,12 @@ static int __kprobes notifier_call_chain(struct notifier_block **nl,
 
 	while (nb && nr_to_call) {
 		next_nb = rcu_dereference(nb->next);
+		if (!func_ptr_is_kernel_text(nb->notifier_call)) {
+			WARN(1, "Invalid notifier called!");
+			nb = next_nb;
+			continue;
+		}
+
 		ret = nb->notifier_call(nb, val, v);
 
 		if (nr_calls)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d8d1d11..f5e5ffb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -513,7 +513,7 @@ static char *string(char *buf, char *end, char *s, int field_width, int precisio
 	return buf;
 }
 
-static inline void *dereference_function_descriptor(void *ptr)
+void *dereference_function_descriptor(void *ptr)
 {
 #if defined(CONFIG_IA64) || defined(CONFIG_PPC64)
 	void *p;
-- 
1.5.5.1


--------------060208080806030906010801--

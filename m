Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8BFF1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 03:00:09 +1100 (AEDT)
Date: Thu, 3 Dec 2015 17:00:04 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20151203160004.GE8047@pathway.suse.cz>
References: <20151125172608.9588569260@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151125172608.9588569260@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2015-11-25 17:53:17, Torsten Duwe wrote:
> Torsten Duwe (9):
>   ppc64 (le): prepare for -mprofile-kernel
>   ppc64le FTRACE_WITH_REGS implementation
>   ppc use ftrace_modify_all_code default
>   ppc64 ftrace_with_regs configuration variables
>   ppc64 ftrace_with_regs: spare early boot and low level
>   ppc64 ftrace: disable profiling for some functions
>   ppc64 ftrace: disable profiling for some files
>   Implement kernel live patching for ppc64le (ABIv2)
>   Enable LIVEPATCH to be configured on ppc64le and add livepatch.o if it
>     is selected.

I had to add the patch below to get LivePatching working.

I tested it the following way:

# livepatching sample
CONFIG_SAMPLES=y
CONFIG_SAMPLE_LIVEPATCH=m

# booted the compiled kernel and printed the default cmdline
$> cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.4.0-rc3-11-default+ root=UUID=...

# loaded the patch and printed the patch cmdline
$> modprobe livepatch-sample
$> cat /proc/cmdline
this has been live patched

# tried to disable and enable the patch
$> echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled
$> cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.4.0-rc3-11-default+ root=UUID=...
$> echo 1 > /sys/kernel/livepatch/livepatch_sample/enabled
$> cat /proc/cmdline
this has been live patched

# also checked messages
$> dmesg | tail -n 4
[   33.673057] livepatch: tainting kernel with TAINT_LIVEPATCH
[   33.673068] livepatch: enabling patch 'livepatch_sample'
[ 1997.098257] livepatch: disabling patch 'livepatch_sample'
[ 2079.696277] livepatch: enabling patch 'livepatch_sample'


Here is the patch:

>From 7eb6f9453c81a996b0f5ffcb8725facadd9ec718 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 3 Dec 2015 13:28:19 +0100
Subject: [PATCH] livepatch: Support ftrace location with an offset

ftrace_set_filter_ip() function requires the exact ftrace location
as a parameter. It is the same as the function address on x86 and s390.
But it is after the TOC load and LR save on powerpc.

This patch adds klp_ftrace_location() arch-specific function that
will compute the ftrace location from the function address.

I thought about handling this with a constant (define) but I
am not sure if it always would be a constant. I also thought
about a weak function. But this seems to be a good compromise.
We are ready for complications and the compiler still might
optimize it.

I made it livepatch-specific to keep it simple. Ftrace supports
more locations of the handler, e.g. Mcount on x86. But livepatching
does not support most of them. Also ftrace does not know the offset
easily because it gets the ftrace locations from __mcount_loc
object section.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/powerpc/include/asm/livepatch.h | 10 ++++++++++
 arch/s390/include/asm/livepatch.h    |  9 +++++++++
 arch/x86/include/asm/livepatch.h     | 10 ++++++++++
 kernel/livepatch/core.c              | 10 +++++++---
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 3200c1152122..aa7e15dae58c 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -34,6 +34,16 @@ static inline int klp_check_compiler_support(void)
 extern int klp_write_module_reloc(struct module *mod, unsigned long type,
 				   unsigned long loc, unsigned long value);
 
+/*
+ * LivePatching works on PPC only when the kernel is compiled with
+ * -mprofile-kernel. The ftrace handler is called after the TOC load
+ * and LR save (16 bytes).
+ */
+static inline unsigned long klp_ftrace_location(unsigned long faddr)
+{
+	return faddr + 16;
+}
+
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->nip = ip;
diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
index 7aa799134a11..b853a1e48d04 100644
--- a/arch/s390/include/asm/livepatch.h
+++ b/arch/s390/include/asm/livepatch.h
@@ -32,6 +32,15 @@ static inline int klp_write_module_reloc(struct module *mod, unsigned long
 	return -ENOSYS;
 }
 
+/*
+ * LivePatching works only when the ftrace handler is called from the first
+ * instruction of the patched function on s390.
+ */
+static inline unsigned long klp_ftrace_location(unsigned long faddr)
+{
+	return faddr;
+}
+
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->psw.addr = ip;
diff --git a/arch/x86/include/asm/livepatch.h b/arch/x86/include/asm/livepatch.h
index 19c099afa861..9a8c84d3fae2 100644
--- a/arch/x86/include/asm/livepatch.h
+++ b/arch/x86/include/asm/livepatch.h
@@ -36,6 +36,16 @@ static inline int klp_check_compiler_support(void)
 int klp_write_module_reloc(struct module *mod, unsigned long type,
 			   unsigned long loc, unsigned long value);
 
+
+/*
+ * LivePatching works only when ftrace uses fentry on x86. Therefore
+ * the ftrace location is the same as the address of the function.
+ */
+static inline unsigned long klp_ftrace_location(unsigned long faddr)
+{
+	return faddr;
+}
+
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->ip = ip;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index db545cbcdb89..f9dc8889e1f1 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -364,8 +364,10 @@ static void klp_disable_func(struct klp_func *func)
 		return;
 
 	if (list_is_singular(&ops->func_stack)) {
+		unsigned long ftrace_loc = klp_ftrace_location(func->old_addr);
+
 		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
+		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
@@ -390,6 +392,8 @@ static int klp_enable_func(struct klp_func *func)
 
 	ops = klp_find_ops(func->old_addr);
 	if (!ops) {
+		unsigned long ftrace_loc = klp_ftrace_location(func->old_addr);
+
 		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 		if (!ops)
 			return -ENOMEM;
@@ -404,7 +408,7 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);
@@ -415,7 +419,7 @@ static int klp_enable_func(struct klp_func *func)
 		if (ret) {
 			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
 			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
 			goto err;
 		}
 
-- 
1.8.5.6

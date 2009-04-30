Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A166DE001
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 10:08:42 +1000 (EST)
From: Tim Abbott <tabbott@MIT.EDU>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 6/8] powerpc: use new macros for .data.init_task.
Date: Thu, 30 Apr 2009 19:56:15 -0400
Message-Id: <1241135777-9462-7-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135777-9462-6-git-send-email-tabbott@mit.edu>
References: <1241135777-9462-1-git-send-email-tabbott@mit.edu>
	<1241135777-9462-2-git-send-email-tabbott@mit.edu>
	<1241135777-9462-3-git-send-email-tabbott@mit.edu>
	<1241135777-9462-4-git-send-email-tabbott@mit.edu>
	<1241135777-9462-5-git-send-email-tabbott@mit.edu>
	<1241135777-9462-6-git-send-email-tabbott@mit.edu>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@mit.edu>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Tim Abbott <tabbott@mit.edu>,
	Waseem Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

.data.init_task should not need a separate output section; this change
moves it into the .data section.

This patch uses THREAD_SIZE rather than 8192/16384 for the alignment.
This should have the effect of increasing the alignment to 32768 if
CONFIG_PPC_256K_PAGES is defined, but it seems that it should be that
way.  One of the powerpc maintainers should confirm that this is
correct, otherwise we can go back to the #ifdef.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/init_task.c        |    3 +--
 arch/powerpc/kernel/machine_kexec_64.c |    4 ++--
 arch/powerpc/kernel/vmlinux.lds.S      |   13 +++----------
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/init_task.c b/arch/powerpc/kernel/init_task.c
index 688b329..a4eb25d 100644
--- a/arch/powerpc/kernel/init_task.c
+++ b/arch/powerpc/kernel/init_task.c
@@ -20,8 +20,7 @@ EXPORT_SYMBOL(init_mm);
  * way process stacks are handled. This is done by having a special
  * "init_task" linker map entry..
  */
-union thread_union init_thread_union 
-	__attribute__((__section__(".data.init_task"))) =
+union thread_union init_thread_union __init_task_data =
 		{ INIT_THREAD_INFO(init_task) };
 
 /*
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 49e705f..3761f76 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -10,6 +10,7 @@
  */
 
 
+#include <linux/init_task.h>
 #include <linux/kexec.h>
 #include <linux/smp.h>
 #include <linux/thread_info.h>
@@ -249,8 +250,7 @@ static void kexec_prepare_cpus(void)
  * We could use a smaller stack if we don't care about anything using
  * current, but that audit has not been performed.
  */
-static union thread_union kexec_stack
-	__attribute__((__section__(".data.init_task"))) = { };
+static union thread_union kexec_stack __init_task_data = { };
 
 /* Our assembly helper, in kexec_stub.S */
 extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long start,
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index e769717..f91d7c1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
+#include <asm/thread_info.h>
 
 ENTRY(_stext)
 
@@ -221,6 +222,8 @@ SECTIONS
 	_sdata = .;
 
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
+		/* The initial task and kernel stack */
+		INIT_TASK_DATA(THREAD_SIZE)
 		PAGE_ALIGNED_DATA
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
@@ -251,16 +254,6 @@ SECTIONS
 	_edata  =  .;
 	PROVIDE32 (edata = .);
 
-	/* The initial task and kernel stack */
-#ifdef CONFIG_PPC32
-	. = ALIGN(8192);
-#else
-	. = ALIGN(16384);
-#endif
-	.data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
-		*(.data.init_task)
-	}
-
 	. = ALIGN(L1_CACHE_BYTES);
 	.data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) {
 		*(.data.read_mostly)
-- 
1.6.2.1

Return-Path: <jslaby@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW61b60fTzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 23:58:27 +1100 (AEDT)
From: Jiri Slaby <jslaby@suse.cz>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>, Jeff Dike <jdike@addtoit.com>,
 Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
Subject: [PATCH 3/4] exit_thread: accept a task parameter to be exited
Date: Thu, 24 Mar 2016 13:58:13 +0100
Message-Id: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to call exit_thread from copy_process in a fail path.  So make
it accept task_struct as a parameter.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Steven Miao <realmz6@gmail.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Chen Liqin <liqin.linux@gmail.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: adi-buildroot-devel@lists.sourceforge.net
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-cris-kernel@axis.com
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-metag@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-am33-list@redhat.com
Cc: nios2-dev@lists.rocketboards.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
Cc: linux-xtensa@linux-xtensa.org
---
 arch/alpha/kernel/process.c             |  2 +-
 arch/arc/kernel/process.c               |  2 +-
 arch/arm/kernel/process.c               |  4 ++--
 arch/arm64/kernel/process.c             |  2 +-
 arch/avr32/kernel/process.c             |  4 ++--
 arch/blackfin/include/asm/processor.h   |  2 +-
 arch/c6x/kernel/process.c               |  2 +-
 arch/cris/arch-v10/kernel/process.c     |  2 +-
 arch/cris/arch-v32/kernel/process.c     |  4 ++--
 arch/frv/include/asm/processor.h        |  2 +-
 arch/h8300/include/asm/processor.h      |  2 +-
 arch/hexagon/kernel/process.c           |  2 +-
 arch/ia64/kernel/perfmon.c              |  4 ++--
 arch/ia64/kernel/process.c              | 14 +++++++-------
 arch/m32r/kernel/process.c              |  4 ++--
 arch/m68k/include/asm/processor.h       |  2 +-
 arch/metag/include/asm/processor.h      |  2 +-
 arch/metag/kernel/process.c             |  6 +++---
 arch/microblaze/include/asm/processor.h |  4 ++--
 arch/mips/kernel/process.c              |  2 +-
 arch/mn10300/kernel/process.c           |  4 ++--
 arch/nios2/include/asm/processor.h      |  2 +-
 arch/openrisc/include/asm/processor.h   |  2 +-
 arch/parisc/kernel/process.c            |  2 +-
 arch/powerpc/kernel/process.c           |  2 +-
 arch/s390/kernel/process.c              |  4 ++--
 arch/score/kernel/process.c             |  2 +-
 arch/sh/kernel/process_32.c             |  2 +-
 arch/sh/kernel/process_64.c             |  4 ++--
 arch/sparc/kernel/process_32.c          | 12 ++++++------
 arch/sparc/kernel/process_64.c          |  4 ++--
 arch/tile/kernel/process.c              |  4 ++--
 arch/um/kernel/process.c                |  2 +-
 arch/unicore32/kernel/process.c         |  2 +-
 arch/x86/kernel/process.c               |  3 +--
 arch/xtensa/kernel/process.c            |  4 ++--
 include/linux/sched.h                   |  2 +-
 kernel/exit.c                           |  2 +-
 38 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 84d13263ce46..1e044d1f7525 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL(start_thread);
  * Free current thread data structures etc..
  */
 void
-exit_thread(void)
+exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index a3f750e76b68..70944dfab6c6 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -186,7 +186,7 @@ void flush_thread(void)
 /*
  * Free any architecture-specific thread data structures, etc.
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 4adfb46e3ee9..e8ecd02bf7ea 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -193,9 +193,9 @@ EXPORT_SYMBOL_GPL(thread_notify_head);
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	thread_notify(THREAD_NOTIFY_EXIT, current_thread_info());
+	thread_notify(THREAD_NOTIFY_EXIT, task_thread_info(me));
 }
 
 void flush_thread(void)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 80624829db61..84b288c85e4a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -203,7 +203,7 @@ void show_regs(struct pt_regs * regs)
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/avr32/kernel/process.c b/arch/avr32/kernel/process.c
index 42a53e740a7e..ea21d0e99b6b 100644
--- a/arch/avr32/kernel/process.c
+++ b/arch/avr32/kernel/process.c
@@ -62,9 +62,9 @@ void machine_restart(char *cmd)
 /*
  * Free current thread data structures etc
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	ocd_disable(current);
+	ocd_disable(me);
 }
 
 void flush_thread(void)
diff --git a/arch/blackfin/include/asm/processor.h b/arch/blackfin/include/asm/processor.h
index 7acd46653df3..7aa6cd0ac8d9 100644
--- a/arch/blackfin/include/asm/processor.h
+++ b/arch/blackfin/include/asm/processor.h
@@ -78,7 +78,7 @@ static inline void release_thread(struct task_struct *dead_task)
 /*
  * Free current thread data structures etc..
  */
-static inline void exit_thread(void)
+static inline void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
index 3ae9f5a166a0..4b2dfb1d330d 100644
--- a/arch/c6x/kernel/process.c
+++ b/arch/c6x/kernel/process.c
@@ -82,7 +82,7 @@ void flush_thread(void)
 {
 }
 
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/cris/arch-v10/kernel/process.c b/arch/cris/arch-v10/kernel/process.c
index 02b783457be0..2aaaccc3883c 100644
--- a/arch/cris/arch-v10/kernel/process.c
+++ b/arch/cris/arch-v10/kernel/process.c
@@ -39,7 +39,7 @@ void default_idle(void)
  * Free current thread data structures etc..
  */
 
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 	/* Nothing needs to be done.  */
 }
diff --git a/arch/cris/arch-v32/kernel/process.c b/arch/cris/arch-v32/kernel/process.c
index c7ce784a393c..5f55d15366ea 100644
--- a/arch/cris/arch-v32/kernel/process.c
+++ b/arch/cris/arch-v32/kernel/process.c
@@ -33,9 +33,9 @@ void default_idle(void)
  */
 
 extern void deconfigure_bp(long pid);
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	deconfigure_bp(current->pid);
+	deconfigure_bp(me->pid);
 }
 
 /*
diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
index ae8d423e79d9..cff4440abcee 100644
--- a/arch/frv/include/asm/processor.h
+++ b/arch/frv/include/asm/processor.h
@@ -99,7 +99,7 @@ extern asmlinkage void *restore_user_regs(const struct user_context *target, ...
 /*
  * Free current thread data structures etc..
  */
-static inline void exit_thread(void)
+static inline void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index 54e3fd83c336..d79f99c645ad 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -113,7 +113,7 @@ static inline void release_thread(struct task_struct *dead_task)
 /*
  * Free current thread data structures etc..
  */
-static inline void exit_thread(void)
+static inline void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index a9ebd471823a..228b77433fe8 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -139,7 +139,7 @@ void release_thread(struct task_struct *dead_task)
 /*
  * Free any architecture-specific thread data structures, etc.
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 9cd607b06964..2436ad5f92c1 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -4542,8 +4542,8 @@ pfm_context_unload(pfm_context_t *ctx, void *arg, int count, struct pt_regs *reg
 
 
 /*
- * called only from exit_thread(): task == current
- * we come here only if current has a context attached (loaded or masked)
+ * called only from exit_thread()
+ * we come here only if the task has a context attached (loaded or masked)
  */
 void
 pfm_exit_thread(struct task_struct *task)
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index b51514957620..445f09fb2820 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -570,22 +570,22 @@ flush_thread (void)
 }
 
 /*
- * Clean up state associated with current thread.  This is called when
+ * Clean up state associated with a thread.  This is called when
  * the thread calls exit().
  */
 void
-exit_thread (void)
+exit_thread (struct task_struct *me)
 {
 
-	ia64_drop_fpu(current);
+	ia64_drop_fpu(me);
 #ifdef CONFIG_PERFMON
        /* if needed, stop monitoring and flush state to perfmon context */
-	if (current->thread.pfm_context)
-		pfm_exit_thread(current);
+	if (me->thread.pfm_context)
+		pfm_exit_thread(me);
 
 	/* free debug register resources */
-	if (current->thread.flags & IA64_THREAD_DBG_VALID)
-		pfm_release_debug_registers(current);
+	if (me->thread.flags & IA64_THREAD_DBG_VALID)
+		pfm_release_debug_registers(me);
 #endif
 }
 
diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
index e69221d581d5..00a41866b05e 100644
--- a/arch/m32r/kernel/process.c
+++ b/arch/m32r/kernel/process.c
@@ -104,10 +104,10 @@ void show_regs(struct pt_regs * regs)
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 	/* Nothing to do. */
-	DPRINTK("pid = %d\n", current->pid);
+	DPRINTK("pid = %d\n", me->pid);
 }
 
 void flush_thread(void)
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index 20dda1d4b860..57ef5d420307 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -156,7 +156,7 @@ static inline void release_thread(struct task_struct *dead_task)
 /*
  * Free current thread data structures etc..
  */
-static inline void exit_thread(void)
+static inline void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/metag/include/asm/processor.h b/arch/metag/include/asm/processor.h
index 0838ca699764..daf7943168f0 100644
--- a/arch/metag/include/asm/processor.h
+++ b/arch/metag/include/asm/processor.h
@@ -134,7 +134,7 @@ static inline void release_thread(struct task_struct *dead_task)
 #define copy_segments(tsk, mm)		do { } while (0)
 #define release_segments(mm)		do { } while (0)
 
-extern void exit_thread(void);
+extern void exit_thread(struct task_struct *me);
 
 /*
  * Return saved PC of a blocked thread.
diff --git a/arch/metag/kernel/process.c b/arch/metag/kernel/process.c
index 7f546183a0f0..f5c507c3d804 100644
--- a/arch/metag/kernel/process.c
+++ b/arch/metag/kernel/process.c
@@ -345,10 +345,10 @@ void flush_thread(void)
 /*
  * Free current thread data structures etc.
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	clear_fpu(&current->thread);
-	clear_dsp(&current->thread);
+	clear_fpu(&me->thread);
+	clear_dsp(&me->thread);
 }
 
 /* TODO: figure out how to unwind the kernel stack here to figure out
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 497a988d79c2..41300e76aac0 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -71,7 +71,7 @@ static inline void release_thread(struct task_struct *dead_task)
 }
 
 /* Free all resources held by a thread. */
-static inline void exit_thread(void)
+static inline void exit_thread(struct task_struct *me)
 {
 }
 
@@ -128,7 +128,7 @@ static inline void release_thread(struct task_struct *dead_task)
 }
 
 /* Free current thread data structures etc.  */
-static inline void exit_thread(void)
+static inline void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 92880cee449e..26f90e9ea288 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -73,7 +73,7 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 	regs->regs[29] = sp;
 }
 
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/mn10300/kernel/process.c b/arch/mn10300/kernel/process.c
index 74a96ccf7451..99d73b5c2d33 100644
--- a/arch/mn10300/kernel/process.c
+++ b/arch/mn10300/kernel/process.c
@@ -103,9 +103,9 @@ void show_regs(struct pt_regs *regs)
 /*
  * free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	exit_fpu(current);
+	exit_fpu(me);
 }
 
 void flush_thread(void)
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
index c2ba45c159c7..a8443c158d65 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -76,7 +76,7 @@ static inline void release_thread(struct task_struct *dead_task)
 }
 
 /* Free current thread data structures etc.. */
-static inline void exit_thread(void)
+static inline void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 4d235e3d2534..26a8f3760a71 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -88,7 +88,7 @@ unsigned long get_wchan(struct task_struct *p);
  * Free current thread data structures etc..
  */
 
-extern inline void exit_thread(void)
+extern inline void exit_thread(struct task_struct *me)
 {
 	/* Nothing needs to be done.  */
 }
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 809905a811ed..5750fe642202 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -147,7 +147,7 @@ EXPORT_SYMBOL(pm_power_off);
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 612df305886b..bb6da7f3c27b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1326,7 +1326,7 @@ void show_regs(struct pt_regs * regs)
 		show_instructions(regs);
 }
 
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 7fabc985a7dd..b86625490090 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -70,9 +70,9 @@ extern void kernel_thread_starter(void);
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	exit_thread_runtime_instr(current);
+	exit_thread_runtime_instr(me);
 }
 
 void flush_thread(void)
diff --git a/arch/score/kernel/process.c b/arch/score/kernel/process.c
index a1519ad3d49d..de22a45558d6 100644
--- a/arch/score/kernel/process.c
+++ b/arch/score/kernel/process.c
@@ -56,7 +56,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	regs->regs[0] = sp;
 }
 
-void exit_thread(void) {}
+void exit_thread(struct task_struct *me) {}
 
 /*
  * When a process does an "exec", machine state like FPU and debug
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 2885fc9d9dcd..4e360f2be5fd 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(start_thread);
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index e2062e643341..8bb717f5bfc9 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -288,7 +288,7 @@ void show_regs(struct pt_regs *regs)
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 	/*
 	 * See arch/sparc/kernel/process.c for the precedent for doing
@@ -307,7 +307,7 @@ void exit_thread(void)
 	 * which it would get safely nulled.
 	 */
 #ifdef CONFIG_SH_FPU
-	if (last_task_used_math == current) {
+	if (last_task_used_math == me) {
 		last_task_used_math = NULL;
 	}
 #endif
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index c5113c7ce2fd..00ade5a2f5e8 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -184,21 +184,21 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 #ifndef CONFIG_SMP
-	if(last_task_used_math == current) {
+	if (last_task_used_math == me) {
 #else
-	if (test_thread_flag(TIF_USEDFPU)) {
+	if (test_ti_thread_flag(task_thread_info(me), TIF_USEDFPU)) {
 #endif
 		/* Keep process from leaving FPU in a bogon state. */
 		put_psr(get_psr() | PSR_EF);
-		fpsave(&current->thread.float_regs[0], &current->thread.fsr,
-		       &current->thread.fpqueue[0], &current->thread.fpqdepth);
+		fpsave(&me->thread.float_regs[0], &me->thread.fsr,
+		       &me->thread.fpqueue[0], &me->thread.fpqdepth);
 #ifndef CONFIG_SMP
 		last_task_used_math = NULL;
 #else
-		clear_thread_flag(TIF_USEDFPU);
+		clear_ti_thread_flag(task_thread_info(me), TIF_USEDFPU);
 #endif
 	}
 }
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 46a59643bb1c..5cb4077f5cb8 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -417,9 +417,9 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 }
 
 /* Free current thread data structures etc.. */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	struct thread_info *t = current_thread_info();
+	struct thread_info *t = task_thread_info(me);
 
 	if (t->utraps) {
 		if (t->utraps[0] < 2)
diff --git a/arch/tile/kernel/process.c b/arch/tile/kernel/process.c
index b5f30d376ce1..94080d327efc 100644
--- a/arch/tile/kernel/process.c
+++ b/arch/tile/kernel/process.c
@@ -541,7 +541,7 @@ void flush_thread(void)
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 #ifdef CONFIG_HARDWALL
 	/*
@@ -550,7 +550,7 @@ void exit_thread(void)
 	 * the last reference to a hardwall fd, it would already have
 	 * been released and deactivated at this point.)
 	 */
-	hardwall_deactivate_all(current);
+	hardwall_deactivate_all(me);
 #endif
 }
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 48af59aae129..06eb532965d1 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -103,7 +103,7 @@ void interrupt_end(void)
 		tracehook_notify_resume(regs);
 }
 
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/process.c
index b008e9961465..7c23697bc2ed 100644
--- a/arch/unicore32/kernel/process.c
+++ b/arch/unicore32/kernel/process.c
@@ -204,7 +204,7 @@ void show_regs(struct pt_regs *regs)
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2915d54e9dd5..55c97e4ef71b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -97,9 +97,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 /*
  * Free current thread data structures etc..
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
-	struct task_struct *me = current;
 	struct thread_struct *t = &me->thread;
 	unsigned long *bp = t->io_bitmap_ptr;
 	struct fpu *fpu = &t->fpu;
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 5bbfed81c97b..6f3b54eb346c 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -115,10 +115,10 @@ void arch_cpu_idle(void)
 /*
  * This is called when the thread calls exit().
  */
-void exit_thread(void)
+void exit_thread(struct task_struct *me)
 {
 #if XTENSA_HAVE_COPROCESSORS
-	coprocessor_release_all(current_thread_info());
+	coprocessor_release_all(task_thread_info(me));
 #endif
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index af5cc4768026..db4daa3aa894 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2648,7 +2648,7 @@ static inline int copy_thread_tls(
 }
 #endif
 extern void flush_thread(void);
-extern void exit_thread(void);
+extern void exit_thread(struct task_struct *);
 
 extern void exit_files(struct task_struct *);
 extern void __cleanup_sighand(struct sighand_struct *);
diff --git a/kernel/exit.c b/kernel/exit.c
index fd90195667e1..75b34fe835b2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -746,7 +746,7 @@ void do_exit(long code)
 		disassociate_ctty(1);
 	exit_task_namespaces(tsk);
 	exit_task_work(tsk);
-	exit_thread();
+	exit_thread(tsk);
 
 	/*
 	 * Flush inherited counters to the parent - before the parent
-- 
2.7.4

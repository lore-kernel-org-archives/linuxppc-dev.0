Return-Path: <jslaby@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbGzl0PmhzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 18:56:18 +1100 (AEDT)
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
 Richard Kuo <rkuo@codeaurora.org>,
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
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 2/4] exit_thread: remove empty bodies
Date: Thu, 31 Mar 2016 09:55:53 +0200
Message-Id: <1459410955-5422-2-git-send-email-jslaby@suse.cz>
In-Reply-To: <1459410955-5422-1-git-send-email-jslaby@suse.cz>
References: <1459410955-5422-1-git-send-email-jslaby@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define HAVE_EXIT_THREAD for archs which want to do something in
exit_thread. For others, let's define exit_thread as an empty inline.

This is a cleanup before we change the prototype of exit_thread to
accept a task parameter.

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
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: adi-buildroot-devel@lists.sourceforge.net
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-cris-kernel@axis.com
Cc: linux-ia64@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-hexagon@vger.kernel.org
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
 arch/Kconfig                            |  5 +++++
 arch/alpha/kernel/process.c             |  8 --------
 arch/arc/kernel/process.c               |  7 -------
 arch/arm/Kconfig                        |  1 +
 arch/arm64/kernel/process.c             |  7 -------
 arch/avr32/Kconfig                      |  1 +
 arch/blackfin/include/asm/processor.h   |  7 -------
 arch/c6x/kernel/process.c               |  4 ----
 arch/cris/Kconfig                       |  1 +
 arch/cris/arch-v10/kernel/process.c     |  9 ---------
 arch/frv/include/asm/processor.h        |  7 -------
 arch/h8300/include/asm/processor.h      |  7 -------
 arch/hexagon/kernel/process.c           |  7 -------
 arch/ia64/Kconfig                       |  1 +
 arch/m32r/kernel/process.c              |  9 ---------
 arch/m68k/include/asm/processor.h       |  7 -------
 arch/metag/Kconfig                      |  1 +
 arch/metag/include/asm/processor.h      |  2 --
 arch/microblaze/include/asm/processor.h | 10 ----------
 arch/mips/include/asm/processor.h       |  4 ----
 arch/mn10300/Kconfig                    |  1 +
 arch/nios2/include/asm/processor.h      |  5 -----
 arch/openrisc/include/asm/processor.h   |  9 ---------
 arch/parisc/kernel/process.c            |  7 -------
 arch/powerpc/kernel/process.c           |  4 ----
 arch/s390/Kconfig                       |  1 +
 arch/score/kernel/process.c             |  2 --
 arch/sh/Kconfig                         |  1 +
 arch/sh/kernel/process_32.c             |  7 -------
 arch/sparc/Kconfig                      |  1 +
 arch/tile/Kconfig                       |  1 +
 arch/um/kernel/process.c                |  4 ----
 arch/unicore32/kernel/process.c         |  7 -------
 arch/x86/Kconfig                        |  1 +
 arch/xtensa/Kconfig                     |  1 +
 include/linux/sched.h                   |  7 +++++++
 36 files changed, 24 insertions(+), 140 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 81869a5e7e17..0f298f9123dc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -517,6 +517,11 @@ config HAVE_ARCH_MMAP_RND_BITS
 	  - ARCH_MMAP_RND_BITS_MIN
 	  - ARCH_MMAP_RND_BITS_MAX
 
+config HAVE_EXIT_THREAD
+	bool
+	help
+	  An architecture implements exit_thread.
+
 config ARCH_MMAP_RND_BITS_MIN
 	int
 
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 84d13263ce46..b483156698d5 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -210,14 +210,6 @@ start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 }
 EXPORT_SYMBOL(start_thread);
 
-/*
- * Free current thread data structures etc..
- */
-void
-exit_thread(void)
-{
-}
-
 void
 flush_thread(void)
 {
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index a3f750e76b68..b5db9e7fd649 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -183,13 +183,6 @@ void flush_thread(void)
 {
 }
 
-/*
- * Free any architecture-specific thread data structures, etc.
- */
-void exit_thread(void)
-{
-}
-
 int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 {
 	return 0;
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2b7626..0846026c84de 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,7 @@ config ARM
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
+	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 80624829db61..5655f756e4f2 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -200,13 +200,6 @@ void show_regs(struct pt_regs * regs)
 	__show_regs(regs);
 }
 
-/*
- * Free current thread data structures etc..
- */
-void exit_thread(void)
-{
-}
-
 static void tls_thread_flush(void)
 {
 	asm ("msr tpidr_el0, xzr");
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index b6878eb64884..37d9c02be634 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -4,6 +4,7 @@ config AVR32
 	# that we usually don't need on AVR32.
 	select EXPERT
 	select HAVE_CLK
+	select HAVE_EXIT_THREAD
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
 	select VIRT_TO_BUS
diff --git a/arch/blackfin/include/asm/processor.h b/arch/blackfin/include/asm/processor.h
index 7acd46653df3..0c265aba94ad 100644
--- a/arch/blackfin/include/asm/processor.h
+++ b/arch/blackfin/include/asm/processor.h
@@ -76,13 +76,6 @@ static inline void release_thread(struct task_struct *dead_task)
 }
 
 /*
- * Free current thread data structures etc..
- */
-static inline void exit_thread(void)
-{
-}
-
-/*
  * Return saved PC of a blocked thread.
  */
 #define thread_saved_pc(tsk)	(tsk->thread.pc)
diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
index 3ae9f5a166a0..0ee7686a78f3 100644
--- a/arch/c6x/kernel/process.c
+++ b/arch/c6x/kernel/process.c
@@ -82,10 +82,6 @@ void flush_thread(void)
 {
 }
 
-void exit_thread(void)
-{
-}
-
 /*
  * Do necessary setup to start up a newly executed thread.
  */
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index e086f9e93728..10a5ccb85cd6 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -62,6 +62,7 @@ config CRIS
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
 	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_EXIT_THREAD if ETRAX_ARCH_V32
 	select IRQ_DOMAIN if ETRAX_ARCH_V32
 	select OF if ETRAX_ARCH_V32
 	select OF_EARLY_FLATTREE if ETRAX_ARCH_V32
diff --git a/arch/cris/arch-v10/kernel/process.c b/arch/cris/arch-v10/kernel/process.c
index 02b783457be0..96e5afef6b47 100644
--- a/arch/cris/arch-v10/kernel/process.c
+++ b/arch/cris/arch-v10/kernel/process.c
@@ -35,15 +35,6 @@ void default_idle(void)
 	local_irq_enable();
 }
 
-/*
- * Free current thread data structures etc..
- */
-
-void exit_thread(void)
-{
-	/* Nothing needs to be done.  */
-}
-
 /* if the watchdog is enabled, we can simply disable interrupts and go
  * into an eternal loop, and the watchdog will reset the CPU after 0.1s
  * if on the other hand the watchdog wasn't enabled, we just enable it and wait
diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
index ae8d423e79d9..73f0a79ad8e6 100644
--- a/arch/frv/include/asm/processor.h
+++ b/arch/frv/include/asm/processor.h
@@ -97,13 +97,6 @@ extern asmlinkage void *restore_user_regs(const struct user_context *target, ...
 #define forget_segments()		do { } while (0)
 
 /*
- * Free current thread data structures etc..
- */
-static inline void exit_thread(void)
-{
-}
-
-/*
  * Return saved PC of a blocked thread.
  */
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index 54e3fd83c336..111df7397ac7 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -111,13 +111,6 @@ static inline void release_thread(struct task_struct *dead_task)
 }
 
 /*
- * Free current thread data structures etc..
- */
-static inline void exit_thread(void)
-{
-}
-
-/*
  * Return saved PC of a blocked thread.
  */
 unsigned long thread_saved_pc(struct task_struct *tsk);
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index a9ebd471823a..d9edfd3fc52a 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -137,13 +137,6 @@ void release_thread(struct task_struct *dead_task)
 }
 
 /*
- * Free any architecture-specific thread data structures, etc.
- */
-void exit_thread(void)
-{
-}
-
-/*
  * Some archs flush debug and FPU info here
  */
 void flush_thread(void)
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index b534ebab36ea..f80758cb7157 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -18,6 +18,7 @@ config IA64
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_EXIT_THREAD
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
index e69221d581d5..a88b1f01e91f 100644
--- a/arch/m32r/kernel/process.c
+++ b/arch/m32r/kernel/process.c
@@ -101,15 +101,6 @@ void show_regs(struct pt_regs * regs)
 #endif
 }
 
-/*
- * Free current thread data structures etc..
- */
-void exit_thread(void)
-{
-	/* Nothing to do. */
-	DPRINTK("pid = %d\n", current->pid);
-}
-
 void flush_thread(void)
 {
 	DPRINTK("pid = %d\n", current->pid);
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index 20dda1d4b860..a6ce2ec8d693 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -153,13 +153,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/*
- * Free current thread data structures etc..
- */
-static inline void exit_thread(void)
-{
-}
-
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 unsigned long get_wchan(struct task_struct *p);
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index a0fa88da3e31..e47a08d72819 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -11,6 +11,7 @@ config METAG
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_KERNEL_BZIP2
diff --git a/arch/metag/include/asm/processor.h b/arch/metag/include/asm/processor.h
index 0838ca699764..a0333ebcac35 100644
--- a/arch/metag/include/asm/processor.h
+++ b/arch/metag/include/asm/processor.h
@@ -134,8 +134,6 @@ static inline void release_thread(struct task_struct *dead_task)
 #define copy_segments(tsk, mm)		do { } while (0)
 #define release_segments(mm)		do { } while (0)
 
-extern void exit_thread(void);
-
 /*
  * Return saved PC of a blocked thread.
  */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 497a988d79c2..c38d0dd91134 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -70,11 +70,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/* Free all resources held by a thread. */
-static inline void exit_thread(void)
-{
-}
-
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
 extern unsigned long get_wchan(struct task_struct *p);
@@ -127,11 +122,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/* Free current thread data structures etc.  */
-static inline void exit_thread(void)
-{
-}
-
 /* Return saved (kernel) PC of a blocked thread.  */
 #  define thread_saved_pc(tsk)	\
 	((tsk)->thread.regs ? (tsk)->thread.regs->r15 : 0)
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 06469df2b638..cfa15bad43af 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -359,10 +359,6 @@ static inline void flush_thread(void)
 {
 }
 
-static inline void exit_thread(void)
-{
-}
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index 06ddb5501ab1..9627e81a6cbb 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -1,5 +1,6 @@
 config MN10300
 	def_bool y
+	select HAVE_EXIT_THREAD
 	select HAVE_OPROFILE
 	select HAVE_UID16
 	select GENERIC_IRQ_SHOW
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
index c2ba45c159c7..1c953f0cadbf 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -75,11 +75,6 @@ static inline void release_thread(struct task_struct *dead_task)
 {
 }
 
-/* Free current thread data structures etc.. */
-static inline void exit_thread(void)
-{
-}
-
 /* Return saved PC of a blocked thread. */
 #define thread_saved_pc(tsk)	((tsk)->thread.kregs->ea)
 
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 4d235e3d2534..70334c9f7d24 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -85,15 +85,6 @@ void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);
 
 /*
- * Free current thread data structures etc..
- */
-
-extern inline void exit_thread(void)
-{
-	/* Nothing needs to be done.  */
-}
-
-/*
  * Return saved PC of a blocked thread. For now, this is the "user" PC
  */
 extern unsigned long thread_saved_pc(struct task_struct *t);
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 809905a811ed..40639439d8b3 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -144,13 +144,6 @@ void machine_power_off(void)
 void (*pm_power_off)(void) = machine_power_off;
 EXPORT_SYMBOL(pm_power_off);
 
-/*
- * Free current thread data structures etc..
- */
-void exit_thread(void)
-{
-}
-
 void flush_thread(void)
 {
 	/* Only needs to handle fpu stuff or perf monitors.
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 612df305886b..e323020d91dd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1326,10 +1326,6 @@ void show_regs(struct pt_regs * regs)
 		show_instructions(regs);
 }
 
-void exit_thread(void)
-{
-}
-
 void flush_thread(void)
 {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 43b25835325f..37941df616d9 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -130,6 +130,7 @@ config S390
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/score/kernel/process.c b/arch/score/kernel/process.c
index a1519ad3d49d..aae9480706c2 100644
--- a/arch/score/kernel/process.c
+++ b/arch/score/kernel/process.c
@@ -56,8 +56,6 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	regs->regs[0] = sp;
 }
 
-void exit_thread(void) {}
-
 /*
  * When a process does an "exec", machine state like FPU and debug
  * registers need to be reset.  This is a hook function for that.
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ed20fc3fc81..cb93af8f8017 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -71,6 +71,7 @@ config SUPERH32
 
 config SUPERH64
 	def_bool ARCH = "sh64"
+	select HAVE_EXIT_THREAD
 	select KALLSYMS
 
 config ARCH_DEFCONFIG
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 2885fc9d9dcd..ee12e9451874 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -76,13 +76,6 @@ void start_thread(struct pt_regs *regs, unsigned long new_pc,
 }
 EXPORT_SYMBOL(start_thread);
 
-/*
- * Free current thread data structures etc..
- */
-void exit_thread(void)
-{
-}
-
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 57ffaf285c2f..b66aea06e9c9 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -20,6 +20,7 @@ config SPARC
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_EXIT_THREAD
 	select SYSCTL_EXCEPTION_TRACE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 81719302b056..174746225577 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -3,6 +3,7 @@
 
 config TILE
 	def_bool y
+	select HAVE_EXIT_THREAD
 	select HAVE_PERF_EVENTS
 	select USE_PMC if PERF_EVENTS
 	select HAVE_DMA_API_DEBUG
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 48af59aae129..0b04711f1f18 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -103,10 +103,6 @@ void interrupt_end(void)
 		tracehook_notify_resume(regs);
 }
 
-void exit_thread(void)
-{
-}
-
 int get_current_pid(void)
 {
 	return task_pid_nr(current);
diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/process.c
index b008e9961465..00299c927852 100644
--- a/arch/unicore32/kernel/process.c
+++ b/arch/unicore32/kernel/process.c
@@ -201,13 +201,6 @@ void show_regs(struct pt_regs *regs)
 	__backtrace();
 }
 
-/*
- * Free current thread data structures etc..
- */
-void exit_thread(void)
-{
-}
-
 void flush_thread(void)
 {
 	struct thread_info *thread = current_thread_info();
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6bc6f9832d67..8f6196084eac 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -105,6 +105,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_EXIT_THREAD
 	select HAVE_FENTRY			if X86_64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_FP_TEST
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index e832d3e9835e..c6b2ee78b617 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -15,6 +15,7 @@ config XTENSA
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select HAVE_DMA_API_DEBUG
+	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUTEX_CMPXCHG if !MMU
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 362c0e20ebbb..de5370802828 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2646,7 +2646,14 @@ static inline int copy_thread_tls(
 }
 #endif
 extern void flush_thread(void);
+
+#ifdef CONFIG_HAVE_EXIT_THREAD
 extern void exit_thread(void);
+#else
+static inline void exit_thread(void)
+{
+}
+#endif
 
 extern void exit_files(struct task_struct *);
 extern void __cleanup_sighand(struct sighand_struct *);
-- 
2.7.4

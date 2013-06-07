Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 796642C007B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 18:53:24 +1000 (EST)
Message-ID: <1370595190.3766.359.camel@pasglop>
Subject: Re: fsqrt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-R61911 <r61911@freescale.com>
Date: Fri, 07 Jun 2013 18:53:10 +1000
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B213A62@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
 <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
 <1370577138.3766.342.camel@pasglop> <1370579976.3766.345.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B2135A0@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370580426.3766.349.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B213817@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370590884.3766.357.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B213A62@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 07:45 +0000, Zang Roy-R61911 wrote:
> 
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Another question...
> > 
> > Do you guys happen to have a patch to emulate fsqrt in the kernel ?
> > 
> > Fedora 19 seems to be using it ... among others.
> You mean this one
> arch/powerpc/math-emu/fsqrt.c ?

No. This is for setups that have no FPU, I don't think that will work
with an actual FPU.

fsqrt is an optional instruction in the architecture and FSL chips don't
use it. However it looks like Fedora is compiled with a toolchain that
generates it.

I've successfully launched the Fedora installer using this hack in the
kernel:

>From f75adba1ee91691d431e283184e15412114000d1 Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 7 Jun 2013 18:42:44 +1000
Subject: [PATCH] Gross hack

---
 arch/powerpc/include/asm/ppc-opcode.h |    2 ++
 arch/powerpc/kernel/Makefile          |    4 ++-
 arch/powerpc/kernel/fsqrt-emu.c       |   44 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps.c           |    7 ++++++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/kernel/fsqrt-emu.c

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index eccfc16..146c5e9 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -88,6 +88,8 @@
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
 #define PPC_INST_DCBZL			0x7c2007ec
+#define PPC_INST_FSQRT			0xfc00002c
+#define PPC_INST_FSQRT_MASK		0xfc1f07fe
 #define PPC_INST_ICBT			0x7c00002c
 #define PPC_INST_ISEL			0x7c00001e
 #define PPC_INST_ISEL_MASK		0xfc00003e
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f960a79..64c9962 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -26,6 +26,8 @@ CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
 CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
 endif
 
+CFLAGS_REMOVE_fsqrt-emu.o = -msoft-float
+
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
@@ -34,7 +36,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   udbg.o misc.o io.o dma.o \
 				   misc_$(CONFIG_WORD_SIZE).o vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
-				   signal_64.o ptrace32.o \
+				   signal_64.o ptrace32.o fsqrt-emu.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
diff --git a/arch/powerpc/kernel/fsqrt-emu.c b/arch/powerpc/kernel/fsqrt-emu.c
new file mode 100644
index 0000000..2da4f71
--- /dev/null
+++ b/arch/powerpc/kernel/fsqrt-emu.c
@@ -0,0 +1,44 @@
+#include <linux/kernel.h>
+#include <linux/preempt.h>
+#include <linux/sched.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+#include <asm/switch_to.h>
+
+static double crackpot_sqrt(double val)
+{
+    int i;
+    float x, y;
+    const float f = 1.5F;
+
+    x = val * 0.5F;
+    y  = val;
+    i  = * ( int * ) &y;
+    i  = 0x5f3759df - ( i >> 1 );
+    y  = * ( float * ) &i;
+    y  = y * ( f - ( x * y * y ) );
+    y  = y * ( f - ( x * y * y ) );
+    return val * y;
+}
+
+int emulate_fsqrt_inst(struct pt_regs *regs, u32 instword)
+{
+	unsigned int frt_r = (instword >> 21) & 0x1f;
+	unsigned int frb_r = (instword >> 21) & 0x1f;
+	double frt, frb;
+
+	/* XXX THIS WHOLE THING IS JUST A HACK ! */
+	preempt_disable();
+	enable_kernel_fp();
+	frb = current->thread.fpr[frb_r][0];
+	frt = crackpot_sqrt(frb);
+	current->thread.fpr[frt_r][0] = frt;
+	if (instword & 1)
+		regs->ccr &= 0xff00ffff;
+	preempt_enable();
+
+	return 0;
+}
+
+
+
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6dfbb38..e677792 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -938,6 +938,8 @@ static int emulate_isel(struct pt_regs *regs, u32 instword)
 	return 0;
 }
 
+extern int emulate_fsqrt_inst(struct pt_regs *regs, u32 instword);
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 static inline bool tm_abort_check(struct pt_regs *regs, int cause)
 {
@@ -1018,6 +1020,11 @@ static int emulate_instruction(struct pt_regs *regs)
 		return emulate_isel(regs, instword);
 	}
 
+	if ((instword & PPC_INST_FSQRT_MASK) == PPC_INST_FSQRT) {
+		PPC_WARN_EMULATED(isel, regs);
+		return emulate_fsqrt_inst(regs, instword);
+	}
+
 #ifdef CONFIG_PPC64
 	/* Emulate the mfspr rD, DSCR. */
 	if ((((instword & PPC_INST_MFSPR_DSCR_USER_MASK) ==
-- 
1.7.10.4

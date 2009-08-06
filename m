Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BE3C8B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 14:58:46 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B345DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 14:58:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <19066.25333.469817.404676@drongo.ozlabs.ibm.com>
Date: Thu, 6 Aug 2009 14:58:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf_counter: powerpc: Add callchain support
In-Reply-To: <19066.25278.925555.133212@drongo.ozlabs.ibm.com>
References: <19066.25278.925555.133212@drongo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for tracing callchains for powerpc, both 32-bit
and 64-bit, and both in the kernel and userspace, from PMU interrupt
context.

The first three entries stored for each callchain are the NIP (next
instruction pointer), LR (link register), and the contents of the LR
save area in the second stack frame (the first is ignored because the
ABI convention on powerpc is that functions save their return address
in their caller's stack frame).  Because functions don't have to save
their return address (LR value) and don't have to establish a stack
frame, it's possible for either or both of LR and the second stack
frame's LR save area to have valid return addresses in them.  This
is basically impossible to disambiguate without either reading the
code or looking at auxiliary information such as CFI tables.  Since
we don't want to do that at interrupt time, we store both LR and the
second stack frame's LR save area.

Once we get past the second stack frame, there is no ambiguity; all
return addresses we get are reliable.

For kernel traces, we check whether they are valid kernel instruction
addresses and store zero instead if they are not (rather than
omitting them, which would make it impossible for userspace to know
which was which).  We also store zero instead of the second stack
frame's LR save area value if it is the same as LR.

For kernel traces, we check for interrupt frames, and for user traces,
we check for signal frames.  In each case, since we're starting a new
trace, we store a PERF=5FCONTEXT=5FKERNEL/USER marker so that userspace=

knows that the next three entries are NIP, LR and the second stack fram=
e
for the interrupted context.

We read user memory with =5F=5Fget=5Fuser=5Finatomic.  On 64-bit, if th=
is
PMU interrupt occurred while interrupts are soft-disabled, and
there is no MMU hash table entry for the page, we will get an
-EFAULT return from =5F=5Fget=5Fuser=5Finatomic even if there is a vali=
d
Linux PTE for the page, since hash=5Fpage isn't reentrant.  Thus we
have code here to read the Linux PTE and access the page via the
kernel linear mapping.  Since 64-bit doesn't use (or need) highmem
there is no need to do kmap=5Fatomic.  On 32-bit, we don't do soft
interrupt disabling, so this complication doesn't occur and there
is no need to fall back to reading the Linux PTE, since hash=5Fpage
will get called automatically if necessary.

Note that we cannot get PMU interrupts in the interval during
context switch between switch=5Fmm (which switches the user address
space) and switch=5Fto (which actually changes current to the new
process).  On 64-bit this is because interrupts are hard-disabled
in switch=5Fmm and stay hard-disabled until they are soft-enabled
later, after switch=5Fto has returned.  So there is no possibility
of trying to do a user stack trace when the user address space is
not current's address space.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/Makefile         |    2 +-
 arch/powerpc/kernel/perf=5Fcallchain.c |  520 ++++++++++++++++++++++++=
++++++++++
 2 files changed, 521 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/perf=5Fcallchain.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefil=
e
index b73396b..9619285 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -97,7 +97,7 @@ obj64-$(CONFIG=5FAUDIT)=09=09+=3D compat=5Faudit.o
=20
 obj-$(CONFIG=5FDYNAMIC=5FFTRACE)=09+=3D ftrace.o
 obj-$(CONFIG=5FFUNCTION=5FGRAPH=5FTRACER)=09+=3D ftrace.o
-obj-$(CONFIG=5FPPC=5FPERF=5FCTRS)=09+=3D perf=5Fcounter.o
+obj-$(CONFIG=5FPPC=5FPERF=5FCTRS)=09+=3D perf=5Fcounter.o perf=5Fcallc=
hain.o
 obj64-$(CONFIG=5FPPC=5FPERF=5FCTRS)=09+=3D power4-pmu.o ppc970-pmu.o p=
ower5-pmu.o \
 =09=09=09=09   power5+-pmu.o power6-pmu.o power7-pmu.o
 obj32-$(CONFIG=5FPPC=5FPERF=5FCTRS)=09+=3D mpc7450-pmu.o
diff --git a/arch/powerpc/kernel/perf=5Fcallchain.c b/arch/powerpc/kern=
el/perf=5Fcallchain.c
new file mode 100644
index 0000000..ed13777
--- /dev/null
+++ b/arch/powerpc/kernel/perf=5Fcallchain.c
@@ -0,0 +1,520 @@
+/*
+ * Performance counter callchain support - powerpc architecture code
+ *
+ * Copyright =A9 2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/perf=5Fcounter.h>
+#include <linux/percpu.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+#include <asm/pgtable.h>
+#include <asm/sigcontext.h>
+#include <asm/ucontext.h>
+#include <asm/vdso.h>
+#ifdef CONFIG=5FPPC64
+#include "ppc32.h"
+#endif
+
+/*
+ * Store another value in a callchain=5Fentry.
+ */
+static inline void callchain=5Fstore(struct perf=5Fcallchain=5Fentry *=
entry, u64 ip)
+{
+=09unsigned int nr =3D entry->nr;
+
+=09if (nr < PERF=5FMAX=5FSTACK=5FDEPTH) {
+=09=09entry->ip[nr] =3D ip;
+=09=09entry->nr =3D nr + 1;
+=09}
+}
+
+/*
+ * Is sp valid as the address of the next kernel stack frame after pre=
v=5Fsp=3F
+ * The next frame may be in a different stack area but should not go
+ * back down in the same stack area.
+ */
+static int valid=5Fnext=5Fsp(unsigned long sp, unsigned long prev=5Fsp=
)
+{
+=09if (sp & 0xf)
+=09=09return 0;=09=09/* must be 16-byte aligned */
+=09if (!validate=5Fsp(sp, current, STACK=5FFRAME=5FOVERHEAD))
+=09=09return 0;
+=09if (sp >=3D prev=5Fsp + STACK=5FFRAME=5FOVERHEAD)
+=09=09return 1;
+=09/*
+=09 * sp could decrease when we jump off an interrupt stack
+=09 * back to the regular process stack.
+=09 */
+=09if ((sp & ~(THREAD=5FSIZE - 1)) !=3D (prev=5Fsp & ~(THREAD=5FSIZE -=
 1)))
+=09=09return 1;
+=09return 0;
+}
+
+static void perf=5Fcallchain=5Fkernel(struct pt=5Fregs *regs,
+=09=09=09=09  struct perf=5Fcallchain=5Fentry *entry)
+{
+=09unsigned long sp, next=5Fsp;
+=09unsigned long next=5Fip;
+=09unsigned long lr;
+=09long level =3D 0;
+=09unsigned long *fp;
+
+=09lr =3D regs->link;
+=09sp =3D regs->gpr[1];
+=09callchain=5Fstore(entry, PERF=5FCONTEXT=5FKERNEL);
+=09callchain=5Fstore(entry, regs->nip);
+
+=09if (!validate=5Fsp(sp, current, STACK=5FFRAME=5FOVERHEAD))
+=09=09return;
+
+=09for (;;) {
+=09=09fp =3D (unsigned long *) sp;
+=09=09next=5Fsp =3D fp[0];
+
+=09=09if (next=5Fsp =3D=3D sp + STACK=5FINT=5FFRAME=5FSIZE &&
+=09=09    fp[STACK=5FFRAME=5FMARKER] =3D=3D STACK=5FFRAME=5FREGS=5FMAR=
KER) {
+=09=09=09/*
+=09=09=09 * This looks like an interrupt frame for an
+=09=09=09 * interrupt that occurred in the kernel
+=09=09=09 */
+=09=09=09regs =3D (struct pt=5Fregs *)(sp + STACK=5FFRAME=5FOVERHEAD);=

+=09=09=09next=5Fip =3D regs->nip;
+=09=09=09lr =3D regs->link;
+=09=09=09level =3D 0;
+=09=09=09callchain=5Fstore(entry, PERF=5FCONTEXT=5FKERNEL);
+
+=09=09} else {
+=09=09=09if (level =3D=3D 0)
+=09=09=09=09next=5Fip =3D lr;
+=09=09=09else
+=09=09=09=09next=5Fip =3D fp[STACK=5FFRAME=5FLR=5FSAVE];
+
+=09=09=09/*
+=09=09=09 * We can't tell which of the first two addresses
+=09=09=09 * we get are valid, but we can filter out the
+=09=09=09 * obviously bogus ones here.  We replace them
+=09=09=09 * with 0 rather than removing them entirely so
+=09=09=09 * that userspace can tell which is which.
+=09=09=09 */
+=09=09=09if ((level =3D=3D 1 && next=5Fip =3D=3D lr) ||
+=09=09=09    (level <=3D 1 && !kernel=5Ftext=5Faddress(next=5Fip)))
+=09=09=09=09next=5Fip =3D 0;
+
+=09=09=09++level;
+=09=09}
+
+=09=09callchain=5Fstore(entry, next=5Fip);
+=09=09if (!valid=5Fnext=5Fsp(next=5Fsp, sp))
+=09=09=09return;
+=09=09sp =3D next=5Fsp;
+=09}
+}
+
+#ifdef CONFIG=5FPPC64
+/*
+ * On 64-bit we don't want to invoke hash=5Fpage on user addresses fro=
m
+ * interrupt context, so if the access faults, we read the page tables=

+ * to find which page (if any) is mapped and access it directly.
+ */
+static int read=5Fuser=5Fstack=5Fslow(void =5F=5Fuser *ptr, void *ret,=
 int nb)
+{
+=09pgd=5Ft *pgdir;
+=09pte=5Ft *ptep, pte;
+=09int pagesize;
+=09unsigned long addr =3D (unsigned long) ptr;
+=09unsigned long offset;
+=09unsigned long pfn;
+=09void *kaddr;
+
+=09pgdir =3D current->mm->pgd;
+=09if (!pgdir)
+=09=09return -EFAULT;
+
+=09pagesize =3D get=5Fslice=5Fpsize(current->mm, addr);
+
+=09/* align address to page boundary */
+=09offset =3D addr & ((1ul << mmu=5Fpsize=5Fdefs[pagesize].shift) - 1)=
;
+=09addr -=3D offset;
+
+=09if (HPAGE=5FSHIFT && mmu=5Fhuge=5Fpsizes[pagesize])
+=09=09ptep =3D huge=5Fpte=5Foffset(current->mm, addr);
+=09else
+=09=09ptep =3D find=5Flinux=5Fpte(pgdir, addr);
+
+=09if (ptep =3D=3D NULL)
+=09=09return -EFAULT;
+=09pte =3D *ptep;
+=09if (!pte=5Fpresent(pte) || !(pte=5Fval(pte) & =5FPAGE=5FUSER))
+=09=09return -EFAULT;
+=09pfn =3D pte=5Fpfn(pte);
+=09if (!page=5Fis=5Fram(pfn))
+=09=09return -EFAULT;
+
+=09/* no highmem to worry about here */
+=09kaddr =3D pfn=5Fto=5Fkaddr(pfn);
+=09memcpy(ret, kaddr + offset, nb);
+=09return 0;
+}
+
+static int read=5Fuser=5Fstack=5F64(unsigned long =5F=5Fuser *ptr, uns=
igned long *ret)
+{
+=09if ((unsigned long)ptr > TASK=5FSIZE - sizeof(unsigned long) ||
+=09    ((unsigned long)ptr & 7))
+=09=09return -EFAULT;
+
+=09if (!=5F=5Fget=5Fuser=5Finatomic(*ret, ptr))
+=09=09return 0;
+
+=09return read=5Fuser=5Fstack=5Fslow(ptr, ret, 8);
+}
+
+static int read=5Fuser=5Fstack=5F32(unsigned int =5F=5Fuser *ptr, unsi=
gned int *ret)
+{
+=09if ((unsigned long)ptr > TASK=5FSIZE - sizeof(unsigned int) ||
+=09    ((unsigned long)ptr & 3))
+=09=09return -EFAULT;
+
+=09if (!=5F=5Fget=5Fuser=5Finatomic(*ret, ptr))
+=09=09return 0;
+
+=09return read=5Fuser=5Fstack=5Fslow(ptr, ret, 4);
+}
+
+static inline int valid=5Fuser=5Fsp(unsigned long sp, int is=5F64)
+{
+=09if (!sp || (sp & 7) || sp > (is=5F64 =3F TASK=5FSIZE : 0x100000000U=
L) - 32)
+=09=09return 0;
+=09return 1;
+}
+
+/*
+ * 64-bit user processes use the same stack frame for RT and non-RT si=
gnals.
+ */
+struct signal=5Fframe=5F64 {
+=09char=09=09dummy[=5F=5FSIGNAL=5FFRAMESIZE];
+=09struct ucontext=09uc;
+=09unsigned long=09unused[2];
+=09unsigned int=09tramp[6];
+=09struct siginfo=09*pinfo;
+=09void=09=09*puc;
+=09struct siginfo=09info;
+=09char=09=09abigap[288];
+};
+
+static int is=5Fsigreturn=5F64=5Faddress(unsigned long nip, unsigned l=
ong fp)
+{
+=09if (nip =3D=3D fp + offsetof(struct signal=5Fframe=5F64, tramp))
+=09=09return 1;
+=09if (vdso64=5Frt=5Fsigtramp && current->mm->context.vdso=5Fbase &&
+=09    nip =3D=3D current->mm->context.vdso=5Fbase + vdso64=5Frt=5Fsig=
tramp)
+=09=09return 1;
+=09return 0;
+}
+
+/*
+ * Do some sanity checking on the signal frame pointed to by sp.
+ * We check the pinfo and puc pointers in the frame.
+ */
+static int sane=5Fsignal=5F64=5Fframe(unsigned long sp)
+{
+=09struct signal=5Fframe=5F64 =5F=5Fuser *sf;
+=09unsigned long pinfo, puc;
+
+=09sf =3D (struct signal=5Fframe=5F64 =5F=5Fuser *) sp;
+=09if (read=5Fuser=5Fstack=5F64((unsigned long =5F=5Fuser *) &sf->pinf=
o, &pinfo) ||
+=09    read=5Fuser=5Fstack=5F64((unsigned long =5F=5Fuser *) &sf->puc,=
 &puc))
+=09=09return 0;
+=09return pinfo =3D=3D (unsigned long) &sf->info &&
+=09=09puc =3D=3D (unsigned long) &sf->uc;
+}
+
+static void perf=5Fcallchain=5Fuser=5F64(struct pt=5Fregs *regs,
+=09=09=09=09   struct perf=5Fcallchain=5Fentry *entry)
+{
+=09unsigned long sp, next=5Fsp;
+=09unsigned long next=5Fip;
+=09unsigned long lr;
+=09long level =3D 0;
+=09struct signal=5Fframe=5F64 =5F=5Fuser *sigframe;
+=09unsigned long =5F=5Fuser *fp, *uregs;
+
+=09next=5Fip =3D regs->nip;
+=09lr =3D regs->link;
+=09sp =3D regs->gpr[1];
+=09callchain=5Fstore(entry, PERF=5FCONTEXT=5FUSER);
+=09callchain=5Fstore(entry, next=5Fip);
+
+=09for (;;) {
+=09=09fp =3D (unsigned long =5F=5Fuser *) sp;
+=09=09if (!valid=5Fuser=5Fsp(sp, 1) || read=5Fuser=5Fstack=5F64(fp, &n=
ext=5Fsp))
+=09=09=09return;
+=09=09if (level > 0 && read=5Fuser=5Fstack=5F64(&fp[2], &next=5Fip))
+=09=09=09return;
+
+=09=09/*
+=09=09 * Note: the next=5Fsp - sp >=3D signal frame size check
+=09=09 * is true when next=5Fsp < sp, which can happen when
+=09=09 * transitioning from an alternate signal stack to the
+=09=09 * normal stack.
+=09=09 */
+=09=09if (next=5Fsp - sp >=3D sizeof(struct signal=5Fframe=5F64) &&
+=09=09    (is=5Fsigreturn=5F64=5Faddress(next=5Fip, sp) ||
+=09=09     (level <=3D 1 && is=5Fsigreturn=5F64=5Faddress(lr, sp))) &&=

+=09=09    sane=5Fsignal=5F64=5Fframe(sp)) {
+=09=09=09/*
+=09=09=09 * This looks like an signal frame
+=09=09=09 */
+=09=09=09sigframe =3D (struct signal=5Fframe=5F64 =5F=5Fuser *) sp;
+=09=09=09uregs =3D sigframe->uc.uc=5Fmcontext.gp=5Fregs;
+=09=09=09if (read=5Fuser=5Fstack=5F64(&uregs[PT=5FNIP], &next=5Fip) ||=

+=09=09=09    read=5Fuser=5Fstack=5F64(&uregs[PT=5FLNK], &lr) ||
+=09=09=09    read=5Fuser=5Fstack=5F64(&uregs[PT=5FR1], &sp))
+=09=09=09=09return;
+=09=09=09level =3D 0;
+=09=09=09callchain=5Fstore(entry, PERF=5FCONTEXT=5FUSER);
+=09=09=09callchain=5Fstore(entry, next=5Fip);
+=09=09=09continue;
+=09=09}
+
+=09=09if (level =3D=3D 0)
+=09=09=09next=5Fip =3D lr;
+=09=09callchain=5Fstore(entry, next=5Fip);
+=09=09++level;
+=09=09sp =3D next=5Fsp;
+=09}
+}
+
+static inline int current=5Fis=5F64bit(void)
+{
+=09/*
+=09 * We can't use test=5Fthread=5Fflag() here because we may be on an=

+=09 * interrupt stack, and the thread flags don't get copied over
+=09 * from the thread=5Finfo on the main stack to the interrupt stack.=

+=09 */
+=09return !test=5Fti=5Fthread=5Fflag(task=5Fthread=5Finfo(current), TI=
F=5F32BIT);
+}
+
+#else  /* CONFIG=5FPPC64 */
+/*
+ * On 32-bit we just access the address and let hash=5Fpage create a
+ * HPTE if necessary, so there is no need to fall back to reading
+ * the page tables.  Since this is called at interrupt level,
+ * do=5Fpage=5Ffault() won't treat a DSI as a page fault.
+ */
+static int read=5Fuser=5Fstack=5F32(unsigned int =5F=5Fuser *ptr, unsi=
gned int *ret)
+{
+=09if ((unsigned long)ptr > TASK=5FSIZE - sizeof(unsigned int) ||
+=09    ((unsigned long)ptr & 3))
+=09=09return -EFAULT;
+
+=09return =5F=5Fget=5Fuser=5Finatomic(*ret, ptr);
+}
+
+static inline void perf=5Fcallchain=5Fuser=5F64(struct pt=5Fregs *regs=
,
+=09=09=09=09=09  struct perf=5Fcallchain=5Fentry *entry)
+{
+}
+
+static inline int current=5Fis=5F64bit(void)
+{
+=09return 0;
+}
+
+static inline int valid=5Fuser=5Fsp(unsigned long sp, int is=5F64)
+{
+=09if (!sp || (sp & 7) || sp > TASK=5FSIZE - 32)
+=09=09return 0;
+=09return 1;
+}
+
+#define =5F=5FSIGNAL=5FFRAMESIZE32=09=5F=5FSIGNAL=5FFRAMESIZE
+#define sigcontext32=09=09sigcontext
+#define mcontext32=09=09mcontext
+#define ucontext32=09=09ucontext
+#define compat=5Fsiginfo=5Ft=09struct siginfo
+
+#endif /* CONFIG=5FPPC64 */
+
+/*
+ * Layout for non-RT signal frames
+ */
+struct signal=5Fframe=5F32 {
+=09char=09=09=09dummy[=5F=5FSIGNAL=5FFRAMESIZE32];
+=09struct sigcontext32=09sctx;
+=09struct mcontext32=09mctx;
+=09int=09=09=09abigap[56];
+};
+
+/*
+ * Layout for RT signal frames
+ */
+struct rt=5Fsignal=5Fframe=5F32 {
+=09char=09=09=09dummy[=5F=5FSIGNAL=5FFRAMESIZE32 + 16];
+=09compat=5Fsiginfo=5Ft=09info;
+=09struct ucontext32=09uc;
+=09int=09=09=09abigap[56];
+};
+
+static int is=5Fsigreturn=5F32=5Faddress(unsigned int nip, unsigned in=
t fp)
+{
+=09if (nip =3D=3D fp + offsetof(struct signal=5Fframe=5F32, mctx.mc=5F=
pad))
+=09=09return 1;
+=09if (vdso32=5Fsigtramp && current->mm->context.vdso=5Fbase &&
+=09    nip =3D=3D current->mm->context.vdso=5Fbase + vdso32=5Fsigtramp=
)
+=09=09return 1;
+=09return 0;
+}
+
+static int is=5Frt=5Fsigreturn=5F32=5Faddress(unsigned int nip, unsign=
ed int fp)
+{
+=09if (nip =3D=3D fp + offsetof(struct rt=5Fsignal=5Fframe=5F32,
+=09=09=09=09 uc.uc=5Fmcontext.mc=5Fpad))
+=09=09return 1;
+=09if (vdso32=5Frt=5Fsigtramp && current->mm->context.vdso=5Fbase &&
+=09    nip =3D=3D current->mm->context.vdso=5Fbase + vdso32=5Frt=5Fsig=
tramp)
+=09=09return 1;
+=09return 0;
+}
+
+static int sane=5Fsignal=5F32=5Fframe(unsigned int sp)
+{
+=09struct signal=5Fframe=5F32 =5F=5Fuser *sf;
+=09unsigned int regs;
+
+=09sf =3D (struct signal=5Fframe=5F32 =5F=5Fuser *) (unsigned long) sp=
;
+=09if (read=5Fuser=5Fstack=5F32((unsigned int =5F=5Fuser *) &sf->sctx.=
regs, &regs))
+=09=09return 0;
+=09return regs =3D=3D (unsigned long) &sf->mctx;
+}
+
+static int sane=5Frt=5Fsignal=5F32=5Fframe(unsigned int sp)
+{
+=09struct rt=5Fsignal=5Fframe=5F32 =5F=5Fuser *sf;
+=09unsigned int regs;
+
+=09sf =3D (struct rt=5Fsignal=5Fframe=5F32 =5F=5Fuser *) (unsigned lon=
g) sp;
+=09if (read=5Fuser=5Fstack=5F32((unsigned int =5F=5Fuser *) &sf->uc.uc=
=5Fregs, &regs))
+=09=09return 0;
+=09return regs =3D=3D (unsigned long) &sf->uc.uc=5Fmcontext;
+}
+
+static unsigned int =5F=5Fuser *signal=5Fframe=5F32=5Fregs(unsigned in=
t sp,
+=09=09=09=09unsigned int next=5Fsp, unsigned int next=5Fip)
+{
+=09struct mcontext32 =5F=5Fuser *mctx =3D NULL;
+=09struct signal=5Fframe=5F32 =5F=5Fuser *sf;
+=09struct rt=5Fsignal=5Fframe=5F32 =5F=5Fuser *rt=5Fsf;
+
+=09/*
+=09 * Note: the next=5Fsp - sp >=3D signal frame size check
+=09 * is true when next=5Fsp < sp, for example, when
+=09 * transitioning from an alternate signal stack to the
+=09 * normal stack.
+=09 */
+=09if (next=5Fsp - sp >=3D sizeof(struct signal=5Fframe=5F32) &&
+=09    is=5Fsigreturn=5F32=5Faddress(next=5Fip, sp) &&
+=09    sane=5Fsignal=5F32=5Fframe(sp)) {
+=09=09sf =3D (struct signal=5Fframe=5F32 =5F=5Fuser *) (unsigned long)=
 sp;
+=09=09mctx =3D &sf->mctx;
+=09}
+
+=09if (!mctx && next=5Fsp - sp >=3D sizeof(struct rt=5Fsignal=5Fframe=5F=
32) &&
+=09    is=5Frt=5Fsigreturn=5F32=5Faddress(next=5Fip, sp) &&
+=09    sane=5Frt=5Fsignal=5F32=5Fframe(sp)) {
+=09=09rt=5Fsf =3D (struct rt=5Fsignal=5Fframe=5F32 =5F=5Fuser *) (unsi=
gned long) sp;
+=09=09mctx =3D &rt=5Fsf->uc.uc=5Fmcontext;
+=09}
+
+=09if (!mctx)
+=09=09return NULL;
+=09return mctx->mc=5Fgregs;
+}
+
+static void perf=5Fcallchain=5Fuser=5F32(struct pt=5Fregs *regs,
+=09=09=09=09   struct perf=5Fcallchain=5Fentry *entry)
+{
+=09unsigned int sp, next=5Fsp;
+=09unsigned int next=5Fip;
+=09unsigned int lr;
+=09long level =3D 0;
+=09unsigned int =5F=5Fuser *fp, *uregs;
+
+=09next=5Fip =3D regs->nip;
+=09lr =3D regs->link;
+=09sp =3D regs->gpr[1];
+=09callchain=5Fstore(entry, PERF=5FCONTEXT=5FUSER);
+=09callchain=5Fstore(entry, next=5Fip);
+
+=09while (entry->nr < PERF=5FMAX=5FSTACK=5FDEPTH) {
+=09=09fp =3D (unsigned int =5F=5Fuser *) (unsigned long) sp;
+=09=09if (!valid=5Fuser=5Fsp(sp, 0) || read=5Fuser=5Fstack=5F32(fp, &n=
ext=5Fsp))
+=09=09=09return;
+=09=09if (level > 0 && read=5Fuser=5Fstack=5F32(&fp[1], &next=5Fip))
+=09=09=09return;
+
+=09=09uregs =3D signal=5Fframe=5F32=5Fregs(sp, next=5Fsp, next=5Fip);
+=09=09if (!uregs && level <=3D 1)
+=09=09=09uregs =3D signal=5Fframe=5F32=5Fregs(sp, next=5Fsp, lr);
+=09=09if (uregs) {
+=09=09=09/*
+=09=09=09 * This looks like an signal frame, so restart
+=09=09=09 * the stack trace with the values in it.
+=09=09=09 */
+=09=09=09if (read=5Fuser=5Fstack=5F32(&uregs[PT=5FNIP], &next=5Fip) ||=

+=09=09=09    read=5Fuser=5Fstack=5F32(&uregs[PT=5FLNK], &lr) ||
+=09=09=09    read=5Fuser=5Fstack=5F32(&uregs[PT=5FR1], &sp))
+=09=09=09=09return;
+=09=09=09level =3D 0;
+=09=09=09callchain=5Fstore(entry, PERF=5FCONTEXT=5FUSER);
+=09=09=09callchain=5Fstore(entry, next=5Fip);
+=09=09=09continue;
+=09=09}
+
+=09=09if (level =3D=3D 0)
+=09=09=09next=5Fip =3D lr;
+=09=09callchain=5Fstore(entry, next=5Fip);
+=09=09++level;
+=09=09sp =3D next=5Fsp;
+=09}
+}
+
+/*
+ * Since we can't get PMU interrupts inside a PMU interrupt handler,
+ * we don't need separate irq and nmi entries here.
+ */
+static DEFINE=5FPER=5FCPU(struct perf=5Fcallchain=5Fentry, callchain);=

+
+struct perf=5Fcallchain=5Fentry *perf=5Fcallchain(struct pt=5Fregs *re=
gs)
+{
+=09struct perf=5Fcallchain=5Fentry *entry =3D &=5F=5Fget=5Fcpu=5Fvar(c=
allchain);
+
+=09entry->nr =3D 0;
+
+=09if (current->pid =3D=3D 0)=09=09/* idle task=3F */
+=09=09return entry;
+
+=09if (!user=5Fmode(regs)) {
+=09=09perf=5Fcallchain=5Fkernel(regs, entry);
+=09=09if (current->mm)
+=09=09=09regs =3D task=5Fpt=5Fregs(current);
+=09=09else
+=09=09=09regs =3D NULL;
+=09}
+
+=09if (regs) {
+=09=09if (current=5Fis=5F64bit())
+=09=09=09perf=5Fcallchain=5Fuser=5F64(regs, entry);
+=09=09else
+=09=09=09perf=5Fcallchain=5Fuser=5F32(regs, entry);
+=09}
+
+=09return entry;
+}
--=20
1.5.5.rc3.7.gba13

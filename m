Message-ID: <3B98CB49.E72DD46F@jpl.nasa.gov>
Date: Fri, 07 Sep 2001 06:27:37 -0700
From: Edwin Robert Tisdale <E.Robert.Tisdale@jpl.nasa.gov>
Reply-To: E.Robert.Tisdale@jpl.nasa.gov
MIME-Version: 1.0
To: Altivec Forum <altivec_forum@forum.altivec.org>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: AltiVec aware ptrace for Linux
References: <LYRIS-1276875-39452-2001.09.06-21.05.29--E.Robert.Tisdale#jpl.nasa.gov@forum.altivec.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> 1. Make a unified diff listing rather than the old-style diff.
>
> 2. Your diff is backwards, it shows your new stuff as being deleted.
>    Do the diff as "diff -u old new".
>
> 3. Don't take out the "addr = addr >> 2;" lines.
>    I know the comment says "temporary hack"
>    but you don't want to believe everything you read. :)
>    In fact, a lot of existing software relies on
>    the argument to PTRACE_PEEK/POKEUSR
>    being an offset into a notional structure rather than an index
>    and your change would introduce a significant change
>    to existing behaviour which would break applications.
>    Note that >> 2 divides by 4, not 2
>    as you seemed to think in a previous message.
>
> 4. Send the patch to me (paulus@samba.org, the PPC/Linux maintainer)
>    and to the linuxppc-dev@lists.linuxppc.org list.

/usr/src/linux-2.2.19/arch/ppc/kernel$ diff -u ptrace.cold ptrace.c
--- ptrace.cold Sun Mar 25 08:31:49 2001
+++ ptrace.c Fri Sep  7 07:00:43 2001
@@ -415,19 +415,26 @@
    unsigned long tmp;

    ret = -EIO;
-   if ((addr & 3) || addr < 0 || addr > (PT_FPSCR << 2))
+   if ((addr & 3))
     goto out;

    tmp = 0;  /* Default return condition */
-   addr = addr >> 2; /* temporary hack. */
-   if (addr < PT_FPR0) {
+   addr >>= 2;
+   if (PT_R0 <= addr && addr <= PT_MQ) {
     tmp = get_reg(child, addr);
    }
-   else if (addr >= PT_FPR0 && addr <= PT_FPSCR) {
+   else if (PT_FPR0 <= addr && addr <= PT_FPSCR) {
     if (child->tss.regs->msr & MSR_FP)
      giveup_fpu(child);
     tmp = ((long *)child->tss.fpr)[addr - PT_FPR0];
    }
+#ifdef CONFIG_ALTIVEC
+   else if (PT_VR0 <= addr && addr <= PT_VRSAVE) {
+    if (child->tss.regs->msr & MSR_VEC)
+     giveup_altivec(child);
+    tmp = ((long *)child->tss.vr)[addr - PT_VR0];
+   }
+#endif /* CONFIG_ALTIVEC */
    else
     goto out;
    ret = put_user(tmp, (unsigned long *) data);
@@ -444,26 +451,29 @@

   case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
    ret = -EIO;
-   if ((addr & 3) || addr < 0 || addr >= ((PT_FPR0 + 64) << 2))
+   if ((addr & 3) || PT_ORIG_R3 == addr)
     goto out;

-   addr = addr >> 2; /* temporary hack. */
-
-   if (addr == PT_ORIG_R3)
-    goto out;
-   if (addr < PT_FPR0) {
+   addr >>= 2;
+   if (PT_FPR0 <= addr && addr <= PT_FPSCR) {
     if (put_reg(child, addr, data))
      goto out;
     ret = 0;
-    goto out;
    }
-   if (addr >= PT_FPR0 && addr < PT_FPR0 + 64) {
+   else if (PT_FPR0 <= addr && addr <= PT_FPSRC) {
     if (child->tss.regs->msr & MSR_FP)
      giveup_fpu(child);
     ((long *)child->tss.fpr)[addr - PT_FPR0] = data;     ret = 0;
-    goto out;
    }
+#ifdef CONFIG_ALTIVEC
+   else if (PT_VR0 <= addr && addr <= PT_VRSAVE) {
+    if (child->tss.regs->msr & MSR_VEC)
+     giveup_altivec(child);
+    ((long *)child->tss.vr)[addr - PT_VR0] = data;
+    ret = 0;
+   }
+#endif /* CONFIG_ALTIVEC */
    goto out;

   case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */

/usr/src/linux-2.2.19/include/asm$ diff -u ptrace.hold ptrace.h
--- ptrace.hold Sun Mar 25 08:31:08 2001
+++ ptrace.h Thu Sep  6 17:13:12 2001
@@ -97,5 +97,12 @@
 #define PT_FPR31 (PT_FPR0 + 2*31)
 #define PT_FPSCR (PT_FPR0 + 2*32 + 1)

+#ifdef CONFIG_ALTIVEC
+#define PT_VR0 128
+#define PT_VR31 (PT_VR0 + 4*31)
+#define PT_VRCR (PT_VR0 + 4*32)
+#define PT_VRSAVE (PT_VR0 + 4*33 + 1)
+#endif /* CONFIG_ALTIVEC */
+
 #endif


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

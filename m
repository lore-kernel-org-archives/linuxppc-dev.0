Date: Wed, 19 Sep 2001 12:07:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: applications in HHL 2.0, 405GP
Message-ID: <20010919120709.B13693@zax>
References: <200109071118.EAA14228@krakatoa.gigabitnetworks.com> <3BA77B15.2090707@cray.com> <01091812073101.04299@minotaur.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01091812073101.04299@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 18, 2001 at 12:05:09PM -0700, Joe Green wrote:
>
> David Updegraff wrote:
> > Anyway, I thought it was the "theory" that the kernel was trapping the
> > float instructions and emulating them...???
>
> Remember that it's not just a matter of configuring math emulation into
> the kernel.  The function call ABI is different for soft vs. hard
> float, so library calls will go kerflooey if you mix the two.  If you
> stick to all hard float user space, you can use kernel math emulation.

Except of course that the 4xx port as it stands doesn't support kernel
math emulation.  The patch below adds support (and also lets 4xx do
the other emulated instructions that most of the ppc ports support).
Anyone care to merge it?

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/traps.c linux-bungo/arch/ppc/kernel/traps.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/traps.c	Tue Sep  4 19:13:42 2001
+++ linux-bungo/arch/ppc/kernel/traps.c	Wed Sep 12 13:16:43 2001
@@ -267,6 +267,7 @@
 {
 #if defined(CONFIG_4xx)
 	unsigned int esr = mfspr(SPRN_ESR);
+	extern int do_mathemu(struct pt_regs *regs);

 	if (esr & ESR_PTR) {
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
@@ -275,9 +276,19 @@
 #endif
 		_exception(SIGTRAP, regs);
 	} else {
-		_exception(SIGILL, regs);
+		int errcode;
+#ifdef CONFIG_MATH_EMULATION
+		if (do_mathemu(regs) == 0)
+			return;
+#endif /* CONFIG_MATH_EMULATION */
+		if ((errcode = emulate_instruction(regs))) {
+			if (errcode == -EFAULT)
+				_exception(SIGBUS, regs);
+			else
+				_exception(SIGILL, regs);
+		}
 	}
-#else
+#else /* ! CONFIG_4xx */
 	if (regs->msr & 0x100000) {
 		/* IEEE FP exception */
 		_exception(SIGFPE, regs);
@@ -286,7 +297,7 @@
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 		if (debugger_bpt(regs))
 			return;
-#endif
+#endif /* defined(CONFIG_XMON) || defined(CONFIG_KGDB) */
 		_exception(SIGTRAP, regs);
 	} else {
 		/* Try to emulate it if we should. */


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

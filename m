Date: Thu, 30 Aug 2001 17:52:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 4xx - a question and a patch
Message-ID: <20010830175217.H858@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


First the question: is there a good reason that set_dec() is a no-op
on 4xx, rather than setting the PIT?  It's not a perfect approximation
to the decrementer, but as far as I can tell it should be close enough
for the next_dec code from arch/ppc/kernel/time.c to work properly.

Second a patch - the below adds floating point emulation to the 4xx.
With this patch I've been able to boot a Walnut to a shell.  Of
course, anything I try to run from the shell dies horribly...

diff -urN ../linuxppc_2_4_devel/arch/ppc/kernel/traps.c linux-bungo/arch/ppc/kernel/traps.c
--- ../linuxppc_2_4_devel/arch/ppc/kernel/traps.c	Wed Aug 29 10:41:56 2001
+++ linux-bungo/arch/ppc/kernel/traps.c	Thu Aug 30 17:02:36 2001
@@ -1,5 +1,5 @@
 /*
- * BK Id: SCCS/s.traps.c 1.23 08/29/01 08:57:35 paulus
+ * BK Id: %F% %I% %G% %U% %#%
  */
 /*
  *  linux/arch/ppc/kernel/traps.c
@@ -265,7 +265,12 @@
 #endif
 		_exception(SIGTRAP, regs);
 	} else {
+#ifdef CONFIG_MATH_EMULATION
+		if (do_mathemu(regs))
+			_exception(SIGILL, regs);
+#else
 		_exception(SIGILL, regs);
+#endif
 	}
 #else
 	if (regs->msr & 0x100000) {


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

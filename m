Date: Thu, 26 Jun 2003 22:06:38 -0500
Subject: Patches for single stepping emulated instructions
Content-Type: multipart/mixed; boundary=Apple-Mail-5-1066586933
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: paulus@samba.org
From: Kumar Gala <kumar.gala@motorola.com>
Message-Id: <5E35612E-A84C-11D7-83F6-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-5-1066586933
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Paul,

Here are patches for 2.4devel and 2.5 to properly handle single
stepping of emulated instructions.

- kumar


--Apple-Mail-5-1066586933
Content-Disposition: attachment;
	filename=single-step.2.5.bk
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="single-step.2.5.bk"

This BitKeeper patch contains the following changesets:
1.1018

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs.
# User:	galak
# Host:	blarg.somerset.sps.mot.com
# Root:	/local0/bk/linuxppc-2.5

#
#--- 1.32/arch/ppc/kernel/traps.c	Tue Jun 10 22:18:49 2003
#+++ 1.33/arch/ppc/kernel/traps.c	Thu Jun 26 22:00:21 2003
#@@ -351,16 +351,29 @@
# {
# 	int errcode;
#
#-#if defined(CONFIG_4xx)
#+#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
# 	unsigned int esr = regs->dsisr;
# 	int isbpt = esr & ESR_PTR;
# 	extern int do_mathemu(struct pt_regs *regs);
#
# #ifdef CONFIG_MATH_EMULATION
#-	if (!isbpt && do_mathemu(regs) == 0)
#+	if (!isbpt && do_mathemu(regs) == 0) {
#+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
#+		/* If we were single stepping and emulated an instruction
#+		 * send a SIGTRAP to emulate the single step as well */
#+		if (current->thread.dbcr0 & DBCR0_IC) {
#+			current->thread.dbcr0 &= ~DBCR0_IC;
#+			_exception(SIGTRAP, regs);
#+		}
#+#else
#+		if (regs->msr & MSR_SE) {
#+			regs->msr &= ~MSR_SE;
#+			_exception(SIGTRAP, regs);
#+		}
#+#endif
# 		return;
#+	}
# #endif /* CONFIG_MATH_EMULATION */
#-
# #else /* ! CONFIG_4xx */
# 	int isbpt = regs->msr & 0x20000;
#
#@@ -389,6 +402,20 @@
# 			_exception(SIGBUS, regs);
# 		else
# 			_exception(SIGILL, regs);
#+	} else {
#+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
#+		/* If we were single stepping and emulated an instruction
#+		 * send a SIGTRAP to emulate the single step as well */
#+		if (current->thread.dbcr0 & DBCR0_IC) {
#+			current->thread.dbcr0 &= ~DBCR0_IC;
#+			_exception(SIGTRAP, regs);
#+		}
#+#else
#+		if (regs->msr & MSR_SE) {
#+			regs->msr &= ~MSR_SE;
#+			_exception(SIGTRAP, regs);
#+		}
#+#endif
# 	}
# }
#
#

# Diff checksum=60afb446


# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
mporter@kernel.crashing.org|ChangeSet|20030626232810|16045
D 1.1018 03/06/26 22:02:44-05:00 galak@blarg.somerset.sps.mot.com +1 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Made emulated instructions respect single step tracing.
K 17579
P ChangeSet
------------------------------------------------

0a0
> torvalds@athlon.transmeta.com|arch/ppc/kernel/traps.c|20020205174025|09576|13ab26ac96ad2190 galak@blarg.somerset.sps.mot.com|arch/ppc/kernel/traps.c|20030627030021|07044

== arch/ppc/kernel/traps.c ==
torvalds@athlon.transmeta.com|arch/ppc/kernel/traps.c|20020205174025|09576|13ab26ac96ad2190
paulus@samba.org|arch/ppc/kernel/traps.c|20030611031849|10106
D 1.33 03/06/26 22:00:21-05:00 galak@blarg.somerset.sps.mot.com +30 -3
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Made emulated instructions respect single step tracing.  If an
c emulated instruction completes and single tracing is enabled we
c should send a SIGTRAP to the process.
K 7044
O -rw-rw-r--
P arch/ppc/kernel/traps.c
------------------------------------------------

D354 1
I354 1
#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
D360 1
I360 14
	if (!isbpt && do_mathemu(regs) == 0) {
#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
		/* If we were single stepping and emulated an instruction
		 * send a SIGTRAP to emulate the single step as well */
		if (current->thread.dbcr0 & DBCR0_IC) {
			current->thread.dbcr0 &= ~DBCR0_IC;
			_exception(SIGTRAP, regs);
		}
#else
		if (regs->msr & MSR_SE) {
			regs->msr &= ~MSR_SE;
			_exception(SIGTRAP, regs);
		}
#endif
I361 1
	}
D363 1
I391 14
	} else {
#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
		/* If we were single stepping and emulated an instruction
		 * send a SIGTRAP to emulate the single step as well */
		if (current->thread.dbcr0 & DBCR0_IC) {
			current->thread.dbcr0 &= ~DBCR0_IC;
			_exception(SIGTRAP, regs);
		}
#else
		if (regs->msr & MSR_SE) {
			regs->msr &= ~MSR_SE;
			_exception(SIGTRAP, regs);
		}
#endif

# Patch checksum=556e94e2

--Apple-Mail-5-1066586933
Content-Disposition: attachment;
	filename=single-step.2_4_devel.bk
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="single-step.2_4_devel.bk"

This BitKeeper patch contains the following changesets:
1.1321,1.1322

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs.
# User:	galak
# Host:	blarg.somerset.sps.mot.com
# Root:	/local0/bk/linuxppc_2_4_devel

#
#--- 1.46/arch/ppc/kernel/traps.c	Mon Apr  7 16:59:37 2003
#+++ 1.48/arch/ppc/kernel/traps.c	Thu Jun 26 21:58:45 2003
#@@ -343,8 +343,22 @@
# 	 * hardware people - not sure if it can happen on any illegal
# 	 * instruction or only on FP instructions, whether there is a
# 	 * pattern to occurences etc. -dgibson 31/Mar/2003 */
#-	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0)
#+	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0) {
#+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
#+		/* If we were single stepping and emulated an instruction
#+		* send a SIGTRAP to emulate the single step as well */
#+		if (current->thread.dbcr0 & DBCR0_IC) {
#+			current->thread.dbcr0 &= ~DBCR0_IC;
#+			_exception(SIGTRAP, regs, TRAP_TRACE, 0);
#+		}
#+#else
#+		if (regs->msr & MSR_SE) {
#+			regs->msr &= ~MSR_SE;
#+			_exception(SIGTRAP, regs, TRAP_TRACE, 0);
#+		}
#+#endif
# 		return;
#+	}
# #endif /* CONFIG_MATH_EMULATION */
#
# 	if (reason & REASON_FP) {
#@@ -380,8 +394,22 @@
#
# 	if (reason & REASON_PRIVILEGED) {
# 		/* Try to emulate it if we should. */
#-		if (emulate_instruction(regs) == 0)
#+		if (emulate_instruction(regs) == 0) {
#+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
#+			/* If we were single stepping and emulated an instruction
#+			 * send a SIGTRAP to emulate the single step as well */
#+			if (current->thread.dbcr0 & DBCR0_IC) {
#+				current->thread.dbcr0 &= ~DBCR0_IC;
#+				_exception(SIGTRAP, regs, TRAP_TRACE, 0);
#+			}
#+#else
#+			if (regs->msr & MSR_SE) {
#+				regs->msr &= ~MSR_SE;
#+				_exception(SIGTRAP, regs, TRAP_TRACE, 0);
#+			}
#+#endif
# 			return;
#+		}
# 		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
# 		return;
# 	}
#@@ -481,7 +509,7 @@
#
# 		if (!user_mode(regs) && debugger_bpt(regs))
# 			return;
#-		_exception(SIGTRAP, regs, 0, 0);
#+		_exception(SIGTRAP, regs, TRAP_BRKPT, 0);
#
# 	} else if (debug_status & DBSR_IC) {	/* instruction completion */
#
#@@ -490,7 +518,7 @@
#
# 		if (!user_mode(regs) && debugger_sstep(regs))
# 			return;
#-		_exception(SIGTRAP, regs, 0, 0);
#+		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
# 	}
# }
# #endif /* CONFIG_4xx || CONFIG_BOOKE */
#

# Diff checksum=d9786509


# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
mporter@kernel.crashing.org|ChangeSet|20030626005737|39517
D 1.1321 03/06/26 21:28:17-05:00 galak@blarg.somerset.sps.mot.com +1 -0
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c - Made emulated instructions respect single step tracing.
c - Added signal codes to SIGTRAPs raised by DebugException.
K 39517
P ChangeSet
------------------------------------------------

0a0
> cort@ftsoj.fsmlabs.com|arch/ppc/kernel/traps.c|20010106073007|59482|a197725432ca2496 galak@blarg.somerset.sps.mot.com|arch/ppc/kernel/traps.c|20030627022719|46504

galak@blarg.somerset.sps.mot.com|ChangeSet|20030627022817|39517
D 1.1322 03/06/26 21:58:47-05:00 galak@blarg.somerset.sps.mot.com +1 -0
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c removed additional if checking
K 39519
P ChangeSet
------------------------------------------------

0a0
> cort@ftsoj.fsmlabs.com|arch/ppc/kernel/traps.c|20010106073007|59482|a197725432ca2496 galak@blarg.somerset.sps.mot.com|arch/ppc/kernel/traps.c|20030627025845|43326

== arch/ppc/kernel/traps.c ==
cort@ftsoj.fsmlabs.com|arch/ppc/kernel/traps.c|20010106073007|59482|a197725432ca2496
galak@blarg.somerset.sps.mot.com|arch/ppc/kernel/traps.c|20030407215937|43451
D 1.47 03/06/26 21:27:19-05:00 galak@blarg.somerset.sps.mot.com +32 -4
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c Made emulated instructions respect single step tracing.  If an emulated instruction
c completes and single tracing is enabled we should send a SIGTRAP to the process.
c
c Added signal codes to SIGTRAPs raised by DebugException.
K 46504
O -rw-rw-r--
P arch/ppc/kernel/traps.c
------------------------------------------------

D346 1
I346 14
	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0) {
#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
		/* If we were single stepping and emulated an instruction
		* send a SIGTRAP to emulate the single step as well */
		if ((current->thread.dbcr0 & DBCR0_IC) == DBCR0_IC) {
			current->thread.dbcr0 &= ~DBCR0_IC;
			_exception(SIGTRAP, regs, TRAP_TRACE, 0);
		}
#else
		if ((regs->msr & MSR_SE) == MSR_SE) {
			regs->msr &= ~MSR_SE;
			_exception(SIGTRAP, regs, TRAP_TRACE, 0);
		}
#endif
I347 1
	}
D383 1
I383 14
		if (emulate_instruction(regs) == 0) {
#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
			/* If we were single stepping and emulated an instruction
			 * send a SIGTRAP to emulate the single step as well */
			if ((current->thread.dbcr0 & DBCR0_IC) == DBCR0_IC) {
				current->thread.dbcr0 &= ~DBCR0_IC;
				_exception(SIGTRAP, regs, TRAP_TRACE, 0);
			}
#else
			if ((regs->msr & MSR_SE) == MSR_SE) {
				regs->msr &= ~MSR_SE;
				_exception(SIGTRAP, regs, TRAP_TRACE, 0);
			}
#endif
I384 1
		}
D484 1
I484 1
		_exception(SIGTRAP, regs, TRAP_BRKPT, 0);
D493 1
I493 1
		_exception(SIGTRAP, regs, TRAP_TRACE, 0);

galak@blarg.somerset.sps.mot.com|arch/ppc/kernel/traps.c|20030627022719|46504
D 1.48 03/06/26 21:58:45-05:00 galak@blarg.somerset.sps.mot.com +4 -4
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c removed additional if checking
K 43326
O -rw-rw-r--
P arch/ppc/kernel/traps.c
------------------------------------------------

D350 1
I350 1
		if (current->thread.dbcr0 & DBCR0_IC) {
D355 1
I355 1
		if (regs->msr & MSR_SE) {
D401 1
I401 1
			if (current->thread.dbcr0 & DBCR0_IC) {
D406 1
I406 1
			if (regs->msr & MSR_SE) {

# Patch checksum=5e4c17b8

--Apple-Mail-5-1066586933--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

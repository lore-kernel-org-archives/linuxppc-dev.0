Message-ID: <3FE08C67.4020403@acm.org>
Date: Wed, 17 Dec 2003 11:03:35 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: debug_setcontext syscall
Content-Type: multipart/mixed;
 boundary="------------050005000804030301020509"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------050005000804030301020509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The following patch adds a syscall to the current linuxppc-2.5 tree.
This syscall allows in-application debuggers to work; it allows
debugging actions (currently setting the single-step bit and branch
trace enable bits) to be done for a setcontext, like a return from a
signal handler.

I have also attached a small program that demonstrates the usage of the
single stepping and branch tracing.

I'd like to get this into the standard kernel, but this is (obviously)
just for comment now.

-Corey

--------------050005000804030301020509
Content-Type: text/plain;
 name="test_dbg_setcontext.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_dbg_setcontext.c"


#include <signal.h>
#include <stdio.h>
#include <errno.h>
#include <sys/mman.h>
#include <asm/unistd.h>

struct my_sig_dbg_op {
	int dbg_type;
	unsigned long dbg_value;
};

/* Enable or disable single-stepping.  The value sets the state. */
#define MY_SIG_DBG_SINGLE_STEPPING		1

/* Enable or disable branch tracing.  The value sets the state. */
#define MY_SIG_DBG_BRANCH_TRACING		2

#ifndef __NR_dbg_sigreturn
#define __NR_dbg_sigreturn 256
#endif

/* Create the debug return syscall. */
_syscall3(int, dbg_sigreturn,
	  void *, ucontext,
	  int,    ndbg,
	  struct my_sig_dbg_op *, op);


volatile int called = 0;
volatile int called2 = 0;
volatile int called3 = 0;
volatile int trap_called = 0;

void sighand(int sig, siginfo_t *info, void *ucontext)
{
	struct my_sig_dbg_op op;

	called++;

	kill(getpid(), SIGUSR2);

	op.dbg_type = MY_SIG_DBG_SINGLE_STEPPING;
	op.dbg_value = 1;
	dbg_sigreturn(ucontext, 1, &op);
}

void sighand2(int sig, siginfo_t *info, void *ucontext)
{
	kill(getpid(), SIGPWR);
	called2++;
}

void sighand3(int sig, siginfo_t *info, void *ucontext)
{
	struct my_sig_dbg_op op;
	called3++;

	op.dbg_type = MY_SIG_DBG_SINGLE_STEPPING;
	op.dbg_value = 1;
	dbg_sigreturn(ucontext, 1, &op);
}

#define PAGE_SIZE 4096
#define TO_PAGEBASE(a) (((unsigned int) (a)) & (~(PAGE_SIZE-1)))
#define TRAP_INSTRUCTION  0x0ce00097

static int
write_instruction(unsigned char *address,
		  unsigned long new_instr,
		  unsigned long *old_instr)
{
	char         *pagebase = (char *) TO_PAGEBASE(address);

	/* FIXME - currently assuming read-only executable memory, need a
	   way to fetch the old memory protection. */
	if (mprotect(pagebase,
		     PAGE_SIZE,
		     PROT_READ | PROT_WRITE | PROT_EXEC) != 0) {
		/* Couldn't change memory protection, return an error */
		return -1;
	}

	if (old_instr)
		*old_instr = *((volatile unsigned long *) address);

	*((volatile unsigned long *) address) = new_instr;

	mprotect(pagebase, PAGE_SIZE, PROT_READ | PROT_EXEC);

	/* Flush the cache for the instruction. */
	__asm__ ("dcbst 0,%0\n\ticbi 0,%0" : : "r" (address));

	return 0;
}

unsigned char *instr_addr;
unsigned long old_instr;
int restore = 0;
int tracing = 0;

/* The "old" ucontext. */
struct old_sigcontext_struct {
	unsigned long	_unused[4];
	int		signal;
	unsigned long	handler;
	unsigned long	oldmask;
	struct pt_regs 	*regs;
};
struct old_ucontext {
	unsigned long	  uc_flags;
	struct ucontext  *uc_link;
	stack_t		  uc_stack;
	struct sigcontext_struct uc_mcontext;
	sigset_t	  uc_sigmask;	/* mask last for extensibility */
};

unsigned long
dbg_get_instruction_ptr_from_ucontext(void *ucontext)
{
    struct old_ucontext *uc = ucontext;
    struct pt_regs      *regs = uc->uc_mcontext.regs;
    return regs->nip;
}

void sigtrap(int sig, siginfo_t *info, void *ucontext)
{
	int old_errno = errno;
	trap_called++;
	if (restore) {
		write_instruction(instr_addr, old_instr, NULL);
		restore = 0;
	}
	if (tracing) {
		char buf[100];
		sprintf(buf, "Trap at %8.8x\n", dbg_get_instruction_ptr_from_ucontext(ucontext));
		__libc_write(2, buf, strlen(buf));
		if (trap_called > 20)
			tracing = 0;
		else {
			struct my_sig_dbg_op op;
			errno = old_errno;

			op.dbg_type = MY_SIG_DBG_BRANCH_TRACING;
			op.dbg_value = 1;
			dbg_sigreturn(ucontext, 1, &op);
		}
	}
	errno = old_errno;
}

void call_printf(void)
{
	printf("test\n");
}

int main(int argc, char *argv)
{
	struct sigaction act;
	int rv;

	act.sa_sigaction = sighand;
	act.sa_flags = SA_SIGINFO;
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask, SIGUSR2);
	rv = sigaction(SIGUSR1, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	act.sa_sigaction = sighand2;
	rv = sigaction(SIGUSR2, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	act.sa_sigaction = sighand3;
	rv = sigaction(SIGPWR, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	act.sa_sigaction = sigtrap;
	rv = sigaction(SIGTRAP, &act, NULL);
	if (rv == -1) {
		perror("sigaction");
		exit(1);
	}

	kill(getpid(), SIGUSR1);

	if (!called)
		printf("Didn't get called\n");
	else
		printf("Got called %d times\n", called);

	if (!called2)
		printf("Didn't get called 2\n");
	else
		printf("Got called 2 %d times\n", called2);

	if (!called3)
		printf("Didn't get called 3\n");
	else
		printf("Got called 3 %d times\n", called3);

	if (!trap_called) {
		printf("ERROR: Didn't get trapped\n");
		exit(1);
	} else
		printf("Got trapped %d times\n", trap_called);

	instr_addr = (unsigned char *) call_printf;

	write_instruction(instr_addr, TRAP_INSTRUCTION, &old_instr);
	restore = 1;
	tracing = 1;
	call_printf();

	exit(0);
}

--------------050005000804030301020509
Content-Type: text/plain;
 name="ppc_dbg-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_dbg-2.5.diff"

diff -ur 2.5.old/arch/ppc/kernel/misc.S 2.5/arch/ppc/kernel/misc.S
--- 2.5.old/arch/ppc/kernel/misc.S	2003-12-15 11:20:44.000000000 -0600
+++ 2.5/arch/ppc/kernel/misc.S	2003-12-14 21:31:49.000000000 -0600
@@ -1385,3 +1385,5 @@
 	.long sys_statfs64
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
+	.long sys_ni_syscall	/* 255 */
+	.long sys_debug_setcontext
diff -ur 2.5.old/arch/ppc/kernel/signal.c 2.5/arch/ppc/kernel/signal.c
--- 2.5.old/arch/ppc/kernel/signal.c	2003-12-15 11:21:16.000000000 -0600
+++ 2.5/arch/ppc/kernel/signal.c	2003-12-17 07:50:15.000000000 -0600
@@ -445,6 +445,88 @@
 	return 0;
 }

+int sys_debug_setcontext(struct ucontext __user *ctx,
+			 int ndbg, struct sig_dbg_op *dbg,
+			 int r6, int r7, int r8,
+			 struct pt_regs *regs)
+{
+	unsigned char tmp;
+	struct sig_dbg_op op;
+	int i;
+	unsigned long new_msr = regs->msr;
+#if defined(CONFIG_4xx)
+	unsigned long new_dbcr0 = current->thread.dbcr0;
+#endif
+
+	for (i=0; i<ndbg; i++) {
+		if (__copy_from_user(&op, dbg, sizeof(op)))
+			return -EFAULT;
+		switch (op.dbg_type) {
+		case SIG_DBG_SINGLE_STEPPING:
+#if defined(CONFIG_4xx)
+			if (op.dbg_value) {
+				new_msr |= MSR_DE;
+				new_dbcr0 |= (DBCR0_IDM | DBCR0_IC);
+			} else {
+				new_msr &= ~MSR_DE;
+				new_dbcr0 &= ~(DBCR0_IDM | DBCR0_IC);
+			}
+#else
+			if (op.dbg_value)
+				new_msr |= MSR_SE;
+			else
+				new_msr &= ~MSR_SE;
+#endif
+			break;
+		case SIG_DBG_BRANCH_TRACING:
+#if defined(CONFIG_4xx)
+			return -EINVAL;
+#else
+			if (op.dbg_value)
+				new_msr |= MSR_BE;
+			else
+				new_msr &= ~MSR_BE;
+#endif
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (verify_area(VERIFY_READ, ctx, sizeof(*ctx))
+	    || __get_user(tmp, (u8 *) ctx)
+	    || __get_user(tmp, (u8 *) (ctx + 1) - 1))
+		return -EFAULT;
+
+	/* We wait until here to actually install the values in the
+	   registers so if we fail in the above loop, it will not
+	   affect the contents of these registers.  After this point,
+	   failure is a problem, anyway, and it's very unlikely unless
+	   the user is really doing something wrong. */
+	regs->msr = new_msr;
+#if defined(CONFIG_4xx)
+	current->thread.dbcr0 = new_dbcr0;
+#endif
+
+	/*
+	 * If we get a fault copying the context into the kernel's
+	 * image of the user's registers, we can't just return -EFAULT
+	 * because the user's registers will be corrupted.  For instance
+	 * the NIP value may have been updated but not some of the
+	 * other registers.  Given that we have done the verify_area
+	 * and successfully read the first and last bytes of the region
+	 * above, this should only happen in an out-of-memory situation
+	 * or if another thread unmaps the region containing the context.
+	 * We kill the task with a SIGSEGV in this situation.
+	 */
+	if (do_setcontext(ctx, regs))
+		do_exit(SIGSEGV);
+	sigreturn_exit(regs);
+	/* doesn't actually return back to here */
+	return 0;
+}
+
 /*
  * OK, we're invoking a handler
  */
diff -ur 2.5.old/arch/ppc/kernel/traps.c 2.5/arch/ppc/kernel/traps.c
--- 2.5.old/arch/ppc/kernel/traps.c	2003-12-15 11:18:41.000000000 -0600
+++ 2.5/arch/ppc/kernel/traps.c	2003-12-14 21:27:33.000000000 -0600
@@ -462,7 +462,7 @@
 void
 SingleStepException(struct pt_regs *regs)
 {
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
 	if (debugger_sstep(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
diff -ur 2.5.old/include/asm-ppc/signal.h 2.5/include/asm-ppc/signal.h
--- 2.5.old/include/asm-ppc/signal.h	2003-12-15 11:18:33.000000000 -0600
+++ 2.5/include/asm-ppc/signal.h	2003-12-14 21:27:40.000000000 -0600
@@ -153,4 +153,23 @@
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 #endif /* __KERNEL__ */

+/*
+ * These are parameters to dbg_sigreturn syscall.  They enable or
+ * disable certain debugging things that can be done from signal
+ * handlers.  The dbg_sigreturn syscall *must* be called from a
+ * SA_SIGINFO signal so the ucontext can be passed to it.  It takes an
+ * array of struct sig_dbg_op, which has the debug operations to
+ * perform before returning from the signal.
+ */
+struct sig_dbg_op {
+	int dbg_type;
+	unsigned long dbg_value;
+};
+
+/* Enable or disable single-stepping.  The value sets the state. */
+#define SIG_DBG_SINGLE_STEPPING		1
+
+/* Enable or disable branch tracing.  The value sets the state. */
+#define SIG_DBG_BRANCH_TRACING		2
+
 #endif
diff -ur 2.5.old/include/asm-ppc/unistd.h 2.5/include/asm-ppc/unistd.h
--- 2.5.old/include/asm-ppc/unistd.h	2003-12-15 11:18:41.000000000 -0600
+++ 2.5/include/asm-ppc/unistd.h	2003-12-14 21:29:24.000000000 -0600
@@ -259,8 +259,9 @@
 #define __NR_statfs64		252
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
+#define __NR_debug_setcontext	256

-#define __NR_syscalls		255
+#define __NR_syscalls		257

 #define __NR(n)	#n


--------------050005000804030301020509--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

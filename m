Message-ID: <3F58AA89.80803@acm.org>
Date: Fri, 05 Sep 2003 10:23:53 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Corey Minyard <minyard@acm.org>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
References: <3F4FB0F3.9090906@acm.org> <20030829131824.B18608@home.com> <3F574958.4090402@acm.org>
In-Reply-To: <3F574958.4090402@acm.org>
Content-Type: multipart/mixed;
 boundary="------------090205010503020009020902"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090205010503020009020902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's an example patch (that I have tested) that shows the use of the
top 16 bits of the trap field as communication between the signal
handler and the kernel.

-Corey

Corey Minyard wrote:

>
> Actually, using the SE bit may not be the best way to handle this to
> cover all the PPC variants.
>
> Would it be better to have a special bit field someplace that is used to
> communicate between the signal handler and the kernel?  Some
> possibilities are:
>
>    * The top 16 bits of the trap field
>    * The currently unused mq field (except on APUS?)
>    * A new field in the signal frame
>
> I'm thinking that reserving the top 16 bits of the trap field may be the
> best.  It would always come in as zero (so existing software won't be
> broken) and it will be available for all processors and will not be used
> for anything else by the processor.
>
> Any thoughts?
>
> -Corey
>
> Matt Porter wrote:
>
>> On Fri, Aug 29, 2003 at 03:00:51PM -0500, Corey Minyard wrote:
>>
>>
>>> I have a debugger that runs in an application that requires access to
>>> the SE and BE bits.  The following patch adds that capability to
>>> 2.4.21-ben1.  I have tested this, and gdb still seems to correctly step
>>> out of signal handlers, and it seems to work for 4xx.  Does this
>>> look ok?
>>>
>>>
>>


--------------090205010503020009020902
Content-Type: text/plain;
 name="ppc-dbgr2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc-dbgr2.diff"

--- arch/ppc/kernel/signal.c.old	2003-08-28 15:30:37.000000000 -0500
+++ arch/ppc/kernel/signal.c	2003-09-05 09:17:49.000000000 -0500
@@ -304,6 +304,29 @@
 			     GP_REGS_SIZE - PT_ORIG_R3 * sizeof(elf_greg_t)))
 		return 1;

+
+	/* Check any special handling requests from the signal
+	   handler */
+	if (regs->trap >> 16) {
+		/* If the signal handler has asked for
+		   single-stepping, set it up. */
+		if (regs->trap & PPC_TRAP_ENABLE_SINGLE_STEP) {
+#if defined(CONFIG_4xx)
+			regs->msr |= MSR_DE;
+			current->thread.dbcr0 |= (DBCR0_IDM | DBCR0_IC);
+#else
+			regs->msr |= MSR_SE;
+#endif
+		}
+		/* If the signal handler has asked for branch
+		   tracing, set it up. */
+		if (regs->trap & PPC_TRAP_ENABLE_BRANCH_TRACE) {
+#if !defined(CONFIG_4xx)
+			regs->msr |= MSR_BE;
+#endif
+		}
+	}
+
 	/* force the process to reload the FP registers from
 	   current->thread when it next does FP instructions */
 	regs->msr &= ~MSR_FP;
--- arch/ppc/kernel/traps.c.old	2003-08-28 15:42:26.000000000 -0500
+++ arch/ppc/kernel/traps.c	2003-09-05 09:15:47.000000000 -0500
@@ -396,7 +396,7 @@
 void
 SingleStepException(struct pt_regs *regs)
 {
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
 	if (debugger_sstep(regs))
 		return;
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
--- include/asm-ppc/ptrace.h.old	2003-09-05 09:02:15.000000000 -0500
+++ include/asm-ppc/ptrace.h	2003-09-05 09:16:43.000000000 -0500
@@ -29,11 +29,28 @@
 	unsigned long ccr;
 	unsigned long mq;		/* 601 only (not used at present) */
 					/* Used on APUS to hold IPL value. */
+
+	/* Note that the high-order 16-bits of the trap field are used
+	   to communicate information back from the signal handler, as
+	   described in the PPC_TRAP_xxx macros below.  You should
+	   leave this alone if you do not need these functions. */
 	unsigned long trap;		/* Reason for being here */
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* used for ESR on 4xx/Book-E */
 	unsigned long result; 		/* Result of a system call */
 };
+
+/* If you set this bit in the "trap" field when returning from a
+   signal handler, single stepping will be enabled on the first
+   instruction back from the signal handler, if the processor supports
+   this. */
+#define PPC_TRAP_ENABLE_SINGLE_STEP	(1 << 16)
+
+/* If you set this bit in the "trap" field when returning from a
+   signal handler, branch tracing will be enabled on the first
+   instruction back from the signal handler, if the processor supports
+   this. */
+#define PPC_TRAP_ENABLE_BRANCH_TRACE	(1 << 17)
 #endif

 #ifdef __KERNEL__

--------------090205010503020009020902--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <paulus@ozlabs.org>
Date: Tue, 15 Jun 2010 11:54:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100615015459.GA30479@drongo>
References: <20100528063924.GA8679@in.ibm.com>
	<20100602113316.GA17061@brick.ozlabs.ibm.com>
	<20100604065145.GA2408@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100604065145.GA2408@in.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 04, 2010 at 12:21:45PM +0530, K.Prasad wrote:

> Meanwhile I tested the per-cpu breakpoints with the new emulate_step
> patch (refer linuxppc-dev message-id:
> 20100602112903.GB30149@brick.ozlabs.ibm.com) and they continue to fail
> due to emulate_step() failure, in my case, on a "lwz r0,0(r28)"
> instruction.

You need to pass the instruction word to emulate_step(), not the
instruction address.  Also you need to have the full GPR set
available.  The patch below fixes these problems.  I'll fold these
changes into your patch 2/5.

Paul.
---
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3e423fb..f53029a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -828,6 +828,7 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 
 /* We have a data breakpoint exception - handle it */
 handle_dabr_fault:
+	bl	.save_nvgprs
 	ld      r4,_DAR(r1)
 	ld      r5,_DSISR(r1)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index ef70cf0..489049c 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -35,6 +35,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/processor.h>
 #include <asm/sstep.h>
+#include <asm/uaccess.h>
 
 /*
  * Stores the breakpoints currently in use on each breakpoint address
@@ -203,6 +204,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	int stepped = 1;
 	struct arch_hw_breakpoint *info;
 	unsigned long dar = regs->dar;
+	unsigned int instr;
 
 	/* Disable breakpoints during exception handling */
 	set_dabr(0);
@@ -255,7 +257,11 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 		goto out;
 	}
 
-	stepped = emulate_step(regs, regs->nip);
+	stepped = 0;
+	instr = 0;
+	if (!__get_user_inatomic(instr, (unsigned int *) regs->nip))
+		stepped = emulate_step(regs, instr);
+
 	/*
 	 * emulate_step() could not execute it. We've failed in reliably
 	 * handling the hw-breakpoint. Unregister it and throw a warning

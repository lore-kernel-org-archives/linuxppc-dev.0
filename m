Return-Path: <ananth@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C7B4B7D2E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 15:19:24 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4S5FBi2001622
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:15:11 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S5JLVf175502
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:19:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4S5JLgd026372
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:19:21 -0600
Date: Fri, 28 May 2010 10:49:20 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: remove resume_execution() in kprobes
Message-ID: <20100528051919.GC25946@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com>
	<20100528020556.GA10586@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100528020556.GA10586@brick.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 28, 2010 at 12:05:56PM +1000, Paul Mackerras wrote:
> On Thu, May 27, 2010 at 07:42:03PM +0530, Ananth N Mavinakayanahalli wrote:
> 
> > While we are at it, can we also add nop to the list of emulated
> > instructions?
> 
> I have a patch in development that emulates most of the arithmetic,
> logical and shift/rotate instructions, including ori.

OK.

> While you're here (in a virtual sense at least :), could you explain
> what's going on with the emulate_step() call in resume_execution() in
> arch/powerpc/kernel/kprobes.c?  It looks like, having decided that
> emulate_step() can't handle the instruction, you single-step the
> instruction out of line and then call emulate_step again on the same
> instruction, in resume_execution().  Why on earth is it trying to
> emulate the instruction when it has already been executed at this
> point?  Is there any reason why we can't just remove the emulate_step
> call from resume_execution()?

You are right. We needed emulate_step() in resume_execution() before we
had the code to handle the emulation in kprobe_handler() at the time of
the breakpoint it. At the time we needed it mainly to ensure branch
targets are reflected correctly in regs->nip if the stepped instruction
was a branch.

However, we now don't get to post_kprobe_handler() at all if
emulate_step() returned 1 at the time of the breakpoint hit. It suffices
if we just fixup the nip here. Patch below. Tested for various
instructions that can and can't be emulated...

---
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

emulate_step() in kprobe_handler() would've already determined if the
probed instruction can be emulated. We single-step in hardware only if
the instruction couldn't be emulated. resume_execution() therefore is
superfluous -- all we need is to fix up the instruction pointer after
single-stepping.

Thanks to Paul Mackerras for catching this.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/kernel/kprobes.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

Index: linux-2.6.34/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.34.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.34/arch/powerpc/kernel/kprobes.c
@@ -375,17 +375,6 @@ static int __kprobes trampoline_probe_ha
  * single-stepped a copy of the instruction.  The address of this
  * copy is p->ainsn.insn.
  */
-static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
-{
-	int ret;
-	unsigned int insn = *p->ainsn.insn;
-
-	regs->nip = (unsigned long)p->addr;
-	ret = emulate_step(regs, insn);
-	if (ret == 0)
-		regs->nip = (unsigned long)p->addr + 4;
-}
-
 static int __kprobes post_kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *cur = kprobe_running();
@@ -403,7 +392,8 @@ static int __kprobes post_kprobe_handler
 		cur->post_handler(cur, regs, 0);
 	}
 
-	resume_execution(cur, regs);
+	/* Adjust nip to after the single-stepped instruction */
+	regs->nip = (unsigned long)cur->addr + 4;
 	regs->msr |= kcb->kprobe_saved_msr;
 
 	/*Restore back the original saved kprobes variables and continue. */

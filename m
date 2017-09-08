Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpL6Q1MpwzDrYh
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 11:57:01 +1000 (AEST)
Message-ID: <1504835810.17625.4.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "laurentiu.tudor@nxp.com"
 <laurentiu.tudor@nxp.com>
Date: Thu, 07 Sep 2017 20:56:50 -0500
In-Reply-To: <1504692964.27247.68.camel@infinera.com>
References: <1504265576.20777.61.camel@infinera.com>
 <59AFC83A.8080204@nxp.com> <1504692964.27247.68.camel@infinera.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Machine Check in P2010(e500v2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-06 at 10:16 +0000, Joakim Tjernlund wrote:
> On Wed, 2017-09-06 at 10:05 +0000, Laurentiu Tudor wrote:
> > Hi Jocke,
> > 
> > On 09/01/2017 02:32 PM, Joakim Tjernlund wrote:
> > > I am trying to debug a Machine Check for a P2010 (e500v2) CPU:
> > > 
> > > [   28.111816] Caused by (from MCSR=10008): Bus - Read Data Bus Error
> > > [   28.117998] Oops: Machine check, sig: 7 [#1]
> > > [   28.122263] P1010 RDB
> > > [   28.124529] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO)
> > > linux_kernel_bde(PO)
> > > [   28.132718] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted:
> > > P           O    4.1.38+ #49
> > > [   28.140376] task: db16cd10 ti: df128000 task.ti: df128000
> > > [   28.145770] NIP: 00000000 LR: 10a4e404 CTR: 10046c38
> > > [   28.150730] REGS: df129f10 TRAP: 0204   Tainted:
> > > P           O     (4.1.38+)
> > > [   28.157776] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 00000000
> > > [   28.164140] DEAR: b7187000 ESR: 00000000
> > > GPR00: 10a4e404 bf86ea30 b7ca94a0 132f9fa8 07006000 07000000 00000000
> > > 132f9fd8
> > > GPR08: b7149000 b7159000 0003e000 bf86ea20 24004424 11d6cf7c 00000000
> > > 00000000
> > > GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc 00000011
> > > 00000001
> > > GPR24: 01a4d12d 132ffbf0 11d60000 00000000 07006000 00000000 132f9fa8
> > > 00000000
> > > [   28.196375] NIP [00000000]   (null)
> > > [   28.199859] LR [10a4e404] 0x10a4e404
> > > [   28.203426] Call Trace:
> > > [   28.205866] ---[ end trace f456255ddf9bee83 ]---
> > > 
> > > I cannot figure out why NIP is NULL ? It LOOKs like NIP is set to
> > > MCSRR0 early on but maybe it is lost somehow?
> > > 
> > > Anyhow, looking at entry_32.S:
> > > 	.globl	mcheck_transfer_to_handler
> > > mcheck_transfer_to_handler:
> > > 	mfspr	r0,SPRN_DSRR0
> > > 	stw	r0,_DSRR0(r11)
> > > 	mfspr	r0,SPRN_DSRR1
> > > 	stw	r0,_DSRR1(r11)
> > > 	/* fall through */
> > > 
> > > 	.globl	debug_transfer_to_handler
> > > debug_transfer_to_handler:
> > > 	mfspr	r0,SPRN_CSRR0
> > > 	stw	r0,_CSRR0(r11)
> > > 	mfspr	r0,SPRN_CSRR1
> > > 	stw	r0,_CSRR1(r11)
> > > 	/* fall through */
> > > 
> > > 	.globl	crit_transfer_to_handler
> > > crit_transfer_to_handler:
> > > 
> > > It looks odd that DSRRx is assigned in mcheck and CSRRx in debug and
> > > crit has none. Should not this assigment be shifted down one level?
> > > 
> > 
> > This does indeed looks weird. Have you tried moving the SPRN_CSRR* 
> > saving in the crit section? Any results?
> 
> After looking at this somwhat I think this is intentional and OK.
> I sorted NIP == NULL too:
> @@ -996,7 +998,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
>         if (is_in_pci_mem_space(addr)) {
>                 if (user_mode(regs)) {
>                         pagefault_disable();
> -                       ret = get_user(regs->nip, &inst);
> +                       ret = get_user(inst, (__u32 __user *)regs->nip);
>                         pagefault_enable();
>                 } else {
>                         ret = probe_kernel_address(regs->nip, inst);

:-(

> 
> But after this, the CPU is still locked after an Machine Check. Is this
> to be expected? I figured the user space process would get a SIGBUS and
> kernel
> would resume normal operations.
> 
> Scott, maybe you have some idea?

The userspace process should exit with SIGBUS (not quite the same as receiving
a SIGBUS that can be handled).  Maybe whatever is causing the machine check
ends up causing more problems that lead to the hang.

-Scott

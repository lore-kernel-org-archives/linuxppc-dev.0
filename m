Return-Path: <leoyang.li@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnZt908BfzDqgy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 06:28:47 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, York Sun
 <york.sun@nxp.com>
Subject: RE: Machine Check in P2010(e500v2)
Date: Wed, 6 Sep 2017 20:28:41 +0000
Message-ID: <AM4PR0401MB16990A5A3D77ED57C9A645D98F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1504265576.20777.61.camel@infinera.com>
 <1504600831.27247.20.camel@infinera.com>
 <VI1PR04MB2078E4FFD1B27961F63D88689A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <AM4PR0401MB16992DFADBD59ADEF8E3ACC08F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504729020.27247.120.camel@infinera.com>
In-Reply-To: <1504729020.27247.120.camel@infinera.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> Sent: Wednesday, September 06, 2017 3:17 PM
> To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>; York Sun
> <york.sun@nxp.com>
> Subject: Re: Machine Check in P2010(e500v2)
>=20
> On Wed, 2017-09-06 at 19:31 +0000, Leo Li wrote:
> > > -----Original Message-----
> > > From: York Sun
> > > Sent: Wednesday, September 06, 2017 10:38 AM
> > > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>; linuxppc-
> > > dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>
> > > Subject: Re: Machine Check in P2010(e500v2)
> > >
> > > Scott is no longer with Freescale/NXP. Adding Leo.
> > >
> > > On 09/05/2017 01:40 AM, Joakim Tjernlund wrote:
> > > > So after some debugging I found this bug:
> > > > @@ -996,7 +998,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *re=
gs)
> > > >          if (is_in_pci_mem_space(addr)) {
> > > >                  if (user_mode(regs)) {
> > > >                          pagefault_disable();
> > > > -                       ret =3D get_user(regs->nip, &inst);
> > > > +                       ret =3D get_user(inst, (__u32 __user
> > > > + *)regs->nip);
> > > >                          pagefault_enable();
> > > >                  } else {
> > > >                          ret =3D probe_kernel_address(regs->nip,
> > > > inst);
> > > >
> > > > However, the kernel still locked up after fixing that.
> > > > Now I wonder why this fixup is there in the first place? The
> > > > routine will not really fixup the insn, just return 0xffffffff for
> > > > the failing read and then advance the process NIP.
> >
> > You are right.  The code here only gives 0xffffffff to the load instruc=
tions and
> continue with the next instruction when the load instruction is causing t=
he
> machine check.  This will prevent a system lockup when reading from
> PCI/RapidIO device which is link down.
> >
> > I don't know what is actual problem in your case.  Maybe it is a write
> instruction instead of read?   Or the code is in a infinite loop waiting =
for a valid
> read result?  Are you able to do some further debugging with the NIP corr=
ectly
> printed?
> >
>=20
> According to the MC it is a Read and the NIP also leads to a read in the =
program.
> ATM, I have disabled the fixup but I will enable that again.
> Question, is it safe add a small printk when this MC happens(after fixing=
 up)? I
> need to see that it has happened as the error is somewhat random.

I think it is safe to add printk as the current machine check handlers are =
also using printk.

>=20
>  Jocke
>=20
> > Regards,
> > Leo
> >
> > > >
> > > > Removing the fixup does not help either, kernel still locks up:
> > > > [   28.170532] Machine check in kernel mode.
> > > > [   28.174538] Caused by (from MCSR=3D10008):
> > > > [   28.182804] Bus - Read Data Bus Error: DAR:b7013000
> > > > [   28.197079] Oops: Machine check, sig: 7 [#1]
> > > > [   28.201343] P1010 RDB
> > > > [   28.203608] Modules linked in: linux_bcm_knet(PO) linux_user_bde=
(PO)
> > >
> > > linux_kernel_bde(PO)
> > > > [   28.211796] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P        =
   O
> > >
> > > 4.1.38+ #201
> > > > [   28.219540] task: db16ed10 ti: df122000 task.ti: df122000
> > > > [   28.224935] NIP: 10a4e2f4 LR: 10a4e404 CTR: 10046c38
> > > > [   28.229896] REGS: df123f10 TRAP: 0204   Tainted: P           O  =
   (4.1.38+)
> > > > [   28.236942] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER:
> 00000000
> > > > [   28.243306] DEAR: b7013000 ESR: 00000000
> > > > GPR00: 10a4e404 bfab2730 b7b354a0 132f9fa8 07006000 07000000
> > >
> > > 00000000
> > > > 132f9fd8
> > > > GPR08: b6fd5000 b6fe5000 0003e000 bfab2720 24004424 11d6cf7c
> > > > 00000000
> > > > 00000000
> > > > GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc
> > > > 00000011
> > > > 00000001
> > > > GPR24: 01a5bd3e 132ffbf0 11d60000 00000000 07006000 00000000
> > > > 132f9fa8
> > >
> > > 00000000
> > > > [   28.275547] NIP [10a4e2f4] 0x10a4e2f4
> > > > [   28.279204] LR [10a4e404] 0x10a4e404
> > > > [   28.282772] Call Trace:
> > > > [   28.285213] ---[ end trace 9f8b64ab1e83f449 ]---
> > > > [   28.289825]
> > > >
> > > >
> > > >   Jocke
> > > >
> > > > On Fri, 2017-09-01 at 13:32 +0200, Joakim Tjernlund wrote:
> > > > > I am trying to debug a Machine Check for a P2010 (e500v2) CPU:
> > > > >
> > > > > [   28.111816] Caused by (from MCSR=3D10008): Bus - Read Data Bus=
 Error
> > > > > [   28.117998] Oops: Machine check, sig: 7 [#1]
> > > > > [   28.122263] P1010 RDB
> > > > > [   28.124529] Modules linked in: linux_bcm_knet(PO) linux_user_b=
de(PO)
> > >
> > > linux_kernel_bde(PO)
> > > > > [   28.132718] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P      =
     O
> > >
> > > 4.1.38+ #49
> > > > > [   28.140376] task: db16cd10 ti: df128000 task.ti: df128000
> > > > > [   28.145770] NIP: 00000000 LR: 10a4e404 CTR: 10046c38
> > > > > [   28.150730] REGS: df129f10 TRAP: 0204   Tainted: P           O=
     (4.1.38+)
> > > > > [   28.157776] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER:
> 00000000
> > > > > [   28.164140] DEAR: b7187000 ESR: 00000000
> > > > > GPR00: 10a4e404 bf86ea30 b7ca94a0 132f9fa8 07006000 07000000
> > >
> > > 00000000
> > > > > 132f9fd8
> > > > > GPR08: b7149000 b7159000 0003e000 bf86ea20 24004424 11d6cf7c
> > >
> > > 00000000
> > > > > 00000000
> > > > > GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc
> > >
> > > 00000011
> > > > > 00000001
> > > > > GPR24: 01a4d12d 132ffbf0 11d60000 00000000 07006000 00000000
> > >
> > > 132f9fa8 00000000
> > > > > [   28.196375] NIP [00000000]   (null)
> > > > > [   28.199859] LR [10a4e404] 0x10a4e404
> > > > > [   28.203426] Call Trace:
> > > > > [   28.205866] ---[ end trace f456255ddf9bee83 ]---
> > > > >
> > > > > I cannot figure out why NIP is NULL ? It LOOKs like NIP is set
> > > > > to
> > > > > MCSRR0 early on but maybe it is lost somehow?
> > > > >
> > > > > Anyhow, looking at entry_32.S:
> > > > > 	.globl	mcheck_transfer_to_handler
> > > > > mcheck_transfer_to_handler:
> > > > > 	mfspr	r0,SPRN_DSRR0
> > > > > 	stw	r0,_DSRR0(r11)
> > > > > 	mfspr	r0,SPRN_DSRR1
> > > > > 	stw	r0,_DSRR1(r11)
> > > > > 	/* fall through */
> > > > >
> > > > > 	.globl	debug_transfer_to_handler
> > > > > debug_transfer_to_handler:
> > > > > 	mfspr	r0,SPRN_CSRR0
> > > > > 	stw	r0,_CSRR0(r11)
> > > > > 	mfspr	r0,SPRN_CSRR1
> > > > > 	stw	r0,_CSRR1(r11)
> > > > > 	/* fall through */
> > > > >
> > > > > 	.globl	crit_transfer_to_handler
> > > > > crit_transfer_to_handler:
> > > > >
> > > > > It looks odd that DSRRx is assigned in mcheck and CSRRx in debug
> > > > > and crit has none. Should not this assigment be shifted down one =
level?
> > > > >
> > > > >    Jocke
> >
> >

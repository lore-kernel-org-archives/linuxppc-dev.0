Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0080.outbound.protection.outlook.com [104.47.42.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpcd60Gy9zDrZ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 22:51:03 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: Re: Machine Check in P2010(e500v2)
Date: Fri, 8 Sep 2017 12:50:54 +0000
Message-ID: <1504875052.31322.38.camel@infinera.com>
References: <1504265576.20777.61.camel@infinera.com>
 <1504600831.27247.20.camel@infinera.com>
 <VI1PR04MB2078E4FFD1B27961F63D88689A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <AM4PR0401MB16992DFADBD59ADEF8E3ACC08F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504729020.27247.120.camel@infinera.com>
 <AM4PR0401MB16990A5A3D77ED57C9A645D98F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504731221.27247.126.camel@infinera.com>
 <AM4PR0401MB16995FE3651C5F423FBAD2278F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504738204.27247.133.camel@infinera.com>
 <1504773676.31322.2.camel@infinera.com>
 <AM4PR0401MB16993C0235EA67562A8B8D4E8F940@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504864463.31322.31.camel@infinera.com>
In-Reply-To: <1504864463.31322.31.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-08 at 11:54 +0200, Joakim Tjernlund wrote:
> On Thu, 2017-09-07 at 18:54 +0000, Leo Li wrote:
> > > -----Original Message-----
> > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > Sent: Thursday, September 07, 2017 3:41 AM
> > > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>; York =
Sun
> > > <york.sun@nxp.com>
> > > Subject: Re: Machine Check in P2010(e500v2)
> > >=20
> > > On Thu, 2017-09-07 at 00:50 +0200, Joakim Tjernlund wrote:
> > > > On Wed, 2017-09-06 at 21:13 +0000, Leo Li wrote:
> > > > > > -----Original Message-----
> > > > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > Sent: Wednesday, September 06, 2017 3:54 PM
> > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>;
> > > > > > York Sun <york.sun@nxp.com>
> > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > >=20
> > > > > > On Wed, 2017-09-06 at 20:28 +0000, Leo Li wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.co=
m]
> > > > > > > > Sent: Wednesday, September 06, 2017 3:17 PM
> > > > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li
> > > > > > > > <leoyang.li@nxp.com>; York Sun <york.sun@nxp.com>
> > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > >=20
> > > > > > > > On Wed, 2017-09-06 at 19:31 +0000, Leo Li wrote:
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: York Sun
> > > > > > > > > > Sent: Wednesday, September 06, 2017 10:38 AM
> > > > > > > > > > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>;
> > > > > > > > > > linuxppc- dev@lists.ozlabs.org; Leo Li
> > > > > > > > > > <leoyang.li@nxp.com>
> > > > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > > > >=20
> > > > > > > > > > Scott is no longer with Freescale/NXP. Adding Leo.
> > > > > > > > > >=20
> > > > > > > > > > On 09/05/2017 01:40 AM, Joakim Tjernlund wrote:
> > > > > > > > > > > So after some debugging I found this bug:
> > > > > > > > > > > @@ -996,7 +998,7 @@ int fsl_pci_mcheck_exception(stru=
ct
> > > > > > > > > > > pt_regs
> > > > > >=20
> > > > > > *regs)
> > > > > > > > > > >          if (is_in_pci_mem_space(addr)) {
> > > > > > > > > > >                  if (user_mode(regs)) {
> > > > > > > > > > >                          pagefault_disable();
> > > > > > > > > > > -                       ret =3D get_user(regs->nip, &=
inst);
> > > > > > > > > > > +                       ret =3D get_user(inst, (__u32
> > > > > > > > > > > + __user *)regs->nip);
> > > > > > > > > > >                          pagefault_enable();
> > > > > > > > > > >                  } else {
> > > > > > > > > > >                          ret =3D
> > > > > > > > > > > probe_kernel_address(regs->nip, inst);
> > > > > > > > > > >=20
> > > > > > > > > > > However, the kernel still locked up after fixing that=
.
> > > > > > > > > > > Now I wonder why this fixup is there in the first pla=
ce?
> > > > > > > > > > > The routine will not really fixup the insn, just retu=
rn
> > > > > > > > > > > 0xffffffff for the failing read and then advance the =
process NIP.
> > > > > > > > >=20
> > > > > > > > > You are right.  The code here only gives 0xffffffff to th=
e
> > > > > > > > > load instructions and
> > > > > > > >=20
> > > > > > > > continue with the next instruction when the load instructio=
n
> > > > > > > > is causing the machine check.  This will prevent a system
> > > > > > > > lockup when reading from PCI/RapidIO device which is link d=
own.
> > > > > > > > >=20
> > > > > > > > > I don't know what is actual problem in your case.  Maybe =
it
> > > > > > > > > is a write
> > > > > > > >=20
> > > > > > > > instruction instead of read?   Or the code is in a infinite=
 loop waiting for
> > >=20
> > > a
> > > > > >=20
> > > > > > valid
> > > > > > > > read result?  Are you able to do some further debugging wit=
h
> > > > > > > > the NIP correctly printed?
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > According to the MC it is a Read and the NIP also leads to =
a
> > > > > > > > read in the
> > > > > >=20
> > > > > > program.
> > > > > > > > ATM, I have disabled the fixup but I will enable that again=
.
> > > > > > > > Question, is it safe add a small printk when this MC
> > > > > > > > happens(after fixing up)? I need to see that it has happene=
d
> > > > > > > > as the error is somewhat
> > > > > >=20
> > > > > > random.
> > > > > > >=20
> > > > > > > I think it is safe to add printk as the current machine check
> > > > > > > handlers are also
> > > > > >=20
> > > > > > using printk.
> > > > > >=20
> > > > > > I hope so, but if the fixup fires there is no printk at all so =
I was a bit unsure.
> > > > > > Don't like this fixup though, is there not a better way than
> > > > > > faking a read to user space(or kernel for that matter) ?
> > > > >=20
> > > > > I don't have a better idea.  Without the fixup, the offending loa=
d instruction
> > >=20
> > > will never finish if there is anything wrong with the backing device =
and freeze the
> > > whole system.  Do you have any suggestion in mind?
> > > > >=20
> > > >=20
> > > > But it never finishes the load, it just fakes a load of 0xfffffffff=
,
> > > > for user space I rather have it signal a SIGBUS but that does not s=
eem
> > > > to work either, at least not for us but that could be a bug in gene=
ral MC code
> > >=20
> > > maybe.
> > > > This fixup might be valid for kernel only as it has never worked fo=
r user space
> > >=20
> > > due to the bug I found.
> > > >=20
> > > > Where can I read about this errata ?
> > >=20
> > > I have look high and low an cannot find an errata which maps to this =
fixup.
> > > The closest I get is A-005125 which seems to have another workaround,=
 I cannot
> > > find any evidence that this workaround has been applied in Linux, can=
 you?
> >=20
> > This is not A-005125.  There was an erratum for this issue with older s=
ilicons (e.g. erratum PCI-ex 3 for MPC8572). =20
> > " When its link goes down, the PCI Express controller clears all outsta=
nding transactions with an
> > error indicator and sends a link down exception to the interrupt contro=
ller if
> > PEX_PME_MES_DISR[LDDD] =3D 0. If, however, any transactions are sent to=
 the controller after
> > the link down event, they are accepted by the controller and wait for t=
he link to come back up
> > before starting any timeout counters (for example, completion timeout).=
 There is no mechanism to
> > cancel the new transactions short of a device HRESET. "
> >=20
> > But it was removed in newer silicon like P2020/P2010 probably because a=
 Machine Check will be triggered in this situation to deal with the stalled=
 instruction and no longer considered it as a hardware issue.
> >=20
>=20
> Maybe this fixup should be configurable then?
>=20
> > The A-005125 is dealt with in u-boot.   https://lists.denx.de/pipermail=
/u-boot/2013-August/161185.html
>=20
> Yes, I found it eventually :)
>=20
> However, I cannot return to normal execution. I can follow the code to re=
turning from
> machine_check_exception() and moving into ASM handler for returning from =
a ME but then I
> am a bit lost. It does not seem to be any problem executing, it feels mor=
e like a SW bug
> dealing with machine checks. Don't known how to diagnose this further and=
 could use some pointers.
>=20
>  Jocke

I note that MSR_RI is not set in MSR, can that be a clue?

[   28.118737] Machine check in kernel mode.
[   28.122751] Caused by (from MCSR=3D10008): Bus - Read Data Bus Error: DA=
R:b6f02000
[   28.133106] Oops: Machine check, sig: 7 [#1]
[   28.137370] P2010 RDB
[   28.139636] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) lin=
ux_kernel_bde(PO)
[   28.147826] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P           O    =
4.1.38+ #206
[   28.155570] task: db16cd10 ti: df12a000 task.ti: df12a000
[   28.160964] NIP: 10a4e2f4 LR: 10a4e404 CTR: 10046c38
[   28.165925] REGS: df12bf10 TRAP: 0204   Tainted: P           O     (4.1.=
38+)
[   28.172971] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 00000000
[   28.179336] DEAR: b6f02000 ESR: 00000000
GPR00: 10a4e404 bff8cc90 b7a244a0 132f9fa8 07006000 07000000 00000000 132f9=
fd8
GPR08: b6ec4000 b6ed4000 0003e000 bff8cc80 24004424 11d6cf7c 00000000 00000=
000
GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc 00000011 00000=
001
GPR24: 01a5048d 132ffbf0 11d60000 00000000 07006000 00000000 132f9fa8 00000=
000
[   28.211576] NIP [10a4e2f4] 0x10a4e2f4
[   28.215233] LR [10a4e404] 0x10a4e404
[   28.218802] Call Trace:
[   28.221243] ---[ end trace bc4afbb242721e8a ]---

Finally, I am on kernel 4.1.43

 Jocke=

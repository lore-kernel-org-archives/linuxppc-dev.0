Return-Path: <leoyang.li@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0059.outbound.protection.outlook.com [104.47.1.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp8l40ZlSzDrSj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 04:54:38 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, York Sun
 <york.sun@nxp.com>
Subject: RE: Machine Check in P2010(e500v2)
Date: Thu, 7 Sep 2017 18:54:31 +0000
Message-ID: <AM4PR0401MB16993C0235EA67562A8B8D4E8F940@AM4PR0401MB1699.eurprd04.prod.outlook.com>
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
In-Reply-To: <1504773676.31322.2.camel@infinera.com>
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
> Sent: Thursday, September 07, 2017 3:41 AM
> To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>; York Sun
> <york.sun@nxp.com>
> Subject: Re: Machine Check in P2010(e500v2)
>=20
> On Thu, 2017-09-07 at 00:50 +0200, Joakim Tjernlund wrote:
> > On Wed, 2017-09-06 at 21:13 +0000, Leo Li wrote:
> > > > -----Original Message-----
> > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > > Sent: Wednesday, September 06, 2017 3:54 PM
> > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>;
> > > > York Sun <york.sun@nxp.com>
> > > > Subject: Re: Machine Check in P2010(e500v2)
> > > >
> > > > On Wed, 2017-09-06 at 20:28 +0000, Leo Li wrote:
> > > > > > -----Original Message-----
> > > > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > > > > > Sent: Wednesday, September 06, 2017 3:17 PM
> > > > > > To: linuxppc-dev@lists.ozlabs.org; Leo Li
> > > > > > <leoyang.li@nxp.com>; York Sun <york.sun@nxp.com>
> > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > >
> > > > > > On Wed, 2017-09-06 at 19:31 +0000, Leo Li wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: York Sun
> > > > > > > > Sent: Wednesday, September 06, 2017 10:38 AM
> > > > > > > > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>;
> > > > > > > > linuxppc- dev@lists.ozlabs.org; Leo Li
> > > > > > > > <leoyang.li@nxp.com>
> > > > > > > > Subject: Re: Machine Check in P2010(e500v2)
> > > > > > > >
> > > > > > > > Scott is no longer with Freescale/NXP. Adding Leo.
> > > > > > > >
> > > > > > > > On 09/05/2017 01:40 AM, Joakim Tjernlund wrote:
> > > > > > > > > So after some debugging I found this bug:
> > > > > > > > > @@ -996,7 +998,7 @@ int fsl_pci_mcheck_exception(struct
> > > > > > > > > pt_regs
> > > >
> > > > *regs)
> > > > > > > > >          if (is_in_pci_mem_space(addr)) {
> > > > > > > > >                  if (user_mode(regs)) {
> > > > > > > > >                          pagefault_disable();
> > > > > > > > > -                       ret =3D get_user(regs->nip, &inst=
);
> > > > > > > > > +                       ret =3D get_user(inst, (__u32
> > > > > > > > > + __user *)regs->nip);
> > > > > > > > >                          pagefault_enable();
> > > > > > > > >                  } else {
> > > > > > > > >                          ret =3D
> > > > > > > > > probe_kernel_address(regs->nip, inst);
> > > > > > > > >
> > > > > > > > > However, the kernel still locked up after fixing that.
> > > > > > > > > Now I wonder why this fixup is there in the first place?
> > > > > > > > > The routine will not really fixup the insn, just return
> > > > > > > > > 0xffffffff for the failing read and then advance the proc=
ess NIP.
> > > > > > >
> > > > > > > You are right.  The code here only gives 0xffffffff to the
> > > > > > > load instructions and
> > > > > >
> > > > > > continue with the next instruction when the load instruction
> > > > > > is causing the machine check.  This will prevent a system
> > > > > > lockup when reading from PCI/RapidIO device which is link down.
> > > > > > >
> > > > > > > I don't know what is actual problem in your case.  Maybe it
> > > > > > > is a write
> > > > > >
> > > > > > instruction instead of read?   Or the code is in a infinite loo=
p waiting for
> a
> > > >
> > > > valid
> > > > > > read result?  Are you able to do some further debugging with
> > > > > > the NIP correctly printed?
> > > > > > >
> > > > > >
> > > > > > According to the MC it is a Read and the NIP also leads to a
> > > > > > read in the
> > > >
> > > > program.
> > > > > > ATM, I have disabled the fixup but I will enable that again.
> > > > > > Question, is it safe add a small printk when this MC
> > > > > > happens(after fixing up)? I need to see that it has happened
> > > > > > as the error is somewhat
> > > >
> > > > random.
> > > > >
> > > > > I think it is safe to add printk as the current machine check
> > > > > handlers are also
> > > >
> > > > using printk.
> > > >
> > > > I hope so, but if the fixup fires there is no printk at all so I wa=
s a bit unsure.
> > > > Don't like this fixup though, is there not a better way than
> > > > faking a read to user space(or kernel for that matter) ?
> > >
> > > I don't have a better idea.  Without the fixup, the offending load in=
struction
> will never finish if there is anything wrong with the backing device and =
freeze the
> whole system.  Do you have any suggestion in mind?
> > >
> >
> > But it never finishes the load, it just fakes a load of 0xfffffffff,
> > for user space I rather have it signal a SIGBUS but that does not seem
> > to work either, at least not for us but that could be a bug in general =
MC code
> maybe.
> > This fixup might be valid for kernel only as it has never worked for us=
er space
> due to the bug I found.
> >
> > Where can I read about this errata ?
>=20
> I have look high and low an cannot find an errata which maps to this fixu=
p.
> The closest I get is A-005125 which seems to have another workaround, I c=
annot
> find any evidence that this workaround has been applied in Linux, can you=
?

This is not A-005125.  There was an erratum for this issue with older silic=
ons (e.g. erratum PCI-ex 3 for MPC8572). =20
" When its link goes down, the PCI Express controller clears all outstandin=
g transactions with an
error indicator and sends a link down exception to the interrupt controller=
 if
PEX_PME_MES_DISR[LDDD] =3D 0. If, however, any transactions are sent to the=
 controller after
the link down event, they are accepted by the controller and wait for the l=
ink to come back up
before starting any timeout counters (for example, completion timeout). The=
re is no mechanism to
cancel the new transactions short of a device HRESET. "

But it was removed in newer silicon like P2020/P2010 probably because a Mac=
hine Check will be triggered in this situation to deal with the stalled ins=
truction and no longer considered it as a hardware issue.

The A-005125 is dealt with in u-boot.   https://lists.denx.de/pipermail/u-b=
oot/2013-August/161185.html

Regards,
Leo

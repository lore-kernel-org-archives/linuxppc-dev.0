Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0086.outbound.protection.outlook.com [104.47.32.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnbR60j5czDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 06:53:52 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: Re: Machine Check in P2010(e500v2)
Date: Wed, 6 Sep 2017 20:53:43 +0000
Message-ID: <1504731221.27247.126.camel@infinera.com>
References: <1504265576.20777.61.camel@infinera.com>
 <1504600831.27247.20.camel@infinera.com>
 <VI1PR04MB2078E4FFD1B27961F63D88689A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <AM4PR0401MB16992DFADBD59ADEF8E3ACC08F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
 <1504729020.27247.120.camel@infinera.com>
 <AM4PR0401MB16990A5A3D77ED57C9A645D98F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
In-Reply-To: <AM4PR0401MB16990A5A3D77ED57C9A645D98F970@AM4PR0401MB1699.eurprd04.prod.outlook.com>
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

On Wed, 2017-09-06 at 20:28 +0000, Leo Li wrote:
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> > Sent: Wednesday, September 06, 2017 3:17 PM
> > To: linuxppc-dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>; York Su=
n
> > <york.sun@nxp.com>
> > Subject: Re: Machine Check in P2010(e500v2)
> >=20
> > On Wed, 2017-09-06 at 19:31 +0000, Leo Li wrote:
> > > > -----Original Message-----
> > > > From: York Sun
> > > > Sent: Wednesday, September 06, 2017 10:38 AM
> > > > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>; linuxppc-
> > > > dev@lists.ozlabs.org; Leo Li <leoyang.li@nxp.com>
> > > > Subject: Re: Machine Check in P2010(e500v2)
> > > >=20
> > > > Scott is no longer with Freescale/NXP. Adding Leo.
> > > >=20
> > > > On 09/05/2017 01:40 AM, Joakim Tjernlund wrote:
> > > > > So after some debugging I found this bug:
> > > > > @@ -996,7 +998,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *=
regs)
> > > > >          if (is_in_pci_mem_space(addr)) {
> > > > >                  if (user_mode(regs)) {
> > > > >                          pagefault_disable();
> > > > > -                       ret =3D get_user(regs->nip, &inst);
> > > > > +                       ret =3D get_user(inst, (__u32 __user
> > > > > + *)regs->nip);
> > > > >                          pagefault_enable();
> > > > >                  } else {
> > > > >                          ret =3D probe_kernel_address(regs->nip,
> > > > > inst);
> > > > >=20
> > > > > However, the kernel still locked up after fixing that.
> > > > > Now I wonder why this fixup is there in the first place? The
> > > > > routine will not really fixup the insn, just return 0xffffffff fo=
r
> > > > > the failing read and then advance the process NIP.
> > >=20
> > > You are right.  The code here only gives 0xffffffff to the load instr=
uctions and
> >=20
> > continue with the next instruction when the load instruction is causing=
 the
> > machine check.  This will prevent a system lockup when reading from
> > PCI/RapidIO device which is link down.
> > >=20
> > > I don't know what is actual problem in your case.  Maybe it is a writ=
e
> >=20
> > instruction instead of read?   Or the code is in a infinite loop waitin=
g for a valid
> > read result?  Are you able to do some further debugging with the NIP co=
rrectly
> > printed?
> > >=20
> >=20
> > According to the MC it is a Read and the NIP also leads to a read in th=
e program.
> > ATM, I have disabled the fixup but I will enable that again.
> > Question, is it safe add a small printk when this MC happens(after fixi=
ng up)? I
> > need to see that it has happened as the error is somewhat random.
>=20
> I think it is safe to add printk as the current machine check handlers ar=
e also using printk.

I hope so, but if the fixup fires there is no printk at all so I was a bit =
unsure.
Don't like this fixup though, is there not a better way than faking a read
to user space(or kernel for that matter) ?

 Jocke=

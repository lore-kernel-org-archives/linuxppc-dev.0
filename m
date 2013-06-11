Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B18732C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 03:29:15 +1000 (EST)
Date: Tue, 11 Jun 2013 12:28:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
To: Michael Guntsche <michael.guntsche@it-loops.com>
In-Reply-To: <CALG0vJumuRobQtHdWAuWtbC3oS3_CMpDim=dtSNECCO25SgJUA@mail.gmail.com> (from
 michael.guntsche@it-loops.com on Tue Jun 11 12:09:42 2013)
Message-ID: <1370971739.18413.27@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Rojhalat Ibrahim <imr@rtschenk.de>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2013 12:09:42 PM, Michael Guntsche wrote:
> On Tue, Jun 11, 2013 at 7:00 PM, Scott Wood <scottwood@freescale.com> =20
> wrote:
> > On 06/11/2013 02:24:28 AM, Rojhalat Ibrahim wrote:
> >>
> >> On Monday 10 June 2013 17:52:33 Scott Wood wrote:
> >> > On 06/10/2013 12:07:43 PM, Michael Guntsche wrote:
> >> > > Good evening,
> >> > >
> >> > > This patch does not fix the problem, during boot the kernel =20
> still
> >> > > panics. I had a closer look at the commit and the following =20
> patch
> >> > > fixes it for me....
> >> > >
> >> > > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> >> > > b/arch/powerpc/sysdev/fsl_pci.c
> >> > > index 028ac1f..21b687f 100644
> >> > > --- a/arch/powerpc/sysdev/fsl_pci.c
> >> > > +++ b/arch/powerpc/sysdev/fsl_pci.c
> >> > > @@ -814,7 +814,7 @@ int __init mpc83xx_add_bridge(struct =20
> device_node
> >> > > *dev)
> >> > >
> >> > >                 if (ret)
> >> > >
> >> > >                         goto err0;
> >> > >
> >> > >         } else {
> >> > >
> >> > > -               fsl_setup_indirect_pci(hose, rsrc_cfg.start,
> >> > > +               setup_indirect_pci(hose, rsrc_cfg.start,
> >> > >
> >> > >                                        rsrc_cfg.start + 4, 0);
> >> > >
> >> > >         }
> >> >
> >> > The only difference here is that you're not setting hose->ops to
> >> > fsl_indirect_pci_ops.  Do you know why that is helping, and what
> >> > hose->ops is set to instead?
> >> >
> >> > -Scott
> >>
> >> The difference is only the read function in hose->ops, which is =20
> set to
> >> indirect_read_config instead of fsl_indirect_read_config.
> >>
> >> fsl_indirect_read_config calls fsl_pcie_check_link, which is where =20
> the
> >> Oops
> >> occurs.
> >
> >
> > Why is fsl_pcie_check_link being called for non-PCIe buses?
> >
> >
> >> Mike, can you find out where exactly in fsl_pcie_check_link the =20
> bad access
> >> happens? Enabling CONFIG_DEBUG_BUGVERBOSE might help.
> >
> >
> > Why does it matter?  You shouldn't be calling that function at all.
> >
> > -Scott
>=20
> For the record BUGVERBOSE is already set with this build so this is
> the most detailed trace I get. And regarding Scott's remark, maybe I
> was not clear enough in my first report. This is a PCI only board so I
> also wondered about the call to fsl_pcie_check_link in the first
> place.

Yes, I figured it was non-PCIe because the code change that you said =20
helped was on the non-PCIe branch of the if/else.  Generally it's good =20
to explicitly mention the chip you're using, though.

fsl_setup_indirect_pci should be renamed to fsl_setup_indirect_pcie.  =20
Your patch above should be applied, and fsl_setup_indirect_pcie should =20
be moved into the booke/86xx ifdef to avoid an unused function warning.

-Scott=

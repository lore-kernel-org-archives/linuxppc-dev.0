Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E6562C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 03:01:02 +1000 (EST)
Date: Tue, 11 Jun 2013 12:00:51 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
To: Rojhalat Ibrahim <imr@rtschenk.de>
In-Reply-To: <10631172.HfDeIDHqX3@pcimr> (from imr@rtschenk.de on Tue Jun 11
 02:24:28 2013)
Message-ID: <1370970051.18413.24@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Guntsche <michael.guntsche@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2013 02:24:28 AM, Rojhalat Ibrahim wrote:
> On Monday 10 June 2013 17:52:33 Scott Wood wrote:
> > On 06/10/2013 12:07:43 PM, Michael Guntsche wrote:
> > > Good evening,
> > >
> > > This patch does not fix the problem, during boot the kernel still
> > > panics. I had a closer look at the commit and the following patch
> > > fixes it for me....
> > >
> > > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > > b/arch/powerpc/sysdev/fsl_pci.c
> > > index 028ac1f..21b687f 100644
> > > --- a/arch/powerpc/sysdev/fsl_pci.c
> > > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > > @@ -814,7 +814,7 @@ int __init mpc83xx_add_bridge(struct =20
> device_node
> > > *dev)
> > >
> > >                 if (ret)
> > >
> > >                         goto err0;
> > >
> > >         } else {
> > >
> > > -               fsl_setup_indirect_pci(hose, rsrc_cfg.start,
> > > +               setup_indirect_pci(hose, rsrc_cfg.start,
> > >
> > >                                        rsrc_cfg.start + 4, 0);
> > >
> > >         }
> >
> > The only difference here is that you're not setting hose->ops to
> > fsl_indirect_pci_ops.  Do you know why that is helping, and what
> > hose->ops is set to instead?
> >
> > -Scott
>=20
> The difference is only the read function in hose->ops, which is set to
> indirect_read_config instead of fsl_indirect_read_config.
>=20
> fsl_indirect_read_config calls fsl_pcie_check_link, which is where =20
> the Oops
> occurs.

Why is fsl_pcie_check_link being called for non-PCIe buses?

> Mike, can you find out where exactly in fsl_pcie_check_link the bad =20
> access
> happens? Enabling CONFIG_DEBUG_BUGVERBOSE might help.

Why does it matter?  You shouldn't be calling that function at all.

-Scott=

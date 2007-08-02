Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id AFE2ADDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 16:23:32 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so325401rvf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 01 Aug 2007 23:23:31 -0700 (PDT)
Message-ID: <fa686aa40708012323p2eca4b05pd47acac635cf6370@mail.gmail.com>
Date: Thu, 2 Aug 2007 00:23:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] lite5200b: flash definition in dts
In-Reply-To: <20070802055830.GM4529@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070619095408.GK23294@moe.telargo.com>
	<20070801065203.GK4529@moe.telargo.com>
	<fa686aa40708010541n4d4900cfv7042d6ca685416d1@mail.gmail.com>
	<20070802055830.GM4529@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/1/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> On 01/08/07 06:41 -0600, Grant Likely wrote:
> > On 8/1/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > > Add flash definition for to lite5200b dts, and while at it
> > > fix "ranges" for soc node.
> > >
> ...
> > > +++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
> > > @@ -52,7 +52,8 @@
> > >                 revision = "";                  // from bootloader
> > >                 #interrupt-cells = <3>;
> > >                 device_type = "soc";
> > > -               ranges = <0 f0000000 f0010000>;
> > > +               ranges = <00000000 f0000000 00010000
> > > +                         fe000000 fe000000 02000000>;
> >
> > I don't think this is the right approach.  I think the SoC node is
> > intended for describing the on-chip devices, and the ranges property
> > reflects that.  Shouldn't flash nodes be up 1 level?
> >
>
> That would make sense, however, it does not work, probably because:
> arch/powerpc/kernel/of_platform.c:
> <snip>
>
> Suggestions?

This is fixable in many ways.  I don't know if there is an established
convention yet, but it's just a matter of making sure the platform
setup code adds the devices to the of_platform_bus.  Freescale folks,
what say you?

> BTW. phy's are also not on chip, but are usualy listed under "soc"
> (ie. mpc885ads.dts). Or rtc chip connected to i2c in kuroboxHD.dts.

Phy's are also directly connected to MDIO busses and rtc chips
directly connected to i2c busses.  Both the MDIO and i2c controllers
are mapped entirely within the MBAR region which matches the soc node
range.  Flash seems different to me because it is mapped outside the
shared region...

On the other hand there is PCI whose control registers fall within the
SoC range; but the memory windows absolutely do not.  If my flash
argument holds water, then where does that leave PCI which kind of
straddles the fence.  Gah.  Perhaps I'm getting too wrapped up in
nothing.  Having the flash node as a child of "soc" still describes
the platform in an unambiguous way.

Cheers,
g.

>
>
>         Domen
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

Return-Path: <holt@sgi.com>
Date: Fri, 12 Aug 2011 03:28:24 -0500
From: Robin Holt <holt@sgi.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v11 3/6] flexcan: Fix up fsl-flexcan device tree binding.
Message-ID: <20110812082824.GH4926@sgi.com>
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
	<1313078831-2511-4-git-send-email-holt@sgi.com>
	<CACxGe6vA8K7fhrSvBpKC+9aKftUc2+1EAUQ=A0SmmwzJ2Le=9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACxGe6vA8K7fhrSvBpKC+9aKftUc2+1EAUQ=A0SmmwzJ2Le=9A@mail.gmail.com>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2011 at 10:53:43AM -0600, Grant Likely wrote:
> On Thu, Aug 11, 2011 at 10:07 AM, Robin Holt <holt@sgi.com> wrote:
> > +- compatible : Should be "fsl,<processor>-flexcan" and "fsl,flexcan"
> 
> Don't do this.  "fsl,flexcan" is far too generic.  Be specific to the
> soc part number or the ip core implementation version.

I don't have any crumbs to go with here.  There is nothing in the
documentation I have found to indicate what this is or should be.
I looked at the documentation for the P1010 processor and there is nothing
in there which I noticed that indicates what I could possibly use other
than flexcan.  They don't even indicate the registers are equivalent or
identical to their i.MX implementations for i.MX25 and i.MX35.  The only
thing they call it is flexcan.  I have asked our local freescale rep and
he said "There is no 'chip', it is just flexcan.  flexcan is flexcan."
His tone was such that I got the feeling he thought the question was
crazy as flexcan is flexcan.

> > -Can Engine Clock Source
> > -       There are two sources for CAN clock
> > -       - Platform Clock  It represents the bus clock
> > -       - Oscillator Clock
> > +  An implementation should also claim any of the following compatibles
> > +  that it is fully backwards compatible with:
> >
> > -       Peripheral Clock (PLL)
> > -       --------------
> > -                    |
> > -                   ---------                 -------------
> > -                   |       |CPI Clock        | Prescaler |       Sclock
> > -                   |       |---------------->| (1.. 256) |------------>
> > -                   ---------                 -------------
> > -                     |  |
> > -       --------------  ---------------------CLK_SRC
> > -       Oscillator Clock
> > +  - fsl,p1010-flexcan
> >
> > -- fsl,flexcan-clock-source : CAN Engine Clock Source.This property selects
> > -                            the peripheral clock. PLL clock is fed to the
> > -                            prescaler to generate the Serial Clock (Sclock).
> > -                            Valid values are "oscillator" and "platform"
> > -                            "oscillator": CAN engine clock source is oscillator clock.
> > -                            "platform" The CAN engine clock source is the bus clock
> > -                            (platform clock).
> > +- reg : Offset and length of the register set for this device
> > +- interrupts : Interrupt tuple for this device
> >
> > -- fsl,flexcan-clock-divider : for the reference and system clock, an additional
> > -                             clock divider can be specified.
> > -- clock-frequency: frequency required to calculate the bitrate for FlexCAN.
> > +Example:
> >
> > -Note:
> > -       - v1.0 of flexcan-v1.0 represent the IP block version for P1010 SOC.
> > -       - P1010 does not have oscillator as the Clock Source.So the default
> > -         Clock Source is platform clock.
> > -Examples:
> > -
> > -       can0@1c000 {
> > -               compatible = "fsl,flexcan-v1.0";
> > -               reg = <0x1c000 0x1000>;
> > -               interrupts = <48 0x2>;
> > -               interrupt-parent = <&mpic>;
> > -               fsl,flexcan-clock-source = "platform";
> > -               fsl,flexcan-clock-divider = <2>;
> > -               clock-frequency = <fixed by u-boot>;
> > -       };
> > +  can@1c000 {
> > +          compatible = "fsl,p1010-flexcan", "fsl,flexcan";
> > +          reg = <0x1c000 0x1000>;
> > +          interrupts = <48 0x2>;
> > +          interrupt-parent = <&mpic>;
> > +  };
> 
> The diffstat for this patch looks too big because the whitespace has
> changed.  Try to restrict whitespace changes so that the patch is
> friendly to reviewers.

Reworked the best I can.  That reduced the diffstat by 3 lines.

Robin

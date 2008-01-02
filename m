Return-Path: <dgibson@ozlabs.org>
Date: Wed, 2 Jan 2008 11:26:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080102002652.GA4655@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 01, 2008 at 12:25:32PM -0500, Jon Smirl wrote:
> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
> > +               ssi@16000 {
> > +                       compatible = "fsl,ssi";
> > +                       cell-index = <0>;
> > +                       reg = <16000 100>;
> > +                       interrupt-parent = <&mpic>;
> > +                       interrupts = <3e 2>;
> > +                       fsl,mode = "i2s-slave";
> > +                       codec {
> > +                               compatible = "cirrus,cs4270";
> > +                               /* MCLK source is a stand-alone oscillator */
> > +                               bus-frequency = <bb8000>;
> > +                       };
> > +               };
> 
> Does this need to be bus-frequency? It's always called MCLK in all of
> the literature.
> 
> In my case the MCLK comes from a chip on the i2c bus that is
> programmable How would that be encoded?.

Grah!  If there's one obvious frequency for a node, it should always
be "clock-frequency".  This bus-frequency nonsense seems to be a
disease that started as a secondary frequency in Freescale CPU nodes,
and has escaped to all sorts of other places.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

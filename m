Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 5E1262BF18
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 08:15:07 +1100 (EST)
Date: Wed, 12 Jan 2005 14:14:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <galak@somerset.sps.mot.com>,
	trini@kernel.crashing.org, linuxppc-embedded@ozlabs.org,
	mporter@kernel.crashing.org, jason.mcmullan@timesys.com
Message-ID: <20050112141449.B22626@home.com>
References: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
	<20050112083637.GA13794@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050112083637.GA13794@gate.ebshome.net>;
	from ebs@ebshome.net on Wed, Jan 12, 2005 at 12:36:37AM -0800
Subject: Re: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 12, 2005 at 12:36:37AM -0800, Eugene Surovegin wrote:
> On Wed, Jan 12, 2005 at 01:43:09AM -0600, Kumar Gala wrote:
> > 
> > Please take a look at the following patch.  It adds driver model support 
> > via platform devices to 85xx.  This is originally based on patches from 
> > Jason M. 
> > 
> > The idea behind the code is that for a give family: 4xx, 8xx, 82xx, 83xx, 
> > 85xx, 86xx we will have structure defns for the following:
> > 
> > enum ppc_soc_devices 
> > in asm-ppc/<family.h>:
> >   list of all unique devices in the family
> > 
> > struct platform_device soc_platform_devices[]
> > in arch/ppc/platforms/<family>/<family>_devices.c:
> >   describes all platform devices that exist in the family
> > 
> > struct soc_spec soc_specs[]
> > in arch/ppc/platforms/<family>/<family>_soc.c:
> >   describes each unique chip in the family and what devices it has
> 
> Well, there is a problem right here at least for 4xx. 
> Current OCP implementation is much more flexible IMHO.
> 
> For 4xx is not uncommon when you have the same "logical" device at the 
> different places with different "properties" (e.h. different channel, 
> etc).
> 
> Your case (85xx) looks simpler - all you need is a list of devices 
> which particular SoC supports, without significant differences in 
> "properties". This will not work that easy for 4xx.
> 
> In fact, I don't see any gain (at least for 4xx) in all these changes. 
> It makes 4xx much more tangled IMHO, because we'll still need all 
> those ibm405gp.c, ibm405ep.c, ibm440gp.c etc.

Summarizing some stuff from IRC (now that I'm caught up after time
off :P), I think we can live with this on 4xx. What seems to be
acceptable is that we can have an soc_specs[] and soc_platform_devices[]
in each 4xx SoC platform file. So, core_ocp[] can be merged and split
into soc_specs[]/soc_platform_devices[]. The active one will be selected
at build time just like we do now. This is due to the static nature
of the 4xx memory map (per SoC) and well as the variation in location
of iomem and irq resources as well as platform_data. Our soc_specs[]
will only have one SoC in it, since there is one per file. Doing
something like 85xx will scatter info about as you point out
above...and that doesn't make sense for 4xx.

> Please note, using platform_device is orthogonal to the way we 
> describe each SoC (this is what I don't quite like in your patch), and 
> I don't have any strong objections to using platform_device instead of 
> OCP or feature_call or whatever for communication with device drivers.

Hurray. ;)
 
> > Plus the following functions:
> > 
> > identify_soc_by_id() -- determine soc by an int id
> > identify_soc_by_name() -- determin soc by name (useful in some 82xx cases)
> > ppc_soc_get_pdata() -- get platform_data pointer so board code can modify
> > ppc_soc_update_paddr() -- update iomem resources with a given paddr
> 
> IMHO, ppc_soc_update_paddr - is a very confusing name, in fact, from 
> first read I though it _changes_ paddr to the new value, not _adds_ it 
> :)

I think it should be ppc_soc_update_mem_resource() or some such.
You are updating the IOMEM resource.
 
> Probably this function should be made 85xx specific as I cannot come 
> up with any use for it in 4xx (we don't have anything similar to 
> CCSRBAR ;).

Can't be, it can be used on Marvell and others.

> [snip]
> 
> > +
> > +struct platform_device soc_platform_devices[] = {
> > +	[MPC85xx_TSEC1] = {
> > +		.name = "fsl-gianfar",
> > +		.id	= 1,
> > +		.dev.platform_data = &mpc85xx_tsec1_pdata,
> > +		.num_resources	 = 4,
> > +		.resource = (struct resource[]) {
> > +			{
> > +				.start	= MPC85xx_ENET1_OFFSET,
> > +				.end	= MPC85xx_ENET1_OFFSET +
> > +						MPC85xx_ENET1_SIZE - 1,
> > +				.flags	= IORESOURCE_MEM,
> > +			},
> > +			{
> > +				.name	= "tx",
> > +				.start	= MPC85xx_IRQ_TSEC1_TX,
> > +				.end	= MPC85xx_IRQ_TSEC1_TX,
> > +				.flags	= IORESOURCE_IRQ,
> > +			},
> > +			{
> > +				.name	= "rx",
> > +				.start	= MPC85xx_IRQ_TSEC1_RX,
> > +				.end	= MPC85xx_IRQ_TSEC1_RX,
> > +				.flags	= IORESOURCE_IRQ,
> > +			},
> > +			{
> > +				.name	= "error",
> > +				.start	= MPC85xx_IRQ_TSEC1_ERROR,
> > +				.end	= MPC85xx_IRQ_TSEC1_ERROR,
> > +				.flags	= IORESOURCE_IRQ,
> > +			},
> [snip]
> 
> 
> I already wrote about this but repeat again :(. 
> 
> Why put all these defines (e.g. for memory regions) into header when 
> the only user is this particular file. It doesn't help readability and 
> only obfuscates sources (and 4xx is a very good example of such mess 
> :)

Having been previously convinced of this style, I'd say it's the The
Right Thing To Do(tm).

-Matt

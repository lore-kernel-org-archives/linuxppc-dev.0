Return-Path: <acmay@acmay.homeip.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 549532BF13
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 06:26:32 +1100 (EST)
From: Andrew May <acmay@acmay.homeip.net>
To: Kumar Gala <galak@somerset.sps.mot.com>,
	Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050112141449.B22626@home.com>
References: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
	<20050112083637.GA13794@gate.ebshome.net>
	<20050112141449.B22626@home.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 11:13:43 -0800
Message-Id: <1105730023.5420.58.camel@mud>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
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

On Wed, 2005-01-12 at 14:14 -0700, Matt Porter wrote:
> On Wed, Jan 12, 2005 at 12:36:37AM -0800, Eugene Surovegin wrote:
> > On Wed, Jan 12, 2005 at 01:43:09AM -0600, Kumar Gala wrote:
> > 
> > In fact, I don't see any gain (at least for 4xx) in all these changes. 
> > It makes 4xx much more tangled IMHO, because we'll still need all 
> > those ibm405gp.c, ibm405ep.c, ibm440gp.c etc.
> 
> Summarizing some stuff from IRC (now that I'm caught up after time
> off :P), I think we can live with this on 4xx. What seems to be
> acceptable is that we can have an soc_specs[] and soc_platform_devices[]
> in each 4xx SoC platform file. So, core_ocp[] can be merged and split
> into soc_specs[]/soc_platform_devices[]. The active one will be selected
> at build time just like we do now. This is due to the static nature
> of the 4xx memory map (per SoC) and well as the variation in location
> of iomem and irq resources as well as platform_data. Our soc_specs[]
> will only have one SoC in it, since there is one per file. Doing
> something like 85xx will scatter info about as you point out
> above...and that doesn't make sense for 4xx.

I would like to bring the Virtex-II Pro, into the thinking as well. It
is an FPGA around the 405 so it can be much more flexible on what makes
up the SoC.

I am stuck working on 2.4 for a non-released product (so no code to
submit) and we have 2 of these chips on 1 board.

One has only 1 UART and the other has 2. The rest of the standard
devices are the same, but they all have different IRQ mappings.

I really don't want to build 2 different kernels just to handle this. So
far I have just overwritten the OCP struct at boot time to deal with it,
based on a HW reg that tells me which chip I am running on. I also did
a kernel cmd line option saved in u-boot before I got the HW reg.

If FPGAs start to make up more of the SoC market it don't think a simple
array of the devices is a good model to have. The FPGA could be loaded
differently for special modes with a very different setup.

I am not sure what the trade off should be for the simple build time
array compared to the run time list that is built up.

Would something like this be OK?

struct chip_basic_features[] = { {}, {},....... };

struct chip_ext1_features[] = { {}, {},....... };
struct chip_ext2_features[] = { {}, {},....... };

LIST_HEAD(system_features);


board_init()
{
	list_add_tail( &system_features, &chip_basic_features );

	if( board1 ){
		list_add_tail( &system_features, &chip_ext1_features );
	}else{
		list_add_tail( &system_features, &chip_ext2_features );
	}
}

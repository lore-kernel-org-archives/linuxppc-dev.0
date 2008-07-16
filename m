Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 16 Jul 2008 10:37:52 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Message-ID: <20080716103752.463e00cb@zod.rchland.ibm.com>
In-Reply-To: <20080716141539.GC24045@secretlab.ca>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
	<20080716141539.GC24045@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Jul 2008 08:15:39 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Wed, Jul 16, 2008 at 07:50:25AM -0400, Josh Boyer wrote:
> > On Tue, 15 Jul 2008 22:33:26 -0700
> > fkan@amcc.com wrote:
> > 
> > > From: Victor Gallardo <vgallard@amcc.com>
> > > 
> > > ppc4xx: Add AMCC Arches 460GT eval board support 
> > > 
> > > Signed-off-by: Victor Gallardo <vgallard@amcc.com>
> > 
> > From what I can tell, you don't even need this patch or the defconfig.
> > Nothing differs at this point from Glacier other than the DTS.  Since
> > U-Boot is your loader, it should be able to pass the different DTS to a
> > kernel that supports Cayonlands and have no issues.
> > 
> > > ---
> > >  arch/powerpc/platforms/44x/Kconfig  |   18 ++++++++
> > >  arch/powerpc/platforms/44x/Makefile |    1 +
> > >  arch/powerpc/platforms/44x/arches.c |   76 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 95 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/powerpc/platforms/44x/arches.c
> > > 
> > > diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> > > index 6abe913..95d1217 100644
> > > --- a/arch/powerpc/platforms/44x/Kconfig
> > > +++ b/arch/powerpc/platforms/44x/Kconfig
> > > @@ -77,6 +77,16 @@ config CANYONLANDS
> > >  	help
> > >  	  This option enables support for the AMCC PPC460EX evaluation board.
> > > 
> > > +config ARCHES
> > > +	bool "Arches"
> > > +	depends on 44x
> > > +	default n
> > > +	select 460GT
> > > +	select PCI
> > > +	select PPC4xx_PCI_EXPRESS
> > > +	help
> > > +	  This option enables support for the AMCC PPC460GT Arches board.
> > 
> > If you do want to have explicit support for Arches, that's fine.  Look
> > at how Yosemite is supported.  It just reuses Bamboo.  You could do the
> > same.
> > 
> > >  config YOSEMITE
> > >  	bool "Yosemite"
> > >  	depends on 44x
> > > @@ -149,6 +159,14 @@ config 460EX
> > >  	select IBM_NEW_EMAC_ZMII
> > >  	select IBM_NEW_EMAC_TAH
> > > 
> > > +config 460GT
> > > +	bool
> > > +	select PPC_FPU
> > > +	select IBM_NEW_EMAC_EMAC4
> > > +	select IBM_NEW_EMAC_RGMII
> > > +	select IBM_NEW_EMAC_ZMII
> > > +	select IBM_NEW_EMAC_TAH
> > 
> > I don't see a reason to add this at all.  460EX and 460GT select the
> > same set of options.
> > 
> > >  # 44x errata/workaround config symbols, selected by the CPU models above
> > >  config IBM440EP_ERR42
> > >  	bool
> > > diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
> > > index 774165f..86a4823 100644
> > > --- a/arch/powerpc/platforms/44x/Makefile
> > > +++ b/arch/powerpc/platforms/44x/Makefile
> > > @@ -9,3 +9,4 @@ obj-$(CONFIG_RAINIER)	+= rainier.o
> > >  obj-$(CONFIG_WARP)	+= warp.o
> > >  obj-$(CONFIG_WARP)	+= warp-nand.o
> > >  obj-$(CONFIG_CANYONLANDS) += canyonlands.o
> > > +obj-$(CONFIG_ARCHES)	+= arches.o
> > 
> > Here you would just have:
> > 
> > obj-$(CONFIG_ARCHES) += cayonlands.o
> > 
> > > diff --git a/arch/powerpc/platforms/44x/arches.c b/arch/powerpc/platforms/44x/arches.c
> > > new file mode 100644
> > > index 0000000..6d6aa66
> > > --- /dev/null
> > > +++ b/arch/powerpc/platforms/44x/arches.c
> > 
> > And then you don't need this file at all.  Just add a
> > "amcc,canyonlands" string to your root node compatible property.
> 
> No!  Don't do this because it is not true!

Meh. You're splitting hairs.  It _is_ true from a kernel perspective.

> Instead, add your board name to canyonlands.c in canyonlands_probe().
> It's not the most scalable solution, but it keeps you from lying about
> your hardware in the .dts file.

That could also be done.  Frankly though, if you look at the existing
board.c files in there now, none of them are special.  The device tree
really provides the differences these days, not the C code.  I'm this
|| close to just killing them all and doing a 4xx_board.c file that
does the right thing based on the few boards that have differences.

> I'm working on a more scalable solution for this, but for now just add
> your specific board to canyonlands_probe().

Glad to hear it.  Care to share your thoughts?  It seems to me that
adding board.c files that differ only in board name is pretty silly, so
if your solution avoids that I'll be happy.

josh

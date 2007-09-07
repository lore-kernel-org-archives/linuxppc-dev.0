Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 11:15:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Message-ID: <20070907011553.GO26079@localhost.localdomain>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
	<20070904182028.GC18280@ld0162-tx32.am.freescale.net>
	<20070905114023.GA4072@localhost.localdomain>
	<20070905132106.GB24637@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905132106.GB24637@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 08:21:06AM -0500, Scott Wood wrote:
> On Wed, Sep 05, 2007 at 03:40:23PM +0400, Anton Vorontsov wrote:
> > On Tue, Sep 04, 2007 at 01:20:28PM -0500, Scott Wood wrote:
> > > The kernel is of course welcome to do so -- and this may be a valid
> > > reason to attach pin information to specific device nodes, if it actually
> > > saves a non-negligible amount of power -- but it's not a reason to force
> > > the kernel to have to care by not setting things up in the firmware.
> > 
> > Well, I might agree here. But to me it seems unnatural that I have to
> > upgrade bootloader to use SPI -- I can already boot the kernel.
> 
> Sure -- the firmware should have been done right the first time.
> 
> Unfortunately, it very often doesn't, and thus fixups in the kernel's
> platform code are warranted, but the firmware is still the preferred
> place to do it.

Appealing though it is, I think the whole "firmware is the preferred
place to do it" approach is a lost cause (for nearly every value of
"it").

Firmwares are, more often than not, crap, and that's unlikely to
change.  For a lot of things, having the kernel or bootwrapper cope as
a special case with a handful of crap firmwares which don't set things
up properly isn't actually any easier than having it set them up
itself, always.

Which is why I err strongly in favour of having the kernel set things
up rather than rely on firmware setup, unless there's a very strong
reason why we *have* to respect the firmware's setup.

(Incidentally, this reasoning is why although the approach is very
neat-looking, I'm actually quite uncomfortable with firmwares directly
supplying flattened device trees to the kernel, rather than having the
tree in the bootwrapper.)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

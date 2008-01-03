Return-Path: <dgibson@ozlabs.org>
Date: Thu, 3 Jan 2008 15:46:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080103044620.GC25357@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
	<fa686aa40801020832y373c091dn925bfe64afddcb81@mail.gmail.com>
	<9e4733910801020912k50dceaebm11b59c1cee571e56@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910801020912k50dceaebm11b59c1cee571e56@mail.gmail.com>
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

On Wed, Jan 02, 2008 at 12:12:00PM -0500, Jon Smirl wrote:
> On 1/2/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 1/2/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> > > mpc8610_hpcd is the harder one to load since it doesn't have a device
> > > tree entry. What you want to do it match on the compatible field of
> > > the root node.
> > >
> > > static struct of_device_id fabric_of_match[] = {
> > >         {
> > >                 .compatible     = "fsl,MPC8610HPCD",
> > >         },
> > >         {},
> > > };
> > >
> > > But this doesn't work since the root is the device tree isn't passed
> > > down into the device probe code. (Could this be fixed?)
> >
> > The driver can always get the root node.  But better yet, instantiate
> > the correct fabric device (probably as a platform_device) from the
> > platform code.  Then the correct fabric driver can probe against it.
> 
> The meaning of this has finally sunk into my consciousness. The
> platform code can create a device that isn't bound to a driver. So why
> not make this an of_platform_device?  This is basically a pseudo
> device that isn't in the device tree.
> 
> Alternatively, the best place for this device would be on the ASOC
> bus, but the ASOC bus hasn't been created when the platform code runs.
> Maybe I can figure out a place in the platform code to create this
> device after the ASOC driver has loaded and created the bus. Does the
> platform code get control back after loading all of the device
> drivers?
> 
> In the longer term I'd like to kill platform_bus on powerpc and only
> use of_platform_bus. Platform_bus seems to be functioning like a
> catch-all and collecting junk from lots of different platforms.

Not going to happen.  of_platform_bus is not the right solution, and
in fact we're looking at moving (gradually) away from using
of_platform_bus, and instead using platform devices (along with the
device node being available for *any* struct device via the
arch_sysdata).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

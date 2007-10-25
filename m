Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 10:01:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
Message-ID: <20071025000131.GC23694@localhost.localdomain>
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<fa686aa40710240808r5d634905t6ba81c802e8f123a@mail.gmail.com>
	<9e4733910710240819m3d1cefeand264d2ced243904e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910710240819m3d1cefeand264d2ced243904e@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 11:19:33AM -0400, Jon Smirl wrote:
> On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> > > >       codec0: i2s-codec@0 {
> > > >             compatible = "ti,tas5508";
> > > >             reg = <0>;
> > > >             i2s-handle = <&i2s@2000>;
> > > >       };
> > >
> > > I'd do this the other way around -- that is:
> > >
> > > i2s@2200 {           // PSC2
> > >         compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
> > >         ...
> > >         i2c-handle = <&codec0>;  /* Or something like that */
> >
> > i2c-handle is a poor property name here.  It should be 'codec-handle'.
> >  The codec could theoretically live on just about *any* control bus;
> > not just i2c.
> 
> That's one of the reasons I put the second option in the post.
> 
> In the second option the i2s driver would instantiate first. Next the
> generic code would get loaded. The generic codec will know the control
> but for the device and it can go look in the i2c node for the address.
> i2c node still lists all of the devices on the i2c bus. But the codecs
> are in the i2c-handle property so they don't trigger a second loading
> of the codec.
> 
> A fundamental question is, which bus should trigger the loading of the
> generic codec driver. The answer to this determines how the device
> tree should look.

No!  Device tree layout should not be determined by the instantiation
model used by Linux drivers right now.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

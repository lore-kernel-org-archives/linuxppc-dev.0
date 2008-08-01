Return-Path: <glikely@secretlab.ca>
Date: Thu, 31 Jul 2008 20:03:03 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] powerpc: i2c-mpc: make speed registers
	configurable via FDT
Message-ID: <20080801020303.GA30947@secretlab.ca>
References: <4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 09:19:51PM -0400, Jon Smirl wrote:
> On 7/31/08, Trent Piepho <xyzzy@speakeasy.org> wrote:
> > On Thu, 31 Jul 2008, Jon Smirl wrote:
> >  > As for the source clock, how about creating a new global like
> >  > ppc_proc_freq called ppc_ipb_freq. The platform code can then set the
> >  > right clock value into the variable. For mpc8xxxx get it from uboot.
> >  > mpc5200 can easily compute it from ppc_proc_freq and checking how the
> >  > ipb divider is set. That will move the clock problem out of the i2c
> >  > driver.
> >
> >
> > There is a huge variation in where the I2C source clock comes from.
> >  Sometimes it's the system bus, sometimes ethernet, sometimes SEC, etc.  If
> >  I look at u-boot (which might not be entirely correct or complete), I see:
> >
> >  83xx:  5 different clock sources
> >  85xx:  3 different clock sources
> >  86xx:  2 different clock sources
> >
> >  But there's more.  Sometimes the two I2C controllers don't use the same
> >  clock!  So even if you add 10 globals with different clocks, and then add
> >  code to the mpc i2c driver so if can figure out which one to use given the
> >  platform, it's still not enough because you need to know which controller
> >  the device node is for.
> >
> >  IMHO, what Timur suggested of having u-boot put the source clock into the
> >  i2c node makes the most sense.  U-boot has to figure this out, so why
> >  duplicate the work?
> >
> >  Here's my idea:
> >
> >         i2c@0 {
> >                 compatible = "fsl-i2c";
> >                 bus-frequency = <100000>;
> >
> >                 /* Either */
> >                 source-clock-frequency = <0>;
> >                 /* OR */
> >                 source-clock = <&ccb>;
> >         };
> 
> Can't we hide a lot of this on platforms where the source clock is not
> messed up? For example the mpc5200 doesn't need any of this, the
> needed frequency is already available in mpc52xx_find_ipb_freq().
> mpc5200 doesn't need any uboot change.

Your mixing up device tree layout with implementation details.  Device
tree layout must come first.  mpc52xx_find_ipb_freq() is just a
convenience function that walks up the device tree looking for a
bus-frequency property.

So, instead of making arguments based on available helper functions,
make your arguments based on how data should be laid out in the device
tree.  Currently mpc5200 bindings simply depend on finding a
bus-frequency property in the parent node for determining the input
clock and I don't see any pressing reason to change that (though it
probably needs to be documented better).

However, for the complex cases that Trent and Timur are talking about,
it makes perfect sense to have an optional property in the i2c node
itself that defines a different clock.  Once that decision has been made
and documented, then the driver can be modified and the appropriate
helper functions added to adapt the device tree data into something
useful.

Remember (and chant this to yourself).  The device tree describes
*hardware*.  It does not describe Linux internal implementation details.

g.

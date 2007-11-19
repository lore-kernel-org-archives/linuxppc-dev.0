Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
Date: Mon, 19 Nov 2007 11:00:16 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
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

On 11/19/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> > Jon Smirl wrote:
> >
> > > In the ALSA SOC model the i2s, codec and ac97 drivers are all generic.
> > > A fabric driver tells specifically how a generic codec is wired into
> > > the board. What I haven't been able figure out is how to load the
> > > right fabric driver.
> >
> > Do not use the device tree to load the fabric driver!
>
> Heh, technically you can't use the device tree to load any device
> drivers, it's just a data structure.  :-)
>
> You probably mean "don't use the of_platform bus to load the fabric
> driver".  He still needs to use the data in the device tree to decide
> what fabric drivers to use.  of_platform_bus would be awkward to use
> for this because the node describing the fabric doesn't cleanly sit on
> any particular bus (ie. it describes the board; it does not describe
> the device).
>
> In this case; it probably is appropriate to have the platform code
> instantiate a platform_device for the fabric (instead of an
> of_platform device) which the fabric driver can bind against.

First, I have platform bus turned off in my builds. Platform bus is a
place where cruft accumulates that really belongs somewhere else. For
example when I turned it off I discovered that there was a PC speaker
driver in my kernel and well as several drivers from 82xx chips.

ALSA creates it own bus like i2c. My fabric driver sits on this bus.,
Kconfig attributes control if it is built-in. I've altered the i2c
code to look for child device tree nodes and then load the appropriate
drivers.

static void of_register_i2c_devices(struct i2c_adapter *adap, struct
device_node *adap_node)
{
	struct device_node *node = NULL;

	while ((node = of_get_next_child(adap_node, node))) {
		struct i2c_board_info info;
		const u32 *addr;
		const char *compatible;
		int len;

		addr = of_get_property(node, "reg", &len);
		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
			printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing reg attribute\n");
			continue;
		}

		info.irq = irq_of_parse_and_map(node, 0);
		if (info.irq == NO_IRQ)
			info.irq = -1;

		compatible = of_get_property(node, "compatible", &len);
		if (!compatible) {
			printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing compatible
attribute\n");
			continue;
		}
		strncpy(info.driver_name, compatible, sizeof(info.driver_name));
		info.type[0] = '\0';

		info.platform_data = NULL;
		info.addr = *addr;
		
		i2c_new_device(adap, &info);
	}
}

I have a similar loop in the ac97 driver for loading codecs it controls.

So now I'm at this point:
i2c bus driver loaded, initialized from of
i2s bus driver loaded, initialized from of
tas5504 codec loaded onto i2c, initialized from i2c loop above
multiple fabric drivers loaded onto the alsa bus

Now how do I pick which fabric driver to initialize?

Codec and i2s are also attached to alsa bus.




>
> Another option is to explicitly call of_platform_device_create in the
> platform code on the fabric node (which should be a child of the root
> node) so that you can have an of_platform_bus fabric driver.
>
> Cheers,
> g.
>
> >
> > The layout of the hardware and the relationship between the I2S, I2C, codec,
> > and whatever device is determined by *both* the fabric driver and the device
> > tree.  The information about the devices itself, and *some* information about
> > their relationship is stored in the device tree.  Everything else is in the
> > fabric driver.
> >
> > The design of the device tree is already locked in stone, so to speak.  The DT
> > can only store what it is allowed to store.  If there's something more that
> > you need, you'll have to put it in the fabric driver.
> >
> > If I weren't on vacation this week, I'd email you my code.  It's almost done
> > and it demonstrates what I'm thinking.
> >
> > --
> > Timur Tabi
> > Linux Kernel Developer @ Freescale
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Jon Smirl
jonsmirl@gmail.com

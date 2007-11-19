Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
Date: Mon, 19 Nov 2007 08:33:12 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <4741A56D.9050808@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
> > In the ALSA SOC model the i2s, codec and ac97 drivers are all generic.
> > A fabric driver tells specifically how a generic codec is wired into
> > the board. What I haven't been able figure out is how to load the
> > right fabric driver.
>
> Do not use the device tree to load the fabric driver!

Heh, technically you can't use the device tree to load any device
drivers, it's just a data structure.  :-)

You probably mean "don't use the of_platform bus to load the fabric
driver".  He still needs to use the data in the device tree to decide
what fabric drivers to use.  of_platform_bus would be awkward to use
for this because the node describing the fabric doesn't cleanly sit on
any particular bus (ie. it describes the board; it does not describe
the device).

In this case; it probably is appropriate to have the platform code
instantiate a platform_device for the fabric (instead of an
of_platform device) which the fabric driver can bind against.

Another option is to explicitly call of_platform_device_create in the
platform code on the fabric node (which should be a child of the root
node) so that you can have an of_platform_bus fabric driver.

Cheers,
g.

>
> The layout of the hardware and the relationship between the I2S, I2C, codec,
> and whatever device is determined by *both* the fabric driver and the device
> tree.  The information about the devices itself, and *some* information about
> their relationship is stored in the device tree.  Everything else is in the
> fabric driver.
>
> The design of the device tree is already locked in stone, so to speak.  The DT
> can only store what it is allowed to store.  If there's something more that
> you need, you'll have to put it in the fabric driver.
>
> If I weren't on vacation this week, I'd email you my code.  It's almost done
> and it demonstrates what I'm thinking.
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

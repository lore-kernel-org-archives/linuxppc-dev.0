Return-Path: <benh@kernel.crashing.org>
Subject: Re: Graphic Card on Freescale  MPC837x-rdb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0EE7A51D-FCB1-4A52-B5F6-4F9D7588A361@kernel.crashing.org>
References: <F795765B112E7344AF36AA9112796415069F13E6@xmb-sjc-212.amer.cisco.com>
	<0EE7A51D-FCB1-4A52-B5F6-4F9D7588A361@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 25 Jun 2008 08:32:12 +1000
Message-Id: <1214346732.8011.384.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Bizhan Gholikhamseh <bgholikh@cisco.com>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-24 at 12:32 -0500, Kumar Gala wrote:
> On Jun 24, 2008, at 12:17 PM, Bizhan Gholikhamseh (bgholikh) wrote:
> 
> > HI all,
> > Has anyone tried using a Graphic card on Freescale MPC837x-rdb  
> > board? If so I appreciate any hints and information that I can use.
> 
> Nope, but you'll most likely need some form of x86 emulation for the  
> video bios init.

Yup. There's something in u-boot, though I don't know how well it works
with newer cards. if it's based on x86emu tho, it might be worth looking
at backporting some of the recent fixes/additions (such as bswap and
rtdsc instructions support) to it.

Once you get the card bootstrapped...

I've been working lately with Dave Airlie to get the X radeon driver
work on powerpc (ie endian fixes) on r5xx and r6xx cards. It should
already work with older cards. The new cards use some "interesting"
interface to various tables & pseudo-code scripts in the cards ROM
(called AtomBios) and the code for that, contributed by ATI, has serious
endian bugs which I'm working on fixing as we speak.

For nvidia, you can use the free "nv" driver which provides some level
of 2D acceleration and mode setting but no more. Or you may want to try
the reverse engineered "nouveau" drivers whose level of features might
or might not suit you depending on what you need and what card model you
have.

There's some work on getting recent XGI cards (such has XP 10) to work
as well, though there are still issues with the driver.

It mostly depends on what features you need. If you can get ATI to sell
you an "embedded" chip using one of their old families (r1xx/2xx or even
3xx) it's likely to just work provided you can bootstrap it.

Finally, in the ATI case (and to some extend nVidia but I don't know how
well that works), the card can also be bootstrapped without an x86 BIOS
emulation using some of those "scripts" in the ROM. This should be
working with the ATI AtomBios (r5xx/6xx) once I'm done with it, and we
have some code for older ATI BIOSes too but I haven't tried it and so it
might well not work (it's more tricky for various reasons). This code
can fairly easily be pulled out of the X server if you want your
firmware to be able to bootstrap the cards earlier.

I have no info about other card vendors.

Cheers,
Ben. 

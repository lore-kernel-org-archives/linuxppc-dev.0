Return-Path: <avorontsov@ru.mvista.com>
Date: Fri, 9 Oct 2009 02:20:43 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Message-ID: <20091008222042.GA10743@oksana.dev.rtsoft.ru>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-embedded@vger.kernel.org, linux-i2c@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2009 at 09:48:50AM -0600, Grant Likely wrote:
> On Thu, Oct 8, 2009 at 9:10 AM, Anton Vorontsov
[...]
> > It's *always* a small amound of code, at a start. Then we get
> > floppy disk drivers and the tty layer. ;-)
> 
> Holy straw man argument Batman!
> 
> But the focus is still on creating pdata.  If a translator gets too
> big, then sure, split it into a separate file.  Until then, there I
> see no good reason to do so now.

Luckily, I'm not at24 driver maintainer (Wolfram himself is ;-),
but as a maintainer of driver "Foo", I would not want to see
completely unfamiliar "Bar" in my shiny driver.

Another plus is that you can bypass (or almost bypass) subsystem
maintainers when merging OF-specific patches (since he/she couldn't
possibly care less about all these weird arch internals. But again,
this doesn't work for this particular driver since Wolfram is the
maintainer :-).

> > If I wasn't a PPC/OF guy to some degree, I'd hate PPC/OF people
> > for bringing arch-specific details into a generic code... :-P
> 
> No, this goes beyond PPC/OF.  The real issue is that it is no longer a
> safe assumption that pdata will be a static data structure in platform
> code.  The number of possible data sources is going to get larger, not
> smaller.  OF is just one.  UEFI is another.  Translating that data
> into pdata will be the problem that comes up over and over again.
> However, translation code is still driver specific,
> so it belongs with the driver that it translates code for.

Wait... The translation code depends on a platform, and on a
platform_data structure, the same as non-OF arch-specific code
depends on it. How is it different from a static platform data
in the arch/ code? We don't put static platform data into the
drivers and surround them with ugly #ifdefs+machine_is()...

> So, in my opinion, translation code must:
> 1. be *tiny*

Yeah, dream on. ;-) It's tiny when all you have is of_get_property(),
I'd like to see the code when you'll have GPIOs, IRQs, and platform-
specific fixups.

You might say that at24 doesn't need that stuff, but it does.
Suppose AT24's WP pin is connected to a GPIO, and without
'read-only' property I'd like the driver to pull the pin low,
and vice versa: with 'read-only' specifier, WP should be tied
high. Or if WP is controlled by a switch/jumper, GPIO can be
used to read current WP state.

> -- should be trivial to add to a driver without impacting
> common code

This is doable, yes.

> > No matter how small the OF code is, I believe we shouldn't put it
> > into the generic code. Take a look at mmc_spi case again, it can be
> > easily extended to any arch, because there is no arch-specific stuff,
> > but a "get/put" pattern for platform data.
> 
> I'm not disagreeing with you that the arch specific stuff should be
> logically separated from the generic code.  But I don't agree that it
> belongs in a separate file.  And I also think that the mmc_spi
> implementation uses too much code.  There must be a better way.

I wonder how you'd shrink the mmc_spi bindings, can you elaborate?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

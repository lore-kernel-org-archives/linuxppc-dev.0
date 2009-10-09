Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091008222042.GA10743@oksana.dev.rtsoft.ru>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008222042.GA10743@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 9 Oct 2009 00:37:34 -0600
Message-ID: <fa686aa40910082337jac3a3aehe4d5bb8e3dcb7b70@mail.gmail.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-embedded@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 8, 2009 at 4:20 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Oct 08, 2009 at 09:48:50AM -0600, Grant Likely wrote:
>> But the focus is still on creating pdata. =A0If a translator gets too
>> big, then sure, split it into a separate file. =A0Until then, there I
>> see no good reason to do so now.
>
> Luckily, I'm not at24 driver maintainer (Wolfram himself is ;-),
> but as a maintainer of driver "Foo", I would not want to see
> completely unfamiliar "Bar" in my shiny driver.

It sounds like your saying that data parsing isn't really the same as
driver code, and I don't think that is true.  Device data parsing is
equally as important as the functional behaviour.  A device driver
isn't complete unless it does both.  Right now most drivers only
understand LInux's internal representation (pdata) because that is the
only data source they've needed to this point.  When new data sources
appear (device tree), it is completely appropriate for the driver to
be modified to understand the new data format (with all the caveats of
coding it in a logical way with translation decoupled from function to
keep impact at a bare minimum).

To use your example, a driver author who states "I only use Bar; so I
don't ever want to see Foo code" is probably being a bit short sighted
with regards to portability.

> Another plus is that you can bypass (or almost bypass) subsystem
> maintainers when merging OF-specific patches (since he/she couldn't
> possibly care less about all these weird arch internals. But again,
> this doesn't work for this particular driver since Wolfram is the
> maintainer :-).

I don't want OF parsing to bypass subsystem or driver maintainers.
:-)  I think they should be involved in reviewing and acking
translator code.

>> > If I wasn't a PPC/OF guy to some degree, I'd hate PPC/OF people
>> > for bringing arch-specific details into a generic code... :-P
>>
>> No, this goes beyond PPC/OF. =A0The real issue is that it is no longer a
>> safe assumption that pdata will be a static data structure in platform
>> code. =A0The number of possible data sources is going to get larger, not
>> smaller. =A0OF is just one. =A0UEFI is another. =A0Translating that data
>> into pdata will be the problem that comes up over and over again.
>> However, translation code is still driver specific,
>> so it belongs with the driver that it translates code for.
>
> Wait... The translation code depends on a platform, and on a
> platform_data structure, the same as non-OF arch-specific code
> depends on it.

The translation code depends on the data source.  That may be OF.  It
may be UEFI.  It may be another driver (think a PCI driver
instantiating a set of child platform devices).  It may be a kernel
hacker (who hard codes it into the platform code).  It has nothing to
do with arch/.  (and ignore the whole of_platform bus stuff; that was
a bad idea from the outset (not that we knew that at the time).  I
don't intend to port of_platform to other architectures).

> How is it different from a static platform data
> in the arch/ code? We don't put static platform data into the
> drivers and surround them with ugly #ifdefs+machine_is()...

Of course we don't put static platform data into the drivers; because
static platform data is platform specific, and therefore belongs with
the platform.  An OF translator is different from a static pdata
because it is driver specific code instead of platform specific code.
Platform specific code is only applicable for the platform, so of
course it belongs with the platform code.  Driver specific code
belongs with the driver because it isn't applicable to anything else.
The whole point of the device tree is that it allows driver specific
code to be written that understands the data describing the device
instead of having a programmer hard code it.

>
>> So, in my opinion, translation code must:
>> 1. be *tiny*
>
> Yeah, dream on. ;-) It's tiny when all you have is of_get_property(),
> I'd like to see the code when you'll have GPIOs, IRQs, and platform-
> specific fixups.

It's still pretty tiny, because it still needs to populate a pdata
structure.  99% of the time there won't be any platform specific
fixups either.... In the odd case when there *are* platform specific
hacks, then of course the pdata should be created by platform code,
and not driver code.  One way to do this is to have platform code hook
into the notifier call chain for a bus and watch for devices it needs
to meddle with.  When one shows up, register the custom pdata before
the driver gets probed.  But that is the special case, which doesn't
need to impact the common case.

> You might say that at24 doesn't need that stuff, but it does.
> Suppose AT24's WP pin is connected to a GPIO, and without
> 'read-only' property I'd like the driver to pull the pin low,
> and vice versa: with 'read-only' specifier, WP should be tied
> high. Or if WP is controlled by a switch/jumper, GPIO can be
> used to read current WP state.

I still don't see a problem.  If it can be described in pdata, then a
translator function can populate it from the device tree data.  It
still isn't huge.  Besides, just because it *might* someday become
huge doesn't mean that it should be segregated into another file now.
It can always be moved later if it becomes too big.

>> -- should be trivial to add to a driver without impacting
>> common code
>
> This is doable, yes.
>
>> > No matter how small the OF code is, I believe we shouldn't put it
>> > into the generic code. Take a look at mmc_spi case again, it can be
>> > easily extended to any arch, because there is no arch-specific stuff,
>> > but a "get/put" pattern for platform data.
>>
>> I'm not disagreeing with you that the arch specific stuff should be
>> logically separated from the generic code. =A0But I don't agree that it
>> belongs in a separate file. =A0And I also think that the mmc_spi
>> implementation uses too much code. =A0There must be a better way.
>
> I wonder how you'd shrink the mmc_spi bindings, can you elaborate?

To start; eliminate all the pdata management code and write some
library routines to do that instead.  Next, I'd refactor the code to
separate out the GPIO handling stuff because the GPIO handling really
isn't related to OF at all (that code could just as easily be used by
a static pdata structure definition).  All that should be left is the
meat of the mmc_spi_get_pdata() function which parses the device tree
and populates pdata.

I agree that the infrastructure to do what I'm suggesting doesn't
exist yet; but I say this because I think it is the direction that
device tree support needs to go.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

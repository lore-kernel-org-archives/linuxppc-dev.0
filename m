Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 8B34AB6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 05:16:56 +1100 (EST)
Received: by yxe8 with SMTP id 8so772266yxe.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 10:16:54 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091126121204.GA3558@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
	<200911252141.59549.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 26 Nov 2009 11:16:34 -0700
Message-ID: <fa686aa40911261016p489981a2g1fac393264c4d1c7@mail.gmail.com>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Torsten Fleischer <to-fleischer@t-online.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2009 at 5:12 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Wed, Nov 25, 2009 at 03:11:57PM -0700, Grant Likely wrote:
>> On Wed, Nov 25, 2009 at 1:41 PM, Torsten Fleischer
>> <to-fleischer@t-online.de> wrote:
>> > On Wen, Nov 25, 2009 at 01:33:57 Grant Likely wrote:
>> >> Thanks. =A0However, there needs to be a proper description of what th=
is
>> >> patch does to go in the commit header. =A0Can you please write one?
>> >>
>> >> Thanks,
>> >> g.
>> >>
>> > [...]
>> >
>> > The initialization of the chip selects is removed from the probe() fun=
ction of
>> > the spi_mpc8xxx driver, because the driver doesn't know the polarity o=
f the
>> > chip selects of the SPI devices at the time of its initialization.
>> >
>> > For this reason the initialization of the several chip selects is post=
poned
>> > to the point of time when the very first SPI transfer to the associate=
d device
>> > occurs.
>> >
>> >
>> > Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
>>
>> Ah. =A0I understand what you're doing now. =A0 Hmmm. =A0This approach
>> concerns me because it relies on firmware or platform code to get CS
>> gpios set up properly before the driver is probed.
>
> Yes, that was said at the very beginning of this thread.

I also came in part way through as I wasn't an SPI maintainer when
this thread started.  :-)

>> =A0Firmware doesn't
>> always get it right, and I prefer to avoid platform specific setups as
>> much as possible. =A0Why can't the CS polarity be encoded into the
>> device tree so the driver *does* have the polarity data at probe time?
>
> We have the spi-cs-high property, but it duplicates compatible
> property. 'compatible' is enough to tell whether some device has
> cs-high or cs-low (device's driver knows that already).

But the device's driver isn't controlling the CS line, the SPI bus
driver is.  Besides, there is no guarantee that all drivers will
actualy be loaded before something starts using SPI.  The bus driver
*must* know what the active state of each CS line is before activating
any devices.

The spi bus binding is deficient in this case.  A property (can be
optional) need to be added to the spi bus node to explicitly state the
CS polarities.  It's not entirely sane to look for a "spi-cs-high'
property in the spi device nodes because the SPI bus may not be fully
populated (ie. if a device happens to be sitting on the bus, but isn't
in the device tree yet).  Before any SPI transactions go out, it is
the responsibility of the bus driver to ensure all CS lines are in the
correct state.

> The problem is that SPI bus master doesn't know all the devices,
> so it can't extract that information from the compatible string.
> To workaround that we can use 'spi-cs-high', but that's ugly
> workaround.

It doesn't need to know about the devices, but is must know how all of
its CS lines behave.  So it isn't an really an ugly workaround, but I
do think the binding is insufficient for the SPI bus driver (see
below)

> SPI modes (0,1,2,3) is another matter, some devices can work in
> several modes, so 'spi-cpol' and 'spi-cpha' are actually useful.

yes.  spi-cpol and spi-cpha are actually properties of the device, and
belong in the spi device node, not the spi bus node.

The spi-cs-high property is defined in
Documentation/powerpc/dts-bindings/spi-bus.txt, but it definitely was
a mistake for the reasons I described above.  It does work in some
cases, but a property at the bus node would be better.  The driver can
still fallback to looking for spi-cs-high properties in child nodes.

Currently the spi-cs-high property is parsed in the
of_register_spi_devices() function, but the CS polarity needs to be
known before registering devices.  It needs to be factored out into
another utility function callable by spi bus drivers so that it can
get polarity data at probe time.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id 3072CDDFE9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 04:42:51 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so2549231agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 11:42:50 -0700 (PDT)
Message-ID: <fa686aa40806051142q61ba471fl772ed32586b70e5c@mail.gmail.com>
Date: Thu, 5 Jun 2008 12:42:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [RFC v3] OF: OpenFirmware bindings for the mmc_spi driver
In-Reply-To: <20080605183146.GA29092@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080605161624.GA517@polina.dev.rtsoft.ru>
	<fa686aa40806050945h5e61910flb63a8d00e1d2b0e8@mail.gmail.com>
	<20080605172723.GA14514@polina.dev.rtsoft.ru>
	<fa686aa40806051036x22cd6a2bkc58650f5e69960fe@mail.gmail.com>
	<20080605180058.GA21429@polina.dev.rtsoft.ru>
	<fa686aa40806051118y39cbf14fye5268c819d4bbbfc@mail.gmail.com>
	<20080605183146.GA29092@polina.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 12:31 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Jun 05, 2008 at 12:18:56PM -0600, Grant Likely wrote:
>> On Thu, Jun 5, 2008 at 12:00 PM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > On Thu, Jun 05, 2008 at 11:36:09AM -0600, Grant Likely wrote:
>> >> On Thu, Jun 5, 2008 at 11:27 AM, Anton Vorontsov
>> >> <avorontsov@ru.mvista.com> wrote:
>> >> > Well, I mentioned the usb_add_hcd()-alike approach for the mmc_spi
>> >> > host... The absence of enthusiasm I equaled to "no".
>> >> >
>> >> > Heh.
>> >>
>> >> I'm allergic to USB HCD code; I was probably having convulsions under my desk.
>> >
>> > :-)
>> >
>> > Ok, I also mentioned drivers/ata/pata_of_platform.c (OF version is using
>> > common code from drivers/ata/pata_platform.c).
>> >
>> > Please look there, and tell me if this is what you have in mind. (ignore
>> > _probe in the __pata_platform_probe name. Imagine
>> > pata_platform_add_controller or something).
>>
>> Yes, I like that.  I've done something very similar for drivers with
>> both of and non-of bindings.  For another example, this time all
>> contained within a single .c file, see drivers/video/xilinxfb.c
>
> Ok, great. As I said previously, this is quite easy to do.
>
>> >> > p.s.
>> >> > Btw, you forgot another downside of v2 approach: struct spi_driver
>> >> > duplication... Not sure if everyone will be happy about it.
>> >> >
>> >> > Though, v2 is only version where we can make modular OF_MMC_SPI.
>> >>
>> >> I think we've got our wires crossed.  I'm not referring to the option
>> >> of an of_mmc_spi driver registering an mmc_spi device (which can then
>> >> be probed by the mmc_spi_driver).
>> >
>> > I'm not refrering to this option either.
>>
>> Okay, I'm confused then.  Where is the duplication of struct spi_driver?
>
> Here it is http://lkml.org/lkml/2008/5/23/299
> + static struct spi_driver of_mmc_spi_driver = {

Right; I was going down the wrong thought path.  I have no problem with this.

BTW, while on that topic, I think it is reasonable to roll the members
of of_mmc_spi into either the mmc_spi_platform_data or the
mmc_spi_host structure.  It is just 2 integers and that would
eliminate storing driver data pointers in seemingly random places.

> And here http://lkml.org/lkml/2008/5/24/153 David Brownell says:
>> The only thing that looks odd to me about this is that the wrapper
>> is a spi_device rather than an of_device.  To me it makes more sense
>> to just have an of_device setting up the right spi_device.  (Though
>> maybe I missed some discussion about why that can't work.)

Yeah; I'm not fond of that approach.  It incurs runtime cost of
multiple 'struct device' for a single device which is unnecessary.

> I hope the bottom line is that we're now all happy to create another
> spi_driver to handle "OF MMC-o-SPI" devices..?

Yes, I'm cool with it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

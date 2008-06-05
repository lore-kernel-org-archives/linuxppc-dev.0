Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 56D0EDEAC6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 03:36:11 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so149050anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 10:36:10 -0700 (PDT)
Message-ID: <fa686aa40806051036x22cd6a2bkc58650f5e69960fe@mail.gmail.com>
Date: Thu, 5 Jun 2008 11:36:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [RFC v3] OF: OpenFirmware bindings for the mmc_spi driver
In-Reply-To: <20080605172723.GA14514@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080605161624.GA517@polina.dev.rtsoft.ru>
	<fa686aa40806050945h5e61910flb63a8d00e1d2b0e8@mail.gmail.com>
	<20080605172723.GA14514@polina.dev.rtsoft.ru>
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

On Thu, Jun 5, 2008 at 11:27 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Jun 05, 2008 at 10:45:17AM -0600, Grant Likely wrote:
>> On Thu, Jun 5, 2008 at 10:16 AM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > Here is v3. I'm out of ideas if you won't like it. :-)
>> >
>> > v3:
>> > - Now these bindings are using bus notifiers chain, thus we adhere to the
>> >  spi bus.
>> >
>> >  By the way, this scheme (IMO) looks good for I2C devices which needs
>> >  platform_data extracted from the device tree too (Cc'ing Jochen).
>> >
>> > - Plus changed the OF bindings themselves, implemented voltage-range
>> >  property. (Pierre, please take a look at vddrange_to_ocrmask(). I
>> >  wonder if you would like this in the MMC core instead, with a kernel
>> >  doc, of course.)
>> >
>> > v2:
>> > - Bindings were adhered to the MMC_SPI driver. Withdrawn by Pierre Ossman.
>>
>> Personally I think your v2 was better, and if I'm interpreting
>> Pierre's comments correctly I think his main point is that instead of
>> using the 'stock' probe/remove hooks for the spi mmc driver, the
>> driver should be mildly reworked to provide a common block of code
>> that can be used by both the OF and non-OF versions of the
>> probe/remove routines.  I also think that is the way to go.
>
> Well, I mentioned the usb_add_hcd()-alike approach for the mmc_spi
> host... The absence of enthusiasm I equaled to "no".
>
> Heh.

I'm allergic to USB HCD code; I was probably having convulsions under my desk.

> p.s.
> Btw, you forgot another downside of v2 approach: struct spi_driver
> duplication... Not sure if everyone will be happy about it.
>
> Though, v2 is only version where we can make modular OF_MMC_SPI.

I think we've got our wires crossed.  I'm not referring to the option
of an of_mmc_spi driver registering an mmc_spi device (which can then
be probed by the mmc_spi_driver).  I'm referring to refactoring the
probe/remove code so that common stuff is callable by both the mmc_spi
and of_mmc_spi drivers without the oddity of the of_mmc_spi probe hook
calling the mmc_spi probe hook.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

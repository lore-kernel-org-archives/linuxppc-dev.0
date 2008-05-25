Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 00E85DDF38
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 14:47:09 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so316783anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 21:47:08 -0700 (PDT)
Message-ID: <fa686aa40805242147w400e2ff5jf532f8843ec3f85f@mail.gmail.com>
Date: Sat, 24 May 2008 22:47:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [RFC] OpenFirmware bindings for the MMC-over-SPI driver
In-Reply-To: <200805241256.32639.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<200805241256.32639.david-b@pacbell.net>
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

On Sat, May 24, 2008 at 1:56 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 23 May 2008, Anton Vorontsov wrote:
>>
>> This is second attempt to write the OpenFirmware bindings for the
>> MMC-over-SPI (and SPI bindings in general).
>
> Summary:  an OF-specific wrapper around the mmc_spi platform code.
>
> I think a wrapper to encapsulate all the OF-specific knowledge makes
> much sense here.
>
> The only thing that looks odd to me about this is that the wrapper
> is a spi_device rather than an of_device.  To me it makes more sense
> to just have an of_device setting up the right spi_device.  (Though
> maybe I missed some discussion about why that can't work.)

It's not so much that I can't work; more like it's not necessary.
of_platform bus is by no means the prescribed way to work with the
device tree.  In fact, there is talk about moving away from
of_platform bus entirely and using
platform_device/spi_device/i2c_device/etc directly instead since the
of_platform bus is mostly a clone of the platform bus with different
device binding semantics.

As Anton's patch shows, it is straight forward to add a binding that
can extract the platform data out of the device tree without the
overhead of adding an additional of_platform bus device & driver pair.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

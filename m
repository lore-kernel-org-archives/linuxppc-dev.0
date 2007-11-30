Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 975C6DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 23:05:00 +1100 (EST)
Date: Fri, 30 Nov 2007 15:09:31 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071130120931.GA11286@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
	<20071127212222.GB10829@lixom.net>
	<200711272233.00456.arnd@arndb.de>
	<20071128154904.GA20722@localhost.localdomain>
	<474D9327.9020305@ru.mvista.com> <20071129005440.GA2235@zarina>
	<474FE332.8080103@ru.mvista.com>
	<20071130105849.GA10840@localhost.localdomain>
	<474FF776.1060803@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <474FF776.1060803@ru.mvista.com>
Cc: Olof Johansson <olof@lixom.net>, cbou@mail.ru, linux-ide@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 30, 2007 at 02:43:50PM +0300, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
> 
> >>>Remaining question: any preferred name for that property? pio-mode okay?
> >>>It's assuming that PIO6 capable bus supports PIO0 as well, thus no mask.
> 
> >>  I've already suggested "generic". A name "simple" also comes to my mind.
> 
> >You've misread my question. I didn't ask about driver name, but pio-mode
> >property.
> 
>    Probably "max-pio-mode" is a better variant.

Why? pio-mode in pata-platform context is just something highly
dependent on hardware, can not be touched. And we're passing
pio-mode information from the hardware dependent source --
device tree.

The only difference between pata-platform's max-pio-mode and
dedicated ata driver's pio-mode is that that for the first case
bus already configured for specified mode, and for the second
case dedicated driver should actually use this information
to configure hardware.

No need for max- prefix, I think.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

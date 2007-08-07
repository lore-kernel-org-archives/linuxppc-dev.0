Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4EB9CDDDFD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 20:55:31 +1000 (EST)
Date: Tue, 7 Aug 2007 14:53:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register
	mmc_spi stub
Message-ID: <20070807105346.GB13606@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
	<20070801132948.GB20200@localhost.localdomain>
	<d36303a31bb9cd2ab7cb38a09428e616@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <d36303a31bb9cd2ab7cb38a09428e616@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 08:18:47PM +0200, Segher Boessenkool wrote:
[...]
>>> The hardware should be described in the device tree.  This isn't
>>> the same as simply copying all your Linux code into it ;-)
>>
>> Ugh. SD/MMC slot is the hardware, isn't it? It have wired SPI pins,
>> and chip select pin. To set up this pin, I need mmc node, which means
>> that I can't completely move mmc definitions to the board file, as
>> suggested by Kumar Gala.
>>
>> Advices?
>
> You need to declare in the SPI node which GPIOs it uses for
> what.  You shouldn't have the actual values to put into the
> GPIO registers in the device tree; the kernel driver can
> figure it out.

Well, how SPI differs from UCC in that regard? This is how mpc832x_mds.dts,
mpc832x_rdb.dts, mpc836x_mds.dts, ... doing things already for UCC pins.
And then what pio-map exists for?.. In my understanding pio-map tries to
describe hardware (GPIO) wiring, exactly how SPI (and UCC) nodes trying
to use it.

Heh.. anyway, it's really hard to find proper logic around device tree,
do's and don'ts, so I'll just follow your suggestions in hope that I'll
get it as time goes by. ;-)

> Hope this helps,

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

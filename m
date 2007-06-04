Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F302DDE9F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 18:35:27 +1000 (EST)
In-Reply-To: <1180924186.5476.3.camel@concordia.ozlabs.ibm.com>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<200706012250.58962.m.kozlowski@tuxland.pl>
	<20070601140211.81e5c301.akpm@linux-foundation.org>
	<200706012321.16239.m.kozlowski@tuxland.pl>
	<1180924186.5476.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ffe893f9ab0cca6ac5c0442a851a1dbd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.22-rc3-mm1
Date: Mon, 4 Jun 2007 10:35:20 +0200
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> BTW. This is 'make allnoconfig && make' result:
>>
>>   MODPOST vmlinux
>> ln: accessing `arch/powerpc/boot/zImage': No such file or directory
>> make[1]: *** [arch/powerpc/boot/zImage] Error 1
>> make: *** [zImage] Error 2
>
> If you check your .config I think you'll find you have none of the
> powerpc platforms selected, which means you don't get a zImage.

Which is simply a Makefile bug.

> And your
> kernel won't boot on any actual hardware either :)

I've never seen any allnoconfig kernel do that ;-)

> Perhaps one of the platforms should be the default if nothing else is
> selected, just so allnoconfig works.

Nah, just don't create the zImage link if $(image-y)
is empty.


Segher

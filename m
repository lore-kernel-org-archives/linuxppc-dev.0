Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82129DDEC8
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 11:58:55 +1000 (EST)
In-Reply-To: <20070506004319.GH11303@localhost.localdomain>
References: <00bf8e702554e7903d92f618ee236528@bga.com>
	<1a1a143ae0292ea0a6006a26fb95a446@kernel.crashing.org>
	<20070506004319.GH11303@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <24841a6e4738b12a4799c931d6dc3057@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Date: Sun, 6 May 2007 03:58:34 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Olof Johansson <olof@lixom.net>, ppcdev <linuxppc-dev@ozlabs.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> How?   CPP doesn't apply inside the strings.
>>
>> So put it outside the strings:
>>
>> +     asm volatile (
>> +             "mfspr  %0," #SPRN_DBCR0 "\n\t"
>> +             "oris   %0,%0," #DBCR0_RST_SYSTEM "@h\n\t"
>> +             "mtspr  " #SPRN_DBCR0 ",%0"
>> +             : "=&r"(tmp));
>
> Um, I think stringify(SPRN_DBCR0) is needed there, not just a bare #.

Yes of course.  Someone is paying attention ;-) (*)

> At which point it's not entirely clear to be that just using the "i"
> constraint isn't the simplest option after all.

Sure.  Or even hardcoding the values (with comments),
which would show why a bare "oris" is correct at all.


Segher




(*) ... just not me

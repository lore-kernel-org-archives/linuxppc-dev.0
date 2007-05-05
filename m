Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82940DDE19
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 06:37:45 +1000 (EST)
In-Reply-To: <00bf8e702554e7903d92f618ee236528@bga.com>
References: <00bf8e702554e7903d92f618ee236528@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1a1a143ae0292ea0a6006a26fb95a446@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Date: Sat, 5 May 2007 22:37:37 +0200
To: Milton Miller <miltonm@bga.com>
Cc: Olof Johansson <olof@lixom.net>, ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +static void ebony_exit(void)
>>> +{
>>> +     unsigned long tmp;
>>> +
>>> +     asm volatile (
>>> +             "mfspr  %0,%1\n"
>>> +             "oris   %0,%0,%2@h\n"
>>> +             "mtspr  %1,%0"
>>> +             : "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
>>
>> You don't have to pass in the constants here, you can specify them in
>> the asm. Makes it a little more readable.
>
> How?   CPP doesn't apply inside the strings.

So put it outside the strings:

+     asm volatile (
+             "mfspr  %0," #SPRN_DBCR0 "\n\t"
+             "oris   %0,%0," #DBCR0_RST_SYSTEM "@h\n\t"
+             "mtspr  " #SPRN_DBCR0 ",%0"
+             : "=&r"(tmp));


Segher

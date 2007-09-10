Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 11449DDEB6
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 02:09:09 +1000 (EST)
In-Reply-To: <20070910142513.GB21670@ld0162-tx32.am.freescale.net>
References: <20070907005803.GJ26079@localhost.localdomain>
	<d16e868937a1f77cbf080754f5742ad9@bga.com>
	<20070910142513.GB21670@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6c36dd35d7c6ee967223dc36ecf37d0c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Date: Mon, 10 Sep 2007 11:09:27 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 10, 2007, at 9:25 AM, Scott Wood wrote:

>>>> +static inline void disable_irq(void)
>>>> +{
>>>> +       int dummy;
>>>> +       asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr 
>>>> %0"
>>>> :
>>>> +                    "=r" (dummy) : : "memory");
>>>> +}
>>
>> This will fail (mtmsr illegal instruction) on 64 bit processors that 
>> do
>> not implement the bridge facility (POWER4, 5, 6, PPC970, ...)
>
> Ouch...  And given the One wrapper.a To Rule Them All mandate, we can't
> ifdef it here, but instead must make separate platform files. :-P

Rather than a seperate c file, I think this should go in your 
_zimage_start, renaming fixed-head.S.

milton

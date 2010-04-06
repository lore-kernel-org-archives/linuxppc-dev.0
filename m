Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id 133FFB7D15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Apr 2010 10:29:41 +1000 (EST)
Received: by qyk27 with SMTP id 27so5420099qyk.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 05 Apr 2010 17:29:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BB60975.2010606@conspiracy.net>
References: <48abf2c21003301846h67106ce6h8d51ad167374793f@mail.gmail.com>
	<4BB36EB1.6010105@freescale.com>
	<z2l48abf2c21003311756y80262019yc8c1cc4d2cc61b5f@mail.gmail.com>
	<4BB60975.2010606@conspiracy.net>
Date: Tue, 6 Apr 2010 08:29:36 +0800
Message-ID: <o2z48abf2c21004051729sb38c18b9x7ed8d601ab3e4b64@mail.gmail.com>
Subject: Re: I can not get my MII working on MPC8247 with Linux 2.6.32.6
From: Peter Pan <pppeterpppan@gmail.com>
To: "paul@conspiracy.net" <paulfax@conspiracy.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've checked the TA bit. The TA bit is 11 which means the TA bit is not cor=
rect.
I changed the code to not verify the TA bit, It still returns all
ones. Then I printed out all the values get. All that I get is 1. I'm
going to check the MDIO with a oscilloscope.
Thanks paul, you give me another way of thinking the unworkable PHYs.

2010/4/2 paul@conspiracy.net <paulfax@conspiracy.net>:
> Actually remembered the issue on our 8247 (now 8567) systems when we
> went to the later kernels/u-boot. =A0We were using a Broadcom PHY and the
> power on reset did not meet the minimum specifications. =A0At times the
> PHY's would work properly, many times they were inconsistent, but the
> often the indication was that the turn around bit was invalid (so driver
> returned all one's). =A0A CPLD change on our side fixed this. =A0It may b=
e
> that it was not working correctly at all times with the old kernel, but
> since the TA bit as not checked we never knew.
> Not sure if this is applicable but might be worth verifying.
> Paul
>
>
> On 3/31/2010 7:56 PM, Peter Pan wrote:
>> Yes, the PHY address is correct, I've checked the schematics, and
>> 2.6.22 is also using this PHY address.
>> The different between 2.6.22 and 2.6.32.6 is that:
>> In 2.6.22, we use arch/ppc/8260_io/fcc_enet.c as the driver. IMMR
>> address 0xf0000000 is directly used.
>> In 2.6.32.6, cpm2-fcc-enet driver is used. In that driver, the
>> register address is ioremaped and used. The others are the same.
>> I've tried to use the dir and data register address directly in
>> mii-bitbang.c, but that leads to kernel oops.
>> I've wrote a low level gpio driver for our processor MPC8247, and I
>> used that for our external hardware watchdog, it works fine. Then I
>> use the low level driver in the mii-bitbang.c, it still works
>> incorrect, all I get from MDIO is 1.
>> I'm really confused.
>>
>>
>> 2010/3/31 Scott Wood <scottwood@freescale.com>:
>>
>>> Peter Pan wrote:
>>>
>>>> Recently, I'm porting Linux 2.6.32.6 to our customized MPC8247 based
>>>> board. Everything is fine out except my ethernets. I uses
>>>> cpm2-scc-enet and cpm2-fcc-enet drivers.
>>>> My ethernet works fine in U-Boot with the same setting, and our
>>>> previous Linux 2.6.22 is also working, so there should be nothing
>>>> wrong with the hardware.
>>>> The boot log of the MII part is:
>>>>
>>>> CPM2 Bitbanged MII: probed
>>>> mdio_bus f0010d00: error probing PHY at address 0
>>>> mdio_bus f0010d00: error probing PHY at address 1
>>>>
>>> Are 0 and 1 the addresses you're expecting the PHYs to be at?
>>>
>>> If that's not it, I'd try to examine the specific register accesses tha=
t
>>> 2.6.22 is doing and see what's different.
>>>
>>> -Scott
>>>
>>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
>

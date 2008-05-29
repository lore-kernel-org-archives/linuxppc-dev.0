Return-Path: <panto@embeddedalley.com>
Received: from postoffice.embeddedalley.com (cpe-089228.fiber.wadsnet.net
	[65.114.89.228]) by ozlabs.org (Postfix) with SMTP id BA168DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 21:12:35 +1000 (EST)
Message-Id: <4B443E30-4B6C-4E37-A038-AB05214EE78C@embeddedalley.com>
From: Pantelis Antoniou <panto@embeddedalley.com>
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
In-Reply-To: <20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 14:05:48 +0300
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<20080527214241.GA22636@parisc-linux.org>
	<1211926636.3286.100.camel@pasglop>
	<20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, tpiepho@freescale.com,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 28 =CE=9C=CE=B1=CF=8A 2008, at 11:36 =CE=A0=CE=9C, Haavard Skinnemoen =
wrote:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>>> I'm happy to say that __raw is purely about ordering and make them
>>>> byteswap on powerpc tho (ie, make them little endian like the non-=20=

>>>> raw
>>>> counterpart).
>>>
>>> That would break a lot of drivers.
>>
>> How many actually use __raw_ * ?
>
> I do -- in all the drivers for on-chip peripherals that are shared
> between AT91 ARM (LE) and AVR32 (BE). Since everything goes on inside
> the chip, we must use LE accesses on ARM and BE accesses on AVR32.
>
> Currently, this is the only interface I know that can do native-endian
> accesses, so if you take it away, I'm gonna need an alternative
> interface that doesn't do byteswapping.
>
> Haavard

I certainly do too.

Quite a lot of SoC specific drivers use __raw for accessing their
on-chip peripherals.

Please don't change the __raw semantics, you'll end up breaking almost
everything that's BE.

-- Pantelis

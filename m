Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A028DE11B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 00:54:48 +1000 (EST)
In-Reply-To: <1184260375.24515.35.camel@pterry-fc6.micromemory.com>
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
	<4694F608.2090503@freescale.com>
	<368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3E42@zch01exm26.fsl.freescale.net>
	<1184260375.24515.35.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B2EA074C-5D8E-4E13-B6BF-E81FBA52E76E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Mon, 16 Jul 2007 16:54:35 +0200
To: pterry@micromemory.com
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I thought the idea of the dts/of was for the hardware specific boot
> loader to tell the kernel about hardware that the kernel couldn't
> otherwise know about, because its not detectable by a bus probe  
> method,
> etc. Its not there to tell you how to use the device or arbitrate  
> which
> other devices get to use a device when there are resource conflicts,
> etc.
>
> If the dts/of/boot loader tells the kernel its a fsl soc then it knows
> how to work out which one and what level, and therefore knows what
> devices, such as the DMA device are present.

The device tree describes _all_ hardware in the system,
not just the things that are somewhat harder to probe
for.  Kernel drivers are free to not use all info provided
in the device tree and just hardcode some (correct or
incorrect) implicit knowledge about the device in question.
Whether this is a good idea or not is a different thing.

> I'm truly interested in understanding the correct interpretation  
> because
> we are developing a DMA based, rapidio distributed system on fsl 8641
> and from lurking on here and reading the archives etc, all I see is a
> constant butting of heads on what the dts/of is and how its  
> supposed to
> work.

Really, most of what you see is developing bindings for
specific devices, which takes a lot of discussion since
it needs to be made future-proof.

> Quite why we are using a 20 year old spec, which was never  
> finished, and
> ceased to be a formal spec 10 years ago as the "new" way forward is a
> puzzle to me as well.

You have some misconceptions about Open Firmware I'm afraid.

> Not flame bait,

Good, let's drop this then :-)

> but if someone could point me to
> background material it would be helpful for my education in getting up
> to speed (on the rationale for using it going forwards, not all the  
> old
> sites for the spec itself).

I'm afraid you'll have to get some experience using the OF
device tree to truly appreciate its power and flexibility,
and how many problems it solves.  Yeah this is a pretty weak
answer.


Segher

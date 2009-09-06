Return-Path: <sebastian@breakpoint.cc>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D0ABDB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Sep 2009 21:06:50 +1000 (EST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 033B1DDD01
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Sep 2009 21:06:49 +1000 (EST)
Date: Sun, 6 Sep 2009 13:06:41 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Alemao <xcarandiru@gmail.com>
Subject: Re: MPC85xx External/Internal Interrupts
Message-ID: <20090906110641.GA11350@Chamillionaire.breakpoint.cc>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041228h3638e840r34c0c0e79f178e55@mail.gmail.com>
	<d970ff420909041229hb3aa96dya329e06ea56dd1ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <d970ff420909041229hb3aa96dya329e06ea56dd1ac@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Alemao | 2009-09-04 16:29:15 [-0300]:

>On Fri, Sep 4, 2009 at 4:28 PM, Alemao<xcarandiru@gmail.com> wrote:
>> I've read some posts in the list, and about:
>>
>> irq_of_parse_and_map()
>> irq_create_map()
>>
>> But Im still trying to understand MPC85xx TSEC1 dts.
>>
>> Gianfar driver is using request_irq(), and request_irq() uses virtual
>> irq, right?
Yes. request_irq() expects a linux-irq-number. irq_of_parse_and_map()
provides such a number.

>>
>> Thats why in dts all irqs for TSEC1 are "offseted" of 16?
>>
>> Manual ?| ?DTS
>> ----------------------
>> 13 ? ? ? ? 29
>> 14 ? ? ? ? 30
>> 18 ? ? ? ? 34
>>
>
>This makes no sense.
>
>CPM2-PIC, in MPC8555ERM, its on 30. In DTS is on 46. Offset of 16.
>But my platform code use irq_of_parse_and_map()!
>
>So why this offset?!?!
irq_of_parse_and_map() creates a mapping between the hardware irq number
as specified in the device tree and the linux number (virq) which is
used within the linux api in request_irq() for instance.
irq_of_parse_and_map() is essential to create a mapping between those
two. The interrupt controller on the MPC8555 (mpic) specifies the first
few interrupt numbers as external sources followed by internal sources. 
Now, during the init sequenze of the mpic every interrupt source
(internal and external) becomes its uniqe vector number which identifies
the source by a number. This number is the hardware interrupt number
i.e. that thing in the device tree. The init sequence is a for loop
which starts at 0 for the first interrupt source which happens to be
external interrupt 0, 1 for external interrupt 1 and so on. At the time
it reaches the first internal interrupt source the vector number is 16.
That's why you always have an offset of 16 between every internal
interupt source number in the MPC855ERM document and those weired
numbers in the device tree :)

>Alemao
Sebastian

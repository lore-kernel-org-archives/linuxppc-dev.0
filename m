Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7224DDDEF8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 08:48:05 +1100 (EST)
In-Reply-To: <20080320173302.7075a1d9@lappy.seanm.ca>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7aa50e61f9cc57d201706234ecfaf7eb@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTS question
Date: Thu, 20 Mar 2008 22:47:57 +0100
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The warp has an AD7414 chip hanging off the I2C bus. This chip can
> raise an interrupt when it crosses a critical threshold.
>
> This interrupt is tied to IRQ2 from the processor.

No it's not.  PowerPC has only one interrupt [*].  You probably
mean it is tied to IRQ2 on your "main" interrupt controller?

> What is the best
> way to describe this interrupt in the DTS?

You set the "interrupts" property to contain a description for
this interrupt: likely simply <2 sense>.  The exact format (and
the values for "sense") depend on the exact kind of interrupt
controller.

If there is weird interrupt routing, you might need to set an
"interrupt-parent" property as well, pointing to this interrupt
controller.


Segher

Return-Path: <benh@kernel.crashing.org>
Subject: Re: IRQs in i2c-mpc.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711101544v178e29cer4e53577c011e89f7@mail.gmail.com>
References: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
	<3DBBAC12-579B-4C1F-9C9E-D085FB22B687@kernel.crashing.org>
	<9e4733910711101516n64870e40rbd1fcbe3d123fcc3@mail.gmail.com>
	<A4797E92-9FCF-484A-B6AA-9385913AD465@kernel.crashing.org>
	<9e4733910711101544v178e29cer4e53577c011e89f7@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 11 Nov 2007 17:27:51 +1100
Message-Id: <1194762471.21340.39.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> irq_of_parse_and_map() returns NO_IRQ when the irq parameter is missing.
> 
> This API appears to be broken. In asm-powerpc/irq.h NO_IRQ is defined
> as (0). There is no way to tell an error in the attribute from a valid
> attribute selecting interrupt zero.

No, it is not broken. Interrupt numbers in arch/powerpc are virtually
mapped and 0 is never a legal value, thus NO_IRQ is 0. This was done in
part because Linus wanted it that way.

The hardware number can perfectly be 0 though, that's a different thing,
and has nothing to do with what you pass to request_irq().

Ben.

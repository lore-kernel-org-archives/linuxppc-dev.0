Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8E32D2C02AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 09:21:41 +1000 (EST)
Message-ID: <1370820095.14883.45.camel@pasglop>
Subject: Re: PowerPC assembler question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Erik de Castro Lopo <mle+cl@mega-nerd.com>
Date: Mon, 10 Jun 2013 09:21:35 +1000
In-Reply-To: <20130610090135.a002eba2401c06eedfa7b7ec@mega-nerd.com>
References: <20130610090135.a002eba2401c06eedfa7b7ec@mega-nerd.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-10 at 09:01 +1000, Erik de Castro Lopo wrote:
> Hi all,
> 
> I'm trying to fix a problem in the PowerPC backend of the Glasgow
> Haskell Compiler (GHC) and have a problem with the following
> instruction form:
> 
>     lwz     30, .label - (1b)(31)
> 
> Reading the documentation I could find, I have figured out that this
> loads a 16 bit value into register 30. How it calculates that 16 bit
> value has got me somewhat flumoxed.
> 
> Anybody care to explain?

No, this loads a 32-bit value (16-bit would be lhz).

Note: It's more readable if you use the register names, ie:

	lwz	%r30, .label - (1b)(%r31)

The form of lwz is

	lwz	dest_reg, offset(address_reg)

So it will load a 32-bit value from memory at the address contained in
r31 offset by ".label - 1b" which is itself the difference between
two labels, "label", and the first "1:" label before the instruction

(gcc supports numeric labels that can be referenced with the suffix "b"
for backward and "f" for forward which are handy for small
displacements)

So for example if 1: was the base of the structure and .label a field
in the structure, it would load the 32-bit value of that field for the
structure instance starting at %r31.

In this case, this looks more like some kind of position-independent
code though.

Cheers,
Ben.

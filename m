Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A814DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 16:42:13 +1000 (EST)
Message-ID: <4636E142.8010104@itee.uq.edu.au>
Date: Tue, 01 May 2007 16:42:10 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
References: <4636C836.4050502@itee.uq.edu.au>
	<528646bc0704302255j3a825f10vbffd4bac961b28d7@mail.gmail.com>
In-Reply-To: <528646bc0704302255j3a825f10vbffd4bac961b28d7@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: jacmet@sunsite.dk, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 4/30/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
> 
>> All readb/writeb ops are converted to ioread32/iowrite32.
>>
>> On MicroBlaze readb/writeb are picking up the MSB, instead of LSB, and
>> thus reading all zeros instead of the 8-bit control/status/FIFO
>> registers that you intended.
>>
>> Can you please confirm if this works on PPC?
> 
> Yes, I've confirmed this does work on PPC; but I don't think it's
> quite the correct fix.
> 
> ioread/write32 is mapped to in/out_le32, yet the bootloader driver
> must use in/out_be32.  This is because the uartlite driver follows the
> lead of 8250 and requires an offset of 3 from the base address in
> order to find the relevant byte wise address.  In fact, I believe the
> driver should work as-is on microblaze if the offset-by-3 is not used
> when registering it to the platform bus.

ugh.  I missed the off-by-3 stuff in the PPC platform setup.  Smells bad!

> However, the uartlite is *not* an 8250.  The 8250 turns up all over
> the place and it's registers are defined as 8 bit wide.  The
> offset-by-3 stuff is part of the plat_serial8250_port structure which
> is also used to specify .regshift (increment between registers).
> Whereas the UARTLITE is defined as a 32 bit device and it doesn't show
> up in anywhere near as many designs.  Registers are always 4 bytes
> wide and are always located at multiples of 4 bytes off the base
> address.

Agreed.

> So; starting with your patch and modifying it, I've attached I think
> the change should be.  It should work for microblaze, but I've only
> tested w/ ppc.  Unfortunately the (void*) casts are ugly; there might
> be a way around that, but it's due to the type used for the (struct
> uart_port)->membase variable.

Looks good - boot tested on MicroBlaze 2.6.20

acked-by: John Williams <jwilliams@itee.uq.edu.au>

John

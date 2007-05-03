Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C8F9DDFCC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 11:08:35 +1000 (EST)
Message-ID: <46393609.1010205@itee.uq.edu.au>
Date: Thu, 03 May 2007 11:08:25 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: Peter Korsgaard <peter.korsgaarD@barco.com>
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
References: <4636C836.4050502@itee.uq.edu.au>
	<87647b5ofn.fsf@sleipner.barco.com>
In-Reply-To: <87647b5ofn.fsf@sleipner.barco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

Peter Korsgaard wrote:

> JW> The attached patch gets your uartlite driver going on MicroBlaze.
> 
> Nice!
> 
> JW> All readb/writeb ops are converted to ioread32/iowrite32.
> 
> JW> On MicroBlaze readb/writeb are picking up the MSB, instead of LSB,
> JW> and thus reading all zeros instead of the 8-bit
> JW> control/status/FIFO registers that you intended.
> 
> I take it that the microblaze is big endian? Then you just need to add
> 3 to the base address and everything should work without your patch.

I struggle to see adding 3 to the base address in the platform driver as 
a clean solution.  The base address of the peripheral is 0x10240000, or 
whatever, not 0x10240003.

I understand the reasoning for it, but from the platform's perspective 
it seems wrong.

If you read the opb_uartlite datasheet, it says that bits 0-26 of the 
FIFO, CTRL and STATUS regs are "reserved".  It doesn't say, this is an 
8-bit peripheral that is mapped onto a 32bit bus with a stride of 4.

If you also read page 6 , under address map, it says

BASE_ADDRESS+0 : read from receive FIFO
BASE_ADDRESS+4 : write to transmit FIFO
and so on.

It is a 32-bit peripheral, it just so happens the 24 of those bits are 
currently "reserved".

Grant's recanting may have been triggered by the figure on page 4 of the 
datasheet, which is generic Xilnx IP Core datasheet material explaining 
the endian interpretation for different data widths.

> JW> Can you please confirm if this works on PPC?
> 
> It won't as ioread/write does big/little endian byte swapping. Isn't
> that done on microblaze?

Not presently, but I will fix that.

I think that's Grant's approach of using in/out_be32, and the real base 
address (ie not +3) is the only logically correct solution.

Regards,

John

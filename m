Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 4EEC0DDF7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 23:45:50 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HjF9R-0004IR-0Q
	for linuxppc-embedded@ozlabs.org; Wed, 02 May 2007 15:45:49 +0200
From: Peter Korsgaard <peter.korsgaarD@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
References: <4636C836.4050502@itee.uq.edu.au>
Date: Wed, 02 May 2007 15:45:48 +0200
In-Reply-To: <4636C836.4050502@itee.uq.edu.au> (John Williams's message of
	"Tue, 01 May 2007 14:55:18 +1000")
Message-ID: <87647b5ofn.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "JW" == John Williams <jwilliams@itee.uq.edu.au> writes:

Hi,

JW> The attached patch gets your uartlite driver going on MicroBlaze.

Nice!

JW> All readb/writeb ops are converted to ioread32/iowrite32.

JW> On MicroBlaze readb/writeb are picking up the MSB, instead of LSB,
JW> and thus reading all zeros instead of the 8-bit
JW> control/status/FIFO registers that you intended.

I take it that the microblaze is big endian? Then you just need to add
3 to the base address and everything should work without your patch.

JW> Can you please confirm if this works on PPC?

It won't as ioread/write does big/little endian byte swapping. Isn't
that done on microblaze?

-- 
Bye, Peter Korsgaard

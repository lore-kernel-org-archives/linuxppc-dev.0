Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D15BCDDF3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 16:18:59 +1000 (EST)
Message-ID: <46382D47.1090109@itee.uq.edu.au>
Date: Wed, 02 May 2007 16:18:47 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
References: <4636C836.4050502@itee.uq.edu.au>	
	<528646bc0704302255j3a825f10vbffd4bac961b28d7@mail.gmail.com>	
	<4636E142.8010104@itee.uq.edu.au>
	<528646bc0705012247p4a0fff63oa8d98364d5f639b0@mail.gmail.com>
In-Reply-To: <528646bc0705012247p4a0fff63oa8d98364d5f639b0@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linuxppc-embedded@ozlabs.org
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
> On 5/1/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
> 
>> Grant Likely wrote:
>> > However, the uartlite is *not* an 8250.  The 8250 turns up all over
>> > the place and it's registers are defined as 8 bit wide.  The
>> > offset-by-3 stuff is part of the plat_serial8250_port structure which
>> > is also used to specify .regshift (increment between registers).
>> > Whereas the UARTLITE is defined as a 32 bit device and it doesn't show
>> > up in anywhere near as many designs.  Registers are always 4 bytes
>> > wide and are always located at multiples of 4 bytes off the base
> 
> Hmm, I think I was smoking something last night.  Address used for 8
> bit access should not be affected by CPU endianess.  After David's
> comments, I reread the uartlite documentation.  The current design is
> definately for 32bit OPB bus connections, but it looks like there is a
> posibility for xilinx to add a 16 or 8 bit attachment.  Since the
> uartlite design explicitly supports 8, 16 and 32 bit access, sticking
> with 8 bit io may be the safest.  

To be honest I don't think that will ever happen - just because the OPB 
bus data width is parameterisable, doesn't mean that it actually *works* 
or has been tested on anything other than 32-bits wide.  I've certainly 
never heard of anyone doing so, on either MicroBlaze or PPC.

but, I won't fight over it :)

Either way, it will still require a code change if/when someone does a 
16/8 bit wide OPB bus.  Whether they change the IO access operation, or 
a hardcoded constant, it's still not perfect.

Of course the real solution here is to create an OPB bus driver, with  a 
'width' field that you can pull out of XPAR, and so on... Use that 
instead of platform bus, and all this rubbish can be dealt with cleanly.

> However, I still think the
> application of the 3 byte offset should be done in the driver, and not
> in the platform bus registration.

If it has to be done, I agree the driver is the place to put it.

> I've reworked the patch with the following changes
> - remove 3 byte offset from platform bus registration.
> - added ulite_in/ulite_out macros to make changing bus attachment
> details simpler if xilinx changes the uartlite design.
> - stick with 8 bit IO.

It works fine, however perhaps a comment explaining the +3 offset might 
be appreciated by those who follow.

  > Tested on PPC.  John, can you please test on microblaze?

Acked-by: John Williams <jwilliams@itee.uq.edu.au>

John

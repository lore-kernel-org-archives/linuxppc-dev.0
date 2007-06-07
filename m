Return-Path: <SRS0+8f2be1f524bb961c24bd+1383+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 928FFDDECB
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:06:56 +1000 (EST)
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: David Woodhouse <dwmw2@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <18fbfbaf113ab76b602d279848d9b405@kernel.crashing.org>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
	<548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
	<466323EF.5040807@ru.mvista.com>
	<1181228442.2785.60.camel@pmac.infradead.org>
	<18fbfbaf113ab76b602d279848d9b405@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 17:05:58 +0100
Message-Id: <1181232358.2785.79.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 17:55 +0200, Segher Boessenkool wrote:
> > Any representation of flash devices in the device-tree should ideally
> > have 'bus width' and 'interleave' properties to contain this
> > information.
> >
> > The 'bus width' cannot necessarily be inferred, especially where a 
> > given
> > bus can be configured to allow multiple sizes of access. It's purely a
> > function of how the flash chips are wired up. That's why we actually
> > call it 'bank width', not 'bus width' in the Linux code.
> 
> Ah, "bank width" as in "bus width" per chip select.  I see.
> 
> So I think the best thing to have would be
> 
> 	compatible      "cfi-flash"
> 	bank-width      like you said
> 	device-width    width of a single flash device
> 	reg             complete address range of this thing
> 
> and then the Linux OF CFI flash code / MTD code just keeps
> on probing devices from that address range until it has it
> filled.
> 
> Sounds good / comments / anything I missed?

That seems reasonable. I would personally have used 'interleave' to give
the number of devices interleaved together into the specified
bank-width, rather than specifying device-width. People might get
confused by device-width because many devices can actually be _either_
x16 or x8. But I don't care much. Linux will only be using the
bank-width anyway.

The other thing that might be seen in the 'compatible' property would be
'jedec-flash', and in that case perhaps we also want properties for the
manufacturer and device ident? Linux wouldn't necessarily care about
them, but other operating systems might.

And we also need partition information to get through somehow, in the
cases where the firmware knows it.

-- 
dwmw2

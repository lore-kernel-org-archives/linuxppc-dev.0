Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 6212FDDF91
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 23:59:35 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HjFMj-00054b-7X
	for linuxppc-embedded@ozlabs.org; Wed, 02 May 2007 15:59:33 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
References: <4636C836.4050502@itee.uq.edu.au>
	<528646bc0704302255j3a825f10vbffd4bac961b28d7@mail.gmail.com>
Date: Wed, 02 May 2007 15:59:33 +0200
In-Reply-To: <528646bc0704302255j3a825f10vbffd4bac961b28d7@mail.gmail.com>
	(Grant Likely's message of "Mon, 30 Apr 2007 23:55:52 -0600")
Message-ID: <871whz5nsq.fsf@sleipner.barco.com>
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

>>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

>> Can you please confirm if this works on PPC?

GL> Yes, I've confirmed this does work on PPC; but I don't think it's
GL> quite the correct fix.

GL> ioread/write32 is mapped to in/out_le32, yet the bootloader driver
GL> must use in/out_be32.  This is because the uartlite driver follows
GL> the lead of 8250 and requires an offset of 3 from the base address
GL> in order to find the relevant byte wise address.  In fact, I
GL> believe the driver should work as-is on microblaze if the
GL> offset-by-3 is not used when registering it to the platform bus.

Not used? Isn't the microblaze big endian as well?

GL> However, the uartlite is *not* an 8250.  The 8250 turns up all
GL> over the place and it's registers are defined as 8 bit wide.  The
GL> offset-by-3 stuff is part of the plat_serial8250_port structure
GL> which is also used to specify .regshift (increment between
GL> registers).  Whereas the UARTLITE is defined as a 32 bit device
GL> and it doesn't show up in anywhere near as many designs.
GL> Registers are always 4 bytes wide and are always located at
GL> multiples of 4 bytes off the base address.

Well, yes and no - The registers physically contains 8 bit of
information, but are commonly located on the 32bit opb bus.

GL> The biggest problem with keeping the 3 byte offset and using
GL> ioread/write32 on it makes every register access straddle a 32-bit
GL> boundary.  This means 2 bus transactions for every register
GL> access.  Absolutely not what we want.

Exactly.

GL> The problem with keeping the byte-wise access as it is now is that
GL> it means the platform bus binding needs to explicitly know what
GL> the host access width is and add the 3 byte offset accordingly
GL> (rather than using the base address as specified in xparameters
GL> unmodified and using the in/out_be32 macro take care of reading it
GL> correctly & efficiently).

I don't think that's a big problem. Other reasons for using 8bit I/O
are:

- No endianness problems (besides setting the proper base
  address). "There's no read/write register in native endianness"
  interface in the kernel. readl is always little endian, and _be32
  would be wrong/not available on all archs. The uartlite interface is
  nice and simple - Who knows if someone would add a FPGA with a bunch
  of uartlite's to an ARM/MIPS/whatever design?

- No bus width problems. We have designs which needed extra uarts late
  in the design, and have implemented uartlite compatible firmware in
  a SP3e FPGA connected over a 16bit bus (EMC). The uartlite driver
  works nicely with that as it is. With 32bit access you would double
  the bus transactions.

- It matches 8250.c

GL> (There are also annoyances that will come up when we move to
GL> arch/powerpc and hook it up to the of_platform_bus)

Ohh, like what?

>> I note that Grant's recent bootloader driver uses in_be32/out_be32
>> - would you prefer that instead of ioread32/iowrite32?

GL> I certainly think so.  The device is documented as using 32 bit BE
GL> registers; so the driver should access them as 32bit BE registers
GL> IMHO.  Or at least, if there is a good reason to continue the
GL> bytewise access, then the driver should contain the smarts to
GL> translate from documented base address to the appropriate offset.

How should it be able to do that? Using some magic #ifdef to know if
it's compiled for a big endian arch and do a +3? That seems ugly to
me.

In other words - I disagree.

-- 
Bye, Peter Korsgaard

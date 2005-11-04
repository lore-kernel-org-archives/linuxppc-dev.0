Return-Path: <jarno.manninen@tut.fi>
Received: from kivi.ton.tut.fi (kivi.ton.tut.fi [193.166.235.14])
	by ozlabs.org (Postfix) with ESMTP id 11BF568678
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 15:53:04 +1100 (EST)
Received: from b34.paawola.ton.tut.fi ([195.148.75.85])
	by kivi.ton.tut.fi with esmtp (Exim 3.35 #1 (Debian))
	id 1EXtHL-0004ms-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 04 Nov 2005 06:34:15 +0200
From: Jarno Manninen <jarno.manninen@tut.fi>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 4 Nov 2005 06:34:15 +0200
References: <47F3F98010FF784EBEE6526EAAB078D1C05E6C@tq-mailsrv.tq-net.de>
In-Reply-To: <47F3F98010FF784EBEE6526EAAB078D1C05E6C@tq-mailsrv.tq-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511040634.15623.jarno.manninen@tut.fi>
Subject: Re: SM501 Frame Buffer driver on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 03 November 2005 16:16, Martin Krause wrote:
> Mark Chambers wrote on Thursday, November 03, 2005 3:06 PM:
> > > The endianess on PCI on ppc is still an issue (I haven't
> > > investigated this problem further during the last month).
> >
> > There really shouldn't be an endian issue on SM501 since registers are
> > 32 bit.  What we do have is the 5200 that does byte swapping on PCI
> > for no good reason (IMHO)

Actually the 5200 does _not_ change the order of bytes written on the PCI bus, 
but just the bytelanes. Why? Consider this. We have two mapped entities and 
some data in system memory.

	struct something {
		char 1;
		char 2;
		char 3;
		char 4;
	};

	/* Mapped memory from PCI bus */
	struct something *device_memory;
	uint32_t *device_register;

	/* And local data */
	struct something system_memory = { 0x11, 0x22, 0x33, 0x44 };
	uint32_t value = 0x11223344;

And we transfer data from system memory to PCI device.

	memcpy(device_memory, &system_memory, sizeof(struct something));
	*device_register = value;

These both would create 32-bit access to the PCI device( I suppose :), but if 
we just blindly swap or don't swap written bytes the result is mess:

					Swapping
Item		With 						Without
struct	{ 0x44, 0x33, 0x22, 0x11 }	{ 0x11, 0x22, 0x33, 0x44 }
integer	0x44331100				0x11223344
Result	Integer OK				Struct OK
		Struct messed				Integer messed

So the actual problem is that there is no feasible way to determine if a 
access of given width needs to be swapped on the "bus-level". So basically it 
is left to user to decide when the swapping is needed. But of course this can 
be taken care on the device level with clever planning.

I hope I didn't get it all too wrong. :)

> We experienced a byte swapping issue on the SM501, too, although it
> is connected via the local plus bus with the MPC5200 and not via PCI
> bus.
>
> In 16 bpp mode bytes appear to be swapped in a very ugly way.
> Unfortunately we have no explanation for this, nor a real
> workaround.

Yes, the byteswap implementation on SMI-chips is quite braindead. They have
	
Input	1234
Swap1	4321
Swap2	3412

When what we really need is:

Swap	2143

IMHO the easiest way is to use 24-bit mode that can be usually handled only by 
changing the byte-offsets.

- Jarno

Date: Mon, 29 Jul 2002 10:00:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial core problems on embedded PPC
Message-ID: <20020729100009.A23843@flint.arm.linux.org.uk>
References: <20020729040824.GA2351@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020729040824.GA2351@zax>; from david@gibson.dropbear.id.au on Mon, Jul 29, 2002 at 02:08:24PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 29, 2002 at 02:08:24PM +1000, David Gibson wrote:
> I've been trying to get the new serial core stuff working on a PPC 4xx
> machine (an EP405 board, specifically).  This is proving more
> difficult than I expected.

It's vital that you mention the kernel version you're using; some of
these problems sound like 2.5.28.

> In 8250.c, it appears that in order for a port to be used for the
> serial console it must be defined "old style" with SERIAL_PORT_DFNS,
> rather than being registered with register_serial() (because
> serial8250_console_setup() indexs into the serial8250_ports array)).
> This presents a small problem for 4xx, since it's serial ports are
> memory mapped and the new old_serial_port structure can't represent
> these.

There is no easy solution for this.  Alan said we must not drop support
for serial console initialisation early on in the kernel setup, which
means before the memory subsystems are initialised.

> I added support for these into 8250.c, but ran into further troubles.

I suspect a 2.5.28 kernel; please confirm and we'll that it from there.

> The current plethora of similar-but-not-the-same structures describing
> serial ports (serial_state, serial_struct, uart_port, old_serial_port)
> is also rather confusing.  I'm guessing some of these are deprecated
> and remain only as an aid to transition, but I'm not sure which.

I don't see there being an easy way to kill this off:

1. serial_struct is a userspace API.
2. old_serial_port glues asm/serial.h into 8250.c; asm/serial.h can't be
   changed because (mainly) ppc uses it elsewhere.  Other architectures
   seem to do the same sort of thing.

Unless ppc and others are willing to put up with major breakage when I
change asm/serial.h, I don't see this getting cleaned up.  Comments on
this area welcome.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

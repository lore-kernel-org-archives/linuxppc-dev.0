Date: Fri, 25 Oct 2002 18:41:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Changes I would like to get into the 2_4_devel
Message-ID: <20021026014122.GE30713@opus.bloom.county>
References: <86C2D453-E83F-11D6-A4F1-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86C2D453-E83F-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 25, 2002 at 07:30:59PM +0200, Anders Blomdell wrote:

> Where do I send a request of the following changes to linuxppc_2_4_devel:
>
> in arch/ppc/Makefile:
>   add -D__powerpc__ to CPPFLAGS and CFLAGS (just like it is on  kernel.org)
>     This makes drivers/char/serial.c compile correctly (no more 5 bit
>     characters)
>
> in Makefile:
>   add -D__linux__ to CPPFLAGS
>     This makes coda.h compile correctly (u_quad_t)

As Hollis has pointed out as well, it is very odd that you cannot get a
compiler which correctly defines __linux__ and __powerpc__.  You are
creating a powerpc-linux cross compiler correct, and not powerpc-eabi or
some other incantation?

> in arch/ppc/kernel/i8259.c:
>   Some way to set
>     pci_intack = 0;
>   if we are running on a MVME 2400/2600, since the PIB (PCI-to-ISA Bridge)
>  does
>   not support anything but polling of the 8229 pair.

This is an issue since you're running the MVME 2400/2600 under
CONFIG_ALL_PPC, yes?  Can you verify that in _devel, CONFIG_PPLUS works
on these boards, as from what I recall it should.  As for fixing
CONFIG_ALL_PPC, what I intend to do is add a check to verify the bridge
and then set the intack occordingly.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

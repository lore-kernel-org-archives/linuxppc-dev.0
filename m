Message-ID: <392E4B8B.E3C70B27@agelectronics.co.uk>
Date: Fri, 26 May 2000 11:01:47 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <Pine.BSF.4.21.0005251319150.9249-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:

> BTW, VxWorks can not easily handle more than 32 MBytes of local RAM
> as the eabi specification (as a result of the PowerPC architecure)
> rules for 26 bit (signed) relative addressing. Hence, I will design
> in exactly 32 MBytes of soldered low power SDRAM on UPMA and assign
> UPMB to a DIMM socket. How does PPC/Linux handle this addressing
> problem?

The current release of VxWorks is prepared to use a long jump sequence
to jump to a 32 bit address. Tornado 2 out of the box has worked fine
for me on a 128MByte 7400.

The problem only ever occurs when your code occupies an address range
greater than 32MBytes. VxWorks doesn't support virtual addressing
without some add-ons. It always placed the kernel at the bottom of
memory and dynamically loaded code at the top, so that calls from the
dynamically loaded code into the kernel had offsets that couldn't fit in
a relative branch.

Linux, however, never had this problem. Linux uses virtual memory, which
keeps the application within a smaller address range.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

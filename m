Message-ID: <001a01c1e2cf$a36e3160$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "Krzysztof Jankowski" <kjankow@poczta.onet.pl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3CB6B3D7.8030007@poczta.onet.pl>
Subject: Re: early stage boot progress indication
Date: Sat, 13 Apr 2002 05:43:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Krzysztof ,

> I know that at this stage kernel's addresses were remapped
> from 0x0000xxxx to 0xc000xxxx (am I right?) due MMU being enabled by

Yes, you are right.

> 'turn_on_mmu'. So I remapped UART's memory space by 'io_block_mapping' - but
this
> didn't help.

You need to map this IO above the kernel.  Mine was mapped at 0xEC00_0000.
I was advised to use ioremap instead of io_block_mapping (which limits the
kernels
mapping ability later on.)

>
> What's going on ? Why I'm not seeing characters now ? Did the kernel hang
> somewhere in the middle or am I tottaly wrong in the early debugging idea ?
>

You are not wrong.  I did the exact same thing, however, it took some debugging
to get it to work.  The kernel probably hung because you have a memory access
violation from the MMU.  You can tell by looking in the log_buf area of memory
(you need a jtag debugger to do that.)  It will give you the location you were
running
in when the violation occurred, the address you tried to access and all the ppc
registers.  It's very nice if you can get to it.

Greg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

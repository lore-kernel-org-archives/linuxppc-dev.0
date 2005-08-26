Return-Path: <psadik@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.205])
	by ozlabs.org (Postfix) with ESMTP id D9DDB6806F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 11:38:29 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so637724rne
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 18:38:28 -0700 (PDT)
Message-ID: <ea43f4f9050825183121655ba2@mail.gmail.com>
Date: Thu, 25 Aug 2005 18:31:22 -0700
From: "P. Sadik" <psadik@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Address mapping PPC 405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

  I have a question on how PPC addressing works. I am familiar with
the MIPS architecture and new to PPC.

  On MIPS, there are KUSEG (0x0000_0000 to 0x07FF_FFFF)
which is always translated using TLB. Then there are two
un-translated areas KSEG0 (0x8000_0000 which is cached)
and KSEG1 (0xA000_0000).

  Hence, the kernel is compiled with .text at 0x8000_0000. For kernel
itself, the TLB is never consulted. All the local peripherals will be mappe=
d to=20
0xA000_0000. That means, from kernel, if I have to access a register of any=
=20
peripheral, I can use the un-mapped address and everything will work.

 On PPC I see that, the kernel .text is at 0xC000_0000. Is it a=20
translated address? If it is, for running kernel code, the CPU has to
consult the TLB always?

 Another question is regarding addressing local peripherals. I am using
an ML310 board from Xilinx and it has DDR mapped to 0x0000_0000
to 0x0FFF_FFFF (256 MB). Now, I need to add an IP to the PLB.
For that, I am thinking of using 0x2000_0000 to 0x2000_0FFF.
Now, my driver need to access the registers within the above region.
How will I do that? It is an I/O, hence should I use ioremap, or can
I access it directly? What role cache will play in this case?

 The third question is, can I use de-referencing of address. Is it O.K
to use pointers to access the registers, or do I have to use read/write
variants?=20

  I would appreciate a lot if you could give some insight into this. Any
pointers or reading materials will be very helpful.

Thanks and regards,

Sadik.

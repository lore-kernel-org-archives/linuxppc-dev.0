Message-ID: <393D5CB0.448D6235@embeddededge.com>
Date: Tue, 06 Jun 2000 16:18:56 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel crashes at InstructionTLBMiss
References: <00Jun4.144038est.115228@border.alcanet.com.au>
	 <393BBE5D.49B17E9C@embeddededge.com> <00Jun6.135659est.115272@border.alcanet.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel Wu wrote:

> The reason why I changed the address was because my uncompressed kernel is
> about 1.3M. This means if I load at 0x100000 (the default), then the board data
> gets trashed

Yes, but just move it up a little.  I know you are running the 2.2.xx
kernel, and in the 2.3/2.4 kernel I moved this to 0x180000, which is
the only change necessary.

> .... I realised that the M_TWB was not initialised
> properly in the first place!

I would believe this in a 2.3.xx kernel, but not 2.2......

> ... Anyway, I'm thinking of starting from scratch with
> the kernel and patches at the MontaVista site.

Please do.  I know that runs on many platforms.

> Unfortunately, if you get no output, BDM is the _only_ option you have - at
> least it will give you some details of the registers, although you can't step
> through code die to the virtual addresses.

A good boot rom is a better debugging tool than a BDM.  The BDM is only
useful for the first few instructions of the kernel.  Dumping out key
kernel data structures is more useful than the contents of registers
at the time a BDM catches a trap.

Porting to a new 8xx board is almost a no brainer with the MontaVista
2.2.13 and later kernels.  All you need to do is properly set the IMMR
and the processor clock speed in the board information structure.  Any
board will boot far enough to get console output and attach KGDB or XMON.
When you start changing lots of code before this point, you are just
asking for trouble.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

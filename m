Message-ID: <3905D070.8A880F05@embeddededge.com>
Date: Tue, 25 Apr 2000 13:05:52 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: zzh <david-1z@263.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory map
References: <39056609.13496@mta2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zzh wrote:

> this should be done as early as possible unless want to set or copy those values again from old to new.

I am going to continue to insist there is lots of processor set up
that must occur before a Linux kernel is started.  The Linux kernel
really should assume some standard entry conditions, and gather some
information necessary for operation, then be on its way.

When I write boot roms for custom boards, all of the processor
initialization is complete and the code builds a board descriptor
structure.  It passes this to the Linux start up code.  The functions
in arch/ppc/mbxboot (the embedded start up) should do minimal set up,
relocate and uncompress the kernel image (like the MBX example).

You have to write all of the processor initialization code in any
case, and I find it reduces the development time if you just create
a small boot rom with a debugger.  You can then use the Linux kernel
software with minimal changes and significantly reduce the turn around
time for images that just test the processor initialization.


> ADS manual say this should be 0x0470-0000 with no obvious reason.

It's historical and part of the package.  Just change the memory
controller values to suit you (Linux) environment.

> I choose to map it to 0xf000-0000 with  BAT.

That's a good choice, then make the memory controller address the BCSR
up in that range as well.  Cover everything with one BAT.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

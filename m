From: "Tameen Khan" <tameen@cisco.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Physical Memory map holes in PPC
Date: Thu, 22 Apr 2004 21:26:41 -0700
Message-ID: <00b001c428eb$2d8ae740$273147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am porting Linux kernel Core dumps (LKCD) to PPC platform (440GX).
Need to figure out if there are holes in Pysical memory map for PPC
architecture, and if yes where are they defined.

For example the equivalent funtion for i386 architecture is page_is_ram()
defined in arch/i386/mm/init.c. It uses the e820 memory map, which is
initialized by the setup code in setup.S ( or it is faked to contain 2
regions 0->640K and 1M ->appropriate_end.... So there's at least a memory
hole from 640K -> 1MB)

I have looked through the boot memory allocator code for PPC and I dont find
a similar memory map. They use a phys_avail array for boot memory allocation
which is initialized to a single region from PPC_MEMSTART to total_memory.
>From this it appears that there are no "holes" in physical memory map for
PPC.

Am I right ??
Any input will be appreciated

Thanks
Tameen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

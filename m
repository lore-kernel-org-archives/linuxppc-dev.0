MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Caching problems using UART driver on custom MPC8260 board
Date: Thu, 23 Oct 2003 19:10:35 +0100
Message-ID: <DEF39A0710293E489D45B10E06645CBD02671352@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am using PPC Linux version 2.4.20 on a MPC8260 based custom board, using U-boot 0.4.5 as a bootloader.

I am having some problems using the CPM drivers, which I am inclined to think that could be due to the fact that the kernel memory in cache enabled.

I am modified the uart driver in order to suit the CPM SCC4 port, which is used as a UART on this board.
The UART driver seems to use m8260_cpm_dpalloc function to allocate memory from DPRAM (DBAT0 - cache is disabled), for the buffer descriptors, and use m8260_cpm_hostalloc function to allocate system memory (DBAT2 - cache is enabled) for the data buffers.

I tried to use the driver in this way, but it did not work. I got a series of blank cahracters on the terminal, and when I looked at the TX data with a scope, I saw that the data was always the same, even though the characters were being copied to the exact memory location where the buffer descriptor cbd_bufaddr was set to. i.e. __va(bdp->cdb_bufaddr).

I then, taking as a reference the CPM SPI driver, tried to call flush_dcache_range() with the data buffer range, just before setting the BD_SC_READY bit on bdp->cdb_sc.

This seemed to resolve the problem for the UART driver, but now I am confronted with the fact that the FCC driver uses m8260_cpm_hostalloc for both Buffer Descriptors and data buffers.
I see that this driver is widely used by a series of standard boards, and invalidating cache after writing to Buffer Descriptor and after writing onto data buffers seems a bit over the top.

I also tried to disable cashing on DBAT2 to see if I could use the UART and FCC drivers, but I did not get any output on the console.

I try to find threads with similar problems as the one I am getting here, but I did not seem to find any relevant ones for this particular problem, which is leading me to think that I might be missing something here.

Should I allocate a section of memory into another DBAT with non caching attribute, to be used with hardware ?
Is there another trick to bypass caching for a particular section of memory allocated ?

I would appreciate any suggestions regarding this

Best regards

Joao Vicente

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

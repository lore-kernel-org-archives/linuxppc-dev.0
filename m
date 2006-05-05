Return-Path: <argie_guinto@yahoo.com>
Received: from web33107.mail.mud.yahoo.com (web33107.mail.mud.yahoo.com
	[68.142.206.88]) by ozlabs.org (Postfix) with SMTP id 51E64679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 18:25:26 +1000 (EST)
Message-ID: <20060505081845.43360.qmail@web33107.mail.mud.yahoo.com>
Date: Fri, 5 May 2006 01:18:45 -0700 (PDT)
From: Richard Guinto <argie_guinto@yahoo.com>
Subject: Bad page state in process 'swapper'
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: argie_guinto@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm quoting here Grant's answer:

*****************************************

On 4/11/06, Vincent Winstead <vwinstead at yahoo.com>
wrote:
>
> I'm having a real difficulty trying to get linux
onto this board.  So I'm
> finally turning to the community for help.  The only
people that have
> documented their approach to putting open source
linux onto the ML310 board
> have used bitkeeper to download the kernel for the
project, but bitkeeper
> isn't used any more is it?  I've been going straight
to kernel.org and
> getting kernels from there and crosscompiling them
on my machine to be
> transported to the ppc core on the ML310.  Is this
wrong?  Is there a patch
> or some kernel source that I don't know about for
PPC?  Thanks!

Are you using 2.4 or 2.6?

Support for the ML300 & ML403 is in the mainline 2.6
git tree.  As
long as you've got an xparameters.h file for your FPGA
bitstream,  you
should be able to port a 2.6 kernel really easily.

If you want to use 2.4, you can pull the linuxppc
rsync mirror which
has ML300 support in it.

http://www.penguinppc.org/kernel/  (Look at the very
bottom of the
page for the RSYNC mirror)

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195



*****************************************************





After changing the xparameters.h, I was able to boot
with the 2.6.16.13 kernel, which I got from
kernel.org, but then I'm having a "bad page" problem
as shown in the output below:





loaded at:     00400000 006011A0
board data at: 005FF124 005FF1A0
relocated to:  004051B4 00405230
zimage at:     0040592D 00495B48
initrd at:     00496000 005FEE44
avail ram:     00602000 04000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.16.13 (root@rgdev) (gcc version
3.4.1) #19 Fri May 5 13:39:53 PHT 2006
Xilinx Virtex-II Pro port
Port by MontaVista Software, Inc. (source@mvista.com)
Built 1 zonelists
Kernel command line: console=ttyS0,9600
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
PID hash table entries: 512 (order: 9, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 62060k available (908k kernel code, 364k data,
64k init, 0k highmem)
Bad page state in process 'swapper'
page:c01539c0 flags:0x00000080 mapping:00000000
mapcount:0 count:1
Trying to fix it up, but a reboot is needed
Backtrace:
Call Trace:
[C012DDF0] [C00094B4] show_stack+0x58/0x180
(unreliable)
[C012DE20] [C00452EC] bad_page+0x5c/0xa0
[C012DE40] [C0045DD0]
get_page_from_freelist+0x2cc/0x454
[C012DE90] [C0045FAC] __alloc_pages+0x54/0x278
[C012DED0] [C005869C] cache_alloc_refill+0x2e0/0x53c
[C012DF10] [C0058398] kmem_cache_alloc+0x50/0x74
[C012DF30] [C00594A8] kmem_cache_create+0x3a0/0x508
[C012DFA0] [C013846C] kmem_cache_init+0x180/0x3a0
[C012DFD0] [C012E5E4] start_kernel+0x138/0x1a4
[C012DFF0] [C000225C] start_here+0x44/0xb0



Now, I tried to debug the functions in the call trace,
and it seems that the prep_new_page function calls the
bad_page because the test for page_count(page) != 0 is
TRUE (count value is 1).


I know that the hardware or the memory is working
because I have 2.4.20 running.  What could probably
cause this problem?  Is there a patch for ml300
available to fix this?



Many thanks!!!

*
Richard


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

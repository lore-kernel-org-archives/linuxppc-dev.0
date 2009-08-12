Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 535F3B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 08:15:34 +1000 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 12 Aug 2009 16:11:54 -0600
Subject: Jumbo Frames, sil24 SATA driver, and kswapd0 page allocation failures
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F01FE4C90DE@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I am having some issues with my target and was hoping that someone could le=
nd a hand.  I am using an AMCC 405EX (Kilauea) board running Linux kernel 2=
.6.31.

Here is the problem.  I have some code that receives jumbo frames via the E=
MAC, sticks the data in a buffer, and writes the data out to a solid-state =
SATA disk (using a Silicon Image 3531 controller).

What is happening is that I appear to be running out of memory and I cannot=
 figure out why.  The closest thing I can tell is that the sil24 driver for=
 the SATA controller does not seem to be releasing memory back to the kerne=
l for some reason.  After some time of capturing data and logging it to dis=
k, I get the following kernel dump:

kswapd0: page allocation failure. order:2, mode:0x4020 Call Trace:
[cfaa19a0] [c0006ef0] show_stack+0x44/0x16c (unreliable) [cfaa19e0] [c006f5=
e4] __alloc_pages_nodemask+0x38c/0x4f8
[cfaa1a60] [c006f770] __get_free_pages+0x20/0x50 [cfaa1a70] [c00955d4] __km=
alloc_track_caller+0xcc/0xf0 [cfaa1a90] [c01c437c] __alloc_skb+0x60/0x140 [=
cfaa1ab0] [c01a319c] emac_poll_rx+0x46c/0x7e4 [cfaa1af0] [c019e85c] mal_pol=
l+0xa8/0x1ec [cfaa1b20] [c01cfddc] net_rx_action+0x9c/0x1b4 [cfaa1b50] [c00=
3b3a8] __do_softirq+0xc4/0x148 [cfaa1b90] [c0004d18] do_softirq+0x78/0x80 [=
cfaa1ba0] [c003af94] irq_exit+0x64/0x7c [cfaa1bb0] [c0005210] do_IRQ+0x9c/0=
xb4 [cfaa1bd0] [c000fa7c] ret_from_except+0x0/0x18 [cfaa1c90] [c0094dc4] km=
em_cache_free+0x74/0xcc [cfaa1cb0] [c00c0570] free_buffer_head+0x38/0x84 [c=
faa1cc0] [c00c0b8c] try_to_free_buffers+0x94/0xe0 [cfaa1cf0] [c0067e70] try=
_to_release_page+0x6c/0x84 [cfaa1d00] [c0075f58] shrink_page_list+0x648/0x8=
18 [cfaa1de0] [c0076620] shrink_zone+0x4f8/0xac4 [cfaa1f00] [c0077294] kswa=
pd+0x4a0/0x4bc [cfaa1fc0] [c004d6d8] kthread+0x70/0x74 [cfaa1ff0] [c000f220=
] kernel_thread+0x4c/0x68
Mem-Info:
DMA per-cpu:
CPU    0: hi:   90, btch:  15 usd:  54
Active_anon:5155 active_file:626 inactive_anon:5216
 inactive_file:42474 unevictable:0 dirty:176 writeback:0 unstable:0
 free:631 slab:6416 mapped:324 pagetables:32 bounce:0 DMA free:2524kB min:2=
036kB low:2544kB high:3052kB active_anon:20620kB inactive_anon:20864kB acti=
ve_file:2504kB inactive_file:169896kB unevictable:0kB present:260096kB page=
s_scanned:64 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 345*4kB 119*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB =
0*2048kB 0*4096kB =3D 2524kB
43129 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0 Free swap  =3D 0kB Total swap =
=3D 0kB
65536 pages RAM
1397 pages reserved
43434 pages shared
20347 pages non-shared

I am not sure what is causing this.  It only happens when I run both the ne=
twork and the SATA disk at the same time.  If I only capture data on the EM=
AC, things work just fine (I ran the system overnight, capturing data at 36=
Mbytes/s without even a hiccup).  If I only write data to disk, things seem=
 to work fine.  But when I combine the two, then things go crazy.

Here is the loop:

for(;;)
{
	if( datalength + 9000 > 16*1024*1024 )
	{
		write(fd, (char*)&rxBuf[count][0], dataLength);
		fsync(fd);
		wrBytes +=3D dataLength;
		dataLength =3D 0;

		count =3D (count+1)%RXCNT;
	}

	bytes =3D recvfrom(sock.socket,(char*)&rxBuf[count][dataLength],
		MTUSIZE, (int)NULL, NULL, NULL);

	rxBytes +=3D bytes;
	dataLength +=3D bytes;

	sched_yield();

} /* for(;;) */

A pretty simple loop to receive the data, place it into a buffer, and write=
 it to disk when ready.

What is it about the write call that would not release memory?

Any ideas?  Has anyone seen this type of behavior before?

Thanks!

Jonathan

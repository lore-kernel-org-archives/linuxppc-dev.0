Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw3.extranet.thmulti.com (dmzraw3.extranet.thmulti.com
	[141.11.234.71]) by ozlabs.org (Postfix) with ESMTP id 77028DDF06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 01:42:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC5200B memory performance
Date: Tue, 15 May 2007 17:14:11 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D0@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Daniel Schnell" <daniel.schnell@marel.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Schnell wrote:
>With the attached program (compile with -lrt) I am testing the memcpy()
>throughput. In theory the memory throughput should be the double of the
>memcpy() throughput if source and destination buffers are same size and
>inside the DDR-RAM.

Theory tells that write speed is a little bit different than read speed,
but that's when you want to be picky. RTFD(*).
(*) Datasheets

>So one could make the simple calculation:
>
>132 MHz * 32 Bit (address width) * 2 (DDR) ~ 1GBytes/sec brutto memory
throughput.
>
>For a memcpy this should be then ~500MB/second.

All you can say is, assuming 100% efficient
CPU/cache/bus/DDR-controller,=20
you can say that memcpy (hitting the DRAM) cannot be higher than that=20
value :-)

>Of course in real world scenarios we cannot reach the theoretical
limit,
>but be about 30 % near I guess.

IMO, real world scenarios *should* achieve at least 70%, with
appropriate
memcpy implementation. I've been disappointed lately by PQ3 which cannot
do better than ~50% efficiency. I'd love anyone, esp. from Freescale,
to prove me wrong or show my mistake. The FAE didn't give an answer,=20
but I saw that newer parts will have a "Queue manager" helping=20
the DDR controller. Any idea?

[...]
>The first 4 values are because of the data cache. So here we are
testing

What's your data cache size BTW? Do you have a L2 cache?

>cache performance. All other values will test the memory controller
>interface.

Well, you're testing also part of the cache and memory subsystem.
On the read side, you're paying an extra for cache misses. On the write
side,
there's read-on-write. I don't know the mpc5200 details, but most cache=20
subsystems think it's smart to fill-up (read) end of line you began
to write. But in the big memcpy case, the read is useless because=20
the cache didn't know you were about to overwrite the full line.=20
That's why the dcbz ppc instruction comes in handy to prevent the R-O-W.

In that regard, glibc is very suboptimal. For better performance,
I recommend you to read and understand the cacheable_memcpy assembly
function in Linux kernel (arch/ppc/lib/string.S). It's missing
some read prefetch (dcbt) though.

>All in all, I am not sure, why the memory access is so much slower than
I expected.
>Which factors did I miss in my calculation ? Can anybody run this
>program on its 5200B based board as a comparision ?

The values on PQ3 won't be of any help for you, esp. with disappointing
result (50% efficiency max). If you doubt about your memcpy
implementation,
you may implement the same bench with DMA (to get 50MiB of contiguous
RAM,
do it in kernel or under U-Boot).=20

Best Regards,
--=20
Stephane

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54C3A679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 18:39:38 +1100 (EST)
In-Reply-To: <20060329064551.29548.qmail@web25913.mail.ukl.yahoo.com>
References: <20060329064551.29548.qmail@web25913.mail.ukl.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <77C1FC46-AF49-4807-9AC4-C3DC448F79BF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: linux-2.6-rt patch on ppc and OOM messages
Date: Wed, 29 Mar 2006 01:39:42 -0600
To: emre kara <emrekara2002@yahoo.co.uk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 29, 2006, at 12:45 AM, emre kara wrote:

> Dear All,
> Is Ingo Molnar's realtime-preempt patch compatible
> with ppc, or is there any work on a porting effort of
> this patch ? I have made some tests on a 85xx machine
> with this patch, under heavy load on ethernet
> interfaces, thw system prints OOM messages on console
> and hangs..
> Thanks.

Can you try setting the gfar interrupts to SA_INTERRUPT and see what =20
happens.

- k

> --------------------------console output-----
> softirq-net-rx/: page allocation failure. order:0,
> mode:0x20
> Call Trace:
> [C04E3DB0] [C000A60C] show_stack+0x50/0x188
> (unreliable)
> [C04E3DE0] [C004C3EC] __alloc_pages+0x1c8/0x2a4
> [C04E3E30] [C0063C90] cache_alloc_refill+0x35c/0x57c
> [C04E3E80] [C0063FA4] __kmalloc+0xf4/0xfc
> [C04E3EB0] [C012D460] __alloc_skb+0x58/0x118
> [C04E3ED0] [C011AF20] gfar_new_skb+0x40/0xd4
> [C04E3EF0] [C011D320] gfar_clean_rx_ring+0x25c/0x634
> [C04E3F30] [C011D72C] gfar_poll+0x34/0x140
> [C04E3F50] [C013364C] net_rx_action+0x94/0x188
> [C04E3F80] [C0026730] ksoftirqd+0x104/0x1b4
> [C04E3FC0] [C003779C] kthread+0xf8/0x100
> [C04E3FF0] [C0004DB8] kernel_thread+0x44/0x60
> Mem-info:
> DMA per-cpu:
> cpu 0 hot: high 90, batch 15 used:0
> cpu 0 cold: high 30, batch 7 used:0
> DMA32 per-cpu: empty
> Normal per-cpu: empty
> HighMem per-cpu: empty
> Free pages:         768kB (0kB HighMem)
> Active:1650 inactive:2036 dirty:0 writeback:0
> unstable:0 free:192
> slab:60106 mapped:764 pagetables:29
> DMA free:768kB min:2048kB low:2560kB high:3072kB
> active:6600kB
> inactive:8144kB present:262144kB pages_scanned:0
> all_unreclaimab
> le? no
> lowmem_reserve[]: 0 0 0 0
> DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB
> inactive:0kB
> present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> Normal free:0kB min:0kB low:0kB high:0kB active:0kB
> inactive:0kB
> present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> HighMem free:0kB min:128kB low:128kB high:128kB
> active:0kB
> inactive:0kB present:0kB pages_scanned:0
> all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB
> 1*512kB 0*1024kB
> 0*2048kB 0*4096kB =3D 768kB
> DMA32: empty
> Normal: empty
> HighMem: empty
> Swap cache: add 0, delete 0, find 0/0, race 0+0
> Free swap  =3D 0kB
> Total swap =3D 0kB
> Free swap:            0kB
> 65536 pages of RAM
> 0 pages of HIGHMEM
> 662 free pages
> 1180 reserved pages
> 1249 pages shared
> 0 pages swap cached
> printk: 2159030 messages suppressed.
>
>
>
> 	=09
> ___________________________________________________________
> Yahoo! Photos =96 NEW, now offering a quality print service from just =20=

> 8p a photo http://uk.photos.yahoo.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

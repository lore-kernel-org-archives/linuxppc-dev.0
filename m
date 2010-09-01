Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from echo.usurf.usu.edu (unknown [129.123.194.129])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "echo", Issuer "echo" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7C6F3B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 08:49:31 +1000 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-net@vger.kernel.org"
	<linux-net@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: Memory allocation modifications in ibm_newemac driver
Date: Wed, 1 Sep 2010 22:46:42 +0000
Message-ID: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A305B@Mercury.usurf.usu.edu>
References: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2F09@Mercury.usurf.usu.edu>,
	<5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2FBE@Mercury.usurf.usu.edu>,
	<5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A301B@Mercury.usurf.usu.edu>
In-Reply-To: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A301B@Mercury.usurf.usu.edu>
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

Apparently I spoke too soon - sorry about that.  I am still getting the err=
or when I try to write to disk and receive on the network at the same time.=
  Here is the output:=0A=
=0A=
blastee: page allocation failure. order:1, mode:0x4020=0A=
Call Trace:=0A=
[ccea9a40] [c0006ef0] show_stack+0x44/0x16c (unreliable)=0A=
[ccea9a80] [c006f9f0] __alloc_pages_nodemask+0x38c/0x4f8=0A=
[ccea9b00] [c0095008] __slab_alloc+0x594/0x5e0=0A=
[ccea9b40] [c0095a08] __kmalloc_track_caller+0xe8/0xf0=0A=
[ccea9b60] [c01c848c] __alloc_skb+0x60/0x140=0A=
[ccea9b80] [c01a7df8] emac_poll_rx+0x568/0x768=0A=
[ccea9bc0] [c01a28e4] mal_poll+0xa8/0x1ec=0A=
[ccea9bf0] [c01d3eec] net_rx_action+0x9c/0x1b4=0A=
[ccea9c20] [c003b3c0] __do_softirq+0xc4/0x148=0A=
[ccea9c60] [c0004d18] do_softirq+0x78/0x80=0A=
[ccea9c70] [c003b67c] local_bh_enable+0xc0/0xd8=0A=
[ccea9c80] [c01c29bc] lock_sock_nested+0xc0/0xdc=0A=
[ccea9cc0] [c0212cb4] udp_recvmsg+0x318/0x3a4=0A=
[ccea9d10] [c01c2334] sock_common_recvmsg+0x3c/0x60=0A=
[ccea9d30] [c01c06c4] sock_recvmsg+0xb8/0xf0=0A=
[ccea9e20] [c01c09b0] sys_recvfrom+0x8c/0xfc=0A=
[ccea9f00] [c01c18d4] sys_socketcall+0x128/0x1f8=0A=
[ccea9f40] [c000f434] ret_from_syscall+0x0/0x3c=0A=
Mem-Info:=0A=
DMA per-cpu:=0A=
CPU    0: hi:   90, btch:  15 usd:  48=0A=
Active_anon:28 active_file:807 inactive_anon:85=0A=
 inactive_file:171 unevictable:0 dirty:0 writeback:0 unstable:0=0A=
 free:506 slab:53530 mapped:362 pagetables:19 bounce:0=0A=
DMA free:2024kB min:2036kB low:2544kB high:3052kB active_anon:112kB inactiv=
e_anon:340kB active_file:3228kB inactive_file:684kB unevictable:0kB present=
:260096kB pages_scanned:0 all_unreclaimable? no=0A=
lowmem_reserve[]: 0 0 0=0A=
DMA: 410*4kB 28*8kB 4*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0=
*2048kB 0*4096kB =3D 2024kB=0A=
978 total pagecache pages=0A=
0 pages in swap cache=0A=
Swap cache stats: add 0, delete 0, find 0/0=0A=
Free swap  =3D 0kB=0A=
Total swap =3D 0kB=0A=
65536 pages RAM=0A=
1400 pages reserved=0A=
1001 pages shared=0A=
62828 pages non-shared=0A=
SLUB: Unable to allocate memory on node -1 (gfp=3D0x20)=0A=
  cache: kmalloc-8192, object size: 8192, buffer size: 8192, default order:=
 3, min order: 1=0A=
  node 0: slabs: 7140, objs: 25809, free: 0=0A=
=0A=
Can anyone explain to me why I would be getting this error in the first pla=
ce?  Why is it failing to allocate a page when there are pages available?  =
That does not make any sense to me.=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=

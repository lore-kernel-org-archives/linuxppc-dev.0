Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 830E3DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 00:50:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.28 radeon.ko oops, QS22 (Cell) blade.
Date: Tue, 10 Feb 2009 14:50:12 +0100
References: <4aaa2e1c0902100318l376be033g26d67ed88450a6e8@mail.gmail.com>
In-Reply-To: <4aaa2e1c0902100318l376be033g26d67ed88450a6e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902101450.12693.arnd@arndb.de>
Cc: Wartan Hachaturow <wartan.hachaturow@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 10 February 2009, Wartan Hachaturow wrote:

> [drm] Initialized drm 1.1.0 20060810
> pci 0005:01:00.0: enabling device (0140 -> 0143)
> [drm] Initialized radeon 1.29.0 20080528 on minor 0
> [drm] Setting GART location based on new memory map
> [drm] GART aligned down from 0x04010000 to 0x04000000
> [drm] Loading R500 Microcode
> [drm] Num pipes: 1
> [drm] writeback test failed
> [drm] BEGIN_RING( 8 )
> [drm]    OUT_RING( 0x000005c9 ) at 0x6402505
> Unable to handle kernel paging request for data at address 0xd00000001a04c414
> Faulting instruction address: 0xd000000000fd6d68
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=128 NUMA Cell
> Modules linked in: radeon drm sunrpc pmi tg3 mptsas mptscsih mptbase
> scsi_transport_sas
> NIP: d000000000fd6d68 LR: d000000000fd6d54 CTR: 0000000000000001
> REGS: c0000000fb4f38b0 TRAP: 0300   Not tainted  (2.6.28-lks-wks-alt1)
> MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 24004424  XER: 20000000
> DAR: d00000001a04c414, DSISR: 0000000042000000
> TASK = c0000000fb4e4f50[4088] 'X' THREAD: c0000000fb4f0000 CPU: 2
> GPR00: 00000000000005c9 c0000000fb4f3b30 d000000001016c80 d000000000fff578
> GPR04: 0000000000000000 ffffffffffffffff c00000000097d6b0 c000000000805554
> GPR08: 000000000001ffff 0000000019009414 c00000000097d6b4 0000000000000001
> GPR12: d000000000ffab80 c000000000952800 0000000000000005 0000000000000000
> GPR16: 00000000100b3e50 0000000010090000 0000000010080000 0000000010090000
> GPR20: 00000000100b3e80 0000000000000000 0000000000000006 0000000000000000
> GPR24: ffffffffffffffea d000000001043000 c0000000fecba000 000000000003ffff
> GPR28: d000000000fff578 0000000006402506 d000000001015b38 c0000000fecbf000
> NIP [d000000000fd6d68] .radeon_cp_start+0x358/0x73c [radeon]
> LR [d000000000fd6d54] .radeon_cp_start+0x344/0x73c [radeon]
> Call Trace:
> [c0000000fb4f3b30] [d000000000fd6d54] .radeon_cp_start+0x344/0x73c [radeon]
> (unreliable)
> [c0000000fb4f3be0] [d000000000d9cbbc] .drm_ioctl+0x230/0x300 [drm]
> [c0000000fb4f3ca0] [d000000000ff8e98] .radeon_compat_ioctl+0xb4/0xfc [radeon]
> [c0000000fb4f3d40] [c000000000189944] .compat_sys_ioctl+0x140/0x488
> [c0000000fb4f3e30] [c000000000008570] syscall_exit+0x0/0x40
> Instruction dump:
> 388005c9 837a002c 3929ffe0 7fa5eb78 7f83e378 913a0030 48023e31 e8410028
> 7ba91764 380005c9 3bbd0001 7f83e378 <7c19492e> 38800033 7fbdd838 7fbd07b4
> ---[ end trace b46b031df5997cbf ]---
> [drm:drm_release] *ERROR* Device busy: 1 0
> 
> Any quick ideas for me to check? The ring address seems to be quite strange.
> 

Right, the ring address is definitely broken. 0xd0000000xxxxxxxxx is
probably the right location for the ring, but the offset 0x6402505
into it seems ways off. This comes from dev_priv->ring.tail, which is
set up in radeon_do_cp_reset() and radeon_cp_init_ring_buffer().
You can instrument these two functions with printk() to see whether
one of them is called at all, and where the value comes from.

	Arnd <><

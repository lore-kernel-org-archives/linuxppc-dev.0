Return-Path: <penberg@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id 090C6DDF19
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 21:10:20 +1000 (EST)
Received: by bwz19 with SMTP id 19so1698846bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 04:10:18 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <20090430210004.05a61841.sfr@canb.auug.org.au>
References: <20090428165343.2e357d7a.sfr@canb.auug.org.au>
	<20090429113604.GE3398@wotan.suse.de> <49F87FAB.9050408@in.ibm.com>
	<20090430041146.GB23746@wotan.suse.de> <49F938E4.2030703@in.ibm.com>
	<20090430064127.GF23746@wotan.suse.de> <49F973A0.8070106@in.ibm.com>
	<20090430103528.GA6900@wotan.suse.de>
	<1241087884.19252.5.camel@penberg-laptop>
	<20090430210004.05a61841.sfr@canb.auug.org.au>
Date: Thu, 30 Apr 2009 14:10:17 +0300
Message-ID: <84144f020904300410t12f3c08odc15a6c650f15460@mail.gmail.com>
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nick Piggin <npiggin@suse.de>, Christoph Lameter <cl@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 2:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Pekka, Nick,
>
> On Thu, 30 Apr 2009 13:38:04 +0300 Pekka Enberg <penberg@cs.helsinki.fi> =
wrote:
>>
>> Stephen, does this patch fix all the boot problems for you as well?
>
> Unfortunately not, I am still getting this:
>
> Memory: 1967708k/2097152k available (9836k kernel code, 129444k reserved,=
 1440k data, 8422k bss, 2092k init)
> Calibrating delay loop... 1021.95 BogoMIPS (lpj=3D2043904)
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Mount-cache hash table entries: 256
> Unable to handle kernel paging request for data at address 0x00000008
> Faulting instruction address: 0xc00000000010ea18
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=3D128 NUMA pSeries
> Modules linked in:
> NIP: c00000000010ea18 LR: c00000000010e9e8 CTR: 0000000000000001
> REGS: c000000000b07690 TRAP: 0300 =A0 Not tainted =A0(2.6.30-rc3-autokern=
1)
> MSR: 8000000000009032 <EE,ME,IR,DR> =A0CR: 48000082 =A0XER: 00000005
> DAR: 0000000000000008, DSISR: 0000000042000000
> TASK =3D c0000000009d55d0[0] 'swapper' THREAD: c000000000b04000 CPU: 0
> GPR00: c00000007e001030 c000000000b07910 c000000000b05588 c000000000b4a68=
0
> GPR04: c00000007e001000 c0000000009d5f18 0000000000000002 c0000000009d5f1=
8
> GPR08: 000000000000001a 0000000000000001 0000000000000000 000000000000000=
1
> GPR12: 0000000088000084 c000000000b53280 0000000000000000 000000000350000=
0
> GPR16: c0000000006c8f70 c0000000006c76e8 0000000000000000 00000000003d880=
0
> GPR20: 0000000003cc7d90 c0000000007c7d90 0000000000000010 000000000000000=
0
> GPR24: c000000000b656f0 f000000003347488 c000000000b4a680 f00000000334748=
8
> GPR28: c00000007e001180 c00000007e001000 c000000000a6f010 f0000000033474a=
8
> NIP [c00000000010ea18] .__slab_alloc_page+0x380/0x3dc
> LR [c00000000010e9e8] .__slab_alloc_page+0x350/0x3dc
> Call Trace:
> [c000000000b07910] [c00000000010e9e8] .__slab_alloc_page+0x350/0x3dc (unr=
eliable)
> [c000000000b079d0] [c00000000010f408] .__remote_slab_alloc+0x60/0x138
> [c000000000b07a80] [c000000000110d40] .__kmalloc_track_caller+0xb4/0x23c
> [c000000000b07b30] [c0000000000ec6e8] .kstrdup+0x4c/0x8c
> [c000000000b07bd0] [c000000000136f88] .alloc_vfsmnt+0xb0/0x178
> [c000000000b07c70] [c00000000011cb80] .vfs_kern_mount+0x40/0xf8
> [c000000000b07d10] [c0000000007ae460] .sysfs_init+0x90/0x108
> [c000000000b07db0] [c0000000007ad058] .mnt_init+0xbc/0x254
> [c000000000b07e50] [c0000000007aca00] .vfs_caches_init+0x150/0x184
> [c000000000b07ee0] [c000000000790a30] .start_kernel+0x418/0x484
> [c000000000b07f90] [c000000000008368] .start_here_common+0x1c/0x34
> Instruction dump:
> 60000000 e93d0040 e97d0028 381d0030 7fa4eb78 e95d0030 7f43d378 39290001
> 396b0001 f93d0040 f97d0028 f95b0020 <fbea0008> fbfd0030 f81f0008 4bfffb59
> ---[ end trace 31fd0ba7d8756001 ]---
>
> This is back to what I got before Nick's first patch.
>
> This partition has 2G of memory on node 1 (nothing in node 0) starting at
> address 0. =A0The kernel is using 64k pages.
>
> Let me now if I can tell you anything else or try something.

I'm no good in reading ppc oopses but I'd guess we're trying to
allocate memory on node 0 that doesn't have any of the necessary data
structures set up?

Btw, Nick, I applied the patch already:

http://git.kernel.org/?p=3Dlinux/kernel/git/penberg/slab-2.6.git;a=3Dcommit=
;h=3D908fdd91ff07a2cb5fb316060f302c22080a23c9

so any fixes for Stephen's case needs to be on top of that.

                                  Pekka

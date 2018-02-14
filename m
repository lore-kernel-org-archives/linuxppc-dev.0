Return-Path: <srs0=u53j=fi=linux.vnet.ibm.com=tyreld@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhXn44jjtzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:37:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zhXn40Xlcz8t9V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:37:28 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zhXn31q9Dz9t2x
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2018 08:37:27 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1ELaqVU011661
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2018 16:37:25 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4tcfxhbn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2018 16:37:25 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 16:37:23 -0500
Subject: Re: 4.16-rc1 virtual machine crash on boot
To: Cyril Bur <cyrilbur@gmail.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1518571241.9595.4.camel@gmail.com>
 <f8cfacb1-8675-c8f0-4147-d0ba74717488@linux.vnet.ibm.com>
 <1518588956.9595.6.camel@gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 13:37:19 -0800
MIME-Version: 1.0
In-Reply-To: <1518588956.9595.6.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <3e71dc1a-ad80-71d7-3072-922dbaba5c05@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/13/2018 10:15 PM, Cyril Bur wrote:
> On Tue, 2018-02-13 at 21:12 -0800, Tyrel Datwyler wrote:
>> On 02/13/2018 05:20 PM, Cyril Bur wrote:
>>> Hello all,
>>
>> Does reverting commit 02ef6dd8109b581343ebeb1c4c973513682535d6 alleviate the issue?
>>
> 
> Hi Tyrel,
> 
> No it doesn't. Same backtrace.

What about commit 0c38ed6f6f0b78a404fe46767d21504b37af8705? After a little closer look I think the series that commit enabled is the culprit. Especially, since Michael Ellerman complained of the same crash.

-Tyrel

>>
>>>
>>> I'm seeing this crash trying to boot a KVM virtual machine. This kernel
>>> was compiled with pseries_le_defconfig and run using the following qemu
>>> commandline:
>>>
>>> qemu-system-ppc64 -enable-kvm -cpu POWER8 -smp 4 -m 4G -M pseries
>>> -nographic -vga none -drive file=vm.raw,if=virtio,format=raw -drive
>>> file=mkvmconf2xeO,if=virtio,format=raw -netdev type=user,id=net0
>>> -device virtio-net-pci,netdev=net0 -kernel vmlinux_tscr -append
>>> 'root=/dev/vdb1 rw cloud-init=disabled'
>>>
>>> qemu-system-ppc64 --version
>>> QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16), Copyright
>>> (c) 2003-2008 Fabrice Bellard
>>>
>>>
>>> Key type dns_resolver registered
>>> Unable to handle kernel paging request for data at address 0x00000010
>>> Faulting instruction address: 0xc0000000018f2bbc
>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>> LE SMP NR_CPUS=2048 NUMA pSeries
>>> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc1v4.16-rc1 #8
>>> NIP:  c0000000018f2bbc LR: c0000000018f2bb4 CTR: 0000000000000000
>>> REGS: c0000000fea838d0 TRAP: 0380   Not tainted  (4.16.0-rc1v4.16-rc1)
>>> MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 84000248  XER:
>>> 20000000
>>> CFAR: c0000000019591a0 SOFTE: 0 
>>> GPR00: c0000000018f2bb4 c0000000fea83b50 c000000001bd8400
>>> 0000000000000000 
>>> GPR04: c0000000fea83b70 0000000000000000 000000000000002f
>>> 0000000000000022 
>>> GPR08: 0000000000000000 c0000000022a3e90 0000000000000000
>>> 0000000000000220 
>>> GPR12: 0000000000000000 c00000000fb40980 c00000000000d698
>>> 0000000000000000 
>>> GPR16: 0000000000000000 0000000000000000 0000000000000000
>>> 0000000000000000 
>>> GPR20: 0000000000000000 0000000000000000 0000000000000000
>>> 0000000000000000 
>>> GPR24: 0000000000000000 c0000000018b9248 c0000000018e36d8
>>> c0000000019738a8 
>>> GPR28: 0000000000000007 c0000000fffffc68 c0000000fea83bf0
>>> 0000000000000010 
>>> NIP [c0000000018f2bbc] read_drconf_v1_cell+0x50/0x9c
>>> LR [c0000000018f2bb4] read_drconf_v1_cell+0x48/0x9c
>>> Call Trace:
>>> [c0000000fea83b50] [c0000000018f2bb4] read_drconf_v1_cell+0x48/0x9c
>>> (unreliable)
>>> [c0000000fea83b90] [c0000000018f305c] drmem_init+0x13c/0x2ec
>>> [c0000000fea83c40] [c0000000018e4288] do_one_initcall+0xdc/0x1ac
>>> [c0000000fea83d00] [c0000000018e45d4] kernel_init_freeable+0x27c/0x358
>>> [c0000000fea83dc0] [c00000000000d6bc] kernel_init+0x2c/0x160
>>> [c0000000fea83e30] [c00000000000bc20] ret_from_kernel_thread+0x5c/0xbc
>>> Instruction dump:
>>> 7c7f1b78 60000000 60000000 7c240b78 3d22ffdc 3929f0a4 e95e0000
>>> e8690002 
>>> f9440021 4806657d 60000000 e9210020 <f87f0000> 39090004 39490010
>>> f9010020 
>>> ---[ end trace bd9f49f482d30e03 ]---
>>>
>>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>>>
>>> WARNING: CPU: 1 PID: 1 at drivers/tty/vt/vt.c:3883
>>> do_unblank_screen+0x1f0/0x270
>>> CPU: 1 PID: 1 Comm: swapper/0 Tainted: G      D          4.16.0-
>>> rc1v4.16-rc1 #8
>>> NIP:  c0000000009aa800 LR: c0000000009aa63c CTR: c00000000148f5f0
>>> REGS: c0000000fea832c0 TRAP: 0700   Tainted:
>>> G      D           (4.16.0-rc1v4.16-rc1)
>>> MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28002222  XER:
>>> 20000000
>>> CFAR: c0000000009aa658 SOFTE: 1 
>>> GPR00: c0000000009aa63c c0000000fea83540 c000000001bd8400
>>> 0000000000000000 
>>> GPR04: 0000000000000001 c0000000fb0c200e 0000000000001dd7
>>> c0000000fea834d0 
>>> GPR08: 00000000fe430000 0000000000000000 0000000000000000
>>> 0000000000000001 
>>> GPR12: 0000000028002428 c00000000fb40980 c00000000000d698
>>> 0000000000000000 
>>> GPR16: 0000000000000000 0000000000000000 0000000000000000
>>> 0000000000000000 
>>> GPR20: 0000000000000000 0000000000000000 0000000000000000
>>> 0000000000000000 
>>> GPR24: c0000000fea40000 c0000000feadf910 c000000001a4a7a8
>>> c000000001cc4ea0 
>>> GPR28: c00000000173f4f0 c000000001cc4ec8 0000000000000000
>>> 0000000000000000 
>>> NIP [c0000000009aa800] do_unblank_screen+0x1f0/0x270
>>> LR [c0000000009aa63c] do_unblank_screen+0x2c/0x270
>>> Call Trace:
>>> [c0000000fea83540] [c0000000009aa63c] do_unblank_screen+0x2c/0x270
>>> (unreliable)
>>> [c0000000fea835b0] [c0000000008a2a70] bust_spinlocks+0x40/0x80
>>> [c0000000fea835d0] [c0000000000da90c] panic+0x1b8/0x32c
>>> [c0000000fea83670] [c0000000000e1bd4] do_exit+0xcb4/0xcc0
>>> [c0000000fea83730] [c0000000000275fc] die+0x29c/0x450
>>> [c0000000fea837c0] [c000000000053f88] bad_page_fault+0xe8/0x160
>>> [c0000000fea83830] [c000000000028a90] slb_miss_bad_addr+0x40/0x90
>>> [c0000000fea83860] [c000000000008b08] bad_addr_slb+0x158/0x160
>>> --- interrupt: 380 at read_drconf_v1_cell+0x50/0x9c
>>>     LR = read_drconf_v1_cell+0x48/0x9c
>>> [c0000000fea83b90] [c0000000018f305c] drmem_init+0x13c/0x2ec
>>> [c0000000fea83c40] [c0000000018e4288] do_one_initcall+0xdc/0x1ac
>>> [c0000000fea83d00] [c0000000018e45d4] kernel_init_freeable+0x27c/0x358
>>> [c0000000fea83dc0] [c00000000000d6bc] kernel_init+0x2c/0x160
>>> [c0000000fea83e30] [c00000000000bc20] ret_from_kernel_thread+0x5c/0xbc
>>> Instruction dump:
>>> 3c62ffbf 38840001 7c8407b4 38639ca8 4b7ae0ed 60000000 38210070
>>> e8010010 
>>> ebc1fff0 ebe1fff8 7c0803a6 4e800020 <0fe00000> 4bfffe58 60000000
>>> 60420000 
>>> ---[ end trace bd9f49f482d30e04 ]---
>>> Rebooting in 10 seconds..
>>>
>>
>>
> 

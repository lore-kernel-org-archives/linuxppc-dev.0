Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjrY03NRjzDrKT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 16:29:56 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8R6Rowi006340
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 02:29:53 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qjpn247d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 02:29:53 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 02:29:53 -0400
Subject: Re: Kernel Oops on 4.8.0-rc8 while running trinity tests
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <3752be15-2382-1ffc-3509-bbea81539357@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Date: Tue, 27 Sep 2016 11:59:47 +0530
MIME-Version: 1.0
In-Reply-To: <3752be15-2382-1ffc-3509-bbea81539357@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <33a0fd86-12ac-088e-3e23-60b419804123@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel oops is still reproducible on 4.8.0-rc8 on PowerPC bare metal

While running trinity system call fuzzer, I see these kernel oops messages:

Unable to handle kernel paging request for data at address 
0xe45f770200000000
Faulting instruction address: 0xc000000000055380
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=32 NUMA PowerNV
Modules linked in: torture leds_powernv led_class powernv_op_panel 
powernv_rng rng_core autofs4 [last unloaded: rcutorture]
CPU: 28 PID: 19687 Comm: trinity-main Not tainted 4.8.0-rc8-autotest #1
task: c0000007dc61c600 task.stack: c0000007ddb20000
NIP: c000000000055380 LR: c000000000234968 CTR: 0000000000000000
REGS: c0000007ddb23640 TRAP: 0300   Not tainted (4.8.0-rc8-autotest)
MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002442  XER: 
00000000
CFAR: c0000000000087d0 DAR: e45f770200000000 DSISR: 40000000 SOFTE: 1
GPR00: 0000000000000007 c0000007ddb238c0 c000000000f7c100 c000000000000000
GPR04: 0000000000000000 0000000000000009 0000000000000000 0000000000000000
GPR08: e45f770200000000 0000000000000000 000000000000007f 0000000000000015
GPR12: 0000000000000000 c00000000ffff000 0000000000000000 0000000000001000
GPR16: 0000000000000001 0000000000000000 c000000002e02798 0000000010034120
GPR20: 0000000010034108 c0000007ddf842e0 c000000000ff0df8 0000000000000000
GPR24: c1fffffffffff7ff 0000000000000000 c0000007ddb23a60 0000000001000000
GPR28: 0000000001000000 c000000002e02400 c000000002e02464 0000000000000000
NIP [c000000000055380] __find_linux_pte_or_hugepte+0x1c0/0x330
LR [c000000000234968] __unmap_hugepage_range+0x178/0x670
Call Trace:
[c0000007ddb23980] [c000000000234e80] __unmap_hugepage_range_final+0x20/0x50
[c0000007ddb239b0] [c00000000020a52c] unmap_single_vma+0xcc/0x120
[c0000007ddb239f0] [c00000000020a984] unmap_vmas+0x84/0x120
[c0000007ddb23a40] [c000000000212c00] unmap_region+0xd0/0x1a0
[c0000007ddb23b30] [c000000000214e8c] do_munmap+0x2dc/0x4a0
[c0000007ddb23ba0] [c000000000216800] mmap_region+0x1c0/0x6e0
[c0000007ddb23c90] [c0000000002170fc] do_mmap+0x3dc/0x4c0
[c0000007ddb23d20] [c0000000001f1034] vm_mmap_pgoff+0xc4/0x100
[c0000007ddb23d90] [c0000000002144d0] SyS_mmap_pgoff+0x100/0x2a0
[c0000007ddb23e10] [c000000000012424] sys_mmap+0x44/0x70
[c0000007ddb23e30] [c0000000000095e0] system_call+0x38/0x108
Instruction dump:
7d290030 79081764 3929ffff 3860ffff 7d2a07b4 7c895c36 7d494838 78630044
7908f5e6 79291f24 7d081b78 796b0020 <7d49402a> 7c694214 2eaa0000 f941ffd0
---[ end trace f4f25c6801290199 ]---


On Friday 26 August 2016 12:02 PM, Abdul Haleem wrote:
> Hi,
>
> Trinity tests failed on mainline4.8.0-rc3with the following error 
> message:
>
> Machine Type : PowerPC Bare Metal & also reproducible on PowerVM LPAR
> config : attached
>
> 06:05:25 20:36:07 INFO | Test: running trinity tests
> 06:05:25 20:36:07 INFO | trinity
> 06:05:25 20:36:07 INFO |     START    trinity trinity    
> timestamp=1471912567    localtime=Aug 22 20:36:07
> 06:06:19 Unable to handle kernel paging request for data at address 
> 0xe475e1dc07000000
> 06:06:19 Faulting instruction address: 0xc0000000000553a0
> 06:06:19 Oops: Kernel access of bad area, sig: 11 [#1]
> 06:06:19 SMP NR_CPUS=32 NUMA PowerNV
> 06:06:19 Modules linked in: torture iptable_mangle ipt_MASQUERADE 
> nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat 
> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT 
> nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_filter ip_tables 
> x_tables binfmt_misc kvm_hv kvm leds_powernv led_class 
> powernv_op_panel powernv_rng rng_core autofs4 btrfs xor raid6_pq [last 
> unloaded: rcutorture]
> 06:06:19 CPU: 24 PID: 16309 Comm: trinity-main Not tainted 
> 4.8.0-rc3-autotest #1
> 06:06:19 task: c0000007de330000 task.stack: c0000007d85dc000
> 06:06:19 NIP: c0000000000553a0 LR: c0000000002345a8 CTR: 0000000000000000
> 06:06:19 REGS: c0000007d85df640 TRAP: 0300   Not tainted 
> (4.8.0-rc3-autotest)
> 06:06:19 MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 
> 24002452  XER: 00000000
> 06:06:19 CFAR: c0000000000087d0 DAR: e475e1dc07000000 DSISR: 40000000 
> SOFTE: 1
> 06:06:19 GPR00: 0000000000000007 c0000007d85df8c0 c000000000f7ad00 
> c000000000000000
> 06:06:19 GPR04: 0000000000000000 0000000000000009 0000000007000000 
> 0000000000000000
> 06:06:19 GPR08: e475e1dc07000000 0000000000000000 000000000000007f 
> 0000000000000015
> 06:06:19 GPR12: 0000000000000000 c00000000fffe000 0000000000000000 
> 0000000000001000
> 06:06:19 GPR16: 0000000000000001 0000000000000000 c0000007ddfa6798 
> 00000000100341e0
> 06:06:19 GPR20: 00000000100341c8 c0000007dc336508 c000000000ff0df8 
> 0000000000000000
> 06:06:19 GPR24: c1fffffffffff7ff 0000000000000000 c0000007d85dfa60 
> 0000000001000000
> 06:06:19 GPR28: 0000000001000000 c0000007ddfa6400 c0000007ddfa6464 
> 0000000000000007
> 06:06:19 NIP [c0000000000553a0] __find_linux_pte_or_hugepte+0x1c0/0x330
> 06:06:19 LR [c0000000002345a8] __unmap_hugepage_range+0x178/0x670
> 06:06:19 Call Trace:
> 06:06:19 [c0000007d85df980] [c000000000234ac0] 
> __unmap_hugepage_range_final+0x20/0x50
> 06:06:19 [c0000007d85df9b0] [c00000000020a16c] 
> unmap_single_vma+0xcc/0x120
> 06:06:19 [c0000007d85df9f0] [c00000000020a5c4] unmap_vmas+0x84/0x120
> 06:06:19 [c0000007d85dfa40] [c000000000212840] unmap_region+0xd0/0x1a0
> 06:06:19 [c0000007d85dfb30] [c000000000214acc] do_munmap+0x2dc/0x4a0
> 06:06:19 [c0000007d85dfba0] [c000000000216440] mmap_region+0x1c0/0x6e0
> 06:06:19 [c0000007d85dfc90] [c000000000216d3c] do_mmap+0x3dc/0x4c0
> 06:06:19 [c0000007d85dfd20] [c0000000001f0d04] vm_mmap_pgoff+0xc4/0x100
> 06:06:19 [c0000007d85dfd90] [c000000000214110] SyS_mmap_pgoff+0x100/0x2a0
> 06:06:19 [c0000007d85dfe10] [c000000000012424] sys_mmap+0x44/0x70
> 06:06:19 [c0000007d85dfe30] [c0000000000095e0] system_call+0x38/0x108
> 06:06:19 Instruction dump:
> 06:06:19 7d290030 79081764 3929ffff 3860ffff 7d2a07b4 7c895c36 
> 7d494838 78630044
> 06:06:19 7908f5e6 79291f24 7d081b78 796b0020 <7d49402a> 7c694214 
> 2eaa0000 f941ffd0
> 06:06:19 ---[ end trace 871b82883646cab5 ]---
>
> Regard's
> Abdul
>

Return-Path: <weo@reccoware.de>
Received: from schu.reccoware.net (schu.reccoware.net [87.106.213.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXZVB5GBGzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 21:25:54 +1100 (AEDT)
Received: from localhost (jodystroud.reccoware.net [82.165.160.205])
 (authenticated bits=0)
 by schu.reccoware.net (8.13.8/8.13.8/Recconet-2012062401) with ESMTP id
 v1S9vT6E032547
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 10:57:30 +0100
Message-ID: <1488275851.2358.4.camel@reccoware.de>
Subject: [bug report] v4.10.1 Oops on P1010 - huge tlb
From: Wolfgang Ocker <weo@reccoware.de>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 28 Feb 2017 10:57:31 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With kernel v4.10.1 and huge tlb enabled (CONFIG_HUGETLBFS=y) I see the
 following oops on a P1010:


Freeing unused kernel memory: 428K
This architecture does not have kernel memory protection.
Unable to handle kernel paging request for data at address 0x80000000
Faulting instruction address: 0xc001b3a0
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
SMP NR_CPUS=8
DSP01
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.10.1-weo-00024-g4de55c3 #1
task: eb0e4000 task.stack: eb0e2000
NIP: c001b3a0 LR: c001b390 CTR: 00007ffe
REGS: eb0e3c50 TRAP: 0300   Tainted: G        W        (4.10.1-weo-00024-g4de55c3)
MSR: 00021000 <CE,ME>
  CR: 88428022  XER: 00000000
DEAR: 80000000 ESR: 00000000
GPR00: c001b390 eb0e3d00 eb0e4000 80000000 bffffff1 eb0e3d0c eb0e3d08 00000000
GPR08: c0970000 00000000 00000000 00000080 28428022 00000000 c0002a5c 00000000
GPR16: eb0e3e48 00000001 88002022 20000000 48422022 00000000 88002024 ef0a8000
GPR24: eb0e3e48 00000000 00000000 bffffff1 00000001 bffffff1 00029000 ffffffea
NIP [c001b3a0] follow_huge_addr+0x54/0x114
LR [c001b390] follow_huge_addr+0x44/0x114
Call Trace:
[eb0e3d00] [c001b390] follow_huge_addr+0x44/0x114 (unreliable)
[eb0e3d30] [c014ffbc] follow_page_mask+0x4c/0x4a4
[eb0e3d90] [c01504e4] __get_user_pages+0xd0/0x3d8
[eb0e3df0] [c0150ca0] get_user_pages_remote+0x98/0x238
[eb0e3e40] [c018abf4] copy_strings+0x108/0x2bc
[eb0e3ea0] [c018ade0] copy_strings_kernel+0x38/0x50
[eb0e3ec0] [c018ce00] do_execveat_common+0x468/0x6c4
[eb0e3f10] [c018d094] do_execve+0x38/0x48
[eb0e3f20] [c00021cc] try_to_run_init_process+0x24/0x64
[eb0e3f30] [c0002b24] kernel_init+0xc8/0x11c
[eb0e3f40] [c00112d0] ret_from_kernel_thread+0x5c/0x64
--- interrupt: 0 at   (null)
    LR =   (null)
Instruction dump:
7fc000a6 7c000146 480edde9 807f0020 7fa4eb78 38a1000c 38c10008 4bfff851
2c030000 418200bc 81410008 3be0ffea <80c30000> 80e30004 2f8a0000 409e002c
---[ end trace 79d29a00645dff1b ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


Line numbers:

NIP [c001b3a0] follow_huge_addr+0x54/0x114
	linux/include/linux/compiler.h:243

[eb0e3d00] [c001b390] follow_huge_addr+0x44/0x114 (unreliable)
	linux/arch/powerpc/mm/hugetlbpage.c:635

[eb0e3d30] [c014ffbc] follow_page_mask+0x4c/0x4a4
	linux/mm/gup.c:238


The problem does not occur with 4.9.x. It does not occure with 4.10.1
and CONFIG_HUGETLBFS disabled. The problem does not occur after
reverting the following patches:

"powerpc: get hugetlbpage handling more generic" (03bb2d65900c)
"powerpc/8xx: Implement support of hugepages" (4b9142869947)
"powerpc: Fix pgtable pmd cache init" (bf5ca68dd2ee)
"powerpc/mm/hugetlb: Don't panic when we don't find the default huge page size" (ff8b85796dad)
"powerpc/mm: Fix little-endian 4K hugetlb" (20717e1ff526)


Best regards,
Wolfgang

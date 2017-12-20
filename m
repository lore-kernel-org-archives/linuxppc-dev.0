Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1v181SP6zF07k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 23:17:47 +1100 (AEDT)
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: WARNING: CPU: 0 PID: 2777 at arch/powerpc/mm/hugetlbpage.c:354
 h,ugetlb_free_pgd_range+0xc8/0x1e4
Message-ID: <d569112a-2d43-c77e-3579-a8a2176ddcf7@c-s.fr>
Date: Wed, 20 Dec 2017 13:17:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Trying to malloc() with libhugetlbfs, it runs indefinitly doing page 
faults in do_page_fault()/hugetlb_fault().
When interrupting the blocked app with CTRL+C, I get the following WARNING:

Any idea of what can be wrong ? I'm on a 8xx with 512k huge pages.

[162980.035629] WARNING: CPU: 0 PID: 2777 at 
arch/powerpc/mm/hugetlbpage.c:354 h
ugetlb_free_pgd_range+0xc8/0x1e4
[162980.035699] CPU: 0 PID: 2777 Comm: malloc Tainted: G W       4.14.6-s
3k-dev-ga8e8e8b176-svn9134 #85
[162980.035744] task: c67e2c00 task.stack: c668e000
[162980.035783] NIP:  c000fe18 LR: c00e1eec CTR: c00f90c0
[162980.035830] REGS: c668fc20 TRAP: 0700   Tainted: G W        (4.14.6-s
3k-dev-ga8e8e8b176-svn9134)
[162980.035854] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24044224 XER: 20000000
[162980.036003]
[162980.036003] GPR00: c00e1eec c668fcd0 c67e2c00 00000010 c6869410 
10080000 000
00000 77fb4000
[162980.036003] GPR08: ffff0001 0683c001 00000000 ffffff80 44028228 
10018a34 000
04008 418004fc
[162980.036003] GPR16: c668e000 00040100 c668e000 c06c0000 c668fe78 
c668e000 c68
35ba0 c668fd48
[162980.036003] GPR24: 00000000 73ffffff 74000000 00000001 77fb4000 
100fffff 101
00000 10100000
[162980.036743] NIP [c000fe18] hugetlb_free_pgd_range+0xc8/0x1e4
[162980.036839] LR [c00e1eec] free_pgtables+0x12c/0x150
[162980.036861] Call Trace:
[162980.036939] [c668fcd0] [c00f0774] unlink_anon_vmas+0x1c4/0x214 
(unreliable)
[162980.037040] [c668fd10] [c00e1eec] free_pgtables+0x12c/0x150
[162980.037118] [c668fd40] [c00eabac] exit_mmap+0xe8/0x1b4
[162980.037210] [c668fda0] [c0019710] mmput.part.9+0x20/0xd8
[162980.037301] [c668fdb0] [c001ecb0] do_exit+0x1f0/0x93c
[162980.037386] [c668fe00] [c001f478] do_group_exit+0x40/0xcc
[162980.037479] [c668fe10] [c002a76c] get_signal+0x47c/0x614
[162980.037570] [c668fe70] [c0007840] do_signal+0x54/0x244
[162980.037654] [c668ff30] [c0007ae8] do_notify_resume+0x34/0x88
[162980.037744] [c668ff40] [c000dae8] do_user_signal+0x74/0xc4
[162980.037781] Instruction dump:
[162980.037821] 7fdff378 81370000 54a3463a 80890020 7d24182e 7c841a14 
712a0004 4
082ff94
[162980.038014] 2f890000 419e0010 712a0ff0 408200e0 <0fe00000> 54a9000a 
7f984840
  419d0094
[162980.038216] ---[ end trace c0ceeca8e7a5800a ]---
[162980.038754] BUG: non-zero nr_ptes on freeing mm: 1
[162985.363322] BUG: non-zero nr_ptes on freeing mm: -1

Christophe

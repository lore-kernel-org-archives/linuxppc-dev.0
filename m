Return-Path: <nyushchenko@dev.rtsoft.ru>
Received: from dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
 by ozlabs.org (Postfix) with ESMTP id A96302C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 20:24:02 +1100 (EST)
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: powerpc/hugetlb: BUG: using smp_processor_id() in preemptible
Date: Fri, 17 Jan 2014 13:23:50 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201401171323.52657@blacky.localdomain>
Cc: Alexey Lugovskoy <lugovskoy@dev.rtsoft.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

While running LTP hugeltb tests on freescale powerpc board, I'm getting 

[ 7253.637591] BUG: using smp_processor_id() in preemptible [00000000 00000000]
code: hugemmap01/9048
[ 7253.637601] caller is free_hugepd_range.constprop.25+0x88/0x1a8
[ 7253.637605] CPU: 1 PID: 9048 Comm: hugemmap01 Not tainted 3.10.20-rt14+ #114
[ 7253.637606] Call Trace:
[ 7253.637617] [cb049d80] [c0007ea4] show_stack+0x4c/0x168 (unreliable)
[ 7253.637624] [cb049dc0] [c031c674] debug_smp_processor_id+0x114/0x134
[ 7253.637628] [cb049de0] [c0016d28] free_hugepd_range.constprop.25+0x88/0x1a8
[ 7253.637632] [cb049e00] [c001711c] hugetlb_free_pgd_range+0x6c/0x168
[ 7253.637639] [cb049e40] [c0117408] free_pgtables+0x12c/0x150
[ 7253.637646] [cb049e70] [c011ce38] unmap_region+0xa0/0x11c
[ 7253.637671] [cb049ef0] [c011f03c] do_munmap+0x224/0x3bc
[ 7253.637676] [cb049f20] [c011f2e0] vm_munmap+0x38/0x5c
[ 7253.637682] [cb049f40] [c000ef88] ret_from_syscall+0x0/0x3c
[ 7253.637686] --- Exception: c01 at 0xff16004

This is on 3.10 based kernel but looks like code in question did not change
since then.

Immediate reason of this dump is usage of smp_processor_id() in hugepd_free(),
which is executed in preemptible context on this path.

Perhaps need to add preempt_disable() / preempt_enable() somewhere.
But what is the proper location for these?


Nikita

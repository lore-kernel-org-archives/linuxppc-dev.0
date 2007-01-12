Return-Path: <>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D60D8DDF0C
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 07:00:35 +1100 (EST)
Date: Fri, 12 Jan 2007 14:57:03 -0500
From: Sonny Rao <sonny@burdell.org>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.19: kernel BUG in hugepd_page at arch/powerpc/mm/hugetlbpage.c:58!
Message-ID: <20070112195703.GA1826@kevlar.boston.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nacc@us.ibm.com, libhugetlbfs-devel@lists.sourceforge.net, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Apologies if this is a re-post)

Hi, I was running 2.6.19 and running some benchmarks using
libhugetlbfs (1.0.1) and I can fairly reliably trigger this bug: 

kernel BUG in hugepd_page at arch/powerpc/mm/hugetlbpage.c:58!

6:mon> e
cpu 0x6: Vector: 700 (Program Check) at [c0000002d92c7a10]
    pc: c000000000030170: .huge_pte_offset+0xa8/0xd8
    lr: c000000000031024: .hash_huge_page+0x50/0x42c
    sp: c0000002d92c7c90
   msr: 8000000000021032
  current = 0xc0000002da2a19a0
  paca    = 0xc0000000005b3f80
    pid   = 24695, comm = 
kernel BUG in hugepd_page at arch/powerpc/mm/hugetlbpage.c:58!
6:mon>
6:mon> t
[link register   ] c000000000031024 .hash_huge_page+0x50/0x42c
[c0000002d92c7c90] c0000002d92c7d50 (unreliable)
[c0000002d92c7d50] c00000000002cf80 .hash_page+0x214/0x3bc
[c0000002d92c7e30] c000000000004834 .do_hash_page+0x34/0x40
--- Exception: 301 (Data Access) at 000000001009b0cc
SP (f33bc830) is in userspace
6:mon> r

the bug comes from this code:

static inline pte_t *hugepd_page(hugepd_t hpd)
{
        BUG_ON(!(hpd.pd & HUGEPD_OK));
        return (pte_t *)(hpd.pd & ~HUGEPD_OK);
}


I'm trying to reproduce on 2.6.20-rc3 now, but was wondering if anyone
has seen this before. 

Sonny

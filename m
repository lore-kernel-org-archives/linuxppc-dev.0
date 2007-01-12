Return-Path: <>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B502DDF45
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 08:59:19 +1100 (EST)
Received: from kevlar.boston.burdell.org ([66.92.67.27])
	by asclepius.site5.com with esmtpa (Exim 4.63) id 1H5QBW-0007Tq-1W
	for linuxppc-dev@ozlabs.org; Fri, 12 Jan 2007 12:27:22 -0500
Date: Fri, 12 Jan 2007 12:24:11 -0500
From: Sonny Rao <sonny@burdell.org>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.19: kernel BUG in hugepd_page at arch/powerpc/mm/hugetlbpage.c:58!
Message-ID: <20070112172411.GA1077@kevlar.boston.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, I was running a 2.6.19 kernel w/ 64k pages and running some
benchmarks with libhugetlbfs and got this BUG: 

kernel BUG in hugepd_page at arch/powerpc/mm/hugetlbpage.c:58!
6:mon>
6:mon> t
[link register   ] c000000000031024 .hash_huge_page+0x50/0x42c
[c0000002d92c7c90] c0000002d92c7d50 (unreliable)
[c0000002d92c7d50] c00000000002cf80 .hash_page+0x214/0x3bc
[c0000002d92c7e30] c000000000004834 .do_hash_page+0x34/0x40
--- Exception: 301 (Data Access) at 000000001009b0cc
SP (f33bc830) is in userspace

from this BUG_ON()

static inline pte_t *hugepd_page(hugepd_t hpd)
{
        BUG_ON(!(hpd.pd & HUGEPD_OK));
        return (pte_t *)(hpd.pd & ~HUGEPD_OK);
}

Has anyone seen this before?  A cursory search for hugepd_page and
this bug came up with nothing.

Sonny

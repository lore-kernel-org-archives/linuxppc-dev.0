Return-Path: <agl@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A11F4DDEBF
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 07:08:35 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0CK8WiU011248
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:08:32 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0CK8W87405700
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 13:08:32 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0CK8VGY006766
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 13:08:32 -0700
Subject: Re: 2.6.19: kernel BUG in hugepd_page at
	arch/powerpc/mm/hugetlbpage.c:58!
From: Adam Litke <agl@us.ibm.com>
To: Sonny Rao <sonny@burdell.org>
In-Reply-To: <20070112195703.GA1826@kevlar.boston.burdell.org>
References: <20070112195703.GA1826@kevlar.boston.burdell.org>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 14:08:30 -0600
Message-Id: <1168632510.12413.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, libhugetlbfs-devel@lists.sourceforge.net,
	nacc@us.ibm.com, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-12 at 14:57 -0500, Sonny Rao wrote:
> (Apologies if this is a re-post)
> 
> Hi, I was running 2.6.19 and running some benchmarks using
> libhugetlbfs (1.0.1) and I can fairly reliably trigger this bug:

Is this triggered by a libhugetlbfs test case?  If so, which one?

> 
> kernel BUG in hugepd_page at arch/powerpc/mm/hugetlbpage.c:58!
> 
> 6:mon> e
> cpu 0x6: Vector: 700 (Program Check) at [c0000002d92c7a10]
>     pc: c000000000030170: .huge_pte_offset+0xa8/0xd8
>     lr: c000000000031024: .hash_huge_page+0x50/0x42c
>     sp: c0000002d92c7c90
>    msr: 8000000000021032
>   current = 0xc0000002da2a19a0
>   paca    = 0xc0000000005b3f80
>     pid   = 24695, comm =
> kernel BUG in hugepd_page at arch/powerpc/mm/hugetlbpage.c:58!
> 6:mon>
> 6:mon> t
> [link register   ] c000000000031024 .hash_huge_page+0x50/0x42c
> [c0000002d92c7c90] c0000002d92c7d50 (unreliable)
> [c0000002d92c7d50] c00000000002cf80 .hash_page+0x214/0x3bc
> [c0000002d92c7e30] c000000000004834 .do_hash_page+0x34/0x40
> --- Exception: 301 (Data Access) at 000000001009b0cc
> SP (f33bc830) is in userspace
> 6:mon> r
> 
> the bug comes from this code:
> 
> static inline pte_t *hugepd_page(hugepd_t hpd)
> {
>         BUG_ON(!(hpd.pd & HUGEPD_OK));
>         return (pte_t *)(hpd.pd & ~HUGEPD_OK);
> }
> 
> 
> I'm trying to reproduce on 2.6.20-rc3 now, but was wondering if anyone
> has seen this before.
> 
> Sonny
> 
> 
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

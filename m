Return-Path: <nacc@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55CFF67B7E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2006 02:00:35 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7VG0W3U009389
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 12:00:32 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7VG0Wbd216198
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 10:00:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7VG0V0I022909
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 10:00:32 -0600
Date: Thu, 31 Aug 2006 09:00:52 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: [PATCH] fix NUMA interleaving for huge pages (was RE: libnuma
	interleaving oddness)
Message-ID: <20060831160052.GB23990@us.ibm.com>
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com> <200608300919.13125.ak@suse.de>
	<20060830072948.GE5195@us.ibm.com>
	<Pine.LNX.4.64.0608301401290.4217@schroedinger.engr.sgi.com>
	<20060831060036.GA18661@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060831060036.GA18661@us.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Andi Kleen <ak@suse.de>,
	linux-mm@kvack.org, lnxninja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 30.08.2006 [23:00:36 -0700], Nishanth Aravamudan wrote:
> On 30.08.2006 [14:04:40 -0700], Christoph Lameter wrote:
> > > I took out the mlock() call, and I get the same results, FWIW.
> > 
> > What zones are available on your box? Any with HIGHMEM?
> 
> How do I tell the available zones from userspace? This is ppc64 with
> about 64GB of memory total, it looks like. So, none of the nodes
> (according to /sys/devices/system/node/*/meminfo) have highmem.
> 
> > Also what kernel version are we talking about? Before 2.6.18?
> 
> The SuSE default, 2.6.16.21 -- I thought I mentioned that in one of my
> replies, sorry.
> 
> Tim and I spent most of this afternoon debugging the huge_zonelist()
> callpath with kprobes and jprobes. We found the following via a jprobe
> to offset_li_node():

<snip lengthy previous discussion>

Since vma->vm_pgoff is in units of smallpages, VMAs for huge pages have
the lower HPAGE_SHIFT - PAGE_SHIFT bits always cleared, which results in
badd offsets to the interleave functions. Take this difference from
small pages into account when calculating the offset. This does add a
0-bit shift into the small-page path (via alloc_page_vma()), but I think
that is negligible. Also add a BUG_ON to prevent the offset from growing
due to a negative right-shift, which probably shouldn't be allowed
anyways.

Tested on an 8-memory node ppc64 NUMA box and got the interleaving I
expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

Results with this patch applied, which shouldn't go into the changelog,
I don't think:

for the 4-hugepages at a time case:
20000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.r1YKfL huge dirty=4 N0=1 N1=1 N2=1 N3=1
24000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.r1YKfL huge dirty=4 N4=1 N5=1 N6=1 N7=1
28000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.r1YKfL huge dirty=4 N0=1 N1=1 N2=1 N3=1

for the 1-hugepage at a time case:
20000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N0=1
21000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N1=1
22000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N2=1
23000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N3=1
24000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N4=1
25000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N5=1
26000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N6=1
27000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N7=1
28000000 interleave=0-7 file=/hugetlbfs/libhugetlbfs.tmp.LeSnPN huge dirty=1 N0=1

Andrew, can we get this into 2.6.18?

diff -urpN 2.6.18-rc5/mm/mempolicy.c 2.6.18-rc5-dev/mm/mempolicy.c
--- 2.6.18-rc5/mm/mempolicy.c	2006-08-30 22:55:33.000000000 -0700
+++ 2.6.18-rc5-dev/mm/mempolicy.c	2006-08-31 08:46:22.000000000 -0700
@@ -1176,7 +1176,15 @@ static inline unsigned interleave_nid(st
 	if (vma) {
 		unsigned long off;
 
-		off = vma->vm_pgoff;
+		/*
+		 * for small pages, there is no difference between
+		 * shift and PAGE_SHIFT, so the bit-shift is safe.
+		 * for huge pages, since vm_pgoff is in units of small
+		 * pages, we need to shift off the always 0 bits to get
+		 * a useful offset.
+		 */
+		BUG_ON(shift < PAGE_SHIFT);
+		off = vma->vm_pgoff >> (shift - PAGE_SHIFT);
 		off += (addr - vma->vm_start) >> shift;
 		return offset_il_node(pol, vma, off);
 	} else

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

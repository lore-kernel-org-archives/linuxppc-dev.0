Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E16467B5F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 12:26:09 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U2Q6iE011371
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 22:26:06 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7U2Q6Q5275200
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 20:26:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7U2Q6kH027511
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 20:26:06 -0600
Date: Tue, 29 Aug 2006 19:26:21 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: libnuma interleaving oddness
Message-ID: <20060830022621.GA5195@us.ibm.com>
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060830002110.GZ5195@us.ibm.com>
Cc: linux-mm@kvack.org, lnxninja@us.ibm.com, ak@suse.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 29.08.2006 [17:21:10 -0700], Nishanth Aravamudan wrote:
> On 29.08.2006 [16:57:35 -0700], Christoph Lameter wrote:
> > On Tue, 29 Aug 2006, Nishanth Aravamudan wrote:
> > 
> > > I don't know if this is a libnuma bug (I extracted out the code from
> > > libnuma, it looked sane; and even reimplemented it in libhugetlbfs
> > > for testing purposes, but got the same results) or a NUMA kernel bug
> > > (mbind is some hairy code...) or a ppc64 bug or maybe not a bug at
> > > all.  Regardless, I'm getting somewhat inconsistent behavior. I can
> > > provide more debugging output, or whatever is requested, but I
> > > wasn't sure what to include. I'm hoping someone has heard of or seen
> > > something similar?
> > 
> > Are you setting the tasks allocation policy before the allocation or
> > do you set a vma based policy? The vma based policies will only work
> > for anonymous pages.
> 
> The order is (with necessary params filled in):
> 
> p = mmap( , newsize, RW, PRIVATE, unlinked_hugetlbfs_heap_fd, );
> 
> numa_interleave_memory(p, newsize);
> 
> mlock(p, newsize); /* causes all the hugepages to be faulted in */
> 
> munlock(p,newsize);
> 
> From what I gathered from the numa manpages, the interleave policy
> should take effect on the mlock, as that is "fault-time" in this
> context. We're forcing the fault, that is.

For some more data, I did some manipulations of libhugetlbfs and came up
with the following:

If I use the default hugepage-aligned hugepage-backed malloc
replacement, I get the following in /proc/pid/numa_maps (excerpt):

20000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
21000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
...
37000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1
38000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.3JbO7R\040(deleted) huge dirty=1 N0=1

If I change the nodemask to 1-7, I get:

20000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N1=1
21000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N2=1
22000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N3=1
23000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N4=1
24000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N5=1
25000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N6=1
26000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N7=1
...
35000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N1=1
36000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N2=1
37000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N3=1
38000000 interleave=1-7 file=/libhugetlbfs/libhugetlbfs.tmp.Eh9Bmp\040(deleted) huge dirty=1 N4=1

If I then change our malloc implementation to (unnecessarily) mmap a
size aligned to 4 hugepages, rather aligned to a single hugepage, but
using a nodemask of 0-7, I get:

20000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
24000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
28000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
2c000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
30000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
34000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=4 N0=1 N1=1 N2=1 N3=1
38000000 interleave=0-7 file=/libhugetlbfs/libhugetlbfs.tmp.PFt0xt\040(deleted) huge dirty=1 mapped=4 N0=1 N1=1 N2=1 N3=1

It seems rather odd that it's this inconsistent, and that I'm the only
one seeing it as such :)

Thanks,
Nish


-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

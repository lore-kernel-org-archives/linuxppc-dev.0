Return-Path: <agl@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 69FE2679E0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 03:44:21 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7UHiGZH022839
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 13:44:16 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7UHiFf9283182
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 13:44:15 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7UHiFro016007
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 13:44:15 -0400
Subject: Re: libnuma interleaving oddness
From: Adam Litke <agl@us.ibm.com>
To: Andi Kleen <ak@suse.de>
In-Reply-To: <200608300919.13125.ak@suse.de>
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com>  <200608300919.13125.ak@suse.de>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 12:44:10 -0500
Message-Id: <1156959851.7185.8647.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, Nishanth Aravamudan <nacc@us.ibm.com>,
	lnxninja@us.ibm.com, linuxppc-dev@ozlabs.org,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-30 at 09:19 +0200, Andi Kleen wrote:
> mous pages.
> > 
> > The order is (with necessary params filled in):
> > 
> > p = mmap( , newsize, RW, PRIVATE, unlinked_hugetlbfs_heap_fd, );
> > 
> > numa_interleave_memory(p, newsize);
> > 
> > mlock(p, newsize); /* causes all the hugepages to be faulted in */
> > 
> > munlock(p,newsize);
> > 
> > From what I gathered from the numa manpages, the interleave policy
> > should take effect on the mlock, as that is "fault-time" in this
> > context. We're forcing the fault, that is.
> 
> mlock shouldn't be needed at all here. the new hugetlbfs is supposed
> to reserve at mmap time and numa_interleave_memory() sets a VMA 
> policy which will should do the right thing no matter when the fault
> occurs.

mmap-time reservation of huge pages is done only for shared mappings.
MAP_PRIVATE mappings have full-overcommit semantics.  We use the mlock
call to "guarantee" the MAP_PRIVATE memory to the process.  If mlock
fails, we simply unmap the hugetlb region and tell glibc to revert to
its normal allocation method (mmap normal pages).

> Hmm, maybe mlock() policy() is broken.

The policy decision is made further down than mlock.  As each huge page
is allocated from the static pool, the policy is consulted to see from
which node to pop a huge page. 

The function huge_zonelist() seems to encapsulate the numa policy logic
and after sniffing the code, it looks right to me.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

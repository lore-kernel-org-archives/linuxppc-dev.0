Return-Path: <nacc@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C87167B22
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 10:20:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U0KtYS013514
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 20:20:55 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7U0Kt3T247746
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 20:20:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7U0Ktfb026709
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 20:20:55 -0400
Date: Tue, 29 Aug 2006 17:21:10 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: libnuma interleaving oddness
Message-ID: <20060830002110.GZ5195@us.ibm.com>
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
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

On 29.08.2006 [16:57:35 -0700], Christoph Lameter wrote:
> On Tue, 29 Aug 2006, Nishanth Aravamudan wrote:
> 
> > I don't know if this is a libnuma bug (I extracted out the code from
> > libnuma, it looked sane; and even reimplemented it in libhugetlbfs
> > for testing purposes, but got the same results) or a NUMA kernel bug
> > (mbind is some hairy code...) or a ppc64 bug or maybe not a bug at
> > all.  Regardless, I'm getting somewhat inconsistent behavior. I can
> > provide more debugging output, or whatever is requested, but I
> > wasn't sure what to include. I'm hoping someone has heard of or seen
> > something similar?
> 
> Are you setting the tasks allocation policy before the allocation or
> do you set a vma based policy? The vma based policies will only work
> for anonymous pages.

The order is (with necessary params filled in):

p = mmap( , newsize, RW, PRIVATE, unlinked_hugetlbfs_heap_fd, );

numa_interleave_memory(p, newsize);

mlock(p, newsize); /* causes all the hugepages to be faulted in */

munlock(p,newsize);

>From what I gathered from the numa manpages, the interleave policy
should take effect on the mlock, as that is "fault-time" in this
context. We're forcing the fault, that is.

Does that answer your question? Sorry if I'm unclear, I'm a bit of a
newbie to the VM.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

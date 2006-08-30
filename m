Return-Path: <ak@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D04867B74
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 17:20:04 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libnuma interleaving oddness
Date: Wed, 30 Aug 2006 09:19:13 +0200
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com>
In-Reply-To: <20060830002110.GZ5195@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608300919.13125.ak@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org, lnxninja@us.ibm.com,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mous pages.
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

mlock shouldn't be needed at all here. the new hugetlbfs is supposed
to reserve at mmap time and numa_interleave_memory() sets a VMA 
policy which will should do the right thing no matter when the fault
occurs.

Hmm, maybe mlock() policy() is broken.

-Andi

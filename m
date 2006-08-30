Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A34F67B93
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 17:20:04 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: libnuma interleaving oddness
Date: Wed, 30 Aug 2006 09:16:30 +0200
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608300916.30210.ak@suse.de>
Cc: linuxppc-dev@ozlabs.org, Nishanth Aravamudan <nacc@us.ibm.com>,
	lnxninja@us.ibm.com, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 30 August 2006 01:57, Christoph Lameter wrote:
> On Tue, 29 Aug 2006, Nishanth Aravamudan wrote:
> 
> > I don't know if this is a libnuma bug (I extracted out the code from
> > libnuma, it looked sane; and even reimplemented it in libhugetlbfs for
> > testing purposes, but got the same results) or a NUMA kernel bug (mbind
> > is some hairy code...) or a ppc64 bug or maybe not a bug at all.
> > Regardless, I'm getting somewhat inconsistent behavior. I can provide
> > more debugging output, or whatever is requested, but I wasn't sure what
> > to include. I'm hoping someone has heard of or seen something similar?
> 
> Are you setting the tasks allocation policy before the allocation or do 
> you set a vma based policy? The vma based policies will only work for 
> anonymous pages.

They should work for hugetlb/shmfs too. At least when I originally
wrote it. But the original patch I did for hugetlbfs for that was
never merged and I admit I have never rechecked if it worked with 
the patchkit that was merged later. The problem originally was
that hugetlbfs needed to be changed to do allocate-on-demand
instead of allocation-on-mmap, because mbind() comes after mmap()
and when mmap() already allocates it can't work.

-Andi

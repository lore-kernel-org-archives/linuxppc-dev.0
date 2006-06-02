Return-Path: <agl@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6579067A5B
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 02:49:57 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k52GnpLT004823
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 12:49:51 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k52Gnoqs141546
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 12:49:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k52Gno8W004802
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 12:49:50 -0400
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions
	on vma close
From: Adam Litke <agl@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606021737310.26864@blonde.wat.veritas.com>
References: <1149257287.9693.6.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606021737310.26864@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 11:49:28 -0500
Message-Id: <1149266969.9693.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-02 at 17:43 +0100, Hugh Dickins wrote:
> On Fri, 2 Jun 2006, Adam Litke wrote:
> > 
> > On powerpc, each segment can contain pages of only one size.  When a
> > hugetlb mapping is requested, a segment is located and marked for use
> > with huge pages.  This is a uni-directional operation -- hugetlb
> > segments are never marked for use again with normal pages.  For long
> > running processes which make use of a combination of normal and hugetlb
> > mappings, this behavior can unduly constrain the virtual address space.
> > 
> > The following patch introduces a architecture-specific vm_ops.close()
> > hook.  For all architectures besides powerpc, this is a no-op.  On
> > powerpc, the low and high segments are scanned to locate empty hugetlb
> > segments which can be made available for normal mappings.  Comments?
> 
> Wouldn't hugetlb_free_pgd_range be a better place to do that kind of
> thing, all within arch/powerpc, no need for arch_hugetlb_close_vma etc?

Hmm.  Interesting idea.  I'll take a look.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

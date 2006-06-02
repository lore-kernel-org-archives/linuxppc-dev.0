Return-Path: <hugh_dickins@symantec.com>
Received: from gold.veritas.com (gold.veritas.com [143.127.12.110])
	by ozlabs.org (Postfix) with ESMTP id CEAAE67A42
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 02:43:23 +1000 (EST)
Date: Fri, 2 Jun 2006 17:43:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on
	vma close
In-Reply-To: <1149257287.9693.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606021737310.26864@blonde.wat.veritas.com>
References: <1149257287.9693.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 2 Jun 2006, Adam Litke wrote:
> 
> On powerpc, each segment can contain pages of only one size.  When a
> hugetlb mapping is requested, a segment is located and marked for use
> with huge pages.  This is a uni-directional operation -- hugetlb
> segments are never marked for use again with normal pages.  For long
> running processes which make use of a combination of normal and hugetlb
> mappings, this behavior can unduly constrain the virtual address space.
> 
> The following patch introduces a architecture-specific vm_ops.close()
> hook.  For all architectures besides powerpc, this is a no-op.  On
> powerpc, the low and high segments are scanned to locate empty hugetlb
> segments which can be made available for normal mappings.  Comments?

Wouldn't hugetlb_free_pgd_range be a better place to do that kind of
thing, all within arch/powerpc, no need for arch_hugetlb_close_vma etc?

Hugh

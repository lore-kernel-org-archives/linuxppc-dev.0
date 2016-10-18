Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sz3cT4SCdzDt39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 05:33:45 +1100 (AEDT)
Date: Tue, 18 Oct 2016 11:33:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Jan Stancek <jstancek@redhat.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm/hugetlb: Use the right pte val for compare in
 hugetlb_cow
Message-Id: <20161018113341.e032f26c052dd63a8dca1f09@linux-foundation.org>
In-Reply-To: <20161018154245.18023-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161018154245.18023-1-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Oct 2016 21:12:45 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> We cannot use the pte value used in set_pte_at for pte_same comparison,
> because archs like ppc64, filter/add new pte flag in set_pte_at. Instead
> fetch the pte value inside hugetlb_cow. We are comparing pte value to
> make sure the pte didn't change since we dropped the page table lock.
> hugetlb_cow get called with page table lock held, and we can take a copy
> of the pte value before we drop the page table lock.
> 
> With hugetlbfs, we optimize the MAP_PRIVATE write fault path with no
> previous mapping (huge_pte_none entries), by forcing a cow in the fault
> path. This avoid take an addition fault to covert a read-only mapping
> to read/write. Here we were comparing a recently instantiated pte (via
> set_pte_at) to the pte values from linux page table. As explained above
> on ppc64 such pte_same check returned wrong result, resulting in us
> taking an additional fault on ppc64.

>From my reading this is a minor performance improvement and a -stable
backport isn't needed.  But it is unclear whether the impact warrants a
4.9 merge.

Please be careful about describing end-user visible impacts when fixing
bugs, thanks.

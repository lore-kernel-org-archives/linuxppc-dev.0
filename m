Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id D5F95DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:33:47 +1000 (EST)
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH] IB/ehca: Make sure user pages are from hugetlb before
	using MR large pages
References: <200709121439.32641.fenkes@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Sep 2007 21:33:45 -0700
In-Reply-To: <200709121439.32641.fenkes@de.ibm.com> (Joachim Fenkes's message
	of "Wed, 12 Sep 2007 14:39:31 +0200")
Message-ID: <adaps0nmbfa.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > -#define HCA_CAP_MR_PGSIZE_4K  1
 > -#define HCA_CAP_MR_PGSIZE_64K 2
 > -#define HCA_CAP_MR_PGSIZE_1M  4
 > -#define HCA_CAP_MR_PGSIZE_16M 8
 > +#define HCA_CAP_MR_PGSIZE_4K  0x80000000
 > +#define HCA_CAP_MR_PGSIZE_64K 0x40000000
 > +#define HCA_CAP_MR_PGSIZE_1M  0x20000000
 > +#define HCA_CAP_MR_PGSIZE_16M 0x10000000

Not sure I understand what this has to do with things... is this an
unrelated fix?

 > +static int ehca_is_mem_hugetlb(unsigned long addr, unsigned long size)

This is rather awful -- another call to get_user_pages() to iterate
over all the vmas...

I would suggest extending ib_umem_get() to check the vmas and adding a
member to struct ib_umem to say whether the memory is entirely covered
by hugetlb pages or not.

 > +		ret = ehca_is_mem_hugetlb(virt, length);
 > +		switch (ret) {
 > +		case 0: /* mem is not from hugetlb */
 > +			hwpage_size = PAGE_SIZE;
 > +			break;
 > +		case 1:
 > +			if (length <= EHCA_MR_PGSIZE4K
 > +			    && PAGE_SIZE == EHCA_MR_PGSIZE4K)
 > +				hwpage_size = EHCA_MR_PGSIZE4K;
 > +			else if (length <= EHCA_MR_PGSIZE64K)
 > +				hwpage_size = EHCA_MR_PGSIZE64K;
 > +			else if (length <= EHCA_MR_PGSIZE1M)
 > +				hwpage_size = EHCA_MR_PGSIZE1M;
 > +			else
 > +				hwpage_size = EHCA_MR_PGSIZE16M;
 > +			break;
 > +		default: /* out of mem */
 > +			ib_mr = ERR_PTR(-ENOMEM);
 > +			goto reg_user_mr_exit1;

It seems like it would be better to just assume the memory is not from
a hugetlb is ehca_is_mem_hugetlb() fails its memory allocation and
fall back to the PAGE_SIZE case rather than failing entirely.

Also if someone runs a kernel with 64K pages on a machine where they
end up being simulated from 4K pages, do you have the same issue with
the hypervisor ganging together non-contiguous pages?

 - R.

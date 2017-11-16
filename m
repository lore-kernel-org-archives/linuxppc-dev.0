Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycrnD0qtdzDqsP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 17:24:31 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAG6NsIA026212
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 01:24:28 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e936d5dxc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 01:24:28 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 06:24:26 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, alistair@popple.id.au
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] powerpc/npu: Cleanup MMIO ATSD flushing
In-Reply-To: <20171113081611.27374-1-bsingharora@gmail.com>
References: <20171113081611.27374-1-bsingharora@gmail.com>
Date: Thu, 16 Nov 2017 11:54:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp2qhhbd.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

 +	address = start;
> +	do {
> +		local_irq_disable();
> +		find_linux_pte(mm->pgd, address, &is_thp, &hshift);
> +		if (!is_thp)
> +			shift = PAGE_SHIFT;

It can still be hugetlb if is_thp is false.

> +		else if (hshift && !is_thp)
> +			shift = hshift;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		else
> +			shift = HPAGE_PMD_SIZE;

That is wrong. I guess it should be shift = HPAGE_PMD_SHIFT. But i am
not sure we need to make it this complex at all. See below.

> +#else
> +		else {
> +			shift = PAGE_SHIFT;
> +			pr_warn_once("unsupport page size for mm %p,addr %lx\n",
> +					mm, start);
> +		}
> +#endif

I am still not sure this is correct from a pure page table walking
point. Why not

       if (hshift)
          shift = hshift;
       else
          shift = PAGE_SHIFT;

if you didn't want to differentiate between thp and hugetlb mapping you
can drop is_thp completely.

-aneesh

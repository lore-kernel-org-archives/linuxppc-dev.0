Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRThk3pKpzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 14:32:22 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1K3T9ax040872
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:32:20 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28pp6m2p55-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:32:20 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 20:32:19 -0700
Subject: Re: [PATCH] powerpc/mm/hugetlb: Filter out hugepage size not
 supported by page table layout
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
References: <1487499527-16166-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487538354.23576.158.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 09:02:03 +0530
MIME-Version: 1.0
In-Reply-To: <1487538354.23576.158.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fdc5f84d-f337-24e6-e116-e34cf6ff722b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 20 February 2017 02:35 AM, Benjamin Herrenschmidt wrote:
> On Sun, 2017-02-19 at 15:48 +0530, Aneesh Kumar K.V wrote:
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +       /*
>> +        * We need to make sure that for different page sizes reported by
>> +        * firmware we only add hugetlb support for page sizes that can be
>> +        * supported by linux page table layout.
>> +        * For now we have
>> +        * Radix: 2M
>> +        * Hash: 16M and 16G
>> +        */
>> +       if (radix_enabled()) {
>> +               if (mmu_psize != MMU_PAGE_2M)
>> +                       return -EINVAL;
>> +       } else {
>> +               if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
>> +                       return -EINVAL;
>> +       }
> Hash could support others...

On book3s 64 ? I had the above within #ifdef.

> Same with radix and PUD level pages.

Yes, but gigantic hugepage is not yet supported. Once we add that we will
add MMU_PAGE_1G here.


>
> Why do we need that ? Won't FW provide separate properties for hash and
> radix page sizes anyway ?
>

To avoid crashes like the one reported in the commit message due to 
buggy firmware ? Also
It can serve as an easy way to understand what hugepage sizes are 
supported by different platforms.
I am yet to figure out what the FSL_BOOK3E and PPC_8xx #ifdef above that 
hunk is all about. Having
the supported hugepage size clearly verified against makes it easy ?

-aneesh

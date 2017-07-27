Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJHJs2RvzzDrL8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 02:20:45 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RGJIEc127929
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:20:43 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byjw2j5fu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:20:43 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 10:20:41 -0600
Subject: Re: [PATCH v3 1/3] mm/hugetlb: Allow arch to override and call the
 weak function
To: Michal Hocko <mhocko@kernel.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20170727061828.11406-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727130123.GE27766@dhcp22.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 21:50:35 +0530
MIME-Version: 1.0
In-Reply-To: <20170727130123.GE27766@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e963e910-1999-ddff-87cf-9e8c356fea82@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/27/2017 06:31 PM, Michal Hocko wrote:
> On Thu 27-07-17 11:48:26, Aneesh Kumar K.V wrote:
>> For ppc64, we want to call this function when we are not running as guest.
> 
> What does this mean?
> 

ppc64 guest (aka LPAR) support a different mechanism for hugetlb 
allocation/reservation. The LPAR management application called HMC can 
be used to reserve a set of hugepages and we pass the details of 
reserved pages via device tree to the guest. You can find the details in
htab_dt_scan_hugepage_blocks() . We do the memblock_reserve of the range 
and later in the boot sequence, we just add the reserved range to
huge_boot_pages.

For baremetal config (when we are not running as guest) we want to 
follow what other architecture does, that is look at the command line 
and do memblock allocation. Hence the need to call generic function 
__alloc_bootmem_huge_page() in that case.

I can add all these details in to the commit message if that makes it easy ?

-aneesh

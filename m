Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJGpP37QqzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 01:57:49 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RFuULK119861
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:57:47 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byk5cgc4f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:57:46 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 09:57:45 -0600
Subject: Re: [RFC PATCH 3/3] mm/hugetlb: Remove pmd_huge_split_prepare
To: Michal Hocko <mhocko@kernel.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727083756.32217-3-aneesh.kumar@linux.vnet.ibm.com>
 <20170727125756.GD27766@dhcp22.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 21:27:37 +0530
MIME-Version: 1.0
In-Reply-To: <20170727125756.GD27766@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6d836bdb-0bf4-e855-e3d8-01a622714d1b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/27/2017 06:27 PM, Michal Hocko wrote:
> On Thu 27-07-17 14:07:56, Aneesh Kumar K.V wrote:
>> Instead of marking the pmd ready for split, invalidate the pmd. This should
>> take care of powerpc requirement.
> 
> which is?

I can add the commit which explain details here. Or add more details 
from the older commit here.

c777e2a8b65420b31dac28a453e35be984f5808b

powerpc/mm: Fix Multi hit ERAT cause by recent THP update


> 
>> Only side effect is that we mark the pmd
>> invalid early. This can result in us blocking access to the page a bit longer
>> if we race against a thp split.
> 
> Again, this doesn't tell me what is the problem and why do we care.

Primary motivation is code reduction.

   7 files changed, 35 insertions(+), 87 deletions(-)


-aneesh

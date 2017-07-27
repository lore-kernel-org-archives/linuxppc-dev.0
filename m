Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJGjC1761zDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 01:53:18 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RFrCDK035507
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:53:16 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byjw2gt8n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:53:14 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 09:53:02 -0600
Subject: Re: [RFC PATCH 2/3] powerpc/mm: Implement pmdp_establish for ppc64
To: Michal Hocko <mhocko@kernel.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727083756.32217-2-aneesh.kumar@linux.vnet.ibm.com>
 <20170727125644.GC27766@dhcp22.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 21:22:55 +0530
MIME-Version: 1.0
In-Reply-To: <20170727125644.GC27766@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1cd105a8-5d07-0768-867c-54e678f5f828@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/27/2017 06:26 PM, Michal Hocko wrote:
> On Thu 27-07-17 14:07:55, Aneesh Kumar K.V wrote:
>> We can now use this to set pmd page table entries to absolute values. THP
>> need to ensure that we always update pmd PTE entries such that we never mark
>> the pmd none. pmdp_establish helps in implementing that.
>>
>> This doesn't flush the tlb. Based on the old_pmd value returned caller can
>> decide to call flush_pmd_tlb_range()
> 
> _Why_ do we need this. It doesn't really help that the newly added
> function is not used so we could check that...


We were looking at having pmdp_establish used by the core code. But i 
guess Kirill ended up using pmdp_invalidate. If we don't have 
pmdp_establish usage in core code, we can drop this. This is to help 
Kiril make progress with series at


https://lkml.kernel.org/r/20170615145224.66200-1-kirill.shutemov@linux.intel.com


Also thinking about the interface further, I guess pmdp_establish 
interface is some what confusing. So we may want to rethink this 
further. I know that i asked for pmdp_establish in earlier review of 
Kirill's patchset. But now looking back i am not sure we can clearly 
explain only semantic requirement of pmdp_establish. One thing we may 
want to clarify is whether we should retain the Reference and change bit 
from the old entry when we are doing a pmdp_establish ?

Kirill,

Considering core code is still only using pmdp_invalidate(), we may want 
to drop this interface completely ?

-aneesh

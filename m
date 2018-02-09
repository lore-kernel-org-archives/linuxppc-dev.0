Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdJvg5YbTzF0nD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 02:31:59 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w19FVFO9143608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Feb 2018 10:31:57 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1c3my3xp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 10:31:46 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 08:31:39 -0700
Subject: Re: [PATCH 1/2] powerpc/mm: Fix crashes with PUD level hugetlb config
To: Ram Pai <linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <20180208103442.22045-1-aneesh.kumar@linux.vnet.ibm.com>
 <87r2pvfr5g.fsf@linux.vnet.ibm.com>
 <20180208192930.GB5559@ram.oc3035372033.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 21:01:32 +0530
MIME-Version: 1.0
In-Reply-To: <20180208192930.GB5559@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e893e512-dc98-4f80-4538-0709aca81e0f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/09/2018 12:59 AM, Ram Pai wrote:
> On Thu, Feb 08, 2018 at 08:46:27PM +0530, Aneesh Kumar K.V wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>
>>> To support memory keys, we moved the hash pte slot information to the second
>>> half of the page table. This was ok with PTE entries at level 4 and level 3.
>>> We already allocate larger page table pages at those level to accomodate extra
>>> details. For level 4 we already have the extra space which was used to track
>>> 4k hash page table entry details and at pmd level the extra space was allocated
>>> to track the THP details.
>>>
>>> With hugetlbfs PTE, we used this extra space at the PMD level to store the
>>> slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
>>> didn't allocate extra space. This resulted in memory corruption.
>>>
>>> Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
>>> may need further changes to allocate larger space at PMD level when we enable
>>> HUGETLB. That will be done in next patch.
>>>
>>> Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>
>> Another fix, I still get random memory corruption with hugetlb test with
>> 16G hugepage config.
> 
> this fix may not be needed. It random corruption may be artifact of the typo you
> had in your first patch?

Why? the tables at level 2 and leve3 are of different size and we should 
use the right offset to store the slot details. Even with the change you 
mentioned in the previous mail, I still have kernel crashes with 
hugetlbfs test running in parallel to a kernel build.

-aneesh

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFf1S5h1gzDvnq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 23:12:28 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABC8t8M113090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 07:12:26 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nc3t62cd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 07:12:26 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 05:12:25 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] mm: THP page cache support for ppc64
In-Reply-To: <20161111101439.GB19382@node.shutemov.name>
References: <20161107083441.21901-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161107083441.21901-2-aneesh.kumar@linux.vnet.ibm.com>
 <20161111101439.GB19382@node.shutemov.name>
Date: Fri, 11 Nov 2016 17:42:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737iy1ahw.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Mon, Nov 07, 2016 at 02:04:41PM +0530, Aneesh Kumar K.V wrote:
>> @@ -2953,6 +2966,13 @@ static int do_set_pmd(struct fault_env *fe, struct page *page)
>>  	ret = VM_FAULT_FALLBACK;
>>  	page = compound_head(page);
>>  
>> +	/*
>> +	 * Archs like ppc64 need additonal space to store information
>> +	 * related to pte entry. Use the preallocated table for that.
>> +	 */
>> +	if (arch_needs_pgtable_deposit() && !fe->prealloc_pte)
>> +		fe->prealloc_pte = pte_alloc_one(vma->vm_mm, fe->address);
>> +
>
> -ENOMEM handling?

How about

	if (arch_needs_pgtable_deposit() && !fe->prealloc_pte) {
		fe->prealloc_pte = pte_alloc_one(vma->vm_mm, fe->address);
		if (!fe->prealloc_pte)
			return VM_FAULT_OOM;
	}



>
> I think we should do this way before this point. Maybe in do_fault() or
> something.

doing this in do_set_pmd keeps this closer to where we set the pmd. Any
reason you thing we should move it higher up the stack. We already do
pte_alloc() at the same level for a non transhuge case in
alloc_set_pte().

-aneesh

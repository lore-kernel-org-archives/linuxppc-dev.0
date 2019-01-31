Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BDAC4151A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:08:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D6C2084A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D6C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qpDM29KMzDqT3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 16:08:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qpBj50BRzDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:07:25 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V4xIht022885
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 00:07:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qbsrcsyms-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 00:07:23 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 31 Jan 2019 05:07:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 05:07:17 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0V57GjZ8651114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 05:07:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9D9A11C052;
 Thu, 31 Jan 2019 05:07:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD27C11C04A;
 Thu, 31 Jan 2019 05:07:14 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.38.122])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 31 Jan 2019 05:07:14 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 x86@kernel.org
Subject: Re: [PATCH V5 3/5] arch/powerpc/mm: Nest MMU workaround for mprotect
 RW upgrade.
In-Reply-To: <87fttaqux5.fsf@concordia.ellerman.id.au>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
 <20190116085035.29729-4-aneesh.kumar@linux.ibm.com>
 <87fttaqux5.fsf@concordia.ellerman.id.au>
Date: Thu, 31 Jan 2019 10:37:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19013105-4275-0000-0000-0000030821E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013105-4276-0000-0000-0000381629CB
Message-Id: <87k1ilo1oe.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310039
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> NestMMU requires us to mark the pte invalid and flush the tlb when we do a
>> RW upgrade of pte. We fixed a variant of this in the fault path in commit
>> Fixes: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
>
> You don't want the "Fixes:" there.
>
>>
>> Do the same for mprotect upgrades.
>>
>> Hugetlb is handled in the next patch.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++++++
>>  arch/powerpc/include/asm/book3s/64/radix.h   |  4 ++++
>>  arch/powerpc/mm/pgtable-book3s64.c           | 25 ++++++++++++++++++++
>>  arch/powerpc/mm/pgtable-radix.c              | 18 ++++++++++++++
>>  4 files changed, 65 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 2e6ada28da64..92eaea164700 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -1314,6 +1314,24 @@ static inline int pud_pfn(pud_t pud)
>>  	BUILD_BUG();
>>  	return 0;
>>  }
>
> Can we get a blank line here?
>
>> +#define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>> +pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, pte_t *);
>> +void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
>> +			     pte_t *, pte_t, pte_t);
>
> So these are not inline ...
>
>> +/*
>> + * Returns true for a R -> RW upgrade of pte
>> + */
>> +static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_val)
>> +{
>> +	if (!(old_val & _PAGE_READ))
>> +		return false;
>> +
>> +	if ((!(old_val & _PAGE_WRITE)) && (new_val & _PAGE_WRITE))
>> +		return true;
>> +
>> +	return false;
>> +}
>>  
>>  #endif /* __ASSEMBLY__ */
>>  #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
>> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
>> index f3c31f5e1026..47c742f002ea 100644
>> --- a/arch/powerpc/mm/pgtable-book3s64.c
>> +++ b/arch/powerpc/mm/pgtable-book3s64.c
>> @@ -400,3 +400,28 @@ void arch_report_meminfo(struct seq_file *m)
>>  		   atomic_long_read(&direct_pages_count[MMU_PAGE_1G]) << 20);
>>  }
>>  #endif /* CONFIG_PROC_FS */
>> +
>> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
>> +			     pte_t *ptep)
>> +{
>> +	unsigned long pte_val;
>> +
>> +	/*
>> +	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
>> +	 * possible. Also keep the pte_present true so that we don't take
>> +	 * wrong fault.
>> +	 */
>> +	pte_val = pte_update(vma->vm_mm, addr, ptep, _PAGE_PRESENT, _PAGE_INVALID, 0);
>> +
>> +	return __pte(pte_val);
>> +
>> +}
>> +
>> +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
>> +			     pte_t *ptep, pte_t old_pte, pte_t pte)
>> +{
>
> Which means we're going to be doing a function call to get to here ...
>
>> +	if (radix_enabled())
>> +		return radix__ptep_modify_prot_commit(vma, addr,
>> +						      ptep, old_pte, pte);
>
> And then another function call to get to the radix version ...
>
>> +	set_pte_at(vma->vm_mm, addr, ptep, pte);
>> +}
>> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
>> index 931156069a81..dced3cd241c2 100644
>> --- a/arch/powerpc/mm/pgtable-radix.c
>> +++ b/arch/powerpc/mm/pgtable-radix.c
>> @@ -1063,3 +1063,21 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
>>  	}
>>  	/* See ptesync comment in radix__set_pte_at */
>>  }
>> +
>> +void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
>> +				    unsigned long addr, pte_t *ptep,
>> +				    pte_t old_pte, pte_t pte)
>> +{
>> +	struct mm_struct *mm = vma->vm_mm;
>> +
>> +	/*
>> +	 * To avoid NMMU hang while relaxing access we need to flush the tlb before
>> +	 * we set the new value. We need to do this only for radix, because hash
>> +	 * translation does flush when updating the linux pte.
>> +	 */
>> +	if (is_pte_rw_upgrade(pte_val(old_pte), pte_val(pte)) &&
>> +	    (atomic_read(&mm->context.copros) > 0))
>> +		radix__flush_tlb_page(vma, addr);
>
> To finally get here, where we'll realise that 99.99% of processes don't
> use copros and so we have nothing to do except set the PTE.
>
>> +
>> +	set_pte_at(mm, addr, ptep, pte);
>> +}
>
> So can we just make it all inline in the header? Or do we think it's not
> a hot enough path to worry about it?
>

I did try that earlier, But IIRC that didn't work due to header
inclusion issue. I can try that again in an addon patch. That would
require moving things around so that we find different struct
definitions correctly.

-aneesh


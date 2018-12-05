Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4BC04EBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:08:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DB92081C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DB92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438lbK5KZ2zDqKl
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 15:08:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 438lY91DZSzDqML
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 15:06:52 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB544jtI116513
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Dec 2018 23:06:50 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p63xf7vee-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 23:06:50 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 5 Dec 2018 04:06:49 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Dec 2018 04:06:46 -0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB546jQO20643910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 04:06:46 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E11376E04E;
 Wed,  5 Dec 2018 04:06:45 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46A156E052;
 Wed,  5 Dec 2018 04:06:43 +0000 (GMT)
Received: from [9.85.73.253] (unknown [9.85.73.253])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  5 Dec 2018 04:06:42 +0000 (GMT)
Subject: Re: [PATCH V3 2/5] mm: update ptep_modify_prot_commit to take old pte
 value as arg
To: Christophe LEROY <christophe.leroy@c-s.fr>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org
References: <20181205030931.12037-1-aneesh.kumar@linux.ibm.com>
 <20181205030931.12037-3-aneesh.kumar@linux.ibm.com>
 <f446afd3-a77d-cc5a-1ac8-3992090bcd7d@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 5 Dec 2018 09:36:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <f446afd3-a77d-cc5a-1ac8-3992090bcd7d@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120504-0036-0000-0000-00000A659C5A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010173; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127151; UDB=6.00585436; IPR=6.00907286; 
 MB=3.00024451; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-05 04:06:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120504-0037-0000-0000-000049DD81AA
Message-Id: <48f13462-1695-a759-9df8-1ef60fd88196@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-04_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=623 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050036
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

On 12/5/18 9:32 AM, Christophe LEROY wrote:
> 
> 
> Le 05/12/2018 à 04:09, Aneesh Kumar K.V a écrit :
>> Architectures like ppc64 requires to do a conditional tlb flush based 
>> on the old
>> and new value of pte. Enable that by passing old pte value as the arg.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pgtable.h | 3 ++-
>>   arch/s390/mm/pgtable.c          | 2 +-
>>   arch/x86/include/asm/paravirt.h | 2 +-
>>   fs/proc/task_mmu.c              | 8 +++++---
>>   include/asm-generic/pgtable.h   | 2 +-
>>   mm/memory.c                     | 8 ++++----
>>   mm/mprotect.c                   | 6 +++---
>>   7 files changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h 
>> b/arch/s390/include/asm/pgtable.h
>> index 5d730199e37b..76dc344edb8c 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -1070,7 +1070,8 @@ static inline pte_t ptep_get_and_clear(struct 
>> mm_struct *mm,
>>   #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>>   pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, 
>> pte_t *);
>> -void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long, 
>> pte_t *, pte_t);
>> +void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
>> +                 pte_t *, pte_t, pte_t);
>>   #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
>>   static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
>> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
>> index 29c0a21cd34a..b283b92722cc 100644
>> --- a/arch/s390/mm/pgtable.c
>> +++ b/arch/s390/mm/pgtable.c
>> @@ -322,7 +322,7 @@ pte_t ptep_modify_prot_start(struct vm_area_struct 
>> *vma, unsigned long addr,
>>   EXPORT_SYMBOL(ptep_modify_prot_start);
>>   void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned 
>> long addr,
>> -                 pte_t *ptep, pte_t pte)
>> +                 pte_t *ptep, pte_t old_pte, pte_t pte)
>>   {
>>       pgste_t pgste;
>>       struct mm_struct *mm = vma->vm_mm;
>> diff --git a/arch/x86/include/asm/paravirt.h 
>> b/arch/x86/include/asm/paravirt.h
>> index 1154f154025d..0d75a4f60500 100644
>> --- a/arch/x86/include/asm/paravirt.h
>> +++ b/arch/x86/include/asm/paravirt.h
>> @@ -429,7 +429,7 @@ static inline pte_t ptep_modify_prot_start(struct 
>> vm_area_struct *vma, unsigned
>>   }
>>   static inline void ptep_modify_prot_commit(struct vm_area_struct 
>> *vma, unsigned long addr,
>> -                       pte_t *ptep, pte_t pte)
>> +                       pte_t *ptep, pte_t old_pte, pte_t pte)
>>   {
>>       struct mm_struct *mm = vma->vm_mm;
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 9952d7185170..8d62891d38a8 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -940,10 +940,12 @@ static inline void clear_soft_dirty(struct 
>> vm_area_struct *vma,
>>       pte_t ptent = *pte;
>>       if (pte_present(ptent)) {
>> -        ptent = ptep_modify_prot_start(vma, addr, pte);
>> -        ptent = pte_wrprotect(ptent);
>> +        pte_t old_pte;
>> +
>> +        old_pte = ptep_modify_prot_start(vma, addr, pte);
>> +        ptent = pte_wrprotect(old_pte);
> 
> This change doesn't seem to fit with the commit description. Why write 
> protecting in addition to clearing dirty ?
> 
>

The hunk above use a new variable old_pte. There is no functional change 
in that hunk.

-aneesh


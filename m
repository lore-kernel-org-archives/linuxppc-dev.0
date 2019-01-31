Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFAEC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:05:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D776D2087F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D776D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qp8B3gSSzDqT3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 16:05:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qp6W5yHbzDqR0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:03:47 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V4xJai135779
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 00:03:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qbn28c35n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 00:03:45 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 31 Jan 2019 05:03:42 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 05:03:38 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0V53bGp57016466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 05:03:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B176C11C04C;
 Thu, 31 Jan 2019 05:03:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A602811C04A;
 Thu, 31 Jan 2019 05:03:35 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.38.122])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 31 Jan 2019 05:03:35 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 x86@kernel.org
Subject: Re: [PATCH V5 2/5] mm: update ptep_modify_prot_commit to take old pte
 value as arg
In-Reply-To: <87imy6qv74.fsf@concordia.ellerman.id.au>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
 <20190116085035.29729-3-aneesh.kumar@linux.ibm.com>
 <87imy6qv74.fsf@concordia.ellerman.id.au>
Date: Thu, 31 Jan 2019 10:33:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19013105-4275-0000-0000-00000308218A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013105-4276-0000-0000-00003816296C
Message-Id: <87munho1uh.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=788 adultscore=0 classifier=spam adjust=0 reason=mlx
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
>
>> Architectures like ppc64 require to do a conditional tlb flush based on the old
>> and new value of pte. Enable that by passing old pte value as the arg.
>
> It's not actually the architecture, it's to work around a specific bug
> on Power9.
>
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index c89ce07923c8..028c724dcb1a 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -110,8 +110,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>>  					continue;
>>  			}
>>  
>> -			ptent = ptep_modify_prot_start(vma, addr, pte);
>> -			ptent = pte_modify(ptent, newprot);
>> +			oldpte = ptep_modify_prot_start(vma, addr, pte);
>> +			ptent = pte_modify(oldpte, newprot);
>>  			if (preserve_write)
>>  				ptent = pte_mk_savedwrite(ptent);
>
> Is it OK to reuse oldpte here?
>
> It was set at the top of the loop with:
>
> 		oldpte = *pte;
>
> Is it guaranteed that ptep_modify_prot_start() returns the old value
> unmodified, or could an implementation conceivably filter some bits out?
>
> If so then it could be confusing for oldpte to have its value change
> half way through the loop.
>

ptep_modify_prot_start and ptep_modify_prot_commit is the sequence that
we can safely use to do read/modify/update of a pte entry. Now w.r.t old
pte, we can't update the pte bits from software because we are holding
the page table lock(ptl). Now we could definitely end up having updated
reference and change bit. But we make sure we don't lose those by using
prot_start and prot_commit sequence.

-aneesh


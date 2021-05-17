Return-Path: <SRS0=r+Zg=KM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F10C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 05:56:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6056121F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 05:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6056121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fk7fy1m5vz303q
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 15:56:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gtXHityc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=gtXHityc; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fk7fM2Z6yz2xvT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2021 15:55:54 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14H5YFXq185628; Mon, 17 May 2021 01:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HE9+U6VXKlLDZ96Dhj3/3TC1N6EmBi6MwAzmbalrBvg=;
 b=gtXHitycahuN/vqsu6qHtVRx8N24SxDpyAavU0hTIBAMJdSJK7WhA35K+ldIn7mNOED8
 e9tB1+tDuOK9faLrcURrMX57imvnwvX0heWvmgrhMP31Wi++S0blMRDs+qijL6Dy1NqU
 b0yGX6gOytjn4/+V5POPj53DBYGD8mtW+QUgWYZ6bgP4KHqkn1LILOCNcltVWQy3uuMy
 BoCHVQPPOUJAEy0It5HGfKTmZs9fTo/uQWXjgt13NvxKx3UvFuhUutVeMf2/yW5jlumO
 aAwlAV9jCF6bvqwxL/R8GOoySWSw7/bXaZQPnF+09mmiFTh+/casPz4n2uQA0cchJkk8 pA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38kf3fv6hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 May 2021 01:55:42 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14H5qSbn004032;
 Mon, 17 May 2021 05:55:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 38j5x80apx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 May 2021 05:55:39 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 14H5t9n428115282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 May 2021 05:55:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CE2911C050;
 Mon, 17 May 2021 05:55:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44DDC11C04A;
 Mon, 17 May 2021 05:55:36 +0000 (GMT)
Received: from [9.199.40.240] (unknown [9.199.40.240])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 17 May 2021 05:55:36 +0000 (GMT)
Subject: Re: Fwd: [Bug 213069] New: kernel BUG at
 arch/powerpc/include/asm/book3s/64/hash-4k.h:147! Oops: Exception in kernel
 mode, sig: 5 [#1]
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <bug-213069-206035@https.bugzilla.kernel.org/>
 <4deb5cd5-c713-b020-9143-c74a031e3fd5@csgroup.eu>
 <a8841b4e-3bff-f600-eac7-501f78ced54b@arm.com>
 <7ebc28ad-61e3-ef43-d670-9b80a61268c4@csgroup.eu>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <e9558e0a-314e-ddfd-6776-84c1bfe6f01f@linux.ibm.com>
Date: Mon, 17 May 2021 11:25:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7ebc28ad-61e3-ef43-d670-9b80a61268c4@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qa7Qprig4BaZcRHKpjZakZ3sBrF79pvk
X-Proofpoint-GUID: qa7Qprig4BaZcRHKpjZakZ3sBrF79pvk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-17_01:2021-05-12,
 2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170039
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/17/21 11:17 AM, Christophe Leroy wrote:
> +aneesh
> +linuxppc-dev list
> 
> Le 17/05/2021 à 07:44, Anshuman Khandual a écrit :
>> Hello Christophe,
>>
>> DEBUG_VM_PGTABLE has now been re-enabled on powerpc recently ? was not
>> aware about this. From the error log, it failed explicitly on 4K page
>> size hash config.
>>
>> static inline pmd_t hash__pmd_mkhuge(pmd_t pmd)
>> {
>>          BUG();        ------> Failed
>>          return pmd;
>> }
>>
>> static inline pmd_t __pmd_mkhuge(pmd_t pmd)
>> {
>>          if (radix_enabled())
>>                  return radix__pmd_mkhuge(pmd);
>>          return hash__pmd_mkhuge(pmd);
>> }
>>
>> pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
>> {
>>          unsigned long pmdv;
>>
>>          pmdv = (pfn << PAGE_SHIFT) & PTE_RPN_MASK;
>>
>>          return __pmd_mkhuge(pmd_set_protbits(__pmd(pmdv), pgprot));
>> }
>>
>> It seems like on powerpc, where pfn_pmd() makes a huge page but which
>> is not supported on 4K hash config thus triggering the BUG(). But all
>> pfn_pmd() call sites inside the debug_vm_pgtable() test are protected
>> with CONFIG_TRANSPARENT_HUGEPAGE. IIUC unlike powerpc, pfn_pmd() does
>> not directly make a huge page on other platforms.
>>
>> Looking at arch/powerpc/include/asm/book3s/64/hash-4k.h, all relevant
>> THP helpers has BUG() or 0 which indicates THP might not be supported
>> on 4K page size hash config ?
>>
>> But looking at arch/powerpc/platforms/Kconfig.cputype, it seems like
>> HAVE_ARCH_TRANSPARENT_HUGEPAGE is invariably selected on PPC_BOOK3S_64
>> platforms which I assume includes 4K page size hash config as well.
>>
>> Is THP some how getting enabled on this 4K page size hash config where
>> it should not be (thus triggering the BUG) ? OR am I missing something
>> here.
>>
>

We should put those  pfn_pmd()  and pfn_pud() after

	if (!has_transparent_hugepage())
		return;


On hash with 4K page size, we can't support leaf page table entry and 
PMD and PUD level. Hence we don't support THP for them.

-aneesh

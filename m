Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABC5C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:16:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25898218D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25898218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q3nC16V6zDqSZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:16:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q3N21TfyzDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 00:58:10 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3OEsTHu123349
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:58:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s2s1puy3y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:58:07 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.ibm.com>;
 Wed, 24 Apr 2019 15:58:04 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Apr 2019 15:57:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3OEvrA663176882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2019 14:57:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6642AAE04D;
 Wed, 24 Apr 2019 14:57:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93EFBAE051;
 Wed, 24 Apr 2019 14:57:50 +0000 (GMT)
Received: from [9.145.176.48] (unknown [9.145.176.48])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2019 14:57:50 +0000 (GMT)
Subject: Re: [PATCH v12 23/31] mm: don't do swap readahead during speculative
 page fault
To: Jerome Glisse <jglisse@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-24-ldufour@linux.ibm.com>
 <20190422213611.GN14666@redhat.com>
From: Laurent Dufour <ldufour@linux.ibm.com>
Date: Wed, 24 Apr 2019 16:57:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422213611.GN14666@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042414-0016-0000-0000-000002732720
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042414-0017-0000-0000-000032CF99CC
Message-Id: <42ba3103-cbac-199f-e6f1-0fbc12aaccc8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-24_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240116
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
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Punit Agrawal <punitagrawal@gmail.com>, hpa@zytor.com,
 Michel Lespinasse <walken@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>, paulmck@linux.vnet.ibm.com,
 Haiyan Song <haiyanx.song@intel.com>, npiggin@gmail.com, sj38.park@gmail.com,
 dave@stgolabs.net, kemi.wang@intel.com, kirill@shutemov.name,
 Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Vinayak Menon <vinmenon@codeaurora.org>,
 vinayak menon <vinayakm.list@gmail.com>, akpm@linux-foundation.org,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 22/04/2019 à 23:36, Jerome Glisse a écrit :
> On Tue, Apr 16, 2019 at 03:45:14PM +0200, Laurent Dufour wrote:
>> Vinayak Menon faced a panic because one thread was page faulting a page in
>> swap, while another one was mprotecting a part of the VMA leading to a VMA
>> split.
>> This raise a panic in swap_vma_readahead() because the VMA's boundaries
>> were not more matching the faulting address.
>>
>> To avoid this, if the page is not found in the swap, the speculative page
>> fault is aborted to retry a regular page fault.
>>
>> Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> Note that you should also skip non swap entry in do_swap_page() when doing
> speculative page fault at very least you need to is_device_private_entry()
> case.
> 
> But this should either be part of patch 22 or another patch to fix swap
> case.

Thanks Jérôme,

Yes I missed that, I guess the best option would be to abort on non swap 
entry. I'll add that in the patch 22.

>> ---
>>   mm/memory.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 6e6bf61c0e5c..1991da97e2db 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -2900,6 +2900,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>   				lru_cache_add_anon(page);
>>   				swap_readpage(page, true);
>>   			}
>> +		} else if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
>> +			/*
>> +			 * Don't try readahead during a speculative page fault
>> +			 * as the VMA's boundaries may change in our back.
>> +			 * If the page is not in the swap cache and synchronous
>> +			 * read is disabled, fall back to the regular page
>> +			 * fault mechanism.
>> +			 */
>> +			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
>> +			ret = VM_FAULT_RETRY;
>> +			goto out;
>>   		} else {
>>   			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>>   						vmf);
>> -- 
>> 2.21.0
>>
> 


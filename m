Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A695C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:59:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5D720693
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5D720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pt4N6jN4zDqWy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:59:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pt2Y43kDzDqRL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 17:57:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3O7noqD002985
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 03:57:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2s2k61syvu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 03:57:22 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.ibm.com>;
 Wed, 24 Apr 2019 08:57:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Apr 2019 08:57:10 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3O7v8vK29819118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2019 07:57:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DA4CA4051;
 Wed, 24 Apr 2019 07:57:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFE5FA4040;
 Wed, 24 Apr 2019 07:57:05 +0000 (GMT)
Received: from [9.145.184.124] (unknown [9.145.184.124])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2019 07:57:05 +0000 (GMT)
Subject: Re: [PATCH v12 21/31] mm: Introduce find_vma_rcu()
To: Peter Zijlstra <peterz@infradead.org>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-22-ldufour@linux.ibm.com>
 <20190423092710.GI11158@hirez.programming.kicks-ass.net>
From: Laurent Dufour <ldufour@linux.ibm.com>
Date: Wed, 24 Apr 2019 09:57:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423092710.GI11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042407-0012-0000-0000-00000312C636
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042407-0013-0000-0000-0000214B1A4D
Message-Id: <ea141f88-a0d3-df97-5141-706fa18b7ad3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-24_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=914 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240068
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
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com,
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
 Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net, kemi.wang@intel.com,
 kirill@shutemov.name, Thomas Gleixner <tglx@linutronix.de>,
 zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>, akpm@linux-foundation.org,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 23/04/2019 à 11:27, Peter Zijlstra a écrit :
> On Tue, Apr 16, 2019 at 03:45:12PM +0200, Laurent Dufour wrote:
>> This allows to search for a VMA structure without holding the mmap_sem.
>>
>> The search is repeated while the mm seqlock is changing and until we found
>> a valid VMA.
>>
>> While under the RCU protection, a reference is taken on the VMA, so the
>> caller must call put_vma() once it not more need the VMA structure.
>>
>> At the time a VMA is inserted in the MM RB tree, in vma_rb_insert(), a
>> reference is taken to the VMA by calling get_vma().
>>
>> When removing a VMA from the MM RB tree, the VMA is not release immediately
>> but at the end of the RCU grace period through vm_rcu_put(). This ensures
>> that the VMA remains allocated until the end the RCU grace period.
>>
>> Since the vm_file pointer, if valid, is released in put_vma(), there is no
>> guarantee that the file pointer will be valid on the returned VMA.
> 
> What I'm missing here, and in the previous patch introducing the
> refcount (also see refcount_t), is _why_ we need the refcount thing at
> all.

The need for the VMA's refcount is to ensure that the VMA will remain 
until the end of the SPF handler. This is a consequence of the use of 
RCU instead of SRCU to protect the RB tree.

I was not aware of the refcount_t type, it would be better here to avoid 
wrapping.

> My original plan was to use SRCU, which at the time was not complete
> enough so I abused/hacked preemptible RCU, but that is no longer the
> case, SRCU has all the required bits and pieces.

When I did test using SRCU it was involving a lot a scheduling to run 
the SRCU callback mechanism. In some workload the impact on the 
perfomance was significant [1].

I can't see this overhead using RCU.

> 
> Also; the initial motivation was prefaulting large VMAs and the
> contention on mmap was killing things; but similarly, the contention on
> the refcount (I did try that) killed things just the same.

Doing prefaulting should be doable, I'll try to think further about that.

Regarding the refcount, I should I missed something, this is an atomic 
counter, so there should not be contention on it but cache exclusivity, 
not ideal I agree but I can't see what else to use here.

> So I'm really sad to see the refcount return; and without any apparent
> justification.

I'm not opposed to use another mechanism here, but SRCU didn't show good 
performance with some workload, and I can't see how to use RCU without a 
reference counter here. So please, advise.

Thanks,
Laurent.

[1] 
https://lore.kernel.org/linux-mm/7ca80231-fe02-a3a7-84bc-ce81690ea051@intel.com/


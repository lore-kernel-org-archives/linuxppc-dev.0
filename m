Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F5CC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA47218FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA47218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q3HT6Zj9zDq9d
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 00:54:13 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q3220MCwzDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 00:42:33 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3OEg8mt113487
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:42:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2s2s8u9unj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:42:27 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.ibm.com>;
 Wed, 24 Apr 2019 15:39:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Apr 2019 15:39:06 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3OEd5ka54394892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2019 14:39:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 045A7AE07D;
 Wed, 24 Apr 2019 14:39:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CA9EAE063;
 Wed, 24 Apr 2019 14:39:02 +0000 (GMT)
Received: from [9.145.176.48] (unknown [9.145.176.48])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2019 14:39:02 +0000 (GMT)
Subject: Re: [PATCH v12 21/31] mm: Introduce find_vma_rcu()
To: Jerome Glisse <jglisse@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-22-ldufour@linux.ibm.com>
 <20190422205721.GL14666@redhat.com>
From: Laurent Dufour <ldufour@linux.ibm.com>
Date: Wed, 24 Apr 2019 16:39:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422205721.GL14666@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042414-4275-0000-0000-0000032C30CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042414-4276-0000-0000-0000383B79FB
Message-Id: <b3247537-4ba8-bea3-fecc-74759bd0a873@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-24_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240114
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
 dave@stgolabs.net, kirill@shutemov.name, Thomas Gleixner <tglx@linutronix.de>,
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

Le 22/04/2019 à 22:57, Jerome Glisse a écrit :
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
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> 
> Minor comments about comment (i love recursion :)) see below.
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Thanks Jérôme, see my comments to your comments on my comments below ;)

>> ---
>>   include/linux/mm_types.h |  1 +
>>   mm/internal.h            |  5 ++-
>>   mm/mmap.c                | 76 ++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 78 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 6a6159e11a3f..9af6694cb95d 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -287,6 +287,7 @@ struct vm_area_struct {
>>   
>>   #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>>   	atomic_t vm_ref_count;
>> +	struct rcu_head vm_rcu;
>>   #endif
>>   	struct rb_node vm_rb;
>>   
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 302382bed406..1e368e4afe3c 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -55,7 +55,10 @@ static inline void put_vma(struct vm_area_struct *vma)
>>   		__free_vma(vma);
>>   }
>>   
>> -#else
>> +extern struct vm_area_struct *find_vma_rcu(struct mm_struct *mm,
>> +					   unsigned long addr);
>> +
>> +#else /* CONFIG_SPECULATIVE_PAGE_FAULT */
>>   
>>   static inline void get_vma(struct vm_area_struct *vma)
>>   {
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index c106440dcae7..34bf261dc2c8 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -179,6 +179,18 @@ static inline void mm_write_sequnlock(struct mm_struct *mm)
>>   {
>>   	write_sequnlock(&mm->mm_seq);
>>   }
>> +
>> +static void __vm_rcu_put(struct rcu_head *head)
>> +{
>> +	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
>> +						  vm_rcu);
>> +	put_vma(vma);
>> +}
>> +static void vm_rcu_put(struct vm_area_struct *vma)
>> +{
>> +	VM_BUG_ON_VMA(!RB_EMPTY_NODE(&vma->vm_rb), vma);
>> +	call_rcu(&vma->vm_rcu, __vm_rcu_put);
>> +}
>>   #else
>>   static inline void mm_write_seqlock(struct mm_struct *mm)
>>   {
>> @@ -190,6 +202,8 @@ static inline void mm_write_sequnlock(struct mm_struct *mm)
>>   
>>   void __free_vma(struct vm_area_struct *vma)
>>   {
>> +	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
>> +		VM_BUG_ON_VMA(!RB_EMPTY_NODE(&vma->vm_rb), vma);
>>   	mpol_put(vma_policy(vma));
>>   	vm_area_free(vma);
>>   }
>> @@ -197,11 +211,24 @@ void __free_vma(struct vm_area_struct *vma)
>>   /*
>>    * Close a vm structure and free it, returning the next.
>>    */
>> -static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
>> +static struct vm_area_struct *__remove_vma(struct vm_area_struct *vma)
>>   {
>>   	struct vm_area_struct *next = vma->vm_next;
>>   
>>   	might_sleep();
>> +	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT) &&
>> +	    !RB_EMPTY_NODE(&vma->vm_rb)) {
>> +		/*
>> +		 * If the VMA is still linked in the RB tree, we must release
>> +		 * that reference by calling put_vma().
>> +		 * This should only happen when called from exit_mmap().
>> +		 * We forcely clear the node to satisfy the chec in
>                                                          ^
> Typo: chec -> check

Yep

> 
>> +		 * __free_vma(). This is safe since the RB tree is not walked
>> +		 * anymore.
>> +		 */
>> +		RB_CLEAR_NODE(&vma->vm_rb);
>> +		put_vma(vma);
>> +	}
>>   	if (vma->vm_ops && vma->vm_ops->close)
>>   		vma->vm_ops->close(vma);
>>   	if (vma->vm_file)
>> @@ -211,6 +238,13 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
>>   	return next;
>>   }
>>   
>> +static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
>> +{
>> +	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
>> +		VM_BUG_ON_VMA(!RB_EMPTY_NODE(&vma->vm_rb), vma);
> 
> Adding a comment here explaining the BUG_ON so people can understand
> what is wrong if that happens. For instance:
> 
> /*
>   * remove_vma() should be call only once a vma have been remove from the rbtree
>   * at which point the vma->vm_rb is an empty node. The exception is when vmas
>   * are destroy through exit_mmap() in which case we do not bother updating the
>   * rbtree (see comment in __remove_vma()).
>   */

I agree !


>> +	return __remove_vma(vma);
>> +}
>> +
>>   static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long flags,
>>   		struct list_head *uf);
>>   SYSCALL_DEFINE1(brk, unsigned long, brk)
>> @@ -475,7 +509,7 @@ static inline void vma_rb_insert(struct vm_area_struct *vma,
>>   
>>   	/* All rb_subtree_gap values must be consistent prior to insertion */
>>   	validate_mm_rb(root, NULL);
>> -
>> +	get_vma(vma);
>>   	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
>>   }
>>   
>> @@ -491,6 +525,14 @@ static void __vma_rb_erase(struct vm_area_struct *vma, struct mm_struct *mm)
>>   	mm_write_seqlock(mm);
>>   	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
>>   	mm_write_sequnlock(mm);	/* wmb */
>> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>> +	/*
>> +	 * Ensure the removal is complete before clearing the node.
>> +	 * Matched by vma_has_changed()/handle_speculative_fault().
>> +	 */
>> +	RB_CLEAR_NODE(&vma->vm_rb);
>> +	vm_rcu_put(vma);
>> +#endif
>>   }
>>   
>>   static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
>> @@ -2331,6 +2373,34 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>>   
>>   EXPORT_SYMBOL(find_vma);
>>   
>> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>> +/*
>> + * Like find_vma() but under the protection of RCU and the mm sequence counter.
>> + * The vma returned has to be relaesed by the caller through the call to
>> + * put_vma()
>> + */
>> +struct vm_area_struct *find_vma_rcu(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	struct vm_area_struct *vma = NULL;
>> +	unsigned int seq;
>> +
>> +	do {
>> +		if (vma)
>> +			put_vma(vma);
>> +
>> +		seq = read_seqbegin(&mm->mm_seq);
>> +
>> +		rcu_read_lock();
>> +		vma = find_vma(mm, addr);
>> +		if (vma)
>> +			get_vma(vma);
>> +		rcu_read_unlock();
>> +	} while (read_seqretry(&mm->mm_seq, seq));
>> +
>> +	return vma;
>> +}
>> +#endif
>> +
>>   /*
>>    * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
>>    */
>> @@ -3231,7 +3301,7 @@ void exit_mmap(struct mm_struct *mm)
>>   	while (vma) {
>>   		if (vma->vm_flags & VM_ACCOUNT)
>>   			nr_accounted += vma_pages(vma);
>> -		vma = remove_vma(vma);
>> +		vma = __remove_vma(vma);
>>   	}
>>   	vm_unacct_memory(nr_accounted);
>>   }
>> -- 
>> 2.21.0
>>
> 


Return-Path: <SRS0=nUM7=XQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDF2C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Sep 2019 00:54:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5B820C01
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Sep 2019 00:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rq0bduDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5B820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ZsYg0fzGzF4CL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Sep 2019 10:54:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="rq0bduDx"; 
 dkim-atps=neutral
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ZsWS3VXKzF3xw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2019 10:52:51 +1000 (AEST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d85745f0001>; Fri, 20 Sep 2019 17:52:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 20 Sep 2019 17:52:45 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 20 Sep 2019 17:52:45 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Sep
 2019 00:48:23 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 21 Sep
 2019 00:48:22 +0000
Subject: Re: [PATCH v2 11/11] powerpc/mm/book3s64/pgtable: Uses counting
 method to skip serializing
To: Leonardo Bras <leonardo@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
 <20190920195047.7703-12-leonardo@linux.ibm.com>
 <1b39eaa7-751d-40bc-d3d7-41aaa15be42a@nvidia.com>
 <24863d8904c6e05e5dd48cab57db4274675ae654.camel@linux.ibm.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <4ea26ffb-ad03-bdff-7893-95332b22a5fd@nvidia.com>
Date: Fri, 20 Sep 2019 17:48:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <24863d8904c6e05e5dd48cab57db4274675ae654.camel@linux.ibm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1569027168; bh=mxTrUqQC0LpHtZwDDpptnnmD6mLkuvDFdIcthA0LOFs=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=rq0bduDxx4OWdKvbShQZnzluimNygZGHLda9E0OPFQ08wPpjgp+RqimmmAwRCDzLa
 2uBX+v+EEZwmmxx7dXxlJHiFqLEbW0EvADvxbiU4KoGB8vQL6CjIAs0uLiELRLY2Ys
 Mr49OULj0v7sG9XexjqHd89nasUVCJaD7YNg5K0nEmt48jjl8ZU/OEFZOxsEZMNXiV
 Zhu1NyA4QIuhnXWxDtz2bsykXNzEVwgPam/TwYHQluNP5aWO4RCgm31RBGk8cv3ko5
 5MgNY+Uk6dsPZozW1WhaEpz/zoHb3o7sZWIEfP/yMYaP46Pis+vEnxVeupzhoAVZQ8
 q6rXw+IIUmmUw==
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 9/20/19 1:28 PM, Leonardo Bras wrote:
> On Fri, 2019-09-20 at 13:11 -0700, John Hubbard wrote:
>> On 9/20/19 12:50 PM, Leonardo Bras wrote:
>>> Skips slow part of serialize_against_pte_lookup if there is no running
>>> lockless pagetable walk.
>>>
>>> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
>>> ---
>>>  arch/powerpc/mm/book3s64/pgtable.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
>>> index 13239b17a22c..41ca30269fa3 100644
>>> --- a/arch/powerpc/mm/book3s64/pgtable.c
>>> +++ b/arch/powerpc/mm/book3s64/pgtable.c
>>> @@ -95,7 +95,8 @@ static void do_nothing(void *unused)
>>>  void serialize_against_pte_lookup(struct mm_struct *mm)
>>>  {
>>>  	smp_mb();
>>> -	smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
>>> +	if (running_lockless_pgtbl_walk(mm))
>>> +		smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
>>
>> Hi,
>>
>> If you do this, then you are left without any synchronization. So it will
>> have race conditions: a page table walk could begin right after the above
>> check returns "false", and then code such as hash__pmdp_huge_get_and_clear()
>> will continue on right away, under the false assumption that it has let
>> all the current page table walks complete.
>>
>> The current code uses either interrupts or RCU to synchronize, and in
>> either case, you end up scheduling something on each CPU. If you remove
>> that entirely, I don't see anything left. ("Pure" atomic counting is not
>> a synchronization technique all by itself.)
>>
>> thanks,
> 
> Hello John,
> Thanks for the fast feedback.
> 
> See, before calling serialize_against_pte_lookup(), there is always an
> update or clear on the pmd. So, if a page table walk begin right after
> the check returns "false", there is no problem, since it will use the
> updated pmd.
> 
> Think about serialize, on a process with a bunch of cpus. After you
> check the last processor (wait part), there is no guarantee that the
> first one is not starting a lockless pagetable walk.
> 
> The same mechanism protect both methods.
> 
> Does it make sense?
> 

Yes, after working through this with Mark Hairgrove, I think I finally 
realize that the new code will allow existing gup_fast() readers to drain,
before proceeding. So that technically works (ignoring issues such as 
whether it's desirable to use this approach, vs. for example batching
the THP updates, etc), I agree.

(And please ignore my other response that asked if the counting was 
helping at all--I see that it does.)

However, Mark pointed out a pre-existing question, which neither of us
could figure out: are the irq disable/enable calls effective, given that
they are (apparently) not memory barriers? 

Given this claim from Documentation/memory-barriers.txt:

INTERRUPT DISABLING FUNCTIONS
-----------------------------

Functions that disable interrupts (ACQUIRE equivalent) and enable interrupts
(RELEASE equivalent) will act as compiler barriers only.  So if memory or I/O
barriers are required in such a situation, they must be provided from some
other means.

...and given both the preexisting code, and the code you've added:

mm/gup.c:

	atomic_inc(readers); /* new code */
	local_irq_disable();
	gup_pgd_range();
		...read page tables
	local_irq_enable();
	atomic_dec(readers); /* new code */
 
...if the page table reads are allowed to speculatively happen *outside*
of the irq enable/disable calls (which could happen if there are no run-time
memory barriers in the above code), then nothing works anymore. 

So it seems that full memory barriers (not just compiler barriers) are required.
If the irq enable/disable somehow provides that, then your new code just goes
along for the ride and Just Works. (You don't have any memory barriers in
start_lockless_pgtbl_walk() / end_lockless_pgtbl_walk(), just the compiler
barriers provided by the atomic inc/dec.)

So it's really a pre-existing question about the correctness of the gup_fast()
irq disabling approach.

+CC linux-mm


thanks,
-- 
John Hubbard
NVIDIA

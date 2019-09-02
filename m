Return-Path: <SRS0=Itbs=W5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90564C3A59B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 05:49:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D031121897
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 05:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D031121897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MK0Q1wtfzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 15:49:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=linyunsheng@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MJyH5JMyzDqW1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2019 15:47:34 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 841D5224CEFB5C28D060;
 Mon,  2 Sep 2019 13:47:28 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Sep 2019
 13:47:19 +0800
Subject: Re: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
To: Peter Zijlstra <peterz@infradead.org>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
 <20190831085539.GG2369@hirez.programming.kicks-ass.net>
 <4d89c688-49e4-a2aa-32ee-65e36edcd913@huawei.com>
 <20190831161247.GM2369@hirez.programming.kicks-ass.net>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ae64285f-5134-4147-7b02-34bb5d519e8c@huawei.com>
Date: Mon, 2 Sep 2019 13:46:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190831161247.GM2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
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
Cc: dalias@libc.org, linux-sh@vger.kernel.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linuxarm@huawei.com,
 jiaxun.yang@flygoat.com, linux-kernel@vger.kernel.org, mwb@linux.vnet.ibm.com,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, chenhc@lemote.com,
 will@kernel.org, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp,
 x86@kernel.org, rppt@linux.ibm.com, borntraeger@de.ibm.com,
 dledford@redhat.com, mingo@redhat.com, jeffrey.t.kirsher@intel.com,
 jhogan@kernel.org, nfont@linux.vnet.ibm.com, mattst88@gmail.com,
 len.brown@intel.com, gor@linux.ibm.com, anshuman.khandual@arm.com,
 ink@jurassic.park.msu.ru, cai@lca.pw, luto@kernel.org, tglx@linutronix.de,
 naveen.n.rao@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org,
 rth@twiddle.net, axboe@kernel.dk, robin.murphy@arm.com,
 linux-mips@vger.kernel.org, ralf@linux-mips.org, tbogendoerfer@suse.de,
 paul.burton@mips.com, linux-alpha@vger.kernel.org, bp@alien8.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2019/9/1 0:12, Peter Zijlstra wrote:
> On Sat, Aug 31, 2019 at 06:09:39PM +0800, Yunsheng Lin wrote:
>>
>>
>> On 2019/8/31 16:55, Peter Zijlstra wrote:
>>> On Sat, Aug 31, 2019 at 01:58:16PM +0800, Yunsheng Lin wrote:
>>>> According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
>>>> of proximity domain is optional, as below:
>>>>
>>>> This optional object is used to describe proximity domain
>>>> associations within a machine. _PXM evaluates to an integer
>>>> that identifies a device as belonging to a Proximity Domain
>>>> defined in the System Resource Affinity Table (SRAT).
>>>
>>> That's just words.. what does it actually mean?
>>
>> It means the dev_to_node(dev) may return -1 if the bios does not
>> implement the proximity domain feature, user may use that value
>> to call cpumask_of_node and cpumask_of_node does not protect itself
>> from node id being -1, which causes out of bound access.
> 
>>>> @@ -69,6 +69,12 @@ extern const struct cpumask *cpumask_of_node(int node);
>>>>  /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
>>>>  static inline const struct cpumask *cpumask_of_node(int node)
>>>>  {
>>>> +	if (node >= nr_node_ids)
>>>> +		return cpu_none_mask;
>>>> +
>>>> +	if (node < 0 || !node_to_cpumask_map[node])
>>>> +		return cpu_online_mask;
>>>> +
>>>>  	return node_to_cpumask_map[node];
>>>>  }
>>>>  #endif
>>>
>>> I _reallly_ hate this. Users are expected to use valid numa ids. Now
>>> we're adding all this checking to all users. Why do we want to do that?
>>
>> As above, the dev_to_node(dev) may return -1.
>>
>>>
>>> Using '(unsigned)node >= nr_nods_ids' is an error.
>>
>> 'node >= nr_node_ids' can be dropped if all user is expected to not call
>> cpumask_of_node with node id greater or equal to nr_nods_ids.
> 
> you copied my typo :-)

I did note the typo, corrected the first one, but missed the second one :)

> 
>> From what I can see, the problem can be fixed in three place:
>> 1. Make user dev_to_node return a valid node id even when proximity
>>    domain is not set by bios(or node id set by buggy bios is not valid),
>>    which may need info from the numa system to make sure it will return
>>    a valid node.
>>
>> 2. User that call cpumask_of_node should ensure the node id is valid
>>    before calling cpumask_of_node, and user also need some info to
>>    make ensure node id is valid.
>>
>> 3. Make sure cpumask_of_node deal with invalid node id as this patchset.
>>
>> Which one do you prefer to make sure node id is valid, or do you
>> have any better idea?
>>
>> Any detail advice and suggestion will be very helpful, thanks.
> 
> 1) because even it is not set, the device really does belong to a node.
> It is impossible a device will have magic uniform access to memory when
> CPUs cannot.

So it means dev_to_node() will return either NUMA_NO_NODE or a
valid node id?

> 
> 2) is already true today, cpumask_of_node() requires a valid node_id.

Ok, most of the user does check node_id before calling
cpumask_of_node(), but does a little different type of checking:

1) some does " < 0" check;
2) some does "== NUMA_NO_NODE" check;
3) some does ">= MAX_NUMNODES" check;
4) some does "< 0 || >= MAX_NUMNODES || !node_online(node)" check.


> 
> 3) is just wrong and increases overhead for everyone.

Ok, cpumask_of_node() is also used in some critical path such
as scheduling, which may not need those checking, the overhead
is unnecessary.

But for non-critical path such as setup or configuration path,
it better to have consistent checking, and also simplify the
user code that calls cpumask_of_node().

Do you think it is worth the trouble to add a new function
such as cpumask_of_node_check(maybe some other name) to do
consistent checking?

Or caller just simply check if dev_to_node()'s return value is
NUMA_NO_NODE before calling cpumask_of_node()?


> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 


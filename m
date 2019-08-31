Return-Path: <SRS0=6mHU=W3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22923C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Aug 2019 10:12:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6239821670
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Aug 2019 10:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6239821670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46LBwd64bJzDrBh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Aug 2019 20:12:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=linyunsheng@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46LBtJ6j4ZzDrB8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2019 20:10:15 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1A9E488D2CD023DF4C0A;
 Sat, 31 Aug 2019 18:10:11 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 31 Aug 2019
 18:10:04 +0800
Subject: Re: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
To: Peter Zijlstra <peterz@infradead.org>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
 <20190831085539.GG2369@hirez.programming.kicks-ass.net>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <4d89c688-49e4-a2aa-32ee-65e36edcd913@huawei.com>
Date: Sat, 31 Aug 2019 18:09:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190831085539.GG2369@hirez.programming.kicks-ass.net>
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
 jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org, mwb@linux.vnet.ibm.com,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, chenhc@lemote.com,
 will@kernel.org, cai@lca.pw, linux-s390@vger.kernel.org,
 ysato@users.sourceforge.jp, x86@kernel.org, rppt@linux.ibm.com,
 borntraeger@de.ibm.com, dledford@redhat.com, mingo@redhat.com,
 jeffrey.t.kirsher@intel.com, jhogan@kernel.org, nfont@linux.vnet.ibm.com,
 mattst88@gmail.com, len.brown@intel.com, gor@linux.ibm.com,
 anshuman.khandual@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de,
 naveen.n.rao@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org,
 rth@twiddle.net, axboe@kernel.dk, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, tbogendoerfer@suse.de,
 paul.burton@mips.com, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/8/31 16:55, Peter Zijlstra wrote:
> On Sat, Aug 31, 2019 at 01:58:16PM +0800, Yunsheng Lin wrote:
>> According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
>> of proximity domain is optional, as below:
>>
>> This optional object is used to describe proximity domain
>> associations within a machine. _PXM evaluates to an integer
>> that identifies a device as belonging to a Proximity Domain
>> defined in the System Resource Affinity Table (SRAT).
> 
> That's just words.. what does it actually mean?

It means the dev_to_node(dev) may return -1 if the bios does not
implement the proximity domain feature, user may use that value
to call cpumask_of_node and cpumask_of_node does not protect itself
from node id being -1, which causes out of bound access.

> 
>> This patch checks node id with the below case before returning
>> node_to_cpumask_map[node]:
>> 1. if node_id >= nr_node_ids, return cpu_none_mask
>> 2. if node_id < 0, return cpu_online_mask
>> 3. if node_to_cpumask_map[node_id] is NULL, return cpu_online_mask
>>
>> [1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  arch/x86/include/asm/topology.h | 6 ++++++
>>  arch/x86/mm/numa.c              | 2 +-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
>> index 4b14d23..f36e9c8 100644
>> --- a/arch/x86/include/asm/topology.h
>> +++ b/arch/x86/include/asm/topology.h
>> @@ -69,6 +69,12 @@ extern const struct cpumask *cpumask_of_node(int node);
>>  /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
>>  static inline const struct cpumask *cpumask_of_node(int node)
>>  {
>> +	if (node >= nr_node_ids)
>> +		return cpu_none_mask;
>> +
>> +	if (node < 0 || !node_to_cpumask_map[node])
>> +		return cpu_online_mask;
>> +
>>  	return node_to_cpumask_map[node];
>>  }
>>  #endif
> 
> I _reallly_ hate this. Users are expected to use valid numa ids. Now
> we're adding all this checking to all users. Why do we want to do that?

As above, the dev_to_node(dev) may return -1.

> 
> Using '(unsigned)node >= nr_nods_ids' is an error.

'node >= nr_node_ids' can be dropped if all user is expected to not call
cpumask_of_node with node id greater or equal to nr_nods_ids.

From what I can see, the problem can be fixed in three place:
1. Make user dev_to_node return a valid node id even when proximity
   domain is not set by bios(or node id set by buggy bios is not valid),
   which may need info from the numa system to make sure it will return
   a valid node.

2. User that call cpumask_of_node should ensure the node id is valid
   before calling cpumask_of_node, and user also need some info to
   make ensure node id is valid.

3. Make sure cpumask_of_node deal with invalid node id as this patchset.

Which one do you prefer to make sure node id is valid, or do you
have any better idea?

Any detail advice and suggestion will be very helpful, thanks.

> 
>> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
>> index e6dad60..5e393d2 100644
>> --- a/arch/x86/mm/numa.c
>> +++ b/arch/x86/mm/numa.c
>> @@ -868,7 +868,7 @@ const struct cpumask *cpumask_of_node(int node)
>>  		dump_stack();
>>  		return cpu_none_mask;
>>  	}
>> -	if (node_to_cpumask_map[node] == NULL) {
>> +	if (node < 0 || !node_to_cpumask_map[node]) {
>>  		printk(KERN_WARNING
>>  			"cpumask_of_node(%d): no node_to_cpumask_map!\n",
>>  			node);
>> -- 
>> 2.8.1
>>
> 
> .
> 


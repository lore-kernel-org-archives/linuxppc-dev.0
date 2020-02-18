Return-Path: <SRS0=izeg=4G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36E0C34026
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Feb 2020 11:58:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE750206F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Feb 2020 11:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE750206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MK9m4RvRzDqbG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Feb 2020 22:58:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=virtuozzo.com (client-ip=185.231.240.75; helo=relay.sw.ru;
 envelope-from=ktkhai@virtuozzo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=virtuozzo.com
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MK4R0qPgzDqTh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2020 22:53:23 +1100 (AEDT)
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <ktkhai@virtuozzo.com>)
 id 1j41R8-0003sQ-HT; Tue, 18 Feb 2020 14:53:10 +0300
Subject: Re: [5.6.0-rc2-next-20200218/powerpc] Boot failure on POWER9
To: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <3381CD91-AB3D-4773-BA04-E7A072A63968@linux.vnet.ibm.com>
 <cf6be5f5-4bbc-0d34-fb64-33fd37bc48d9@virtuozzo.com>
 <D32F8819-6D7B-4B0E-95B4-E5A1D2E5CF7B@linux.vnet.ibm.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3b37d94d-2ac4-6b5d-ee8a-eb98cc7f6e5d@virtuozzo.com>
Date: Tue, 18 Feb 2020 14:53:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <D32F8819-6D7B-4B0E-95B4-E5A1D2E5CF7B@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Michal Hocko <mhocko@suse.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 18.02.2020 14:38, Sachin Sant wrote:
> 
> 
>> On 18-Feb-2020, at 4:20 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> Hi, Sachin,
>>
>> On 18.02.2020 13:45, Sachin Sant wrote:
>>>
>>> commit a75056fc1e7c 
>>> mm/memcontrol.c: allocate shrinker_map on appropriate NUMA node
>>>
>>> I can boot the kernel successfully if the patch is reverted. 
>>
>>
>> could you please test your boot with original patch from here:
>>
>> https://patchwork.kernel.org/patch/11360007/
>>
>> ?
> With this original patch I can boot the machine successfully.

Ok, thanks.

I think, there is no a problem in the commited patch, since mem_cgroup_css_alloc()
is called from the place, where any memory allocations have to be allowed. This
is one of the reason, memory_cgrp_subsys.early_init is 0, and all nodes allocations
should be availeble there.

The problem is not in vmalloc() itself, since the second patch with kmalloc_node()
also fails on your setup. Maybe, the reproduction depends on amount of allocated
memory. For me this looks like a problem in powerpc, but it would be interesting
to hear some comments from powerpc guys.

For now we may replace the commited patch with v2 (https://patchwork.kernel.org/patch/11360007/)
containing workaround, which we have in another alloc_mem_cgroup_per_node_info() allocations.

Kirill

Return-Path: <SRS0=VLUV=5C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7562C10F29
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 14:42:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E3C206EC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 14:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E3C206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48hbVR6LbdzDqQf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 01:42:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=vbabka@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48hZD34hj2zDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2020 00:44:51 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 44F85AD1E;
 Tue, 17 Mar 2020 13:44:47 +0000 (UTC)
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
To: Michal Hocko <mhocko@kernel.org>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
 <20200311115735.GM23944@dhcp22.suse.cz>
 <20200312052707.GA3277@linux.vnet.ibm.com>
 <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com>
 <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz>
 <20200312131438.GB3277@linux.vnet.ibm.com>
 <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz>
 <20200312161310.GC3277@linux.vnet.ibm.com>
 <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
 <20200316090652.GC11482@dhcp22.suse.cz>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <65b99db6-3bdf-6caa-74e5-6d6b681f16b5@suse.cz>
Date: Tue, 17 Mar 2020 14:44:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316090652.GC11482@dhcp22.suse.cz>
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Kirill Tkhai <ktkhai@virtuozzo.com>, Mel Gorman <mgorman@suse.de>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christopher Lameter <cl@linux.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/16/20 10:06 AM, Michal Hocko wrote:
> On Thu 12-03-20 17:41:58, Vlastimil Babka wrote:
> [...]
>> with nid present in:
>> N_POSSIBLE - pgdat might not exist, node_to_mem_node() must return some online
> 
> I would rather have a dummy pgdat for those. Have a look at 
> $ git grep "NODE_DATA.*->" | wc -l
> 63
> 
> Who knows how many else we have there. I haven't looked more closely.
> Besides that what is a real reason to not have pgdat ther and force all
> users of a $random node from those that the platform considers possible
> for special casing? Is that a memory overhead? Is that really a thing?

I guess we can ignore memory overhead. I guess there only might be some concern
that for nodes that are initially offline, we will allocate the pgdat on a
different node, and after they are online, it will stay on a different node with
more access latency from local cpus. If we only allocate for online nodes, it
can always be local? But I guess it doesn't matter that much.

> Somebody has suggested to tweak some of the low level routines to do the
> special casing but I really have to say I do not like that. We shouldn't
> use the first online node or anything like that. We should simply always
> follow the topology presented by FW and of that we need to have a pgdat.
> 


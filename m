Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN5c23yyszDvfJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:16:18 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id e9so202092pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:16:17 -0800 (PST)
Subject: Re: [RESEND][v1 0/3] Support memory cgroup hotplug
To: Michal Hocko <mhocko@kernel.org>
References: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
 <20161121140340.GC18112@dhcp22.suse.cz>
Cc: mpe@ellerman.id.au, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Tejun Heo
 <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <20dc8052-a622-e138-72f2-1a921095133b@gmail.com>
Date: Tue, 22 Nov 2016 11:16:10 +1100
MIME-Version: 1.0
In-Reply-To: <20161121140340.GC18112@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 22/11/16 01:03, Michal Hocko wrote:
> On Wed 16-11-16 10:44:58, Balbir Singh wrote:
>> In the absence of hotplug we use extra memory proportional to
>> (possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
>> to disable large consumption with large number of cgroups. This patch
>> adds hotplug support to memory cgroups and reverts the commit that
>> limited possible nodes to online nodes.
> 
> I didn't get to read patches yet (I am currently swamped by emails after
> longer vacation so bear with me) but this doesn't tell us _why_ we want
> this and how much we can actaully save. 

The motivation was 3af229f2071f
(powerpc/numa: Reset node_possible_map to only node_online_map)

In general being dynamic is more
> complex and most systems tend to have possible_nodes close to
> online_nodes in my experience (well at least on most reasonable
> architectures). I would also appreciate some highlevel description of
> the implications. E.g. how to we synchronize with the hotplug operations
> when iterating node specific data structures.

I agree dynamic is more complex, but I think we'll begin to see a lot
of more of it. The rules are not hard IMHO. From an implication perspective
it means that we need to get/put_online_mem_nodes in certain paths - specifically
mem_cgroup_alloc/free and mem_cgroup_init from what I can see so far

Thanks for the review!

Balbir Singh

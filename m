Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNvf51tNpzDw2G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:50:53 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so516493pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 23:50:53 -0800 (PST)
Subject: Re: [mm v2 0/3] Support memory cgroup hotplug
To: Michal Hocko <mhocko@kernel.org>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
 <20161123072543.GD2864@dhcp22.suse.cz>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <342ebcca-b54c-4bc6-906b-653042caae06@gmail.com>
Date: Wed, 23 Nov 2016 18:50:42 +1100
MIME-Version: 1.0
In-Reply-To: <20161123072543.GD2864@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/11/16 18:25, Michal Hocko wrote:
> On Wed 23-11-16 15:36:51, Balbir Singh wrote:
>> In the absence of hotplug we use extra memory proportional to
>> (possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
>> to disable large consumption with large number of cgroups. This patch
>> adds hotplug support to memory cgroups and reverts the commit that
>> limited possible nodes to online nodes.
> 
> Balbir,
> I have asked this in the previous version but there still seems to be a
> lack of information of _why_ do we want this, _how_ much do we save on
> the memory overhead on most systems and _why_ the additional complexity
> is really worth it. Please make sure to add all this in the cover
> letter.
> 

The data is in the patch referred to in patch 3. The order of waste was
200MB for 400 cgroup directories enough for us to restrict possible_map
to online_map. These patches allow us to have a larger possible map and
allow onlining nodes not in the online_map, which is currently a restriction
on ppc64.

A typical system that I use has about 100-150 directories, depending on the
number of users/docker instances/configuration/virtual machines. These numbers
will only grow as we pack more of these instances on them.

>From a complexity view point, the patches are quite straight forward.

> I still didn't get to look into those patches because I am swamped with
> other things but to be honest I do not really see a strong justification
> to make it high priority for me.
> 

I am OK if you need more time to review them, but I've been pushing them
to fix the cases I've mentioned above.

Balbir Singh.

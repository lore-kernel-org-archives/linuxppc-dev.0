Return-Path: <mstsxfx@gmail.com>
Received: from mail-wj0-f195.google.com (mail-wj0-f195.google.com
 [209.85.210.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNw1f4LJczDvh8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 19:07:50 +1100 (AEDT)
Received: by mail-wj0-f195.google.com with SMTP id jb2so435226wjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 00:07:50 -0800 (PST)
Date: Wed, 23 Nov 2016 09:07:45 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [mm v2 0/3] Support memory cgroup hotplug
Message-ID: <20161123080744.GG2864@dhcp22.suse.cz>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
 <20161123072543.GD2864@dhcp22.suse.cz>
 <342ebcca-b54c-4bc6-906b-653042caae06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <342ebcca-b54c-4bc6-906b-653042caae06@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 23-11-16 18:50:42, Balbir Singh wrote:
> 
> 
> On 23/11/16 18:25, Michal Hocko wrote:
> > On Wed 23-11-16 15:36:51, Balbir Singh wrote:
> >> In the absence of hotplug we use extra memory proportional to
> >> (possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
> >> to disable large consumption with large number of cgroups. This patch
> >> adds hotplug support to memory cgroups and reverts the commit that
> >> limited possible nodes to online nodes.
> > 
> > Balbir,
> > I have asked this in the previous version but there still seems to be a
> > lack of information of _why_ do we want this, _how_ much do we save on
> > the memory overhead on most systems and _why_ the additional complexity
> > is really worth it. Please make sure to add all this in the cover
> > letter.
> > 
> 
> The data is in the patch referred to in patch 3. The order of waste was
> 200MB for 400 cgroup directories enough for us to restrict possible_map
> to online_map. These patches allow us to have a larger possible map and
> allow onlining nodes not in the online_map, which is currently a restriction
> on ppc64.

How common is to have possible_map >> online_map? If this is ppc64 then
what is the downside of keeping the current restriction instead?

> A typical system that I use has about 100-150 directories, depending on the
> number of users/docker instances/configuration/virtual machines. These numbers
> will only grow as we pack more of these instances on them.
> 
> From a complexity view point, the patches are quite straight forward.

Well, I would like to hear more about that. {get,put}_online_memory
at random places doesn't sound all that straightforward to me.

-- 
Michal Hocko
SUSE Labs

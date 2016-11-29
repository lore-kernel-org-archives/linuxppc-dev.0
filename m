Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSP723LRzzDvNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 11:09:34 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p66so14477728pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 16:09:34 -0800 (PST)
Subject: Re: [mm v2 0/3] Support memory cgroup hotplug
To: Tejun Heo <tj@kernel.org>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
 <20161123072543.GD2864@dhcp22.suse.cz>
 <342ebcca-b54c-4bc6-906b-653042caae06@gmail.com>
 <20161123080744.GG2864@dhcp22.suse.cz>
 <61dc32fd-2802-6deb-24cf-fa11b5b31532@gmail.com>
 <20161123092830.GH2864@dhcp22.suse.cz>
 <962ac541-55c4-de09-59a3-4947c394eee6@gmail.com>
 <20161128211014.GB12143@htj.duckdns.org>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <fffa4fdc-8bb0-2891-d314-286d4ede305b@gmail.com>
Date: Tue, 29 Nov 2016 11:09:26 +1100
MIME-Version: 1.0
In-Reply-To: <20161128211014.GB12143@htj.duckdns.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 29/11/16 08:10, Tejun Heo wrote:
> On Thu, Nov 24, 2016 at 12:05:12AM +1100, Balbir Singh wrote:
>> On my desktop NODES_SHIFT is 6, many distro kernels have it a 9. I've known
>> of solutions that use fake NUMA for partitioning and need as many nodes as
>> possible.
> 
> It was a crude kludge that people used before memcg.  If people still
> use it, that's fine but we don't want to optimize / make code
> complicated for it, so let's please put away this part of
> justification.

Are you suggesting those use cases can be ignored now?

> 
> It's understandable that some kernels want to have large NODES_SHIFT
> to support wide range of configurations but if that makes wastage too
> high, the simpler solution is updating the users to use the rumtime
> detected possible number / mask instead of the compile time
> NODES_SHIFT.  Note that we do exactly the same thing for per-cpu
> things - we configure high max but do all operations on what's
> possible on the system.
> 
> NUMA code already has possible detection.  Why not simply make memcg
> use those instead of MAX_NUMNODES like how we use nr_cpu_ids instead
> of NR_CPUS?
> 

nodes_possible_map is set to node_online_map at the moment for ppc64.
Which becomes a problem when hotplugging a node that was not already
online.

I am not sure what you mean by possible detection. node_possible_map
is set based on CONFIG_NODE_SHIFT and then can be adjusted by the
architecture (if desired). Are you suggesting firmware populate it
in?

Thanks,
Balbir Singh

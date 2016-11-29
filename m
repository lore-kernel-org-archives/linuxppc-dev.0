Return-Path: <htejun@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSPrX56ZpzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 11:42:04 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id n6so13686058qtd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 16:42:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 28 Nov 2016 19:42:00 -0500
From: Tejun Heo <tj@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [mm v2 0/3] Support memory cgroup hotplug
Message-ID: <20161129004200.GA10703@mtj.duckdns.org>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
 <20161123072543.GD2864@dhcp22.suse.cz>
 <342ebcca-b54c-4bc6-906b-653042caae06@gmail.com>
 <20161123080744.GG2864@dhcp22.suse.cz>
 <61dc32fd-2802-6deb-24cf-fa11b5b31532@gmail.com>
 <20161123092830.GH2864@dhcp22.suse.cz>
 <962ac541-55c4-de09-59a3-4947c394eee6@gmail.com>
 <20161128211014.GB12143@htj.duckdns.org>
 <fffa4fdc-8bb0-2891-d314-286d4ede305b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fffa4fdc-8bb0-2891-d314-286d4ede305b@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Balbir.

On Tue, Nov 29, 2016 at 11:09:26AM +1100, Balbir Singh wrote:
> On 29/11/16 08:10, Tejun Heo wrote:
> > On Thu, Nov 24, 2016 at 12:05:12AM +1100, Balbir Singh wrote:
> >> On my desktop NODES_SHIFT is 6, many distro kernels have it a 9. I've known
> >> of solutions that use fake NUMA for partitioning and need as many nodes as
> >> possible.
> > 
> > It was a crude kludge that people used before memcg.  If people still
> > use it, that's fine but we don't want to optimize / make code
> > complicated for it, so let's please put away this part of
> > justification.
> 
> Are you suggesting those use cases can be ignored now?

Don't do that.  When did I say that?  What I said is that it isn't a
good idea to optimize and complicate the code base for it at this
point.  It shouldn't a controversial argument given fake numa's
inherent issues and general lack of popularity.

Besides, does node hotplug even apply to fake numa?  ISTR it being
configured statically on the boot prompt.

> > NUMA code already has possible detection.  Why not simply make memcg
> > use those instead of MAX_NUMNODES like how we use nr_cpu_ids instead
> > of NR_CPUS?
> 
> nodes_possible_map is set to node_online_map at the moment for ppc64.
> Which becomes a problem when hotplugging a node that was not already
> online.
> 
> I am not sure what you mean by possible detection. node_possible_map
> is set based on CONFIG_NODE_SHIFT and then can be adjusted by the
> architecture (if desired). Are you suggesting firmware populate it
> in?

That's what we do with cpus.  The kernel is built with high maximum
limit and the kernel queries the firmware during boot to determine how
many are actually possible on the system, which in most cases isn't
too far from what's already on the system.  I don't see why we would
take a different approach with NUMA nodes.

Thanks.

-- 
tejun

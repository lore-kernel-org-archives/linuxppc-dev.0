Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSK8B0gsWzDw3K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 08:10:18 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id b66so10879856ywh.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 13:10:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 28 Nov 2016 16:10:14 -0500
From: Tejun Heo <tj@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [mm v2 0/3] Support memory cgroup hotplug
Message-ID: <20161128211014.GB12143@htj.duckdns.org>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
 <20161123072543.GD2864@dhcp22.suse.cz>
 <342ebcca-b54c-4bc6-906b-653042caae06@gmail.com>
 <20161123080744.GG2864@dhcp22.suse.cz>
 <61dc32fd-2802-6deb-24cf-fa11b5b31532@gmail.com>
 <20161123092830.GH2864@dhcp22.suse.cz>
 <962ac541-55c4-de09-59a3-4947c394eee6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <962ac541-55c4-de09-59a3-4947c394eee6@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2016 at 12:05:12AM +1100, Balbir Singh wrote:
> On my desktop NODES_SHIFT is 6, many distro kernels have it a 9. I've known
> of solutions that use fake NUMA for partitioning and need as many nodes as
> possible.

It was a crude kludge that people used before memcg.  If people still
use it, that's fine but we don't want to optimize / make code
complicated for it, so let's please put away this part of
justification.

It's understandable that some kernels want to have large NODES_SHIFT
to support wide range of configurations but if that makes wastage too
high, the simpler solution is updating the users to use the rumtime
detected possible number / mask instead of the compile time
NODES_SHIFT.  Note that we do exactly the same thing for per-cpu
things - we configure high max but do all operations on what's
possible on the system.

NUMA code already has possible detection.  Why not simply make memcg
use those instead of MAX_NUMNODES like how we use nr_cpu_ids instead
of NR_CPUS?

Thanks.

-- 
tejun

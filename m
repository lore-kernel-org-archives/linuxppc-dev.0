Return-Path: <htejun@gmail.com>
Received: from mail-yk0-x230.google.com (mail-yk0-x230.google.com
 [IPv6:2607:f8b0:4002:c07::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DDAB1A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 06:37:44 +1000 (AEST)
Received: by ykay190 with SMTP id y190so47064732yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 13:37:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 Jul 2015 16:37:39 -0400
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC,1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150715203739.GJ15934@mtj.duckdns.org>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150708040056.948A1140770@ozlabs.org>
 <20150708231623.GB44862@linux.vnet.ibm.com>
 <20150710161546.GD44862@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150710161546.GD44862@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Fri, Jul 10, 2015 at 09:15:47AM -0700, Nishanth Aravamudan wrote:
> On 08.07.2015 [16:16:23 -0700], Nishanth Aravamudan wrote:
> > On 08.07.2015 [14:00:56 +1000], Michael Ellerman wrote:
> > > On Thu, 2015-02-07 at 23:02:02 UTC, Nishanth Aravamudan wrote:
> > > > Much like on x86, now that powerpc is using USE_PERCPU_NUMA_NODE_ID, we
> > > > have an ordering issue during boot with early calls to cpu_to_node().
> > > 
> > > "now that .." implies we changed something and broke this. What commit was
> > > it that changed the behaviour?
> > 
> > Well, that's something I'm trying to still unearth. In the commits
> > before and after adding USE_PERCPU_NUMA_NODE_ID (8c272261194d
> > "powerpc/numa: Enable USE_PERCPU_NUMA_NODE_ID"), the dmesg reports:
> > 
> > pcpu-alloc: [0] 0 1 2 3 4 5 6 7
> 
> Ok, I did a bisection, and it seems like prior to commit
> 1a4d76076cda69b0abf15463a8cebc172406da25 ("percpu: implement
> asynchronous chunk population"), we emitted the above, e.g.:
> 
> pcpu-alloc: [0] 0 1 2 3 4 5 6 7
> 
> And after that commit, we emitted:
> 
> pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7
> 
> I'm not exactly sure why that changed, but I'm still
> reading/understanding the commit. Tejun might be able to explain.
> 
> Tejun, for reference, I noticed on Power systems since the
> above-mentioned commit, pcpu-alloc is not reflecting the topology of the
> system correctly -- that is, the pcpu areas are all on node 0
> unconditionally (based up on pcpu-alloc's output). Prior to that, there
> was just one group, it seems like, which completely ignored the NUMA
> topology.
> 
> Is this just an ordering thing that changed with the introduction of the
> async code?

It's just each unit growing and percpu allocator deciding to split
them into separate allocation units.  Before it was serving all cpus
in a single alloc unit as they looked like they belong to the same
NUMA node and small enough to fit into one alloc unit.  In the latter,
the async one added more reserve space, so the allocator is deciding
to split them into two alloc units while assigning them to the same
group as the NUMA info wasn't still there.

Thanks.

-- 
tejun

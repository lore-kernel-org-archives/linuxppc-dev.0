Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 208231A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 02:15:53 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 10 Jul 2015 10:15:52 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 23F713E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 10:15:49 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6AGF5tN18350130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 09:15:05 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6AGFmDF020465
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 10:15:48 -0600
Date: Fri, 10 Jul 2015 09:15:47 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org,
 tj@kernel.org
Subject: Re: [RFC,1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150710161546.GD44862@linux.vnet.ibm.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150708040056.948A1140770@ozlabs.org>
 <20150708231623.GB44862@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150708231623.GB44862@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.07.2015 [16:16:23 -0700], Nishanth Aravamudan wrote:
> On 08.07.2015 [14:00:56 +1000], Michael Ellerman wrote:
> > On Thu, 2015-02-07 at 23:02:02 UTC, Nishanth Aravamudan wrote:
> > > Much like on x86, now that powerpc is using USE_PERCPU_NUMA_NODE_ID, we
> > > have an ordering issue during boot with early calls to cpu_to_node().
> > 
> > "now that .." implies we changed something and broke this. What commit was
> > it that changed the behaviour?
> 
> Well, that's something I'm trying to still unearth. In the commits
> before and after adding USE_PERCPU_NUMA_NODE_ID (8c272261194d
> "powerpc/numa: Enable USE_PERCPU_NUMA_NODE_ID"), the dmesg reports:
> 
> pcpu-alloc: [0] 0 1 2 3 4 5 6 7

Ok, I did a bisection, and it seems like prior to commit
1a4d76076cda69b0abf15463a8cebc172406da25 ("percpu: implement
asynchronous chunk population"), we emitted the above, e.g.:

pcpu-alloc: [0] 0 1 2 3 4 5 6 7

And after that commit, we emitted:

pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7

I'm not exactly sure why that changed, but I'm still
reading/understanding the commit. Tejun might be able to explain.

Tejun, for reference, I noticed on Power systems since the
above-mentioned commit, pcpu-alloc is not reflecting the topology of the
system correctly -- that is, the pcpu areas are all on node 0
unconditionally (based up on pcpu-alloc's output). Prior to that, there
was just one group, it seems like, which completely ignored the NUMA
topology.

Is this just an ordering thing that changed with the introduction of the
async code?

Thanks,
Nish

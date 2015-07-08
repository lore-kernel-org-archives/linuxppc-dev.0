Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53DDC1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 09:16:31 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 17:16:29 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 94C141FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 17:07:35 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t68NFwZw49152128
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 16:15:58 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t68NGOkd032266
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 17:16:25 -0600
Date: Wed, 8 Jul 2015 16:16:23 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC,1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150708231623.GB44862@linux.vnet.ibm.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150708040056.948A1140770@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150708040056.948A1140770@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.07.2015 [14:00:56 +1000], Michael Ellerman wrote:
> On Thu, 2015-02-07 at 23:02:02 UTC, Nishanth Aravamudan wrote:
> > Much like on x86, now that powerpc is using USE_PERCPU_NUMA_NODE_ID, we
> > have an ordering issue during boot with early calls to cpu_to_node().
> 
> "now that .." implies we changed something and broke this. What commit was
> it that changed the behaviour?

Well, that's something I'm trying to still unearth. In the commits
before and after adding USE_PERCPU_NUMA_NODE_ID (8c272261194d
"powerpc/numa: Enable USE_PERCPU_NUMA_NODE_ID"), the dmesg reports:

pcpu-alloc: [0] 0 1 2 3 4 5 6 7

At least prior to 8c272261194d, this might have been due to the old
powerpc-specific cpu_to_node():

static inline int cpu_to_node(int cpu)
{
       int nid;

       nid = numa_cpu_lookup_table[cpu];

       /*
        * During early boot, the numa-cpu lookup table might not have
        been
        * setup for all CPUs yet. In such cases, default to node 0.
        */
       return (nid < 0) ? 0 : nid;
}

which might imply that no one cares or that simply no one noticed.

> > The value returned by those calls now depend on the per-cpu area being
> > setup, but that is not guaranteed to be the case during boot. Instead,
> > we need to add an early_cpu_to_node() which doesn't use the per-CPU area
> > and call that from certain spots that are known to invoke cpu_to_node()
> > before the per-CPU areas are not configured.
> > 
> > On an example 2-node NUMA system with the following topology:
> > 
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3
> > node 0 size: 2029 MB
> > node 0 free: 1753 MB
> > node 1 cpus: 4 5 6 7
> > node 1 size: 2045 MB
> > node 1 free: 1945 MB
> > node distances:
> > node   0   1 
> >   0:  10  40 
> >   1:  40  10 
> > 
> > we currently emit at boot:
> > 
> > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
> > 
> > After this commit, we correctly emit:
> > 
> > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 
> 
> 
> So it looks fairly sane, and I guess it's a bug fix.
> 
> But I'm a bit reluctant to put it in straight away without some time in next.

I'm fine with that -- it could use some more extensive testing,
admittedly (I only have been able to verify the pcpu areas are being
correctly allocated on the right node so far).

I still need to test with hotplug and things like that. Hence the RFC.

> It looks like the symptom is that the per-cpu areas are all allocated on node
> 0, is that all that goes wrong?

Yes, that's the symptom. I cc'd a few folks to see if they could help
indicate the performance implications of such a setup -- sorry, I should
have been more explicit about that.

Thanks,
Nish

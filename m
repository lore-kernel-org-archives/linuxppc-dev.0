Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39AB11A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:28:33 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Mar 2015 16:28:31 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4AD6D1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 16:19:41 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t25NSYgY46268576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 16:28:42 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t25NRv9c012863
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 16:27:57 -0700
Date: Thu, 5 Mar 2015 15:27:31 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305232731.GF30570@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <20150305221308.GG23912@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150305221308.GG23912@htj.duckdns.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.03.2015 [17:13:08 -0500], Tejun Heo wrote:
> On Thu, Mar 05, 2015 at 10:05:49AM -0800, Nishanth Aravamudan wrote:
> > While looking at this, I noticed that nr_node_ids is actually a
> > misnomer, it seems. It's not the number, but the maximum_node_id, as
> > with sparse NUMA nodes, you might only have two NUMA nodes possible, but
> > to make certain loops work, nr_node_ids will be, e.g., 17. Should it be
> > changed?
> 
> It's the same for nr_cpu_ids.  It's counting the number of valid IDs
> during that boot instance.  In the above case, whether the nodes are
> sparse or not, there exist 17 node ids - 0 to 16.  Maybe numa_max_id
> had been a better name (but would that equal the highest number or
> +1?) but nr_node_ids != nr_nodes so I don't think it's a misnomer
> either.  Doesn't really matter at this point.  Maybe add comments on
> top of both?

Yes, I will consider that. To me, I guess it's more a matter of:

a) How does nr_node_ids relate to the number of possible NUMA node IDs
at runtime?

They are identical.

b) How does nr_node_ids relate to the number of NUMA node IDs in use?

There is no relation.

c) How does nr_node_ids relate to the maximum NUMA node ID in use?

It is one larger than that value.

However, for a), at least, we don't care about that on power, really. We
don't have node hotplug, so the "possible" is the "online" in practice,
for a given system.

Iteration seems to generally not be a problem (since we have sparse
iterators anyways) and we shouldn't be allocating for non-present nodes.

But we run into excessive allocations (I'm looking into a few others
Dipankar has found now) with array allocations based of nr_node_ids or
MAX_NUMNODES when the NUMA topology is sparse..

-Nish

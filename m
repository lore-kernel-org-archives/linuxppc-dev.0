Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DCC5C2C0227
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 10:56:30 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 21 Feb 2014 16:56:28 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2C56119D8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 16:56:24 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1LNu1Xh7274892
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 00:56:01 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1LNuO86003575
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 16:56:25 -0700
Date: Fri, 21 Feb 2014 15:56:16 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] mm: return NUMA_NO_NODE in local_memory_node if
 zonelists are not setup
Message-ID: <20140221235616.GA25399@linux.vnet.ibm.com>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402201004460.11829@nuc>
 <20140220182847.GA24745@linux.vnet.ibm.com>
 <20140221144203.8d7b0d7039846c0304f86141@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140221144203.8d7b0d7039846c0304f86141@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.02.2014 [14:42:03 -0800], Andrew Morton wrote:
> On Thu, 20 Feb 2014 10:28:47 -0800 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:
> 
> > On 20.02.2014 [10:05:39 -0600], Christoph Lameter wrote:
> > > On Wed, 19 Feb 2014, Nishanth Aravamudan wrote:
> > > 
> > > > We can call local_memory_node() before the zonelists are setup. In that
> > > > case, first_zones_zonelist() will not set zone and the reference to
> > > > zone->node will Oops. Catch this case, and, since we presumably running
> > > > very early, just return that any node will do.
> > > 
> > > Really? Isnt there some way to avoid this call if zonelists are not setup
> > > yet?
> > 
> > How do I best determine if zonelists aren't setup yet?
> > 
> > The call-path in question (after my series is applied) is:
> > 
> > arch/powerpc/kernel/setup_64.c::setup_arch ->
> > 	arch/powerpc/mm/numa.c::do_init_bootmem() ->
> > 		cpu_numa_callback() ->
> > 			numa_setup_cpu() ->
> > 				map_cpu_to_node() ->
> > 					update_numa_cpu_node() ->
> > 						set_cpu_numa_mem()
> > 
> > and setup_arch() is called before build_all_zonelists(NULL, NULL) in
> > start_kernel(). This seemed like the most reasonable path, as it's used
> > on hotplug as well.
> > 
> 
> But the call to local_memory_node() you added was in start_secondary(),
> which isn't in that trace.

I added two calls to local_memory_node(), I *think* both are necessary,
but am willing to be corrected.

One is in map_cpu_to_node() and one is in start_secondary(). The
start_secondary() path is fine, AFAICT, as we are up & running at that
point. But in [the renamed function] update_numa_cpu_node() which is
used by hotplug, we get called from do_init_bootmem(), which is before
the zonelists are setup.

I think both calls are necessary because I believe the
arch_update_cpu_topology() is used for supporting firmware-driven
home-noding, which does not invoke start_secondary() again (the
processor is already running, we're just updating the topology in that
situation).

Then again, I could special-case the do_init_bootmem callpath, which is
only called at kernel init time?

> I do agree that calling local_memory_node() too early then trying to
> fudge around the consequences seems rather wrong.

If the answer is to simply not call local_memory_node() early, I'll
submit a patch to at least add a comment, as there's nothing in the code
itself to prevent this from happening and is guaranteed to oops.

Thanks,
Nish

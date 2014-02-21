Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id D271C2C02FA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 09:42:05 +1100 (EST)
Date: Fri, 21 Feb 2014 14:42:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] mm: return NUMA_NO_NODE in local_memory_node if
 zonelists are not setup
Message-Id: <20140221144203.8d7b0d7039846c0304f86141@linux-foundation.org>
In-Reply-To: <20140220182847.GA24745@linux.vnet.ibm.com>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402201004460.11829@nuc>
 <20140220182847.GA24745@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 20 Feb 2014 10:28:47 -0800 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:

> On 20.02.2014 [10:05:39 -0600], Christoph Lameter wrote:
> > On Wed, 19 Feb 2014, Nishanth Aravamudan wrote:
> > 
> > > We can call local_memory_node() before the zonelists are setup. In that
> > > case, first_zones_zonelist() will not set zone and the reference to
> > > zone->node will Oops. Catch this case, and, since we presumably running
> > > very early, just return that any node will do.
> > 
> > Really? Isnt there some way to avoid this call if zonelists are not setup
> > yet?
> 
> How do I best determine if zonelists aren't setup yet?
> 
> The call-path in question (after my series is applied) is:
> 
> arch/powerpc/kernel/setup_64.c::setup_arch ->
> 	arch/powerpc/mm/numa.c::do_init_bootmem() ->
> 		cpu_numa_callback() ->
> 			numa_setup_cpu() ->
> 				map_cpu_to_node() ->
> 					update_numa_cpu_node() ->
> 						set_cpu_numa_mem()
> 
> and setup_arch() is called before build_all_zonelists(NULL, NULL) in
> start_kernel(). This seemed like the most reasonable path, as it's used
> on hotplug as well.
> 

But the call to local_memory_node() you added was in start_secondary(),
which isn't in that trace.

I do agree that calling local_memory_node() too early then trying to
fudge around the consequences seems rather wrong.

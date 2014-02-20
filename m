Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 017DF2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 05:29:05 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 20 Feb 2014 11:29:02 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0F12C3E40063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 11:29:00 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1KISxXW1049038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 19:29:00 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1KISx5i029830
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 11:28:59 -0700
Date: Thu, 20 Feb 2014 10:28:47 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 1/3] mm: return NUMA_NO_NODE in local_memory_node if
 zonelists are not setup
Message-ID: <20140220182847.GA24745@linux.vnet.ibm.com>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402201004460.11829@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402201004460.11829@nuc>
Cc: Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20.02.2014 [10:05:39 -0600], Christoph Lameter wrote:
> On Wed, 19 Feb 2014, Nishanth Aravamudan wrote:
> 
> > We can call local_memory_node() before the zonelists are setup. In that
> > case, first_zones_zonelist() will not set zone and the reference to
> > zone->node will Oops. Catch this case, and, since we presumably running
> > very early, just return that any node will do.
> 
> Really? Isnt there some way to avoid this call if zonelists are not setup
> yet?

How do I best determine if zonelists aren't setup yet?

The call-path in question (after my series is applied) is:

arch/powerpc/kernel/setup_64.c::setup_arch ->
	arch/powerpc/mm/numa.c::do_init_bootmem() ->
		cpu_numa_callback() ->
			numa_setup_cpu() ->
				map_cpu_to_node() ->
					update_numa_cpu_node() ->
						set_cpu_numa_mem()

and setup_arch() is called before build_all_zonelists(NULL, NULL) in
start_kernel(). This seemed like the most reasonable path, as it's used
on hotplug as well.

I'm open to suggestsions!

Thanks,
Nish

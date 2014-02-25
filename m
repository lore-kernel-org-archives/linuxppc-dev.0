Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2FCB12C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 13:34:26 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 24 Feb 2014 19:34:23 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A17933E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 19:34:21 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P0Vftv8192396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 01:31:41 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P2YJv9019167
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 19:34:20 -0700
Date: Mon, 24 Feb 2014 18:34:15 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 1/3] mm: return NUMA_NO_NODE in local_memory_node if
 zonelists are not setup
Message-ID: <20140225023415.GA6105@linux.vnet.ibm.com>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402201004460.11829@nuc>
 <20140220182847.GA24745@linux.vnet.ibm.com>
 <20140221144203.8d7b0d7039846c0304f86141@linux-foundation.org>
 <20140221235616.GA25399@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402241342480.20839@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402241342480.20839@nuc>
Cc: Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24.02.2014 [13:43:31 -0600], Christoph Lameter wrote:
> On Fri, 21 Feb 2014, Nishanth Aravamudan wrote:
> 
> > I added two calls to local_memory_node(), I *think* both are necessary,
> > but am willing to be corrected.
> >
> > One is in map_cpu_to_node() and one is in start_secondary(). The
> > start_secondary() path is fine, AFAICT, as we are up & running at that
> > point. But in [the renamed function] update_numa_cpu_node() which is
> > used by hotplug, we get called from do_init_bootmem(), which is before
> > the zonelists are setup.
> >
> > I think both calls are necessary because I believe the
> > arch_update_cpu_topology() is used for supporting firmware-driven
> > home-noding, which does not invoke start_secondary() again (the
> > processor is already running, we're just updating the topology in that
> > situation).
> >
> > Then again, I could special-case the do_init_bootmem callpath, which is
> > only called at kernel init time?
> 
> Well taht looks to be simpler.

Ok, I'll work on this.

> > > I do agree that calling local_memory_node() too early then trying to
> > > fudge around the consequences seems rather wrong.
> >
> > If the answer is to simply not call local_memory_node() early, I'll
> > submit a patch to at least add a comment, as there's nothing in the code
> > itself to prevent this from happening and is guaranteed to oops.
> 
> Ok.

Thanks!
-Nish

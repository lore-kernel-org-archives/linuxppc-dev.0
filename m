Return-Path: <cl@linux.com>
Received: from qmta05.emeryville.ca.mail.comcast.net
 (qmta05.emeryville.ca.mail.comcast.net [76.96.30.48])
 by ozlabs.org (Postfix) with ESMTP id AD9D22C0227
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 06:43:39 +1100 (EST)
Date: Mon, 24 Feb 2014 13:43:31 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] mm: return NUMA_NO_NODE in local_memory_node if
 zonelists are not setup
In-Reply-To: <20140221235616.GA25399@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402241342480.20839@nuc>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402201004460.11829@nuc>
 <20140220182847.GA24745@linux.vnet.ibm.com>
 <20140221144203.8d7b0d7039846c0304f86141@linux-foundation.org>
 <20140221235616.GA25399@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 21 Feb 2014, Nishanth Aravamudan wrote:

> I added two calls to local_memory_node(), I *think* both are necessary,
> but am willing to be corrected.
>
> One is in map_cpu_to_node() and one is in start_secondary(). The
> start_secondary() path is fine, AFAICT, as we are up & running at that
> point. But in [the renamed function] update_numa_cpu_node() which is
> used by hotplug, we get called from do_init_bootmem(), which is before
> the zonelists are setup.
>
> I think both calls are necessary because I believe the
> arch_update_cpu_topology() is used for supporting firmware-driven
> home-noding, which does not invoke start_secondary() again (the
> processor is already running, we're just updating the topology in that
> situation).
>
> Then again, I could special-case the do_init_bootmem callpath, which is
> only called at kernel init time?

Well taht looks to be simpler.

> > I do agree that calling local_memory_node() too early then trying to
> > fudge around the consequences seems rather wrong.
>
> If the answer is to simply not call local_memory_node() early, I'll
> submit a patch to at least add a comment, as there's nothing in the code
> itself to prevent this from happening and is guaranteed to oops.

Ok.

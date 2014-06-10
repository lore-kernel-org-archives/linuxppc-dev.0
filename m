Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 100371A00D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 09:31:18 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 17:31:15 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7EC8D3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 17:31:12 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.ahe.boulder.ibm.com
 [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5ALRkw17995874
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 23:27:47 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5ANVAjf021371
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 17:31:11 -0600
Date: Tue, 10 Jun 2014 16:30:59 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: NUMA topology question wrt. d4edc5b6
Message-ID: <20140610233059.GA24463@linux.vnet.ibm.com>
References: <20140521200451.GB5755@linux.vnet.ibm.com>
 <537E6285.3050000@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1406091436090.5271@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1406091436090.5271@chino.kir.corp.google.com>
Cc: Dave Hansen <dave@sr71.net>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Linux MM <linux-mm@kvack.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 nfont@linux.vnet.ibm.com, Cody P Schafer <cody@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09.06.2014 [14:38:26 -0700], David Rientjes wrote:
> On Fri, 23 May 2014, Srivatsa S. Bhat wrote:
> 
> > diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> > index c920215..58e6469 100644
> > --- a/arch/powerpc/include/asm/topology.h
> > +++ b/arch/powerpc/include/asm/topology.h
> > @@ -18,6 +18,7 @@ struct device_node;
> >   */
> >  #define RECLAIM_DISTANCE 10
> >  
> > +#include <linux/nodemask.h>
> >  #include <asm/mmzone.h>
> >  
> >  static inline int cpu_to_node(int cpu)
> > @@ -30,7 +31,7 @@ static inline int cpu_to_node(int cpu)
> >  	 * During early boot, the numa-cpu lookup table might not have been
> >  	 * setup for all CPUs yet. In such cases, default to node 0.
> >  	 */
> > -	return (nid < 0) ? 0 : nid;
> > +	return (nid < 0) ? first_online_node : nid;
> >  }
> >  
> >  #define parent_node(node)	(node)
> 
> I wonder what would happen on ppc if we just returned NUMA_NO_NODE here 
> for cpus that have not been mapped (they shouldn't even be possible).  

Well, with my patch (Ben sent it to Linus in the last pull request, I
think), powerpc uses the generic per-cpu stuff, so this function is
gone. Dunno if it makes sense to initialize the per-cpu data to
NUMA_NO_NODE (rather than 0?).

For powerpc, it's a timing thing. We can call cpu_to_node() quite early,
and we may not have set up the mapping information yet.

> This would at least allow callers that do
> kmalloc_node(..., cpu_to_node(cpu)) to be allocated on the local cpu 
> rather than on a perhaps offline or remote node 0.
> 
> It would seem better to catch callers that do 
> cpu_to_node(<not-possible-cpu>) rather than blindly return an online node.

Agreed, but I've not seen such a case.

Thanks,
Nish

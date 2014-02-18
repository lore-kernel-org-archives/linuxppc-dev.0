Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A0852C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 04:36:53 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 18 Feb 2014 10:36:51 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5D9CC19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 10:36:48 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1IHaQ7u9175498
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 18:36:26 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1IHakTa003697
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 10:36:49 -0700
Date: Tue, 18 Feb 2014 09:28:33 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140218172832.GD31998@linux.vnet.ibm.com>
References: <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com>
 <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com>
 <20140217070051.GE3468@lge.com>
 <alpine.DEB.2.10.1402181051560.1291@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402181051560.1291@nuc>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.02.2014 [10:57:09 -0600], Christoph Lameter wrote:
> On Mon, 17 Feb 2014, Joonsoo Kim wrote:
> 
> > On Wed, Feb 12, 2014 at 10:51:37PM -0800, Nishanth Aravamudan wrote:
> > > Hi Joonsoo,
> > > Also, given that only ia64 and (hopefuly soon) ppc64 can set
> > > CONFIG_HAVE_MEMORYLESS_NODES, does that mean x86_64 can't have
> > > memoryless nodes present? Even with fakenuma? Just curious.
> 
> x86_64 currently does not support memoryless nodes otherwise it would
> have set CONFIG_HAVE_MEMORYLESS_NODES in the kconfig. Memoryless nodes are
> a bit strange given that the NUMA paradigm is to have NUMA nodes (meaning
> memory) with processors. MEMORYLESS nodes means that we have a fake NUMA
> node without memory but just processors. Not very efficient. Not sure why
> people use these configurations.

Well, on powerpc, with the hypervisor providing the resources and the
topology, you can have cpuless and memoryless nodes. I'm not sure how
"fake" the NUMA is -- as I think since the resources are virtualized to
be one system, it's logically possible that the actual topology of the
resources can be CPUs from physical node 0 and memory from physical node
2. I would think with KVM on a sufficiently large (physically NUMA
x86_64) and loaded system, one could cause the same sort of
configuration to occur for a guest?

In any case, these configurations happen fairly often on long-running
(not rebooted) systems as LPARs are created/destroyed, resources are
DLPAR'd in and out of LPARs, etc.

> > I don't know, because I'm not expert on NUMA system :)
> > At first glance, fakenuma can't be used for testing
> > CONFIG_HAVE_MEMORYLESS_NODES. Maybe some modification is needed.
> 
> Well yeah. You'd have to do some mods to enable that testing.

I might look into it, as it might have sped up testing these changes.

Thanks,
Nish

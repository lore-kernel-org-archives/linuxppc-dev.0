Return-Path: <rientjes@google.com>
Received: from mail-pb0-x234.google.com (mail-pb0-x234.google.com
 [IPv6:2607:f8b0:400e:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 97B352C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 09:45:54 +1100 (EST)
Received: by mail-pb0-f52.google.com with SMTP id jt11so11425737pbb.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 14:45:51 -0800 (PST)
Date: Thu, 13 Feb 2014 14:45:49 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: enable CONFIG_HAVE_MEMORYLESS_NODES
In-Reply-To: <20140213214131.GB12409@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1402131444440.13899@chino.kir.corp.google.com>
References: <20140128183457.GA9315@linux.vnet.ibm.com>
 <20140213214131.GB12409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Matt Mackall <mpm@selenic.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 13 Feb 2014, Nishanth Aravamudan wrote:

> > Anton Blanchard found an issue with an LPAR that had no memory in Node
> > 0. Christoph Lameter recommended, as one possible solution, to use
> > numa_mem_id() for locality of the nearest memory node-wise. However,
> > numa_mem_id() [and the other related APIs] are only useful if
> > CONFIG_HAVE_MEMORYLESS_NODES is set. This is only the case for ia64
> > currently, but clearly we can have memoryless nodes on ppc64. Add the
> > Kconfig option and define it to be the same value as CONFIG_NUMA.
> > 
> > On the LPAR in question, which was very inefficiently using slabs, this
> > took the slab consumption at boot from roughly 7GB to roughly 4GB.
> 
> Err, this should have been
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> !
> 
> Sorry about that Ben!
>     
> > ---
> > Ben, the only question I have wrt this change is if it's appropriate to
> > change it for all powerpc configs (that have NUMA on)?
> > 

I'm suspecting that Ben will request that the proper set_numa_mem() calls 
are done for ppc init to make this actually do anything other than return 
numa_mem_id() == numa_node_id().

> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 25493a0..bb2d5fe 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -447,6 +447,9 @@ config NODES_SHIFT
> >  	default "4"
> >  	depends on NEED_MULTIPLE_NODES
> >  
> > +config HAVE_MEMORYLESS_NODES
> > +	def_bool NUMA
> > +
> >  config ARCH_SELECT_MEMORY_MODEL
> >  	def_bool y
> >  	depends on PPC64

Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A7D672C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 08:09:36 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 18 Feb 2014 16:09:33 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 00A7738C8027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 16:09:30 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1IL9TON66191410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 21:09:29 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1IL9S7g005333
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 16:09:29 -0500
Date: Tue, 18 Feb 2014 13:09:23 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140218210923.GA28170@linux.vnet.ibm.com>
References: <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com>
 <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com>
 <20140217070051.GE3468@lge.com>
 <alpine.DEB.2.10.1402181051560.1291@nuc>
 <20140218172832.GD31998@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402181356120.2910@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402181356120.2910@nuc>
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

On 18.02.2014 [13:58:20 -0600], Christoph Lameter wrote:
> On Tue, 18 Feb 2014, Nishanth Aravamudan wrote:
> 
> >
> > Well, on powerpc, with the hypervisor providing the resources and the
> > topology, you can have cpuless and memoryless nodes. I'm not sure how
> > "fake" the NUMA is -- as I think since the resources are virtualized to
> > be one system, it's logically possible that the actual topology of the
> > resources can be CPUs from physical node 0 and memory from physical node
> > 2. I would think with KVM on a sufficiently large (physically NUMA
> > x86_64) and loaded system, one could cause the same sort of
> > configuration to occur for a guest?
> 
> Ok but since you have a virtualized environment: Why not provide a fake
> home node with fake memory that could be anywhere? This would avoid the
> whole problem of supporting such a config at the kernel level.

We use the topology provided by the hypervisor, it does actually reflect
where CPUs and memory are, and their corresponding performance/NUMA
characteristics.

> Do not have a fake node that has no memory.
> 
> > In any case, these configurations happen fairly often on long-running
> > (not rebooted) systems as LPARs are created/destroyed, resources are
> > DLPAR'd in and out of LPARs, etc.
> 
> Ok then also move the memory of the local node somewhere?

This happens below the OS, we don't control the hypervisor's decisions.
I'm not sure if that's what you are suggesting.

Thanks,
Nish

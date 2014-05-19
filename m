Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A86DF1A007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 04:24:18 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 19 May 2014 14:24:15 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D1331C90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 14:24:07 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4JIOCHR64422036
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 18:24:12 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4JIOBnu006641
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 14:24:12 -0400
Date: Mon, 19 May 2014 11:24:00 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: Node 0 not necessary for powerpc?
Message-ID: <20140519182400.GM8941@linux.vnet.ibm.com>
References: <20140311195632.GA946@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403120839110.6865@nuc>
 <20140313164949.GC22247@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140313164949.GC22247@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.03.2014 [09:49:49 -0700], Nishanth Aravamudan wrote:
> On 12.03.2014 [08:41:40 -0500], Christoph Lameter wrote:
> > On Tue, 11 Mar 2014, Nishanth Aravamudan wrote:
> > > I have a P7 system that has no node0, but a node0 shows up in numactl
> > > --hardware, which has no cpus and no memory (and no PCI devices):
> > 
> > Well as you see from the code there has been so far the assumption that
> > node 0 has memory. I have never run a machine that has no node 0 memory.
> 
> Do you mean beyond the initialization? I didn't see anything obvious so
> far in the code itself that assumes a given node has memory (in the
> sense of the nid). What are your thoughts about how best to support
> this?

Ah, I found one path that is problematic on powerpc:

I'm seeing a panic at boot with this change on an LPAR which actually
has no Node 0. Here's what I think is happening:

start_kernel
    ...
    -> setup_per_cpu_areas
        -> pcpu_embed_first_chunk
            -> pcpu_fc_alloc
                -> ___alloc_bootmem_node(NODE_DATA(cpu_to_node(cpu), ...
    -> smp_prepare_boot_cpu
        -> set_numa_node(boot_cpuid)

So we panic on the NODE_DATA call. It seems that ia64, at least, uses
pcpu_alloc_first_chunk rather than embed. x86 has some code to handle
early calls of cpu_to_node (early_cpu_to_node) and sets the mapping for
all CPUs in setup_per_cpu_areas().

Thoughts? Does that mean we need something similar to x86 for powerpc?

Thanks,
Nish

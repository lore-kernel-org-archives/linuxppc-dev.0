Return-Path: <cl@linux.com>
Received: from qmta07.emeryville.ca.mail.comcast.net
 (qmta07.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:64])
 by lists.ozlabs.org (Postfix) with ESMTP id 2600B1A0814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 00:24:47 +1000 (EST)
Date: Wed, 21 May 2014 09:16:27 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Node 0 not necessary for powerpc?
In-Reply-To: <20140519182400.GM8941@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1405210915170.7859@gentwo.org>
References: <20140311195632.GA946@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403120839110.6865@nuc>
 <20140313164949.GC22247@linux.vnet.ibm.com>
 <20140519182400.GM8941@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <htejun@gmail.com>, linux-mm@kvack.org, tony.luck@intel.com,
 anton@samba.org, David Rientjes <rientjes@google.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 May 2014, Nishanth Aravamudan wrote:

> I'm seeing a panic at boot with this change on an LPAR which actually
> has no Node 0. Here's what I think is happening:
>
> start_kernel
>     ...
>     -> setup_per_cpu_areas
>         -> pcpu_embed_first_chunk
>             -> pcpu_fc_alloc
>                 -> ___alloc_bootmem_node(NODE_DATA(cpu_to_node(cpu), ...
>     -> smp_prepare_boot_cpu
>         -> set_numa_node(boot_cpuid)
>
> So we panic on the NODE_DATA call. It seems that ia64, at least, uses
> pcpu_alloc_first_chunk rather than embed. x86 has some code to handle
> early calls of cpu_to_node (early_cpu_to_node) and sets the mapping for
> all CPUs in setup_per_cpu_areas().

Maybe we can switch ia64 too embed? Tejun: Why are there these
dependencies?

> Thoughts? Does that mean we need something similar to x86 for powerpc?

Tejun is the expert in this area. CCing him.

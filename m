Return-Path: <rientjes@google.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423891A005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:48:02 +1000 (EST)
Received: by mail-ig0-f169.google.com with SMTP id a13so4350023igq.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jun 2014 14:47:59 -0700 (PDT)
Date: Mon, 9 Jun 2014 14:47:57 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Node 0 not necessary for powerpc?
In-Reply-To: <20140521195743.GA5755@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1406091447240.5271@chino.kir.corp.google.com>
References: <20140311195632.GA946@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403120839110.6865@nuc>
 <20140313164949.GC22247@linux.vnet.ibm.com>
 <20140519182400.GM8941@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1405210915170.7859@gentwo.org>
 <20140521185812.GA5259@htj.dyndns.org>
 <20140521195743.GA5755@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <htejun@gmail.com>, linux-mm@kvack.org, tony.luck@intel.com,
 anton@samba.org, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 May 2014, Nishanth Aravamudan wrote:

> For context: I was looking at why N_ONLINE was statically setting Node 0
> to be online, whether or not the topology is that way -- I've been
> getting several bugs lately where Node 0 is online, but has no CPUs and
> no memory on it, on powerpc. 
> 
> On powerpc, setup_per_cpu_areas calls into ___alloc_bootmem_node using
> NODE_DATA(cpu_to_node(cpu)).
> 
> Currently, cpu_to_node() in arch/powerpc/include/asm/topology.h does:
> 
>         /*
>          * During early boot, the numa-cpu lookup table might not have been
>          * setup for all CPUs yet. In such cases, default to node 0.
>          */
>         return (nid < 0) ? 0 : nid;
> 
> And so early at boot, if node 0 is not present, we end up accessing an
> unitialized NODE_DATA(). So this seems buggy (I'll contact the powerpc
> deveopers separately on that).
> 

I think what this really wants to do is NODE_DATA(cpu_to_mem(cpu)) and I 
thought ppc had the cpu-to-local-memory-node mappings correct?

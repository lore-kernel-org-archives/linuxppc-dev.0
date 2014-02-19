Return-Path: <rientjes@google.com>
Received: from mail-pb0-x22a.google.com (mail-pb0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29B042C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 09:03:23 +1100 (EST)
Received: by mail-pb0-f42.google.com with SMTP id jt11so978545pbb.15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 14:03:21 -0800 (PST)
Date: Wed, 19 Feb 2014 14:03:19 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <alpine.DEB.2.10.1402181356120.2910@nuc>
Message-ID: <alpine.DEB.2.02.1402191400400.31921@chino.kir.corp.google.com>
References: <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com> <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com> <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com> <20140217070051.GE3468@lge.com>
 <alpine.DEB.2.10.1402181051560.1291@nuc>
 <20140218172832.GD31998@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402181356120.2910@nuc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Matt Mackall <mpm@selenic.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Feb 2014, Christoph Lameter wrote:

> Ok but since you have a virtualized environment: Why not provide a fake
> home node with fake memory that could be anywhere? This would avoid the
> whole problem of supporting such a config at the kernel level.
> 

By acpi, the abstraction of a NUMA node can include any combination of 
cpus, memory, I/O resources, networking, or storage devices.  This allows 
two memoryless nodes, for example, to have different proximity to memory.

Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E0642C0227
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 09:23:23 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 18 Feb 2014 15:23:20 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DA1EF1FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 15:23:17 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1IMNCL37012628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 23:23:17 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1IMMu2r012606
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 15:22:57 -0700
Date: Tue, 18 Feb 2014 14:22:42 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for
 determining the fallback node
Message-ID: <20140218222242.GA10844@linux.vnet.ibm.com>
References: <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com>
 <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com>
 <20140217070051.GE3468@lge.com>
 <alpine.DEB.2.10.1402181051560.1291@nuc>
 <20140218172832.GD31998@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402181356120.2910@nuc>
 <20140218210923.GA28170@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402181547210.3973@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1402181547210.3973@nuc>
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

On 18.02.2014 [15:49:22 -0600], Christoph Lameter wrote:
> On Tue, 18 Feb 2014, Nishanth Aravamudan wrote:
> 
> > We use the topology provided by the hypervisor, it does actually reflect
> > where CPUs and memory are, and their corresponding performance/NUMA
> > characteristics.
> 
> And so there are actually nodes without memory that have processors?

Virtually (topologically as indicated to Linux), yes. Physically, I
don't think they are, but they might be exhausted, which is we get sort
of odd-appearing NUMA configurations.

> Can the hypervisor or the linux arch code be convinced to ignore nodes
> without memory or assign a sane default node to processors?

I think this happens quite often, so I don't know that we want to ignore
the performance impact of the underlying NUMA configuration. I guess we
could special-case memoryless/cpuless configurations somewhat, but I
don't think there's any reason to do that if we can make memoryless-node
support work in-kernel?

> > > Ok then also move the memory of the local node somewhere?
> >
> > This happens below the OS, we don't control the hypervisor's decisions.
> > I'm not sure if that's what you are suggesting.
> 
> You could also do this from the powerpc arch code by sanitizing the
> processor / node information that is then used by Linux.

I see what you're saying now, thanks!

-Nish

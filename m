Return-Path: <cl@linux.com>
Received: from qmta04.emeryville.ca.mail.comcast.net
 (qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
 by ozlabs.org (Postfix) with ESMTP id 8E0142C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 08:49:29 +1100 (EST)
Date: Tue, 18 Feb 2014 15:49:22 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140218210923.GA28170@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402181547210.3973@nuc>
References: <20140207054819.GC28952@lge.com>
 <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com> <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com>
 <20140217070051.GE3468@lge.com> <alpine.DEB.2.10.1402181051560.1291@nuc>
 <20140218172832.GD31998@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402181356120.2910@nuc>
 <20140218210923.GA28170@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 18 Feb 2014, Nishanth Aravamudan wrote:

> We use the topology provided by the hypervisor, it does actually reflect
> where CPUs and memory are, and their corresponding performance/NUMA
> characteristics.

And so there are actually nodes without memory that have processors?
Can the hypervisor or the linux arch code be convinced to ignore nodes
without memory or assign a sane default node to processors?

> > Ok then also move the memory of the local node somewhere?
>
> This happens below the OS, we don't control the hypervisor's decisions.
> I'm not sure if that's what you are suggesting.

You could also do this from the powerpc arch code by sanitizing the
processor / node information that is then used by Linux.

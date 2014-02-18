Return-Path: <cl@linux.com>
Received: from qmta07.emeryville.ca.mail.comcast.net
 (qmta07.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:64])
 by ozlabs.org (Postfix) with ESMTP id 520BA2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 03:57:13 +1100 (EST)
Date: Tue, 18 Feb 2014 10:57:09 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140217070051.GE3468@lge.com>
Message-ID: <alpine.DEB.2.10.1402181051560.1291@nuc>
References: <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060041040.21148@chino.kir.corp.google.com>
 <CAAmzW4PXkdpNi5pZ=4BzdXNvqTEAhcuw-x0pWidqrxzdePxXxA@mail.gmail.com>
 <alpine.DEB.2.02.1402061248450.9567@chino.kir.corp.google.com>
 <20140207054819.GC28952@lge.com> <alpine.DEB.2.10.1402071150090.15168@nuc>
 <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com> <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com>
 <20140217070051.GE3468@lge.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 17 Feb 2014, Joonsoo Kim wrote:

> On Wed, Feb 12, 2014 at 10:51:37PM -0800, Nishanth Aravamudan wrote:
> > Hi Joonsoo,
> > Also, given that only ia64 and (hopefuly soon) ppc64 can set
> > CONFIG_HAVE_MEMORYLESS_NODES, does that mean x86_64 can't have
> > memoryless nodes present? Even with fakenuma? Just curious.

x86_64 currently does not support memoryless nodes otherwise it would
have set CONFIG_HAVE_MEMORYLESS_NODES in the kconfig. Memoryless nodes are
a bit strange given that the NUMA paradigm is to have NUMA nodes (meaning
memory) with processors. MEMORYLESS nodes means that we have a fake NUMA
node without memory but just processors. Not very efficient. Not sure why
people use these configurations.

> I don't know, because I'm not expert on NUMA system :)
> At first glance, fakenuma can't be used for testing
> CONFIG_HAVE_MEMORYLESS_NODES. Maybe some modification is needed.

Well yeah. You'd have to do some mods to enable that testing.

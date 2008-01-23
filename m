Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id 4A3A2DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 05:35:34 +1100 (EST)
Date: Wed, 23 Jan 2008 10:35:32 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Fix boot problem in situations where the boot CPU is
	running on a memoryless node
In-Reply-To: <Pine.LNX.4.64.0801231611160.20050@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0801231034110.11430@schroedinger.engr.sgi.com>
References: <20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<20080122214505.GA15674@aepfle.de>
	<Pine.LNX.4.64.0801221417480.1912@schroedinger.engr.sgi.com>
	<20080123075821.GA17713@aepfle.de> <20080123105044.GD21455@csn.ul.ie>
	<20080123121459.GA18631@aepfle.de> <20080123125236.GA18876@aepfle.de>
	<20080123135513.GA14175@csn.ul.ie>
	<Pine.LNX.4.64.0801231611160.20050@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lee.schermerhorn@hp.com, Olaf Hering <olaf@aepfle.de>,
	Linux MM <linux-mm@kvack.org>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	hanth Aravamudan <nacc@us.ibm.com>, akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Jan 2008, Pekka J Enberg wrote:

> I still think Christoph's kmem_getpages() patch is correct (to fix 
> cache_grow() oops) but I overlooked the fact that none the callers of 
> ____cache_alloc_node() deal with bootstrapping (with the exception of 
> __cache_alloc_node() that even has a comment about it).

My patch is useless. kmem_getpages called with nodeid == -1 falls back 
correctly to the available node. The problem is that the node structures 
for the page does not exist.
 
> But what I am really wondering about is, why wasn't the 
> N_NORMAL_MEMORY revert enough? I assume this used to work before so what 
> more do we need to revert for 2.6.24?

I think that is because SLUB relaxed the requirements on having regular 
memory on the boot node. Now the expectation is that SLAB can do the same.

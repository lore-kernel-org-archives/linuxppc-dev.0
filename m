Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 58DAADDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 05:51:33 +1100 (EST)
Date: Wed, 23 Jan 2008 10:51:32 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Fix boot problem in situations where the boot CPU is
	running on a memoryless node
In-Reply-To: <Pine.LNX.4.64.0801231906520.1028@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0801231036440.11430@schroedinger.engr.sgi.com>
References: <20080122214505.GA15674@aepfle.de>
	<Pine.LNX.4.64.0801221417480.1912@schroedinger.engr.sgi.com>
	<20080123075821.GA17713@aepfle.de> <20080123105044.GD21455@csn.ul.ie>
	<20080123121459.GA18631@aepfle.de> <20080123125236.GA18876@aepfle.de>
	<20080123135513.GA14175@csn.ul.ie>
	<Pine.LNX.4.64.0801231611160.20050@sbz-30.cs.Helsinki.FI>
	<Pine.LNX.4.64.0801231626320.21475@sbz-30.cs.Helsinki.FI>
	<Pine.LNX.4.64.0801231648140.23343@sbz-30.cs.Helsinki.FI>
	<20080123155655.GB20156@csn.ul.ie>
	<Pine.LNX.4.64.0801231906520.1028@sbz-30.cs.Helsinki.FI>
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

> Fine. But, why are we hitting fallback_alloc() in the first place? It's 
> definitely not because of missing ->nodelists as we do:
> 
>         cache_cache.nodelists[node] = &initkmem_list3[CACHE_CACHE];
> 
> before attempting to set up kmalloc caches. Now, if I understood 
> correctly, we're booting off a memoryless node so kmem_getpages() will 
> return NULL thus forcing us to fallback_alloc() which is unavailable at 
> this point.
> 
> As far as I can tell, there are two ways to fix this:
> 
>   (1) don't boot off a memoryless node (why are we doing this in the first 
>       place?)

Right. That is the solution that I would prefer.

>   (2) initialize cache_cache.nodelists with initmem_list3 equivalents
>       for *each node hat has normal memory*

Or simply do it for all. SLAB bootstrap is very complex thing though.

> 
> I am still wondering why this worked before, though.

I doubt it did ever work for SLAB.

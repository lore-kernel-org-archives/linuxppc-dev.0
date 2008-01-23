Return-Path: <penberg@cs.helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE79CDDF1F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 04:29:22 +1100 (EST)
Date: Wed, 23 Jan 2008 19:29:15 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] Fix boot problem in situations where the boot CPU is
	running on a memoryless node
In-Reply-To: <20080123155655.GB20156@csn.ul.ie>
Message-ID: <Pine.LNX.4.64.0801231906520.1028@sbz-30.cs.Helsinki.FI>
References: <20080122214505.GA15674@aepfle.de>
	<Pine.LNX.4.64.0801221417480.1912@schroedinger.engr.sgi.com>
	<20080123075821.GA17713@aepfle.de> <20080123105044.GD21455@csn.ul.ie>
	<20080123121459.GA18631@aepfle.de> <20080123125236.GA18876@aepfle.de>
	<20080123135513.GA14175@csn.ul.ie>
	<Pine.LNX.4.64.0801231611160.20050@sbz-30.cs.Helsinki.FI>
	<Pine.LNX.4.64.0801231626320.21475@sbz-30.cs.Helsinki.FI>
	<Pine.LNX.4.64.0801231648140.23343@sbz-30.cs.Helsinki.FI>
	<20080123155655.GB20156@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lee.schermerhorn@hp.com, Olaf Hering <olaf@aepfle.de>,
	Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	hanth Aravamudan <nacc@us.ibm.com>, akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, 23 Jan 2008, Mel Gorman wrote:
> Applied in combination with the N_NORMAL_MEMORY revert and it fails to
> boot. Console is as follows;

Thanks for testing!
 
On Wed, 23 Jan 2008, Mel Gorman wrote:
> [c0000000005c3b40] c0000000000dadb4 .cache_grow+0x7c/0x338
> [c0000000005c3c00] c0000000000db518 .fallback_alloc+0x1c0/0x224
> [c0000000005c3cb0] c0000000000db920 .kmem_cache_alloc+0xe0/0x14c
> [c0000000005c3d50] c0000000000dcbd0 .kmem_cache_create+0x230/0x4cc
> [c0000000005c3e30] c0000000004c049c .kmem_cache_init+0x1ec/0x51c
> [c0000000005c3ee0] c00000000049f8d8 .start_kernel+0x304/0x3fc
> [c0000000005c3f90] c000000000008594 .start_here_common+0x54/0xc0
> 
> 0xc0000000000dadb4 is in cache_grow (mm/slab.c:2782).
> 2777            local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
> 2778    
> 2779            /* Take the l3 list lock to change the colour_next on this node */
> 2780            check_irq_off();
> 2781            l3 = cachep->nodelists[nodeid];
> 2782            spin_lock(&l3->list_lock);
> 2783    
> 2784            /* Get colour for the slab, and cal the next value. */
> 2785            offset = l3->colour_next;
> 2786            l3->colour_next++;

Ok, so it's too early to fallback_alloc() because in kmem_cache_init() we 
do:

        for (i = 0; i < NUM_INIT_LISTS; i++) {
                kmem_list3_init(&initkmem_list3[i]);
                if (i < MAX_NUMNODES)
                        cache_cache.nodelists[i] = NULL;
        }

Fine. But, why are we hitting fallback_alloc() in the first place? It's 
definitely not because of missing ->nodelists as we do:

        cache_cache.nodelists[node] = &initkmem_list3[CACHE_CACHE];

before attempting to set up kmalloc caches. Now, if I understood 
correctly, we're booting off a memoryless node so kmem_getpages() will 
return NULL thus forcing us to fallback_alloc() which is unavailable at 
this point.

As far as I can tell, there are two ways to fix this:

  (1) don't boot off a memoryless node (why are we doing this in the first 
      place?)
  (2) initialize cache_cache.nodelists with initmem_list3 equivalents
      for *each node hat has normal memory*

I am still wondering why this worked before, though.

			Pekka

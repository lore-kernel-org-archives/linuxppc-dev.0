Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id D85D1679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 05:50:18 +1000 (EST)
Date: Fri, 13 Oct 2006 12:05:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1160764895.11239.14.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Oct 2006, Will Schmidt wrote:

>     Am seeing a crash on a power5 LPAR when booting the linux-2.6 git
> tree.  It's fairly early during boot, so I've included the whole log
> below.   This partition has 8 procs, (shared, including threads), and
> 512M RAM.  

This looks like slab bootstrap. You are bootstrapping while having 
zonelists build with zones that are only going to be populated later? 
This will lead to incorrect NUMA placement of lots of slab structures on 
bootup.

Check if the patch below may cure the oops. Your memory is likely 
still placed on the wrong numa nodes since we have to fallback from 
the intended node.

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-10-13 11:59:55.000000000 -0700
+++ linux-2.6/mm/slab.c	2006-10-13 12:03:15.000000000 -0700
@@ -3154,7 +3154,8 @@ void *fallback_alloc(struct kmem_cache *
 
 	for (z = zonelist->zones; *z && !obj; z++)
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z, flags))
+				cpuset_zone_allowed(*z, flags) &&
+				(*z)->free_pages)
 			obj = __cache_alloc_node(cache,
 					flags | __GFP_THISNODE,
 					zone_to_nid(*z));

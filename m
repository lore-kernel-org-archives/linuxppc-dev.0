Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 7CFDEDDEBC
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 09:16:30 +1100 (EST)
Date: Fri, 18 Jan 2008 14:16:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080118213011.GC10491@csn.ul.ie>
Message-ID: <Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
References: <20080115150949.GA14089@aepfle.de>
	<84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
	<Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de>
	<Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
	<20080118213011.GC10491@csn.ul.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lee.schermerhorn@hp.com, Linux MM <linux-mm@kvack.org>,
	Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	hanth Aravamudan <nacc@us.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Could you try this patch?

Memoryless nodes: Set N_NORMAL_MEMORY for a node if we do not support HIGHMEM

It seems that we only scan through zones to set N_NORMAL_MEMORY only if
CONFIG_HIGHMEM and CONFIG_NUMA are set. We need to set N_NORMAL_MEMORY
in the !CONFIG_HIGHMEM case.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2008-01-18 14:08:41.000000000 -0800
+++ linux-2.6/mm/page_alloc.c	2008-01-18 14:13:34.000000000 -0800
@@ -3812,7 +3812,6 @@ restart:
 /* Any regular memory on that node ? */
 static void check_for_regular_memory(pg_data_t *pgdat)
 {
-#ifdef CONFIG_HIGHMEM
 	enum zone_type zone_type;
 
 	for (zone_type = 0; zone_type <= ZONE_NORMAL; zone_type++) {
@@ -3820,7 +3819,6 @@ static void check_for_regular_memory(pg_
 		if (zone->present_pages)
 			node_set_state(zone_to_nid(zone), N_NORMAL_MEMORY);
 	}
-#endif
 }
 
 /**

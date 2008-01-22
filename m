Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 62B57DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:23:22 +1100 (EST)
Date: Tue, 22 Jan 2008 14:23:18 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080122214505.GA15674@aepfle.de>
Message-ID: <Pine.LNX.4.64.0801221417480.1912@schroedinger.engr.sgi.com>
References: <84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
	<Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de>
	<Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
	<20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<20080122214505.GA15674@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lee.schermerhorn@hp.com, Linux MM <linux-mm@kvack.org>,
	Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
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

On Tue, 22 Jan 2008, Olaf Hering wrote:

> It crashes now in a different way if the patch below is applied:

Yup no l3 structure for the current node. We are early in boostrap. You 
could just check if the l3 is there and if not just skip starting the 
reaper? This will be redone later anyways. Not sure if this will solve all 
your issues though. An l3 for the current node that we are booting on 
needs to be created early on for SLAB bootstrap to succeed. AFAICT SLUB 
doesnt care and simply uses whatever the page allocator gives it for the 
cpu slab. We may have gotten there because you only tested with SLUB 
recently and thus changes got in that broke SLAB boot assumptions.


> 0xc0000000000fe018 is in setup_cpu_cache (/home/olaf/kernel/git/linux-2.6-numa/mm/slab.c:2111).
> 2106                                    BUG_ON(!cachep->nodelists[node]);
> 2107                                    kmem_list3_init(cachep->nodelists[node]);
> 2108                            }
> 2109                    }
> 2110            }

if (cachep->nodelists[numa_node_id()])
	return;

> 2111            cachep->nodelists[numa_node_id()]->next_reap =
> 2112                            jiffies + REAPTIMEOUT_LIST3 +
> 2113                            ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
> 2114
> 2115            cpu_cache_get(cachep)->avail = 0;
> 
> 

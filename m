Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 1B75FDDEEB
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:11:19 +1100 (EST)
Date: Tue, 22 Jan 2008 12:11:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080122195448.GA15567@csn.ul.ie>
Message-ID: <Pine.LNX.4.64.0801221203340.27950@schroedinger.engr.sgi.com>
References: <20080115150949.GA14089@aepfle.de>
	<84144f020801170414q7d408a74uf47a84b777c36a4a@mail.gmail.com>
	<Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
	<Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de>
	<Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
	<20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lee.schermerhorn@hp.com, Olaf Hering <olaf@aepfle.de>,
	Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
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

On Tue, 22 Jan 2008, Mel Gorman wrote:

> Christoph/Pekka, this patch is papering over the problem and something
> more fundamental may be going wrong. The crash occurs because l3 is NULL
> and the cache is kmem_cache so this is early in the boot process. It is
> selecting l3 based on node 2 which is correct in terms of available memory
> but it initialises the lists on node 0 because that is the node the CPUs are
> located. Hence later it uses an uninitialised nodelists and BLAM. Relevant
> parts of the log for seeing the memoryless nodes in relation to CPUs is;

Would it be possible to run the bootstrap on a cpu that has a 
node with memory associated to it? I believe we had the same situation 
last year when GFP_THISNODE was introduced?

After you reverted the slab memoryless node patch there should be per node 
structures created for node 0 unless the node is marked offline. Is it? If 
so then you are booting a cpu that is associated with an offline node. 

> Can you see a better solution than this?

Well this means that bootstrap will work by introducing foreign objects 
into the per cpu queue (should only hold per cpu objects). They will 
later be consumed and then the queues will contain the right objects so 
the effect of the patch is minimal.

I thought we fixed the similar situation last year by dropping 
GFP_THISNODE for some allocations?

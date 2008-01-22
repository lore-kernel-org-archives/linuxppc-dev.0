Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F4D8DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:11:03 +1100 (EST)
Date: Tue, 22 Jan 2008 23:10:58 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: crash in kmem_cache_init
Message-ID: <20080122231058.GB866@csn.ul.ie>
References: <Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
	<20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de>
	<20080122195448.GA15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221203340.27950@schroedinger.engr.sgi.com>
	<20080122212654.GB15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221330390.1652@schroedinger.engr.sgi.com>
	<20080122225046.GA866@csn.ul.ie>
	<Pine.LNX.4.64.0801221453480.2271@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <Pine.LNX.4.64.0801221453480.2271@schroedinger.engr.sgi.com>
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

On (22/01/08 14:57), Christoph Lameter didst pronounce:
> On Tue, 22 Jan 2008, Mel Gorman wrote:
> 
> > > > Whatever this was a problem fixed in the past or not, it's broken again now
> > > > :( . It's possible that there is a __GFP_THISNODE that can be dropped early
> > > > at boot-time that would also fix this problem in a way that doesn't
> > > > affect runtime (like altering cache_grow in my patch does).
> > > 
> > > The dropping of GFP_THISNODE has the same effect as your patch. 
> > 
> > The dropping of it totally? If so, this patch might fix a boot but it'll
> > potentially be a performance regression on NUMA machines that only have
> > nodes with memory, right?
> 
> No the dropping during early allocations.,
> 

We can live with that if the machine otherwise survives during tests.
They are kicked off at the moment with CONFIG_SLAB_DEBUG set but the point
is moot if the patch doesn't work for Olaf. Am still waiting to hear if
the two patches in combination work for him.

> > o 0
> > o 2
> > Nodes with regular memory
> > o 2
> > Current running CPU 0 is associated with node 0
> > Current node is 0
> > 
> > So node 2 has regular memory but it's trying to use node 0 at a glance.
> > I've attached the patch I used against 2.6.24-rc8. It includes the revert.
> 
> We need the current processor to be attached to a node that has 
> memory. We cannot fall back that early because the structures for the 
> other nodes do not exist yet.
> 

Or bodge it early in the boot process so that a node with memory is
always used.

> > Online nodes
> > o 0
> > o 2
> > Nodes with regular memory
> > o 2
> > Current running CPU 0 is associated with node 0
> > Current node is 0
> >  o kmem_list3_init
> 
> This needs to be node 2.
> 

Rather it should be 2. I'll admit the physical setup of this machine is
.... less than ideal but clearly it's something that can happen even if
it's a bad idea.

> > [c0000000005c3b40] c0000000000dadec .cache_grow+0x7c/0x338
> > [c0000000005c3c00] c0000000000db54c .fallback_alloc+0x1c0/0x224
> 
> Fallback during bootstrap.
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab

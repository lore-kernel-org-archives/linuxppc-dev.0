Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id 08C9ADDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:34:16 +1100 (EST)
Date: Tue, 22 Jan 2008 13:34:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080122212654.GB15567@csn.ul.ie>
Message-ID: <Pine.LNX.4.64.0801221330390.1652@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0801170628580.19208@schroedinger.engr.sgi.com>
	<20080117181222.GA24411@aepfle.de>
	<Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de>
	<Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
	<20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221203340.27950@schroedinger.engr.sgi.com>
	<20080122212654.GB15567@csn.ul.ie>
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

> > After you reverted the slab memoryless node patch there should be per node 
> > structures created for node 0 unless the node is marked offline. Is it? If 
> > so then you are booting a cpu that is associated with an offline node. 
> > 
> 
> I'll roll a patch that prints out the online states before startup and
> see what it looks like.

Ok. Great.

> 
> > > Can you see a better solution than this?
> > 
> > Well this means that bootstrap will work by introducing foreign objects 
> > into the per cpu queue (should only hold per cpu objects). They will 
> > later be consumed and then the queues will contain the right objects so 
> > the effect of the patch is minimal.
> > 
> 
> By minimal, do you mean that you expect it to break in some other
> respect later or minimal as in "this is bad but should not have no
> adverse impact".

Should not have any adverse impact after the objects from the cpu queue 
have been consumed. If the cache_reaper tries to shift objects back 
from the per cpu queue into slabs then BUG_ONs may be triggered. Make sure 
you run the tests with full debugging please.

> Whatever this was a problem fixed in the past or not, it's broken again now
> :( . It's possible that there is a __GFP_THISNODE that can be dropped early
> at boot-time that would also fix this problem in a way that doesn't
> affect runtime (like altering cache_grow in my patch does).

The dropping of GFP_THISNODE has the same effect as your patch. 
Objects from another node get into the per cpu queue. And on free we 
assume that per cpu queue objects are from the local node. If debug is on 
then we check that with BUG_ONs.

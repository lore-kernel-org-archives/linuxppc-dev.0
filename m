Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 0232FDE038
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 05:42:01 +1100 (EST)
Date: Wed, 23 Jan 2008 10:41:59 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] Fix boot problem in situations where the boot CPU is
	running on a memoryless node
In-Reply-To: <20080123135513.GA14175@csn.ul.ie>
Message-ID: <Pine.LNX.4.64.0801231040160.11430@schroedinger.engr.sgi.com>
References: <20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<20080122214505.GA15674@aepfle.de>
	<Pine.LNX.4.64.0801221417480.1912@schroedinger.engr.sgi.com>
	<20080123075821.GA17713@aepfle.de> <20080123105044.GD21455@csn.ul.ie>
	<20080123121459.GA18631@aepfle.de> <20080123125236.GA18876@aepfle.de>
	<20080123135513.GA14175@csn.ul.ie>
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

On Wed, 23 Jan 2008, Mel Gorman wrote:

> This patch adds the necessary checks to make sure a kmem_list3 exists for
> the preferred node used when growing the cache. If the preferred node has
> no nodelist then the currently running node is used instead. This
> problem only affects the SLAB allocator, SLUB appears to work fine.

That is a dangerous thing to do. SLAB per cpu queues will contain foreign 
objects which may cause troubles when pushing the objects back. I think we 
may be lucky that these objects are consumed at boot. If all of the 
foreign objects are consumed at boot then we are fine. At least an 
explanation as to this issue should be added to the patch.

Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 251ECDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:14:18 +1100 (EST)
Date: Tue, 22 Jan 2008 15:14:16 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <20080122231058.GB866@csn.ul.ie>
Message-ID: <Pine.LNX.4.64.0801221513100.2565@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
	<20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221203340.27950@schroedinger.engr.sgi.com>
	<20080122212654.GB15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221330390.1652@schroedinger.engr.sgi.com>
	<20080122225046.GA866@csn.ul.ie>
	<Pine.LNX.4.64.0801221453480.2271@schroedinger.engr.sgi.com>
	<20080122231058.GB866@csn.ul.ie>
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

> Rather it should be 2. I'll admit the physical setup of this machine is
> .... less than ideal but clearly it's something that can happen even if
> it's a bad idea.

Ok. Lets hope that Pekka's find does the trick. But this would mean that 
fallback gets memory from node 2 for the page allocator. Then fallback 
alloc is going to try to insert it into the l3 of node 2 which is not 
there yet. So another ooops. Sigh.

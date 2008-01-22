Return-Path: <clameter@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 0FA2CDDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:18:53 +1100 (EST)
Date: Tue, 22 Jan 2008 15:18:52 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <Pine.LNX.4.64.0801221501240.2565@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0801221517260.2871@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080117211511.GA25320@aepfle.de>
	<Pine.LNX.4.64.0801181043290.30348@schroedinger.engr.sgi.com>
	<20080118213011.GC10491@csn.ul.ie>
	<Pine.LNX.4.64.0801181414200.8924@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221203340.27950@schroedinger.engr.sgi.com>
	<20080122212654.GB15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221330390.1652@schroedinger.engr.sgi.com>
	<20080122225046.GA866@csn.ul.ie> <47967560.8080101@cs.helsinki.fi>
	<Pine.LNX.4.64.0801221501240.2565@schroedinger.engr.sgi.com>
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

On Tue, 22 Jan 2008, Christoph Lameter wrote:

> But I doubt that this is it. The fallback logic was added later and it 
> worked fine.

My patch is useless (fascinating history of the changelog there through). 
fallback_alloc calls kmem_getpages without GFP_THISNODE. This means that 
alloc_pages_node() will try to allocate on the current node but fallback 
to neighboring node if nothing is there....

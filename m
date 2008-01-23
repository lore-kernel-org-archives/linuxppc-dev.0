Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FAB3DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 01:42:29 +1100 (EST)
Date: Wed, 23 Jan 2008 14:42:23 +0000
From: Mel Gorman <mel@csn.ul.ie>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] Fix boot problem in situations where the boot CPU is
	running on a memoryless node
Message-ID: <20080123144222.GA20156@csn.ul.ie>
References: <20080118225713.GA31128@aepfle.de>
	<20080122195448.GA15567@csn.ul.ie>
	<20080122214505.GA15674@aepfle.de>
	<Pine.LNX.4.64.0801221417480.1912@schroedinger.engr.sgi.com>
	<20080123075821.GA17713@aepfle.de>
	<20080123105044.GD21455@csn.ul.ie>
	<20080123121459.GA18631@aepfle.de>
	<20080123125236.GA18876@aepfle.de>
	<20080123135513.GA14175@csn.ul.ie>
	<20080123142759.GB19161@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080123142759.GB19161@aepfle.de>
Cc: lee.schermerhorn@hp.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
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

On (23/01/08 15:27), Olaf Hering didst pronounce:
> On Wed, Jan 23, Mel Gorman wrote:
> 
> > This patch in combination with a partial revert of commit
> > 04231b3002ac53f8a64a7bd142fde3fa4b6808c6 fixes a regression between 2.6.23
> > and 2.6.24-rc8 where a PPC64 machine with all CPUS on a memoryless node fails
> > to boot. If approved by the SLAB maintainers, it should be merged for 2.6.24.
> 
> This change alone does not help, its not the version I tested.
> Will all the changes below go into 2.6.24 as well, in a seperate patch?
> 
> -       for_each_node_state(node, N_NORMAL_MEMORY) {
> +       for_each_online_node(node) {

Those changes are already in a separate patch and have been sent. I don't
see it in git yet but it should be on the way.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab

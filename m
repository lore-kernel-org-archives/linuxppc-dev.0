Return-Path: <bob.picco@hp.com>
Received: from ccerelrim01.cce.hp.com (ccerelrim01.cce.hp.com [161.114.21.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ccerelrim01.cce.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 2AF0967C02
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 03:45:12 +1000 (EST)
From: "Bob Picco" <bob.picco@hp.com>
Date: Wed, 12 Apr 2006 13:18:42 -0400
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
	independent manner
Message-ID: <20060412171842.GG23742@localhost>
References: <20060411103946.18153.83059.sendpatchset@skynet>
	<20060411222029.GA7743@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
	<20060412000500.GA8532@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
	<20060412154633.GA10589@agluck-lia64.sc.intel.com>
	<Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
	<20060412170726.GA11143@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412170726.GA11143@agluck-lia64.sc.intel.com>
Cc: davej@codemonkey.org.uk, ak@suse.de, bob.picco@hp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Mel Gorman <mel@skynet.ie>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

luck wrote:	[Wed Apr 12 2006, 01:07:26PM EDT]
> On Wed, Apr 12, 2006 at 05:00:32PM +0100, Mel Gorman wrote:
> > Patch is attached as 105-ia64_use_init_nodes.patch until I beat sense into 
> > my mail setup. I've added Bob Picco to the cc list as he will hit the same 
> > issue with whitespace corruption.
> 
> Next I tried building a "generic" kernel (using arch/ia64/defconfig). This
> has NUMA=y and DISCONTIG=y).  This crashes with the following console log.
> 
> 
> -Tony
[snip]
Yes. I see the same. It's because with granules we have intersecting
regions which add_active_range doesn't handle. At least that's what
appears to be the reason. I modified add_active_range to combine an
added intersecting region and it boots. However, present pages in zones is
enormous which probably means hole calculation is wrong. That's what I'm
pursuing now.

bob

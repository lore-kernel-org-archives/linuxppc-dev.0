Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 292E7DDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 06:36:01 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAQJZwrj012025
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 14:35:58 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAQJZua2059042
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 12:35:58 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAQJZuHi030459
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 12:35:56 -0700
Subject: Re: pseries (power3) boot hang  (pageblock_nr_pages==0)
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20071121220337.GB31674@csn.ul.ie>
References: <1195682111.4421.23.camel@farscape.rchland.ibm.com>
	<20071121220337.GB31674@csn.ul.ie>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 13:35:57 -0600
Message-Id: <1196105757.11297.11.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Memory Management List <linux-mm@kvack.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-21 at 22:03 +0000, Mel Gorman wrote:
> On (21/11/07 15:55), Will Schmidt didst pronounce:
> > Hi Folks, 
> > 
> > I imagine this would be properly fixed with something similar to the
> > change for iSeries.  
> 
> Have you tried with the patch that fixed the iSeries boot problem?
> Thanks for tracking down the problem to such a specific place.

I had not, but gave this patch a spin this morning, and it does the
job.  :-)    I was thinking (without really looking at it), that the
iseries fix was in platform specific code.   Silly me. :-)

So for the record, this patch also fixes power3 pSeries systems.

fwiw:
Tested-By:  Will Schmidt <will_schmidt@vnet.ibm.com>

Thanks, 

-Will


> ======
> 
> Ordinarily, the size of a pageblock is determined at compile-time based on
> the hugepage size. On PPC64, the hugepage size is determined at runtime based
> on what is supported by the machine. On legacy machines such as iSeries which
> do not support hugepages, HPAGE_SHIFT is 0. This results in pageblock_order
> being set to -PAGE_SHIFT and a crash results shortly afterwards.
> 
> This patch checks that HPAGE_SHIFT is a sensible value before using the
> hugepage size. If it is 0, MAX_ORDER-1 is used instead as this is a sensible
> value of pageblock_order.
> 
> This is a fix for 2.6.24.
> 
> Credit goes to Stephen Rothwell for identifying the bug and testing on
> iSeries.  Additional credit goes to David Gibson for testing with the
> libhugetlbfs test suite.
> 
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> 
> ---

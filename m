Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCAFFDE1DA
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 03:57:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3LHuSVK020661
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 10:56:28 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3LHuR1L019534
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 12:56:27 -0500 (CDT)
Date: Mon, 21 Apr 2008 12:56:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
Message-ID: <20080421175627.GD4134@ld0162-tx32.am.freescale.net>
References: <200804161640.42693.laurentp@cse-semaphore.com>
	<20080416160540.GB442@polina.dev.rtsoft.ru>
	<200804161809.40805.laurentp@cse-semaphore.com>
	<200804181334.34229.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804181334.34229.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 01:34:29PM +0200, Laurent Pinchart wrote:
> Scott Wood was concerned in 
> http://patchwork.ozlabs.org/linuxppc/patch?id=17490 that the gpio lib might 
> be an unnecessary burden for memory-constraint platforms. Should we keep two 
> mdio bitbang drivers, one with direct access to the ports and one using gpio 
> lib ? The later solves the concurrent access issues present in the current 
> fs_enet mdio bitbang driber.

The memory-constrained platform I had in mind was 8xx, which doesn't use
bitbanged MDIO.  It might nice to keep the gpiolib bit separate to avoid
situations such as ep8248e where mdiobb would be the only thing requiring
a gpiolib binding, though -- but it shouldn't be two separate bitbang
drivers, just the existing bitbang driver plus some glue code that binds
it to gpiolib.

-Scott

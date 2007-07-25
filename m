Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D1EDDDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 06:32:36 +1000 (EST)
Date: Wed, 25 Jul 2007 21:39:25 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Message-ID: <20070725213925.2f25906c@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.60.0707252130090.6234@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<Pine.LNX.4.60.0707252130090.6234@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> driver to using platform-device. I got a reply, that it's not worth it now 
> that IDE is slowly becoming obsolete, and the pata_platform serves the 
> perpose perfectly well. I found this argument reasonable, I had the same 
> doubt, just wanted to double-check. So, why do we now need a new legacy 
> (a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
> exists?


We don't *need* it but some people still want to use old IDE and the
author was willing to make it neatly compatible so that anything that
works with the pata_platform should be able to use the ide_platform
driver and vice versa. For the shorter term that can only be a good thing
- arch code doesn't need to care about which driver is used, end users
can pick and it doesn't end up adding new ties between code and old IDE.

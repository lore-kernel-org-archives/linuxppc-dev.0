Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B93DDE0BA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:12:39 +1000 (EST)
Date: Thu, 11 Oct 2007 15:12:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
Message-ID: <20071011201232.GD4247@loki.buserror.net>
References: <200710111408.34207.sr@denx.de>
	<1192107771.5534.120.camel@localhost.localdomain>
	<200710111531.13022.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710111531.13022.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 03:31:12PM +0200, Stefan Roese wrote:
> Yes, good catch. Since I'm not using the bootwrapper, I should be able to get 
> rid of WANT_DEVICE_TREE too. But it seems to be autoselected in 
> arch/powerpc/platforms/Kconfig.cputype for 40x and most other "embedded" 
> CPU's. Any idea why this is the case?

Probably copying from 83xx, 85xx, etc, which set it on the entire CPU family
because there's a wrapper platform that covers the entire family.  AFAICT,
there are only board wrappers for 4xx, so individual boards should be
selecting WANT_DEVICE_TREE.

In any case, you can just set DEVICE_TREE to an empty string if you only
want the regular uImage.

-Scott

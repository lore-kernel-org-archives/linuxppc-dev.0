Return-Path: <drzeus-mmc@drzeus.cx>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC74DDDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 21:46:09 +1000 (EST)
Date: Sat, 17 May 2008 13:36:33 +0200
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card
	detect line
Message-ID: <20080517133633.5aa26938@mjolnir.drzeus.cx>
In-Reply-To: <20080516165057.GC24196@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 May 2008 20:50:57 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Some boards do not use interrupts on the CD line, so we want to poll
> the CD and see if there was a change. 1 second poll interval seems
> resonable.
> 

The idea isn't bad, but I'm not sure about the mechanism.

To poll a MMC slot, you do not really need a card detect at all. The
MMC layer can just shoot off some requests and see if anything
responds.  The PXA driver (if my memory serves me right) already does
this. So the best idea there would be to add this feature to the MMC
core and let the host indicate that it needs it via MMC_CAP_NEEDS_POLL
or something like that.

The card detection pin then becomes an optimisation, something that is
also useful in other ways. Have the host driver check the card detection
pin at the start of every request, and quickly fail it if there is no
card present.

That should give you what you want with much more flexibility for other
uses as well.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

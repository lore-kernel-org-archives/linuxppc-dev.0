Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6485DDE29
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:46:43 +1100 (EST)
Date: Wed, 2 Jan 2008 11:45:58 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] Add support for freescale watchdog to CPM serial
	driver.
Message-ID: <20080102174558.GA4398@loki.buserror.net>
References: <477513CC.3060109@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477513CC.3060109@scram.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 28, 2007 at 04:18:36PM +0100, Jochen Friedrich wrote:
> If a freescale watchdog device node is present, reset the watchdog
> while waiting for serial input.

Hmm...  I don't like combining the watchdog and serial code together.  What
if some other serial device is used with this watchdog?  The serial driver
should only have to call an externally provided poke_watchdog() function.

-Scott

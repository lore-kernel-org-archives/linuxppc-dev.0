Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38C34DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:53:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAKJrn0J022966
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 12:53:50 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id mAKJrmmY000443
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 13:53:48 -0600 (CST)
Date: Thu, 20 Nov 2008 13:53:48 -0600
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Message-ID: <20081120195347.GA29459@ld0162-tx32.am.freescale.net>
References: <200811201332.24061.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200811201332.24061.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 01:32:23PM +0100, Laurent Pinchart wrote:
> Instead of rounding the divider down, improve the baud-rate generators
> accuracy by rounding to the nearest integer.
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>

This makes things worse on mpc8272ads -- the result of the division is
13.56, but I only get error-free serial output when rounding down.  I
don't think the remote end has timing problems, as I don't see this with
any other board.

Possibly the crystal is a little off, or maybe it's just better to be a
little too fast than a little too slow for some reason?

Maybe we should change CPM_CLK to be MAIN_CLK/4 rather than MAIN_CLK/16
when the BRG clock is below a certain frequency.

-Scott

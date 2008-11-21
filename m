Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 8EF15DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 03:04:51 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Fri, 21 Nov 2008 17:04:56 +0100
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<20081120195347.GA29459@ld0162-tx32.am.freescale.net>
In-Reply-To: <20081120195347.GA29459@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811211704.56808.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Thursday 20 November 2008, Scott Wood wrote:
> On Thu, Nov 20, 2008 at 01:32:23PM +0100, Laurent Pinchart wrote:
> > Instead of rounding the divider down, improve the baud-rate generators
> > accuracy by rounding to the nearest integer.
> >
> > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
>
> This makes things worse on mpc8272ads -- the result of the division is
> 13.56, but I only get error-free serial output when rounding down.  I
> don't think the remote end has timing problems, as I don't see this with
> any other board.

I get exactly the opposite here with an mpc8248 base board. Rounding down 
makes 115200bds completely unreliable :-/

Could you measure the serial baudrate with and without the patch using an 
oscilloscope ?

> Possibly the crystal is a little off,

That's always possible.

> or maybe it's just better to be a little too fast than a little too slow for
> some reason? 
>
> Maybe we should change CPM_CLK to be MAIN_CLK/4 rather than MAIN_CLK/16
> when the BRG clock is below a certain frequency.

Isn't that the job of the boot loader ? Accuracy would be improved, but power 
consumption will raise as well :-/

Best regards,

Laurent Pinchart

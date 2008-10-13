Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A50FDE07C
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 00:11:58 +1100 (EST)
Message-ID: <48F34922.503@billgatliff.com>
Date: Mon, 13 Oct 2008 08:12:02 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Floating inputs on unused GPIO pins
References: <200810131156.59477.laurentp@cse-semaphore.com>	<c384c5ea0810130308q5cfa2c2ld8ea5eafec99bba3@mail.gmail.com>
	<200810131304.41435.laurentp@cse-semaphore.com>
In-Reply-To: <200810131304.41435.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:

> 
> There are no internal pull-up or pull-down resistors on the MPC8248 GPIO pins. I know our hardware engineer has a valid point theoretically. Does the point stand practically, or does the MPC8248 "state-of-the-art"(tm)(c)(whatever) technology make floating inputs safe ?

Well, Freescale's own layout recommendations recommend pullups or pulldowns for
all input pins, but it's isn't clear what motivates that suggestion.

The block diagram, Figure 37-21, is less than helpful.  :)  I recall a doc
somewhere that showed the input protection circuitry ends up providing a modest
pullup/down, so the line never truly "floats".  But it's a very high-impedance
path, and I can't seem to find the doc anyway so it could be for a completely
different chip altogether.

The part isn't going to blow up if you leave inputs unconnected, at least if you
avoid high-EMI/RFI environments.  But I can imagine the possibility of increased
power consumption if I try hard enough.  I would think that the magnitude would
be completely swamped by the consumption of the rest of the chip, however...

The technical answer might not be the best political one, at least not without
Freescale-branded docs to back you up.  I say, write the code and make everyone
else happy.  :)

At least until someone plugs in that expansion module!


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com

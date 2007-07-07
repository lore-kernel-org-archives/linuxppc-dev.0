Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5C4CDDDFCA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 22:12:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
Date: Sat, 7 Jul 2007 14:10:14 +0200
References: <1183784308.3066.16.camel@shinybook.infradead.org>
In-Reply-To: <1183784308.3066.16.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200707071410.14998.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, David Woodhouse wrote:
> 
> The MV64660 has reg-shift==2 for its otherwise 16550-compatible uarts.
> While the bootwrapper copes with this, of_serial.c doesn't. (The udbg
> code doesn't either, but I'll fix that later).
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Given the existence of the boards, it looks correct to do this.
However, I wonder if it was correct for the MV64660 to claim
compatibily witn ns16550 if the programming model is not exactly
the same. The official OF serial port bindings don't mention the
reg-shift property, so it maybe would have been better to have
a different value for the "compatible" property, in order not
to confuse existing operating systems that implement the standard.

Also, what about etherboot and yaboot? Do they handle this
correctly?

	Arnd <><

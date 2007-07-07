Return-Path: <SRS0+bd14105a136047a0bf47+1413+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30243DE15B
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 00:59:15 +1000 (EST)
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>, wmb@firmworks.com
In-Reply-To: <200707071410.14998.arnd@arndb.de>
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<200707071410.14998.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 07 Jul 2007 10:59:39 -0400
Message-Id: <1183820379.3066.40.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-07-07 at 14:10 +0200, Arnd Bergmann wrote:
> On Saturday 07 July 2007, David Woodhouse wrote:
> > 
> > The MV64660 has reg-shift==2 for its otherwise 16550-compatible uarts.
> > While the bootwrapper copes with this, of_serial.c doesn't. (The udbg
> > code doesn't either, but I'll fix that later).
> > 
> > Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Given the existence of the boards, it looks correct to do this.
> However, I wonder if it was correct for the MV64660 to claim
> compatibily witn ns16550 if the programming model is not exactly
> the same. The official OF serial port bindings don't mention the
> reg-shift property, so it maybe would have been better to have
> a different value for the "compatible" property, in order not
> to confuse existing operating systems that implement the standard.

Well, so far this only exists in the hacked-up device tree for my
bootwrapper; not in any real firmware. If a reg-shift property is the
wrong way to do it, we can change it. I got the reg-shift thing from
Mark's code in arch/powerpc/boot/ns16550.c, which handles it that way
for the bootwrapper (although I don't see any device-tree blobs which
use it, apart from mine).

-- 
dwmw2

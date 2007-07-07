Return-Path: <SRS0+bd14105a136047a0bf47+1413+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 848F1DE172
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 02:50:41 +1000 (EST)
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707071410.14998.arnd@arndb.de>
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<200707071410.14998.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 07 Jul 2007 12:51:23 -0400
Message-Id: <1183827083.3066.64.camel@shinybook.infradead.org>
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
> Given the existence of the boards, it looks correct to do this.
> However, I wonder if it was correct for the MV64660 to claim
> compatibily witn ns16550 if the programming model is not exactly
> the same. The official OF serial port bindings don't mention the
> reg-shift property, so it maybe would have been better to have
> a different value for the "compatible" property, in order not
> to confuse existing operating systems that implement the standard. 

Ok, how about 'sparse16550'? Otherwise identical to ns16550, but with
the reg-shift property. I'll send a patch shortly, and I'll reorder the
match table -- if something claims compatibility with both 8250 and
16550, shouldn't we drive it as the latter?

Can we add properties to indicate the common high-speed modes too? The
Natsemi baud-base thing could be autodetected by 8250.c if you'd let it,
but the SMSC trick just has to be set as a UPF_MAGIC_MULTIPLIER flag.

-- 
dwmw2

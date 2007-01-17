Return-Path: <mikpe@it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 27632DDEF6
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 07:45:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17838.34747.222649.93821@alkaid.it.uu.se>
Date: Wed, 17 Jan 2007 21:31:55 +0100
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
In-Reply-To: <45AE539E.2040600@garzik.org>
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
	<45AE539E.2040600@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > If there is a highly common case, the code for that case
 > > is available, and the code is cheap to execute (doesn't
 > > require too many additional variables), then having an
 > > explicit test + inline code is preferred. If any of these
 > > conditions isn't met, then I wouldn't bother converting
 > > the call to the if/inline/call combo.
 > 
 > 
 > To be a bit more specific, the branch being taken, or not, depends on 
 > the system setup.  For example, in sata_promise's case, with no other 
 > SATA controllers in use,
 > 
 > 	if (ap->ops->irq_on)
 > 		ap->ops->irq_on(ap);
 > 	else
 > 		ata_irq_on(ap);
 > 
 > the direct function call will ALWAYS be called.  But if you had a weird 
 > system with both Cell and Promise PDC203xx, then the branch is dependent 
 > on whether the activity comes from the Cell SATA or Promise SATA.
 > 
 > So it's highly predictable in a great many cases.
 > 
 > And it should be noted that it is a direct function call not inline, 
 > thus its if/indirect/direct not if/indirect/inline.
 > 
 > Does that change the answer at all?

The real benefits from identifying a common case is to inline
the code for it. So the fact that the common case is still a
full-blown function call here and not inline code means that
there's much less benefit from rewriting an indirect call as
an if/indirect/direct sequence.

There is some branch prediction benefit from having
if/call-indirect/call-direct-to-common-case instead of a
single call-indirect, but only if the common case really is
much more common than other cases, or if the other cases
are limited to just one (so there's two common cases).

I wouldn't change a call-indirect to if/call-indirect/call-direct
unless it's on a very hot path with a known dominant common case.

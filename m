Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6297DDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 03:49:56 +1100 (EST)
Message-ID: <45AE539E.2040600@garzik.org>
Date: Wed, 17 Jan 2007 11:49:34 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
In-Reply-To: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mikael Pettersson wrote:
> If there is a highly common case, the code for that case
> is available, and the code is cheap to execute (doesn't
> require too many additional variables), then having an
> explicit test + inline code is preferred. If any of these
> conditions isn't met, then I wouldn't bother converting
> the call to the if/inline/call combo.


To be a bit more specific, the branch being taken, or not, depends on 
the system setup.  For example, in sata_promise's case, with no other 
SATA controllers in use,

	if (ap->ops->irq_on)
		ap->ops->irq_on(ap);
	else
		ata_irq_on(ap);

the direct function call will ALWAYS be called.  But if you had a weird 
system with both Cell and Promise PDC203xx, then the branch is dependent 
on whether the activity comes from the Cell SATA or Promise SATA.

So it's highly predictable in a great many cases.

And it should be noted that it is a direct function call not inline, 
thus its if/indirect/direct not if/indirect/inline.

Does that change the answer at all?

	Jeff

Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53DFBDE009
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 09:04:43 +1100 (EST)
Message-ID: <45AD4BEB.4070507@garzik.org>
Date: Tue, 16 Jan 2007 17:04:27 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>,  benh@kernel.crashing.org
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
References: <200701161046.l0GAk5Go019691@toshiba.co.jp>
	<20070116120335.59b4491d@localhost.localdomain>
In-Reply-To: <20070116120335.59b4491d@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan wrote:
> Jeff - at some point we could eliminate a lot of the NULL checks like
> these by having the registration code fill in the defaults where
> appropriate ?

libata policy up until this point has been to require all drivers fill 
in the hook, either with the commonly-used default, or with their own 
variant.  Thus, no NULL checks for required hooks, and you get an oops 
if you fail this requirement.  I like that better than defaults buried 
inside libata-core, where it is easier for programmers to forget them.

But actually, it's an open question for the compiler guys whether this 
case is preferred:

	if (ap->ops->hook)
		ap->ops->hook(foo, bar);
	else
		commonly_used_default(foo, bar);

or this:

	ap->ops->hook(foo, bar);

With advanced branch prediction in modern CPUs, ISTR the first case may 
be worth considering, even with the branch.

If the second case is preferred, then Akira should make a bombing run 
through each driver, applying the patch
+	.irq_on		= ata_irq_on

No NULL checks or registration code bother, in that case.

Comments welcome...

	Jeff

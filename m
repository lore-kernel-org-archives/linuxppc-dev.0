Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB1E3DE009
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 09:05:51 +1100 (EST)
Message-ID: <45AD4C39.3050202@garzik.org>
Date: Tue, 16 Jan 2007 17:05:45 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/4] libata-sff.c: add another IRQ calls
References: <200701161046.l0GAkE5u029367@toshiba.co.jp>
	<20070116120450.1bb44ebb@localhost.localdomain>
In-Reply-To: <20070116120450.1bb44ebb@localhost.localdomain>
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
> On Tue, 16 Jan 2007 19:46:23 +0900
> Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:
> 
>> When enabling IRQ, ap->ops->irq_on is checked.
>> Because most drivers can use ata_irq_on() as is, this
>> patch allows ap->ops->irq_on to be NULL.
>> If it is NULL, ata_irq_on() are used.
> 
> 
> I believe you can now remove the if(ap->ioaddr.ctl_addr) check as any
> device lacking a ctl_addr can now provide an irq_on() method using your
> changes.
> 
> You've fixed the FIXME 

Agreed.

Abstracting out the Control/Alt-Status register block operations has 
been a long-standing TODO that I knew would be required, sometime down 
the line.  I certainly support adding such abstractions, as they are 
required for several non-x86 IDE drivers, not just Cell.

	Jeff

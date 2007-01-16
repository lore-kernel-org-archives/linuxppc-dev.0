Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD0F7DDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 22:57:54 +1100 (EST)
Date: Tue, 16 Jan 2007 12:04:50 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 3/4] libata-sff.c: add another IRQ calls
Message-ID: <20070116120450.1bb44ebb@localhost.localdomain>
In-Reply-To: <200701161046.l0GAkE5u029367@toshiba.co.jp>
References: <200701161046.l0GAkE5u029367@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Jan 2007 19:46:23 +0900
Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:

> When enabling IRQ, ap->ops->irq_on is checked.
> Because most drivers can use ata_irq_on() as is, this
> patch allows ap->ops->irq_on to be NULL.
> If it is NULL, ata_irq_on() are used.


I believe you can now remove the if(ap->ioaddr.ctl_addr) check as any
device lacking a ctl_addr can now provide an irq_on() method using your
changes.

You've fixed the FIXME 

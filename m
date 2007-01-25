Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5DA2DE093
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 12:18:01 +1100 (EST)
Message-ID: <45B8053D.3000007@garzik.org>
Date: Wed, 24 Jan 2007 20:17:49 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
	<45AE539E.2040600@garzik.org>
	<17838.34747.222649.93821@alkaid.it.uu.se>
	<200701180055.l0I0tl6M021051@toshiba.co.jp>
In-Reply-To: <200701180055.l0I0tl6M021051@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Akira Iguchi wrote:
>> The real benefits from identifying a common case is to inline
>> the code for it. So the fact that the common case is still a
>> full-blown function call here and not inline code means that
>> there's much less benefit from rewriting an indirect call as
>> an if/indirect/direct sequence.
> 
> According to your comment, this patch adds IRQ calls (irq_on, irq_ack)
> to each driver and always uses these indirect calls.
> 
> For irq_on, most drivers use ata_irq_on(). Some drivers
> (ahci.c, sata_sil24.c) use ata_dummy_irq_on() because they
> don't have either explicit or implicit assignment (ex: ata_pci_init_one)
> of ctl_addr.
> 
> For irq_ack, ata_irq_ack() is used.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

very close to perfect :)

ahci and sata_sil24 need dummy functions for ->irq_ack().  As you can 
see, ata_irq_ack() is only used in debug situations, and it [the current 
code] is very wrong for ahci and sata_sil24.

Also, please split up the patch into two pieces:  (1) update core and 
headers, and (2) update every driver.


> diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/include/linux/libata.h linux-2.6.20-rc4.mod/include/linux/libata.h
> --- linux-2.6.20-rc4/include/linux/libata.h	2007-01-17 23:23:27.000000000 +0900
> +++ linux-2.6.20-rc4.mod/include/linux/libata.h	2007-01-17 23:24:49.000000000 +0900
> @@ -638,6 +638,8 @@ struct ata_port_operations {
>  
>  	irq_handler_t irq_handler;
>  	void (*irq_clear) (struct ata_port *);
> +	u8 (*irq_on) (struct ata_port *);
> +	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
>  
>  	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
>  	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
> @@ -761,6 +763,7 @@ extern void ata_port_queue_task(struct a
>  extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
>  			     unsigned long interval_msec,
>  			     unsigned long timeout_msec);
> +u8 ata_irq_on(struct ata_port *ap);
>  
>  /*
>   * Default driver ops implementations
> @@ -1202,6 +1205,8 @@ static inline u8 ata_irq_ack(struct ata_
>  	return status;
>  }
>  
> +static inline u8 ata_dummy_irq_on (struct ata_port *ap)	{ return 0; }
> +

This won't work, you need to create a non-inline function and 
EXPORT_SYMBOL_GPL it.

	Jeff

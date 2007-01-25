Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD036DDFE5
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 12:11:01 +1100 (EST)
Message-ID: <45B80395.50302@garzik.org>
Date: Wed, 24 Jan 2007 20:10:45 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 1/4] libata.h: add another IRQ calls
References: <200701161045.l0GAjwJ0029209@toshiba.co.jp>
In-Reply-To: <200701161045.l0GAjwJ0029209@toshiba.co.jp>
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

Akira Iguchi wrote:
> Two IRQ calls are added in ata_port_operations.
> - irq_on() is used to enable interrupts. 
> - irq_ack() is used to acknowledge a device interrupt.
> 
> And there are additional function declarations which are
> used in pata_scc.c.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

After this round of comments, please resend the entire patchset, so that 
I have everything straight.


> @@ -761,6 +763,9 @@ extern void ata_port_queue_task(struct a
>  extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
>  			     unsigned long interval_msec,
>  			     unsigned long timeout_msec);
> +unsigned int ata_dev_try_classify(struct ata_port *, unsigned int, u8 *);
> +struct ata_probe_ent *ata_probe_ent_alloc(struct device *,
> +					  const struct ata_port_info *);
>  


To properly export these functions, (a) remove their declarations from 
drivers/ata/libata.h and (b) add EXPORT_SYMBOL_GPL() declarations.

	Jeff

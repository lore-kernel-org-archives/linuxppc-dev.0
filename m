Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9FB7DDF2D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:45:59 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0C0jtY7015575
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 09:45:55 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l0C0jshj020937
	for linuxppc-dev@ozlabs.org; Fri, 12 Jan 2007 09:45:54 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0C0jrqZ002175
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 09:45:53 +0900 (JST)
Message-Id: <200701120045.l0C0jqHV012168@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 12 Jan 2007 09:48:19 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linas@austin.ibm.com, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: (Your message of "Thu, 11 Jan 2007 11:17:06 -0600")
	<20070111171706.GG6177@austin.ibm.com>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	<200701111008.34866.arnd@arndb.de>
	<200701110928.l0B9SUri015056@toshiba.co.jp>
	<20070111171706.GG6177@austin.ibm.com>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Linas-san, Arnd-san.

>Why is it that other drivers did not need this functions? Did they
>copy them?  Or maybe they don't need them?

As I mentioned in PATCH 1/2, main reason is that this PATA controller
supports only 32bit accesses and that I need to copy all functions
which have low-level access in ata_scc.c.
In these functions, static functions I exported are used.
I thought exporting them was better than copying them.

But other drivers can use functions which have low-level access as it is.
Therefore they don't need to export static functions.

Now, I am trying to implement low-level calls in struct ata_port_operations
to deal with this problem. Please wait a moment.


>-static unsigned int
>+unsigned int
> ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)

I use this in scc_std_softreset(), which is almost same as
ata_std_softreset(). But I cannot use it because ata_devchk() and
ata_bus_softreset() called by it use low-level access.


>-static void ata_pio_sectors(struct ata_queued_cmd *qc)
>+void ata_pio_sectors(struct ata_queued_cmd *qc)
..
>-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>+void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
..
>-static void atapi_pio_bytes(struct ata_queued_cmd *qc)
>+void atapi_pio_bytes(struct ata_queued_cmd *qc)

I use them in scc_hsm_move(), which is almost same as ata_hsm_move().
ata_hsm_move() calls ata_hsm_qc_complete() and it calls ata_irq_on().
There is a low-level access in ata_irq_on(), so I cannot use it.


Best regards,
Akira Iguchi

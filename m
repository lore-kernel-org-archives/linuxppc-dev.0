Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id EB37D67A03
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 23:49:33 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 16/16] Supporting spidernet on Celleb
Date: Thu, 16 Nov 2006 11:15:48 +0100
References: <200611151002.kAFA29Tf017783@toshiba.co.jp>
In-Reply-To: <200611151002.kAFA29Tf017783@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611161115.49183.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 15 November 2006 11:02, Ishizaki Kou wrote:
> This patch adds auto-negotiation.
> Downloading firmware operation moves into spider_net_open().
> This patch is not tested on Cell-Blade.

This patch needs to be submitted to netdev@vger.kernel.org instead
of linuxppc-dev. Please also Cc: the maintainer of the driver,
James K Lewis <jklewis@us.ibm.com>, he at least needs to test
the changes.

The patch looks good overall, I have only a small cosmetic comments:

> @@ -1837,7 +1994,7 @@
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> =A0try_host_fw:
> -=A0=A0=A0=A0=A0=A0=A0dn =3D pci_device_to_OF_node(card->pdev);
> +=A0=A0=A0=A0=A0=A0=A0dn =3D (struct device_node *)card->pdev->sysdata;
> =A0=A0=A0=A0=A0=A0=A0=A0if (!dn)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out_err;
> =A0

> @@ -2071,7 +2234,7 @@
> =20
>         netdev->irq =3D card->pdev->irq;
> =20
> -       dn =3D pci_device_to_OF_node(card->pdev);
> +       dn =3D (struct device_node *)card->pdev->sysdata;
>         if (!dn)
>                 return -EIO;
> =20

This should not be required. If you PCI bus is set up
correctly, pci_device_to_OF_node() will do the right thing.
What problem are you trying to solve here?

> +static void
> +spider_net_link_phy(struct spider_net_card *card)

> @@ -2058,6 +2215,12 @@
> =A0=A0=A0=A0=A0=A0=A0=A0card->tx_timer.data =3D (unsigned long) card;
> =A0=A0=A0=A0=A0=A0=A0=A0netdev->irq =3D card->pdev->irq;
> =A0
> +=A0=A0=A0=A0=A0=A0=A0card->aneg_count =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0init_timer(&card->aneg_timer);
> +=A0=A0=A0=A0=A0=A0=A0card->aneg_timer.function =3D
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(void (*)(unsigned long)) s=
pider_net_link_phy;
> +=A0=A0=A0=A0=A0=A0=A0card->aneg_timer.data =3D (unsigned long) card;
> +
> =A0=A0=A0=A0=A0=A0=A0=A0card->options.rx_csum =3D SPIDER_NET_RX_CSUM_DEFA=
ULT;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0card->num_tx_desc =3D tx_descriptors;

You should not need a cast here. It's better to cast the data value
in the function itself than casting the function pointer. This makes
sure we notice when the prototype of the function pointer changes.

	Arnd <><

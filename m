Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0097267C7E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 23:14:20 +1100 (EST)
Date: Tue, 21 Nov 2006 11:49:53 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH] drivers/ide: PATA driver for Celleb
Message-ID: <20061121114953.1443e7a1@localhost.localdomain>
In-Reply-To: <200611210959.kAL9x8eH026223@toshiba.co.jp>
References: <200611210959.kAL9x8eH026223@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We use a drivers/ide driver because its design is more suitable for
> SCC IDE controller than libata driver. Since SCC supports only 32bit

Understand that drivers/ide will be going away at some point long term
but not for a while.

> read/write, we must override many callbacks of ata_port_operations
> by modifying generic helpers. Each time the libata common code is
> updated, we must update those modified helpers. It is very hard for us.
> But we will try to implement the libata driver as needed.

It would be good to do so - the future is libata. It may also help because
it may indicate places were libata not your code should change in order to
get a nicer interface.


> +/* PIO transfer mode  table */
> +/* JCHST */
> +static unsigned long JCHSTtbl[2][7] = {

const...

> +	switch (speed) {
> +	case XFER_UDMA_6:
> +		idx = 6;
> +		break;

These values are carefully arranged so you can do

	if (speed >= XFER_UDMA_0)
		idx = speed - XFER_UDMA_0;
	else
		return 1;


Otherwise looks ready to merge.

Alan

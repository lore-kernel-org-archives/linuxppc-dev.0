Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA451DDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 07:02:11 +1000 (EST)
Date: Mon, 11 Jun 2007 16:02:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH 1/6] 82xx: Add the support of Wind River SBC PowerQUICCII
	82xx
Message-ID: <20070611210201.GA17280@ld0162-tx32.am.freescale.net>
References: <1181292534.11341.9.camel@mark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1181292534.11341.9.camel@mark>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 08, 2007 at 04:48:53PM +0800, Mark Zhan wrote:
> +	new_bus->phy_mask = 0xFFFFFFFF;
> +	for (i = 0; i < PHY_MAX_ADDR; i++)
> +		if (pdata->irq[i] != -1)
> +			new_bus->phy_mask &= ~(1 << i);
> +

This assumes that all PHYs have an IRQ.

I have patches forthcoming to of_platform-ize this code when
CONFIG_PPC_MERGE is defined; phy_mask will be set properly then.

Though, I notice that this is the only driver that sets phy_mask.  Is
there any reason we can't just leave the mask clear, and let the probe
for non-existent phys fail?

-Scott

Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0113.outbound.protection.outlook.com [207.46.100.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 998E21A0332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 09:16:03 +1100 (AEDT)
Message-ID: <1427408150.22867.135.camel@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
From: Scott Wood <scottwood@freescale.com>
To: <ying.zhang@freescale.com>
Date: Thu, 26 Mar 2015 17:15:50 -0500
In-Reply-To: <1427361317-4733-1-git-send-email-ying.zhang@freescale.com>
References: <1427361317-4733-1-git-send-email-ying.zhang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Ying Zhang <b40530@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 17:15 +0800, ying.zhang@freescale.com wrote:
> From: Ying Zhang <b40530@freescale.com>
> 
> Create the dts files for each core and splits the devices between
> the two cores for P1021RDB-PC.
> 
> Core0 has l2, serial0, i2c, spi, gpio, tdm,dma, usb, eth0, eth1,
> sdhc, crypto, global-util, message, pci0, pci1, msi, crypto.
> Core1 has l2, serial1, eth2.

Are we going to have this split for every board (I hope not)?  We
already have a couple examples of CAMP; why do we need p1021
specifically?

> Signed-off-by: Ying Zhang <b40530@freescale.com>
> Change-Id: I92614abdca3db3ab6083c4443ad563fd687050ec
> Reviewed-on: http://git.am.freescale.net:8181/1179
> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>

Get rid of the gerrit stuff.

> +		mpic: pic@40000 {
> +			protected-sources = <
> +			42		/* serial1 */
> +			31 32 33	/* enet2-queue-group0 */
> +			25 26 27	/* enet2-queue-group1 */
> +			>;
> +			pic-no-reset;
> +		};

If you have pic-no-reset you don't strictly need protected-sources.
Having it can protect against some relatively unlikely software errors,
at the expense of allowing more likely device tree errors.  Or at least,
it makes it harder to modify the device tree to assign devices
differently.

-Scott

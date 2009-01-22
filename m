Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 00DECDDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 23:09:20 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 10/10] mmc: Add OpenFirmware bindings for SDHCI driver
Date: Thu, 22 Jan 2009 13:05:28 +0100
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
	<20090122020041.GJ11492@oksana.dev.rtsoft.ru>
In-Reply-To: <20090122020041.GJ11492@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901221305.29532.arnd@arndb.de>
Cc: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org,
	Liu Dave <DaveLiu@freescale.com>,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Konjin Lai <Konjin.Lai@freescale.com>,
	Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <drzeus-sdhci@drzeus.cx>,
	Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 22 January 2009, Anton Vorontsov wrote:
> This patch adds a new driver: sdhci-of. The driver is similar to
> the sdhci-pci, it contains common probe code, and controller-specific
> ops and quirks.
> 
> So far there are only Freescale eSDHC ops and quirks.

Looks very good overall.

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +	ret = of_address_to_resource(np, 0, &mem);
> +	if (ret)
> +		goto err_no_addr;
> +
> +	host->ioaddr = ioremap(mem.start, resource_size(&mem));
> +	if (!host->ioaddr) {
> +		ret = -ENOMEM;
> +		goto err_addr_map;
> +	}

Minor improvement: you could use of_iomap to do this in one step.

	Arnd <><

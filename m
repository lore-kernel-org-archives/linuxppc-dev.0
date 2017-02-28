Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXZgq4lyJzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 21:34:15 +1100 (AEDT)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, Stuart Yoder <stuyoder@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, German Rivera
 <german.rivera@nxp.com>, Itai Katz <itai.katz@nxp.com>, Ramiro Oliveira
 <Ramiro.Oliveira@synopsys.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: fsl-mc: fix warning in DT ranges parser
Date: Tue, 28 Feb 2017 10:34:02 +0000
Message-ID: <58B55219.4070509@nxp.com>
References: <20170227204235.3547639-1-arnd@arndb.de>
In-Reply-To: <20170227204235.3547639-1-arnd@arndb.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On 02/27/2017 10:42 PM, Arnd Bergmann wrote:
> The fsl-mc-bus driver in staging contains a copy of the standard
> 'ranges' property parsing algorithm with a hack to treat a missing
> property the same way as an empty one. This code produces false-positive
> warnings for me in an allmodconfig build:
>
> drivers/staging/fsl-mc/bus/fsl-mc-bus.c: In function 'fsl_mc_bus_probe':
> drivers/staging/fsl-mc/bus/fsl-mc-bus.c:645:6: error: 'mc_size_cells' may=
 be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> drivers/staging/fsl-mc/bus/fsl-mc-bus.c:682:8: error: 'mc_addr_cells' may=
 be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> drivers/staging/fsl-mc/bus/fsl-mc-bus.c:644:6: note: 'mc_addr_cells' was =
declared here
> drivers/staging/fsl-mc/bus/fsl-mc-bus.c:684:8: error: 'paddr_cells' may b=
e used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> drivers/staging/fsl-mc/bus/fsl-mc-bus.c:643:6: note: 'paddr_cells' was de=
clared here
>
> To avoid the warnings, I'm simplifying the argument handling to pass
> the number of valid ranges in the property as the function return code
> rather than passing it by reference. With this change, gcc can see that
> we don't evaluate the cell numbers for an missing ranges property.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, i've tested it and did not see any issues, so here's an:

Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Thanks & Best Regards, Laurentiu=

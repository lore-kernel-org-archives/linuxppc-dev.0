Return-Path: <SRS0=wyLB=JY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Apr 2021 01:08:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69A061152
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Apr 2021 01:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69A061152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FTkCT2Lm8z30Gd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Apr 2021 11:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FThfq3cvfz2yQv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Apr 2021 09:58:10 +1000 (AEST)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13QNi8nL025548;
 Mon, 26 Apr 2021 18:44:08 -0500
Message-ID: <3677398ebb77f334abb4899770db633d9658fe82.camel@kernel.crashing.org>
Subject: Re: [PATCH net-next v4 2/2] of: net: fix of_get_mac_addr_nvmem()
 for non-platform devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>
Date: Tue, 27 Apr 2021 09:44:07 +1000
In-Reply-To: <108f268a35843368466004f7fe5f9f88@walle.cc>
References: <20210412174718.17382-1-michael@walle.cc>
 <20210412174718.17382-3-michael@walle.cc>
 <730d603b12e590c56770309b4df2bd668f7afbe3.camel@kernel.crashing.org>
 <8157eba9317609294da80472622deb28@walle.cc>
 <CAL_JsqLrx6nFZrKiEtm2a1vDvQGG+FkpGtJCG2osM8hhGo3P=Q@mail.gmail.com>
 <108f268a35843368466004f7fe5f9f88@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 27 Apr 2021 11:07:43 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 "moderated list:ARM/STM32
 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>, Jose Abreu <joabreu@synopsys.com>,
 NXP Linux Team <linux-imx@nxp.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Vadym Kochan <vkochan@marvell.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
 linux-omap <linux-omap@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless <linux-wireless@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Vladimir Oltean <olteanv@gmail.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Chris Snook <chris.snook@gmail.com>, Frank Rowand <frowand.list@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, Wingman Kwok <w-kwok2@ti.com>,
 Sean Wang <sean.wang@mediatek.com>, Maxime Ripard <mripard@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, "open
 list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Kalle Valo <kvalo@codeaurora.org>, Mirko Lindner <mlindner@marvell.com>,
 Fugang Duan <fugang.duan@nxp.com>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Taras Chornyi <tchornyi@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Fabio Estevam <festevam@gmail.com>, Stanislaw Gruszka <stf_xl@wp.pl>,
 Florian Fainelli <f.fainelli@gmail.com>, linux-staging@lists.linux.dev,
 Chen-Yu Tsai <wens@csie.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>, Byungho An <bh74.an@samsung.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
 Vladimir Zapolskiy <vz@mleia.com>, John Crispin <john@phrozen.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-oxnas@groups.io,
 Shawn Guo <shawnguo@kernel.org>, "David
 S . Miller" <davem@davemloft.net>, Helmut Schaa <helmut.schaa@googlemail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "open list:MEDIA DRIVERS FOR RENESAS
 - FCP" <linux-renesas-soc@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Russell King <linux@armlinux.org.uk>, Hauke Mehrtens <hauke@hauke-m.de>,
 Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>,
 Sunil Goutham <sgoutham@marvell.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 devicetree@vger.kernel.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, netdev <netdev@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Li Yang <leoyang.li@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Vinod Koul <vkoul@kernel.org>,
 Joyce Ooi <joyce.ooi@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Fietkau <nbd@nbd.name>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2021-04-26 at 12:54 +0200, Michael Walle wrote:
> Before I'll try to come up with a patch for this, I'd like to get
> your opinion on it.
> 
> (1) replacing of_get_mac_address(node) with eth_get_mac_address(dev)
>      might sometimes lead to confusing comments like in
>      drivers/net/ethernet/allwinner/sun4i-emac.c:
> 
>      /* Read MAC-address from DT */
>      ret = of_get_mac_address(np, ndev->dev_addr);

You could leave it or turn it into "from platform", doesn't matter...

> (2) What do you think of eth_get_mac_address(ndev). That is, the

Not sure what you mean, eth_platform_get_mac_address() takes the
address as an argument. I think what you want is a consolidated
nvmem_get_mac_address + eth_platform_get_mac_address that takes a
device, which would have no requirement of the bus_type at all.

Cheers,
Ben.


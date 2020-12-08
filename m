Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB9C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 21:06:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E798723B04
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 21:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E798723B04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrCRH2S30zDqgL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 08:06:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=arnd@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LqSXf0rL; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrCNb6ljSzDqTk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 08:04:31 +1100 (AEDT)
X-Gm-Message-State: AOAM530608RGpKOqOi4TXDmOtvjzH0+Ta130v06yy4rtUysYhr1jFRkX
 fXbPzyBHB1MGRCEF+I8m4xHcOg3w5lOOSpDsn5o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607461468;
 bh=pC5uMEwfR8I7zJOufVHiMnxXyaaTii8pTwxwwzk6hbI=;
 h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
 b=LqSXf0rLtaFg7OiJDPLvxyLr8icmHXe4yuXKIY4h+YZ2yI6o6C2+Cp6lzzcE53RP+
 qbcZNzsrzFDyKkmxH3At8U+KCXIslXO6P2j3/s4ufeGSW+N6hWr0seQipFRcNAoQlr
 P56APB2iQc/CsazNMHtgUJ/hy0/Vvnj2uonhwn+o3qqEHAyMe9/B2iYWYdcNoLgUe3
 eq6fJk9hg8VV7KU6RH6T6+JjtBp5PZIG3B5ZYJ0ym7XHZgQXOxkudvrnnTb9lAaTfq
 4sFfjCrSGex3bf8XGqRI1E4MbgGXDOjkxmUmRa31TG8dWM//mTEfBnw+5clvucs/s2
 gDg3LXbFQcKHw==
X-Google-Smtp-Source: ABdhPJz24xLDQ1sYVHXzKiGgnnVEI0nBoYMIK+EbZwUc+kqiRM7M10D2HVBVPIdLAc7qYdhjqVmYniHI185FcY2oAeo=
X-Received: by 2002:aca:44d:: with SMTP id 74mr1652369oie.4.1607461467934;
 Tue, 08 Dec 2020 13:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20201201222922.3183-1-andrey.zhizhikin@leica-geosystems.com>
 <160744514229.359082.11487352663734358657.b4-ty@arndb.de>
 <20201208170021.GA6168@alpha.franken.de>
In-Reply-To: <20201208170021.GA6168@alpha.franken.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 8 Dec 2020 22:04:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2FyP7TOc-fm=YQE9FX_tOiAk9_k2bn3XK5MW19D++Ymw@mail.gmail.com>
Message-ID: <CAK8P3a2FyP7TOc-fm=YQE9FX_tOiAk9_k2bn3XK5MW19D++Ymw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drop unused BACKLIGHT_GENERIC option
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
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
List-Id: <soc.lore.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Sam Ravnborg <sam@ravnborg.org>, Tony Lindgren <tony@atomide.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>,
 Daniel Thompson <daniel.thompson@linaro.org>, Helge Deller <deller@gmx.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <mripard@kernel.org>,
 Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
 SoC Team <soc@kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Lee Jones <lee.jones@linaro.org>, linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 8, 2020 at 6:00 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> On Tue, Dec 08, 2020 at 05:34:46PM +0100, Arnd Bergmann wrote:
> > [3/5] MIPS: configs: drop unused BACKLIGHT_GENERIC option
> >       commit: 2257682282531de45929c6006152f6e2ee881b42
>
> this one is already in mips-next.

Ok, dropped from my tree,

       Arnd

Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF7C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 17:41:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930E321738
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 17:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwWnyRFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930E321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pW3B48NTzDqPS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 03:41:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SwWnyRFo"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pW1P68V3zDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 03:40:09 +1000 (AEST)
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB05921738;
 Tue, 23 Apr 2019 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556041207;
 bh=OJ5HFdYrclCj1KQA4C5FoU+iSAcjqOdxVRhLB+Vkg7s=;
 h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
 b=SwWnyRFo2YdYR6iHb0xVL3qx7KO7SGmmOgc+HN2CD+qg+RZNZKFcFe4E/+C2WaKU1
 aKGB6bLEEK4YCxRHqEYTVA3G7IbQ/+QM7NWl5S2h2Ogohu6Vpy1mqWUrnD+OMCxOd2
 LT1sfl3Wlao8gHRTlvc/56DyhmvugBnYCvi9IxDs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOiHx=mjhzG-i8H5R0A+Mu3mcBXTNEaaBhC8rwCQPMWArDA+1A@mail.gmail.com>
References: <20190418111211.10474-1-jonas.gorski@gmail.com>
 <20190418111211.10474-2-jonas.gorski@gmail.com>
 <CAMuHMdX7E8fR+2s-gPgGLKUCdW_--YUDW7w+op3BDurgACFEmA@mail.gmail.com>
 <CAOiHx=mjhzG-i8H5R0A+Mu3mcBXTNEaaBhC8rwCQPMWArDA+1A@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RFT V3 1/8] clk: divider: add explicit big endian support
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Jonas Gorski <jonas.gorski@gmail.com>
Message-ID: <155604120699.15276.12116926593244975174@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date: Tue, 23 Apr 2019 10:40:06 -0700
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
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
 Fabio Estevam <festevam@gmail.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Michal Simek <michal.simek@xilinx.com>, Shawn Guo <shawnguo@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Michael Turquette <mturquette@baylibre.com>, Paul Mackerras <paulus@samba.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-tegra <linux-tegra@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Jonas Gorski (2019-04-23 03:39:59)
> No purpose at all, it's an uncaught artifact from rebasing ._.
>=20
> Stephen, which one is your preferred way of fixing that?
>=20
> a) a new V4 patchset without this line
> b) a follow up patch that removes it
> c) just removing the line yourself

I'll go for c and fix up things. Thanks for the catch Geert!


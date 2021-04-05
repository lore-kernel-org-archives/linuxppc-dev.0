Return-Path: <SRS0=L/Xq=JC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6209DC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 22:04:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFEF613C3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 22:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFEF613C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDl7m75LSz30G6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 08:04:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch
 (client-ip=185.16.172.187; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch;
 receiver=<UNKNOWN>)
X-Greylist: delayed 2333 seconds by postgrey-1.36 at boromir;
 Tue, 06 Apr 2021 08:04:33 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDl7P6n2Pz2xfm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Apr 2021 08:04:33 +1000 (AEST)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
 (envelope-from <andrew@lunn.ch>)
 id 1lTWij-00Ezaw-R6; Mon, 05 Apr 2021 23:25:17 +0200
Date: Mon, 5 Apr 2021 23:25:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] of: net: pass the dst buffer to of_get_mac_address()
Message-ID: <YGuAPb1+AcFTOYdq@lunn.ch>
References: <20210405164643.21130-2-michael@walle.cc>
 <202104060306.lmTxeOmW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104060306.lmTxeOmW-lkp@intel.com>
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
Cc: kbuild-all@lists.01.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
 linux-renesas-soc@vger.kernel.org, Michael Walle <michael@walle.cc>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 UNGLinuxDriver@microchip.com, linuxppc-dev@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 06, 2021 at 03:19:11AM +0800, kernel test robot wrote:
> Hi Michael,
> 
> I love your patch! Yet something to improve:

Looks correct. You missed the #else case for #ifdef CONFIG_OF in
stmmac_platform.c

Lets see what else 0-day finds before i start reviewing.

      Andrew

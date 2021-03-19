Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E3FC433C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 17:14:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A473461972
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 17:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A473461972
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F29Vc1Knvz3c4K
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 04:14:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=pMboij1O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256
 header.s=pandora-2019 header.b=pMboij1O; 
 dkim-atps=neutral
X-Greylist: delayed 333 seconds by postgrey-1.36 at boromir;
 Sat, 20 Mar 2021 04:14:06 AEDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F29V6300nz3bpJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Mar 2021 04:14:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jLA7jhfpTD/gf7DnkGIEr5ZaUexlkr8MeBHoScCGjoc=; b=pMboij1OQVxOZWL2QhcrYt1e4
 ToGGhJKSzZbwG4tYuMdaRP9gPpt3iDu4b/G0NaXY7sfwKJxe/52mpTd2kmN5uIR5OsW75mf8jZUrW
 WPnmH10ZCaejYOkmlHOdVaKWey6fs9pQ+H0cXPhiBrS3kdeoHaW7IDL1BrUx4ffaGPhE2rhmpqyDi
 zp2OU8cfqORCkRugVwO8Lpt0dlHOJ40hS8BdqlNhbrVpI/5Z5fhzcM4icQAGc8x1tnyWcva1k1eEV
 UVCAxGz0YiWDQP6WR61CDg1sx+GUloA3+yrX3gr9Q9J4KiPOdAu4lIeh5WxMpF1hbmHKVLWazLGsN
 nMDLsXwzw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51482)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1lNIbN-0004eU-6D; Fri, 19 Mar 2021 17:07:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1lNIbJ-0000hT-70; Fri, 19 Mar 2021 17:07:53 +0000
Date: Fri, 19 Mar 2021 17:07:53 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/10] ARM: disable CONFIG_IDE in footbridge_defconfig
Message-ID: <20210319170753.GV1463@shell.armlinux.org.uk>
References: <20210318045706.200458-1-hch@lst.de>
 <20210318045706.200458-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318045706.200458-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jens Axboe <axboe@kernel.dk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 18, 2021 at 05:56:58AM +0100, Christoph Hellwig wrote:
> footbridge_defconfig enables CONFIG_IDE but no actual host controller
> driver, so just drop it.

I have been using the Cypress 82C693 IDE driver on Footbridge for a
CD ROM drive, and I know it doesn't work with the PATA driver - as
I need to disable BM DMA, otherwise the 82C693/DC21285 combination
deadlocks the PCI bus. The PATA driver doesn't support disabling
BM DMA without disabling it for all PATA ports, which is really
annoying for my IT821x card in the same machine.

So, I'm rather stuck using the PATA driver for the HDDs and the
IDE driver for the CD ROM.

That said, a commit a while back "cleaning up" the PCI layer appears
to have totally shafted the 82C693, as the kernel tries to request
IO resources at the legacy IDE addresses against the PCI bus resource
which only covers 0x1000-0xffff. Hence, the 82C693 IDE ports are non-
functional at the moment.

I'm debating about trying to find a fix to the PCI breakage that was
introduced by "ARM: move PCI i/o resource setup into common code".

I hadn't noticed it because I don't use the CD ROM drive very often,
and I don't upgrade the kernel that often either on the machine -
but it has been running 24x7 for almost two decades.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

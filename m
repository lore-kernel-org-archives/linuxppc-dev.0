Return-Path: <SRS0=qtcn=IR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A79CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 02:26:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1363064DE2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 02:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1363064DE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F1nnp4fZ4z3cFd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Mar 2021 13:26:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=orcam.me.uk
 (client-ip=157.25.102.26; helo=angie.orcam.me.uk;
 envelope-from=macro@orcam.me.uk; receiver=<UNKNOWN>)
X-Greylist: delayed 376 seconds by postgrey-1.36 at boromir;
 Fri, 19 Mar 2021 11:19:08 AEDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [157.25.102.26])
 by lists.ozlabs.org (Postfix) with ESMTP id 4F1kz01zyRz30NB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2021 11:19:08 +1100 (AEDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 0DF1592009C; Fri, 19 Mar 2021 01:12:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id F30ED92009B;
 Fri, 19 Mar 2021 01:12:38 +0100 (CET)
Date: Fri, 19 Mar 2021 01:12:38 +0100 (CET)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/10] MIPS: disable CONFIG_IDE in sb1250_swarm_defconfig
In-Reply-To: <20210318045706.200458-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.2103190042210.21463@angie.orcam.me.uk>
References: <20210318045706.200458-1-hch@lst.de>
 <20210318045706.200458-5-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Fri, 19 Mar 2021 13:25:13 +1100
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
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 18 Mar 2021, Christoph Hellwig wrote:

> sb1250_swarm_defconfig enables CONFIG_IDE but no actual host controller
> driver, so just drop CONFIG_IDE, CONFIG_BLK_DEV_IDECD and
> CONFIG_BLK_DEV_IDETAPE as they are useless.

 Actually BLK_DEV_PLATFORM would handle the SWARM's platform driver as an 
IDE device, however the driver has supported libata ever since commit 
2fef357cf391 ("IDE: Fix platform device registration in Swarm IDE driver 
(v2)") back in 2008, so this is good to go.  We should probably enable 
PATA_PLATFORM in the defconfig instead.

 The printed name of the driver could be improved I suppose though:

scsi host0: pata_platform
ata1: PATA max PIO0 mmio cmd 0x100b3e00 ctl 0x100b7ec0 irq 36

(PIO3 is actually hardwired; it's an odd interface and people reported 
issues with it, but I have never had any myself be it with IDE or libata).

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

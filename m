Return-Path: <SRS0=aOOO=IS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B6C433C1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 04:05:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129F461966
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 04:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129F461966
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F2Rxf4NLDz3c87
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 15:05:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=orcam.me.uk
 (client-ip=2001:4190:8020::4; helo=angie.orcam.me.uk;
 envelope-from=macro@orcam.me.uk; receiver=<UNKNOWN>)
X-Greylist: delayed 100339 seconds by postgrey-1.36 at boromir;
 Sat, 20 Mar 2021 15:05:07 AEDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
 by lists.ozlabs.org (Postfix) with ESMTP id 4F2RxH0qkFz2yYp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Mar 2021 15:05:05 +1100 (AEDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id BAA7A92009C; Sat, 20 Mar 2021 05:04:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id AC6A092009B;
 Sat, 20 Mar 2021 05:04:57 +0100 (CET)
Date: Sat, 20 Mar 2021 05:04:57 +0100 (CET)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/10] ide: remove the legacy ide driver
In-Reply-To: <alpine.DEB.2.21.2103200425360.21463@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2103200455410.21463@angie.orcam.me.uk>
References: <20210318045706.200458-1-hch@lst.de>
 <20210318045706.200458-11-hch@lst.de>
 <alpine.DEB.2.21.2103200425360.21463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 20 Mar 2021, Maciej W. Rozycki wrote:

> > been scheduled for removal for a while.  Finally kill it off so that we
> > can start cleaning up various bits of cruft it forced on the block layer.
> 
>  You need to adjust Documentation/admin-guide/kernel-parameters.txt too, 
> i.e. remove all the `ide*' options, possibly more (I haven't checked in 
> detail).

 And also Documentation/ide/ide.rst.  Also do we have all the necessary 
`hdparm' features supported in libata nowadays for PATA devices?

  Maciej

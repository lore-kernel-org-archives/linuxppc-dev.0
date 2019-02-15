Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD3C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:20:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527FA20838
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 07:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="G5sNFRV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527FA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4414QB3s8hzDqVD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 18:19:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="G5sNFRV3"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4414NT3kjJzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 18:18:00 +1100 (AEDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x1F7HQsM024995
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 16:17:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1F7HQsM024995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550215047;
 bh=GeopkqQtXzwUJZ3y6qZvd9T4Uw6r5SvlPQNc24Bsa4Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=G5sNFRV3kQ3kFp1cpwQ/p977o6bRCOnlYRwRNZbkuKWgFr31TpOAUskfjCkCnggKQ
 bulUyTGR9xrCN2VpS5d9St1neRX4yw62qWtdsw0HBtyn1j5hbwxlhgcjzB+8LnteAj
 KF5Wc0ZLpE3uIZLcK/f8me4qiCozF3AhqXjaf6N3nAbupH9ncY+2IWXtspUZAi3Xjd
 WTtVbIYCTGpMxC8PDivjPWuAWe4F/PcsOgcBrGN2LV3WR6q6hsQIotn0as3Y6WQIUJ
 WwC7hCUSj3KnoLdRwtoHqyvBsQCyP3o6YHxEC6HvDuoD6dzpE4aZfPU+hVbdNCv7VA
 zQ0DRyIAughAA==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id n10so5207798vso.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 23:17:26 -0800 (PST)
X-Gm-Message-State: AHQUAuaoLqvRb3p2dwUZRpR7v4iMO7VAhci9GKUzFhc767F1ymxEHrWS
 JiRhFfccXLKNk4xpTAEY8jmTyFDwvFhEf4Ia3d4=
X-Google-Smtp-Source: AHgI3IZyIXujDelplfko6wBHrsbS2dq6CNqn7D68TH0m2IT92ENSLenQrLKXfUJMf7PNeCSldoJEBtW7NN6lWFtuNvE=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr4199596vsd.155.1550215045700; 
 Thu, 14 Feb 2019 23:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-7-hch@lst.de>
In-Reply-To: <20190213174005.28785-7-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 16:16:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
Message-ID: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
Subject: Re: [PATCH 06/11] lockdep: consolidate the LOCKDEP_SUPPORT symbol
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greentime Hu <green.hu@gmail.com>, linux-riscv@lists.infradead.org,
 Vincent Chen <deanbo422@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+CC Greentime Hu
+CC Vincent Chen


On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add one definition to lib/Kconfig.debug and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


This changes the behavior of nds32.

So please leave a note in the commit description.
(Ideally, we want Ack of a NDS32 maintainer)

Also, please do compile test for NDS32.


-------------------------
This commit changes CONFIG_LOCKDEP_SUPPORT to y for nds32.

NDS32 selects LOCKEP_SUPPORT, but there was previously
no config entry of LOCKDEP_SUPPORT in nds32.

It is now available in lib/Kconfig.debug,
so this commit enables LOCKDEP_SUPPORT for nds32.
-------------------------






--
Best Regards
Masahiro Yamada

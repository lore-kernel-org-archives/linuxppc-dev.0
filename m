Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9537C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 13:55:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39257611EE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 13:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39257611EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4msh3Q24z3c0T
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 23:55:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fgwmn8Bg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+ae8989e1668f84a74d37+6506+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=fgwmn8Bg; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4ms13Vc1z304N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 23:54:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vgcanmBaWEPTYxk9YYX1X9HoTPoV8jfXM0wcJQhAUoQ=; b=fgwmn8BgsRgkDQzIJ5FdXtqhPz
 R0p/51MWowYXfVIYOkLubeP6TdUYNGWGnoLQv6LSowXJ3Hb5giZia5XJ98i6+sJ70opNqCccLFzUQ
 PyNx1d10bCUxHd//DzvLjcQRwJbr0zQsakac3hivey0hFq+IDD5xyVhtgj842ZA/az2/YnUx7O/p0
 qwMbCjiAnUqdwD7DwN6J1PxpkMG76/18P8/9Vgrgn4d6HBOsTxufnmF5JelVFQyWsXj2rz//PiqM0
 S8zxqjIX8uzIP76bBtzg7Aljlu7WoUmF+D4ldcu/pMLYIyEJ5cHV0I54XeNNzntGI7633DVC7Haod
 GgZMbGCg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1ltVyI-0086Pw-AE; Wed, 16 Jun 2021 13:52:51 +0000
Date: Wed, 16 Jun 2021 14:52:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 00/21] Rid W=1 warnings from IDE
Message-ID: <YMoCLu1rrIYOsMT0@infradead.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
 <YL3YMGl9kmtv55B/@infradead.org> <20210614091228.GB5285@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614091228.GB5285@dell>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-ide@vger.kernel.org, Mike Waychison <crlf@sun.com>,
 Paul Mackerras <paulus@samba.org>,
 "Christopher J. Reimer" <reimer@doe.carleton.ca>, Tim Hockin <thockin@sun.com>,
 Erik Andersen <andersee@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
 CJ <cjtsai@ali.com.tw>, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
 Christoph Hellwig <hch@infradead.org>, Duncan Laurie <void@sun.com>,
 Scott Snyder <snyder@fnald0.fnal.gov>, Gadi Oxman <gadio@netvision.net.il>,
 Andre Hedrick <andre@linux-ide.org>, Christian Brunner <chb@muc.de>,
 Jens Axboe <axboe@suse.de>, or <source@mvista.com>,
 Benoit Poulot-Cazajous <poulot@chorus.fr>,
 Robert Bringman <rob@mars.trion.com>, linux-kernel@vger.kernel.org,
 Clear Zhang <Clear.Zhang@ali.com.tw>, Mark Lord <mlord@pobox.com>,
 Adrian Sun <a.sun@sun.com>, Frank Tiernan <frankt@promise.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 14, 2021 at 10:12:28AM +0100, Lee Jones wrote:
> On Mon, 07 Jun 2021, Christoph Hellwig wrote:
> 
> > Please don't touch this code as it is about to be removed entirely.
> 
> Do you have an ETA for this work?

I just resent the series.

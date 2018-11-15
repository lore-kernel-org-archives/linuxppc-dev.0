Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575EAC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:29:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB701214F1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m60hdUB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB701214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wgfY0HHWzF15Z
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:29:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m60hdUB3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="m60hdUB3"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wgY13LPBzF3fB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 23:24:52 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id e3-v6so21031723wrs.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cAnMfMxnQsyrtd5EB+OEuNhgtrQNwlqbyYN2nzIud+c=;
 b=m60hdUB3epw4dNEK6Ves6/K+FqXHxMoPn4Aa3e4nHe8edUFcj+D3Sqsw+hU3cuCmKO
 btBInJX73ERd8bfPBiFICDUFHNo8fcxaP1qX253rCgcqnaGMnDGRvbbQKadb2bh2NKQe
 oJkHcNeeTxSDy7VZ9HJW9/MyAo2odn2vr7177iaYhnmB2k3cJr2VsnljlntsV/n1Pbit
 K+c/HeYvCPD2pT5Ud4aiuvDaUFI/iCyBq29cRsXKeVmbaQ3YQFTEcfpTywRiN2N/qxXZ
 Z31DLw4DteKQhQncUclVNe92ZUcZgVh3LLaDB9b0H5p0KH2hRF8xwrJ8aDhNCK0NEEPh
 28+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cAnMfMxnQsyrtd5EB+OEuNhgtrQNwlqbyYN2nzIud+c=;
 b=ZpGwBD1lgl11oCG5bQyVmw8BMx5Dnq25Z5C9iOPGjIYfvtrqI1UBlsK/1yu3nFVVcr
 /LuzmVf5Dm7vuRIoIHEP1oS/OAnY8x0NFZfQSQKQ/lIZKyaOYVhmBn/HJGMbjkGQHMyb
 r6quvMLnuLOEWh9YMuQIe5qx9jwMhCXlx1FVRVkD2b+SU8ugxyq5Sp1rl/x7tvTNXHB8
 oHlBathno84uBW0GIXtso1sz5OgRoPCgzOV0jujMAQoA5oY3D+Lu49Yc0otwGz6SZ5GM
 1UXyZJrK9IHdHaRCdPPDiCOssU90CL7LA5lLBz4UACSRnG4H1DG+DrjlJkzsRxJMPV83
 CxVQ==
X-Gm-Message-State: AGRZ1gJGZXRMhhokEWcIK3aSyFZEBfDWVE9NnbKUmoJ5utfDQx3N7G6I
 rOc+meIoonEUOdkQh7SZynCHhg==
X-Google-Smtp-Source: AJdET5d8/UZZTXsaPAY+YK96ag6Gtyu/lMccxVwaA1udgd9XMqNdpCkepC5w9C+a/Wdbh5FYdpp7dQ==
X-Received: by 2002:adf:e6c4:: with SMTP id
 y4-v6mr5331319wrm.101.1542284689181; 
 Thu, 15 Nov 2018 04:24:49 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
 by smtp.googlemail.com with ESMTPSA id
 j129-v6sm21008489wmb.47.2018.11.15.04.24.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Nov 2018 04:24:48 -0800 (PST)
Date: Thu, 15 Nov 2018 13:24:44 +0100
From: LABBE Corentin <clabbe@baylibre.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Message-ID: <20181115122444.GA29281@Red>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <20181024085700.GR30658@n2100.armlinux.org.uk>
 <20181115093034.GB23965@Red>
 <20181115093348.GV30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115093348.GV30658@n2100.armlinux.org.uk>
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
Cc: Gilles.Muller@lip6.fr, maxime.ripard@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, paulus@samba.org,
 linux-amlogic@lists.infradead.org, cocci@systeme.lip6.fr,
 narmstrong@baylibre.com, airlied@linux.ie, wens@csie.org, joabreu@synopsys.com,
 agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au,
 nicolas.palix@imag.fr, oss@buserror.net, Julia.Lawall@lip6.fr,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org,
 michal.lkml@markovi.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 khilman@baylibre.com, carlo@caione.org, tj@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 15, 2018 at 09:33:48AM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 15, 2018 at 10:30:34AM +0100, LABBE Corentin wrote:
> > On Wed, Oct 24, 2018 at 09:57:00AM +0100, Russell King - ARM Linux wrote:
> > > On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> > > > This patchset adds a new set of functions which are open-coded in lot of
> > > > place.
> > > > Basicly the pattern is always the same, "read, modify a bit, write"
> > > > some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> > > 
> > > The advantage of them being open-coded is that it's _obvious_ to the
> > > reviewer that there is a read-modify-write going on which, in a multi-
> > > threaded environment, may need some locking (so it should trigger a
> > > review of the locking around that code.)
> > > 
> > > With it hidden inside a helper which has no locking itself, it becomes
> > > much easier to pass over in review, which means that races are much
> > > more likely to go unspotted - and that is bad news.
> > > 
> > 
> > Hello
> > 
> > I understand your fear, but I think the benefit overhaul thoses.
> > Furthermore, drivers which I have converted does not need such locking.
> > 
> > If you want I can rename the header to linux/setbits-non-atomic.h for making obvious the lack of locking.
> 
> It'd probably be better in the function name - it then doesn't get
> "lost" that it's non-atomic when it's included via other headers.
> 

I proposed that way for doing like writeq have do it with io-64-nonatomic-hi-lo.h

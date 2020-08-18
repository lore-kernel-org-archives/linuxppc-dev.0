Return-Path: <SRS0=LqqS=B4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59FEC433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 20:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544C62075E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 20:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEZ9FT5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544C62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWMLv1GkgzDq5k
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 06:04:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TEZ9FT5U; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWMDz2DKvzDqdn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 05:59:12 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id k13so9699950plk.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2020 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UtvEIM7NJb9DV7eM9Gem48qF3l7pVpCdEzxyrXC+k2g=;
 b=TEZ9FT5UQ0c4hTw4uTo0tXnl21MyitKB/Hm0BA/xD94N+19fOdggAxLE1SHPhZXHqD
 Rly/Wc9mUw8GyMUu9e4rUX+5GtFA6peIE4GDgziPYwtFtihtofk84dfTXvuz5Z+I5Lt0
 XAw8PgnIzVDU+KymMURjkfxZx0R0EvGunb2/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UtvEIM7NJb9DV7eM9Gem48qF3l7pVpCdEzxyrXC+k2g=;
 b=bAGrog6CQKoOhVZZXXDz33XuDMpVLdn/Yx3ODyQOjFzQPaj+nsBzl6nIOPAhzq5ReT
 NmyZ53M62ewZtYMJFok0VPs7ecRHek/x1+zrRAEeP2deECKDS4TJCoe96NRGf8JTWNxS
 XbDInX0bLV5VLJMEh8uwPthh7cXOY+og17n8F094hGfcjxuMmjkLMrOwpy9oBb6q+uUh
 7eSfVTHnZs6o3/VuE1GgSTVoh25JmyVD2QMTGVZ/sN6saQDJti4Xkz/BMb6z8OQ+Hvth
 AmkTw2hEJzJjG0TsYjAallVv34ypRyybLhlvBePiIzv1vvTsKKqOompRyH7e2hMzbtnF
 CEjw==
X-Gm-Message-State: AOAM532TxHfkEOCvdQMADilCYJBp8OI8V0B+TikUurxsdUGGemEF/dgL
 5JdkASK/s6k18kpprOfrqU0fNA==
X-Google-Smtp-Source: ABdhPJz5S+aFMIAllTf6EeyEL2d4ft+e+kahg8U05QAv6xwSUo7qPqGWeSmxI0LB5EZTcNSgAu3TAg==
X-Received: by 2002:a17:902:b20e:: with SMTP id
 t14mr16722140plr.58.1597780747129; 
 Tue, 18 Aug 2020 12:59:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id f17sm26147059pfq.67.2020.08.18.12.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 12:59:06 -0700 (PDT)
Date: Tue, 18 Aug 2020 12:59:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <202008181258.CEC4B8B3@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-9-hch@lst.de>
 <202008181244.BBDA7DAB@keescook> <20200818195539.GB32691@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818195539.GB32691@lst.de>
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 18, 2020 at 09:55:39PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:44:49PM -0700, Kees Cook wrote:
> > On Mon, Aug 17, 2020 at 09:32:09AM +0200, Christoph Hellwig wrote:
> > > For 64-bit the only hing missing was a strategic _AC, and for 32-bit we
> > 
> > typo: thing
> > 
> > > need to use __PAGE_OFFSET instead of PAGE_OFFSET in the TASK_SIZE
> > > definition to escape the explicit unsigned long cast.  This just works
> > > because __PAGE_OFFSET is defined using _AC itself and thus never needs
> > > the cast anyway.
> > 
> > Shouldn't this be folded into the prior patch so there's no bisection
> > problem?
> 
> I didn't see a problem bisecting, do you have something particular in
> mind?

Oh, I misunderstood this patch to be a fix for compilation. Is this just
a correctness fix?

-- 
Kees Cook

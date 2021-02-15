Return-Path: <SRS0=Krh9=HR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDFDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Feb 2021 21:06:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B215264DE0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Feb 2021 21:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B215264DE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gimpelevich.san-francisco.ca.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dfc8S1WqZz3cGF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Feb 2021 08:06:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com header.i=@gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=rlpr9Y17;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Void lookup limit
 of 2 exceeded) smtp.mailfrom=gimpelevich.san-francisco.ca.us
 (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=daniel@gimpelevich.san-francisco.ca.us; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com
 header.i=@gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com
 header.a=rsa-sha256 header.s=20150623 header.b=rlpr9Y17; 
 dkim-atps=neutral
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DfZ4J30CLz30Ky
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2021 06:32:11 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id k13so4726314pfh.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2021 11:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L3nj9/R/NkkK99k6HujqpUsnIKZSJ7ODAWop9jG8uEo=;
 b=rlpr9Y17GqcS3VcCW+l+bS1nW3xiXbddJLqCQV49EqcSpGV+KSbl8a+FrYFs9PvSYs
 it8iWSpJw1gsM6AGOhmH5Acw2KmSdULF0CtLUbpv1I2R6STtXs02IIl8hkKiuQrTcClp
 gnpNivl1Mi0M80qg3y9K82mqykBBymTRSXTNI+7NyuKpk2tirw6/VycnssOaap/hbbRM
 aoyntdpV8PSwl9fmqwLS6X81BO88m0k21D/riSbB2g+a2Jud+lXOz+nB4Ew3UND3WIr2
 OpusKjkcH5p5Sf2vfYR7Obk5HSn1xhQe1A1Xn5XMmt5nQ6eZnXSjlWHxq4HTxliPGZwx
 aMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L3nj9/R/NkkK99k6HujqpUsnIKZSJ7ODAWop9jG8uEo=;
 b=S98GH7deIxISfuPKMpl76BwDA3kQLVrr18Vh7RjV4B6YPdblrKIkE37oAr731KW5QP
 CRGCZWNnsOLO2ewpjJ8azcXydni7T7O7csCQCXJzUeyEKL32xu0ufw18aGCgkIKfXvGw
 8VQRBimj5h9meufjeIWHV11bmGj2p+yGRas0+JXv+PgyAefDE63cNj5zVmKxKTMH2Z/0
 oo1JQuZzd1K8r/r8sGtCaPUMWOMtBNsST+22XU+IsEWMTBHd9LKrjNUVT7FgWdn7Zzgy
 m/UyuCBMickxE4UgNB0b6xhggEAvmUl1n1bKB/xuIiMaxei0CRcdQpfviQOtxIbXqBFJ
 Hk+g==
X-Gm-Message-State: AOAM531iHwf452niZu0gozaAaDpIZFWA+Kr3biNWYX/tQ7feLCxMpWrf
 tsuSbGkuF7+P4Fc4/1ZPME+0xQ==
X-Google-Smtp-Source: ABdhPJwYGpgEV2/GV9/dgnc2/rEWjl2dK3GYAnKQrXXgndNQF0w/cYvidbBIhC5ZupXR2KlChWCpFA==
X-Received: by 2002:a63:181e:: with SMTP id y30mr15574858pgl.324.1613417527139; 
 Mon, 15 Feb 2021 11:32:07 -0800 (PST)
Received: from [192.168.72.184] (157-131-244-194.fiber.dynamic.sonic.net.
 [157.131.244.194])
 by smtp.gmail.com with ESMTPSA id y1sm196040pjt.37.2021.02.15.11.32.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Feb 2021 11:32:06 -0800 (PST)
Message-ID: <1613417521.3853.5.camel@chimera>
Subject: Re: [PATCH 1/4] add generic builtin command line
From: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 15 Feb 2021 11:32:01 -0800
In-Reply-To: <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
References: <20190319232448.45964-2-danielwa@cisco.com>
 <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
 <20190320232328.3bijcxek2yg43a25@zorba>
 <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
 <20190321151308.yt6uc3mxgppm5zko@zorba>
 <20190321151519.1f4479d92228c8a8738e02cf@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 16 Feb 2021 08:05:33 +1100
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Maksym Kokhan <maksym.kokhan@globallogic.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
 linuxppc-dev@lists.ozlabs.org, Daniel Walker <danielwa@cisco.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-03-21 at 15:15 -0700, Andrew Morton wrote:
> On Thu, 21 Mar 2019 08:13:08 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> > On Wed, Mar 20, 2019 at 08:14:33PM -0700, Andrew Morton wrote:
> > > The patches (or some version of them) are already in linux-next,
> > > which messes me up.  I'll disable them for now.
> >  
> > Those are from my tree, but I remove them when you picked up the series. The
> > next linux-next should not have them.
> 
> Yup, thanks, all looks good now.

This patchset is currently neither in mainline nor in -next. May I ask
what happened to it? Thanks.


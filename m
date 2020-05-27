Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C84C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 01:24:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795742071A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 01:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bdCwamy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795742071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WtRN2Rl2zDqPy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 11:24:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.a=rsa-sha256
 header.s=google header.b=bdCwamy6; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WtP80MD1zDqFY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2020 11:22:51 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id w3so17359042qkb.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2020 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lfaYQxAvjEIlf4eTifAP04WQLIjbuEqWZK7YVJA2P8E=;
 b=bdCwamy6l5y36tWaBAzw2jsOMRDVBFifmX0OhKp5L2f5ScxkRWlrKyoQKiqD4EeJKV
 r+6FDToY923n0az0tXSPj3wsGp8copRiOZkLeDF23sQ+QpMMHNroqCBKC4N86cfu2+pE
 gRdAk3lFfu8cKsuCTWNl38G8C5Toaqo8iPC8JRJQTeT/TJD29zkYEdZWCjpGUaKsvExt
 Kgexof+updggUzQv3Hh5nwcCouAWGuH4y0cvBuPKaep20bdhYpSNeVaEiycuBhe/Q/cP
 WmDx9CVktclY7TJzbk7DtYAwo5yxGuvOGVb6xy40yatS8SOR2vr/6Vo0E0NQI1wRWObQ
 xn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lfaYQxAvjEIlf4eTifAP04WQLIjbuEqWZK7YVJA2P8E=;
 b=DwaMvbf0J2eArf2dyMjQdNyABE37PLk5087aSYbvvByd7RmK6+Xnqo74QlQRZsAcDv
 MAE2iikfwPpt8/UuJTXRyLOq8S2iVGdDn4ksXyyef0TtdS4RWpA0bBhXPCBYWEECJQbM
 v6ZjfSKjr32juDp6+B22gXSeImtQNQH/+Zbbs6Ka6Q/fB7z5EaKOcvfLL0oicVgds+Sx
 v1Xo+V7NzUwvISjLbR4kWD4JwL7f5XFgGra/g7v55U0XpkKvitmuGXusavxMJqaG3Gmz
 JErTw4kFRXLddzd/y7XBFjvGQuDIjQJcw5eWyuDt8/0K4P3wUA+XDy2t86SaaU4XJNlA
 JgAg==
X-Gm-Message-State: AOAM530En7la7bstKIEknn/enpNY5XYh/w8byPcgZEV2DaLsG2n3l3II
 ofrgbG2KlXnQazE5+zlTiWN8Yw==
X-Google-Smtp-Source: ABdhPJwVgOsRZKK7L4GJOZmoCuR0CuYBMeqWZSLSs2+BbpvtTBspMPRVLYX3X/faUhr8Z3IcSE8AVw==
X-Received: by 2002:a37:9586:: with SMTP id x128mr1790368qkd.312.1590542568200; 
 Tue, 26 May 2020 18:22:48 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id x41sm1286992qtb.76.2020.05.26.18.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 18:22:47 -0700 (PDT)
Date: Tue, 26 May 2020 21:22:45 -0400
From: Qian Cai <cai@lca.pw>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH] powerpc/kvm/book3s64/vio: fix some RCU-list locks
Message-ID: <20200527012245.GJ991@lca.pw>
References: <20200510051834.2011-1-cai@lca.pw>
 <20200527011323.GA293451@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527011323.GA293451@thinks.paulus.ozlabs.org>
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
Cc: paulmck@kernel.org, aik@ozlabs.ru, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 27, 2020 at 11:13:23AM +1000, Paul Mackerras wrote:
> On Sun, May 10, 2020 at 01:18:34AM -0400, Qian Cai wrote:
> > It is unsafe to traverse kvm->arch.spapr_tce_tables and
> > stt->iommu_tables without the RCU read lock held. Also, add
> > cond_resched_rcu() in places with the RCU read lock held that could take
> > a while to finish.
> 
> This mostly looks fine.  The cond_resched_rcu() in kvmppc_tce_validate
> doesn't seem necessary (the list would rarely have more than a few
> dozen entries) and could be a performance problem given that TCE
> validation is a hot-path.
> 
> Are you OK with me modifying the patch to take out that
> cond_resched_rcu(), or is there some reason why it's essential that it
> be there?

Feel free to take out that cond_resched_rcu(). Your reasoning makes
sense.

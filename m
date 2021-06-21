Return-Path: <SRS0=Gjys=LP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AFDC4743C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 11:05:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD1D61059
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 11:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD1D61059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uged.al
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G7msD4lnFz3btR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 21:05:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=uged.al header.i=@uged.al header.a=rsa-sha256 header.s=google header.b=EVDUqdE4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ugedal.com (client-ip=2607:f8b0:4864:20::72c;
 helo=mail-qk1-x72c.google.com; envelope-from=odin@ugedal.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=uged.al header.i=@uged.al header.a=rsa-sha256
 header.s=google header.b=EVDUqdE4; dkim-atps=neutral
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G7mrh5J9Jz2yYG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 21:04:50 +1000 (AEST)
Received: by mail-qk1-x72c.google.com with SMTP id g142so29248391qke.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uged.al; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MvrUCOsjHnbRsvDmF+iBFiQ9cG1N/tBu4rO41BmsuJY=;
 b=EVDUqdE4krKQLAljHqyXPZQniLMQSkWbBzl7Z/Cs0l3Bn1PzJy6LFgNfDcMbk2D+b8
 OPkQIlKV+BmMRUmpg2y6h3SsLtxHE7gXQcRtnygho525ZpO2xoJyk+9xy6eYFAap6gnO
 YZB603T9cFPlRiqSBOQuGiwehGNbeXZn9gBGFsO8FV68HXX5MpovfK9JdKaO/i8njNI7
 tSb+TtGOpA8+A0BaB2xEVVt4m1UjK1iLH/hZN+W2fzeEWQGW4rrcO18YHEFIRuQL8Cvl
 yAjq9mwVWIaP0R+xhO5g82PpXX7Yxx+1CbVcd7jLmZaFnyTgjcGEZQbFSjiARuE0YLXM
 srgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MvrUCOsjHnbRsvDmF+iBFiQ9cG1N/tBu4rO41BmsuJY=;
 b=JNpoBojLXpxFzT3BCyubnui6wucRYMzh7Ue32CjE53p043gF9XncXrO4WNLXnZlt7r
 RiHYgT1CSb/1IQBJykqx1wnWajsmMDT9dBBr+CIyOf8flWNdqNsQF3YKblUcUu/Ht58p
 Nj2HG5WkQUfeqB5IaEm4Tetf9Zt8voIqp739rlXSukivzuw/m+y8dvHgJwc5D+bvqigQ
 iBTK+LDZhMaw4TfRL6TC0EW+VLNL1F+n9FoDNJ7GxYvkF+Y9gXC361Xu7a46bVYa2E9O
 aQOwGF6v2nleEMfwDkOGEnYLrNQQp73i+GZJNiOF5rhYRNYrikizWC0Gyyf9BO9OIOMn
 lEAw==
X-Gm-Message-State: AOAM5306wnynnUmbIoEg0xzjrDYfpAxW2fqYSB0NZnCNCI2oba/7UUcm
 gzNLo8dN/lNzq7S0nzqajkYP3n1j3QtbbOeyvpK5rg==
X-Google-Smtp-Source: ABdhPJw+Kzdc2fnjMLQc6URmG51WkagIptLPEULYF0eySLsniubrLBVZGqwOMMepHPn92rar4m3PR/TuvxrbFZHYsPY=
X-Received: by 2002:a37:b3c5:: with SMTP id
 c188mr22800576qkf.242.1624273486637; 
 Mon, 21 Jun 2021 04:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
 <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com>
In-Reply-To: <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com>
From: Odin Ugedal <odin@uged.al>
Date: Mon, 21 Jun 2021 13:04:07 +0200
Message-ID: <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Odin Ugedal <odin@uged.al>, open list <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

man. 21. jun. 2021 kl. 12:57 skrev Sachin Sant <sachinp@linux.vnet.ibm.com>:
>
> Unfortunately this does not help. I can still recreate the failure.
>
> Have attached the o/p from test run.
>
> Thanks
> -Sachin

Yes, thanks!

I am able to reproduce it locally now, so will keep looking to see if
I find the cause. Thanks!

Odin

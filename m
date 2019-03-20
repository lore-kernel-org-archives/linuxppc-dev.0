Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE9C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 20:06:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBDC21841
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HPpQBz/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBDC21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PgtB6WsGzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 07:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="HPpQBz/C"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Pgqp3K0pzDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 07:04:37 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id n6so14930808qkf.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vo6r5RiuoHQQbBcC9iguZtdqZ6ajLyJa96gCdeOiWbE=;
 b=HPpQBz/CvqsFaa0YHkIdIWC9iwfw02s4wfgNx/cLGOHj1a5FGWAnDDpEotjpjx0NSL
 F0gyFf/ieAD253cjGeiAI+MkOvyvKxGe61VtSSWQyyRJBaP7ihSFnE/JoVW2e+vyFmJ/
 oOS7inR6aNpv0mA8RAyeReJDsdd38nUMURgiM9zWeRT4BPqOg5Djdld7zvw2Y8Eov+n7
 /YZmRaOdN3FdNQJFu/QU8RFIhdswP6VC6E+Es8DpHWFEFDgpkO5rN/P+p1FBRmPnU30m
 WYfL0DDwwyVAavff0M6gTimy98fqUaF3Rinq/8q+m+aNdLDaewlmpV8kawsjV23Vwx7s
 G2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vo6r5RiuoHQQbBcC9iguZtdqZ6ajLyJa96gCdeOiWbE=;
 b=gHF+vhxjHux5rQkPpVNarHl1UzbRk8asYeG/hiF/hkEVTFy87LbbSrVaGKtwyR88Jr
 odkVlKeSdDIFxltftv4wOea+csPZIZkMLJIgyOgbacy+4kxi1lKeAX5U/b2keN964MX/
 ddHsNNlXsZ2JdEqULH0J5iXOvGI4btcRQKMitQQVe3pHfW6ag8xK9wBnPl5pGhMvewRC
 5Qmye2Px/CcVQKNGsTpYWvci90JrZ5+D2p/JxhCCABnync3Mk8KPQQ8hr7sIMWK9/UkS
 bdYKLBsfu2DRn+6MoQ16d5leG8LelI2mIP7nmkEs5EqhViqH++aw+qL0hcAI8p9jGhFR
 GKFg==
X-Gm-Message-State: APjAAAWjipLYxuoS4jY0jdVwzowljqQ+uRscbjAVvIfbZQIzluM0AKn5
 xEkjxul4Wt4GnyUgI2i5o8Zumw==
X-Google-Smtp-Source: APXvYqyNcoCpTrG/QlxBIiS3xOXvYOWD0i6x08P3+8eR8pgFrkDCEqYQr79GX02pD2JjjO+rwwfWzA==
X-Received: by 2002:a37:4d52:: with SMTP id a79mr8186639qkb.75.1553112274192; 
 Wed, 20 Mar 2019 13:04:34 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id h24sm2225964qte.50.2019.03.20.13.04.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Mar 2019 13:04:33 -0700 (PDT)
Message-ID: <1553112272.26196.9.camel@lca.pw>
Subject: Re: [PATCH v2] kmemleak: skip scanning holes in the .bss section
From: Qian Cai <cai@lca.pw>
To: Catalin Marinas <catalin.marinas@arm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Wed, 20 Mar 2019 16:04:32 -0400
In-Reply-To: <20190320181656.GB38229@arrakis.emea.arm.com>
References: <20190313145717.46369-1-cai@lca.pw>
 <20190319115747.GB59586@arrakis.emea.arm.com>
 <87lg19y9dp.fsf@concordia.ellerman.id.au>
 <20190320181656.GB38229@arrakis.emea.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-03-20 at 18:16 +0000, Catalin Marinas wrote:
> I think I have a simpler idea. Kmemleak allows punching holes in
> allocated objects, so just turn the data/bss sections into dedicated
> kmemleak objects. This happens when kmemleak is initialised, before the
> initcalls are invoked. The kvm_free_tmp() would just free the
> corresponding part of the bss.
> 
> Patch below, only tested briefly on arm64. Qian, could you give it a try
> on powerpc? Thanks.

It works great so far!

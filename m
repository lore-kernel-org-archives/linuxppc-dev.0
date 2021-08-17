Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2CC432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 06:00:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9959060F39
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 05:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9959060F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpgNY71v0z3cLl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 15:59:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=YtV+IgzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=YtV+IgzU; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpgMm5G4Lz2yNx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 15:59:15 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id
 qe12-20020a17090b4f8c00b00179321cbae7so4586444pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=dQisk5/c9LVCcy1HAz4ONWGiiJi823Q9v5VbiiIG+Bc=;
 b=YtV+IgzUIN2vDHlGtx9nJADAwIVufluKh2UiMVxJU4IdktVnJTmUT1V3d97kFYCgER
 dUTzO9+YO/FdHkHZagXa4PGJhdDGD61LO5Zvmybkl+Kf4jZJYU1SnWw7DZcpTe6+8xf7
 i56lv3fFxtu0tA3ap/4j9hOydpaZasiMl+KqVnHzHlgaBqG6Z7T+LCspkHVf7df2Pz46
 KPWpUNKqRNm5QTBqhJRyJXObrjEMf3M+IvLU1f28BcM6mfxFGJZNqhbtMPVWKSy2lnDr
 GYu4i88t2VGt7TSryQhU8G8y7zjz2o8zp7bjfdLBJe5Lv7tKt3EIZJ+8PLbWmb1XFFrw
 YctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=dQisk5/c9LVCcy1HAz4ONWGiiJi823Q9v5VbiiIG+Bc=;
 b=iP2L4PvEZQCGgVitFv2zaVyJpeZQ8seL2RnAUcOKIswBSn8ehyz6W3NEhnK8qM4w1P
 lXcyDX5Wer1BD9M/7RLeZDI8vsEidhrVfkYaYlndcUbIdxIiiZcY4RiE7Y29tN7D6Dr2
 Y9YyTDNtMR8i32AHelOyHG7kABI2MvHeQfWjya0hV+QJze81aGCv64VL6f03chUPeVUX
 /aSn1Nb8U4rsdTdqaKTyFAci+ucALPrJ/L7NfpIkisYgApp7ER0SHbPFtMln7ZBTiE8L
 ECDs6N3au1LmskhSpVO0WCQ+35LPFp9LL/ORUdwGtaKLxtt0Jr9gWy3vwLpUrTSoUHeI
 kovA==
X-Gm-Message-State: AOAM532WsbHzvzESykwC6JSUDy8yqkgH/h8SwBVYnkAqRARyXufNca62
 QMyY5DEOMo9zmvVywTmuVBc=
X-Google-Smtp-Source: ABdhPJxr0MwNK4v8M7UNaRnYmKAD3Xt8NlPrz6a98GolJrPy/tjiMEIIyQdDToJaRmyP1qgHk5erUw==
X-Received: by 2002:aa7:8ec1:0:b029:3cd:cd3c:b85c with SMTP id
 b1-20020aa78ec10000b02903cdcd3cb85cmr1934374pfr.15.1629179953591; 
 Mon, 16 Aug 2021 22:59:13 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f0:30b2:5c9e:50:88f3:269a?
 ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
 by smtp.gmail.com with ESMTPSA id b17sm1197470pgl.61.2021.08.16.22.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 22:59:12 -0700 (PDT)
Message-ID: <1cf050db5d37f6e515cd25e26f4e8940960c12d0.camel@gmail.com>
Subject: Re: [PATCH v5 06/11] powerpc/pseries/iommu: Add
 ddw_property_create() and refactor enable_ddw()
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Paul Mackerras <paulus@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kernel test robot
 <lkp@intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 17 Aug 2021 02:59:14 -0300
In-Reply-To: <1ab60060-1435-f77a-d2df-84019e7625a2@linux.ibm.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
 <20210716082755.428187-7-leobras.c@gmail.com>
 <1ab60060-1435-f77a-d2df-84019e7625a2@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Fred, thanks for this feedback!

On Tue, 2021-07-20 at 19:49 +0200, Frederic Barrat wrote:
> 
> >         kfree(window);
> >   
> > -out_clear_window:
> > -       remove_ddw(pdn, true);
> > +out_del_prop:
> > +       of_remove_property(pdn, win64);
> >   
> >   out_free_prop:
> >         kfree(win64->name);
> >         kfree(win64->value);
> >         kfree(win64);
> >   
> > +out_remove_win:
> > +       remove_ddw(pdn, true);
> 
> 
> I believe there's a small problem here. We jump directly to 
> out_remove_win if allocating the property failed. Yet, the first
> thing 
> remove_ddw() does is look for the property. So it will never find it
> and 
> the window is never removed by the hypervisor.
> 
>    Fred

That makes sense, thanks for catching this one!

What I intended here was just removing the DDW, so I think it should be
ok replacing remove_ddw() by a new helper that only does the rtas-call.

I will send a v6 with this change soon.

> 
> 
> > +
> >   out_failed:
> >         if (default_win_removed)
> >                 reset_dma_window(dev, pdn);
> > 



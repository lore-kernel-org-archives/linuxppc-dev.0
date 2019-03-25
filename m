Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77771C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 08:57:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E984520879
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU1LTh+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E984520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SSnK1bmxzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 19:57:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::a42; helo=mail-vk1-xa42.google.com;
 envelope-from=rsalvaterra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BU1LTh+G"; 
 dkim-atps=neutral
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com
 [IPv6:2607:f8b0:4864:20::a42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SSlB2SPrzDq7F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 19:55:14 +1100 (AEDT)
Received: by mail-vk1-xa42.google.com with SMTP id v131so1773032vkd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=TcZZuIvVyj0z6vIyD3VaMMy6CbXx3fo98S/yFrzl8bc=;
 b=BU1LTh+G8r4JAzVcDzN4jaJTG17fbO9uBJJz7l6FhTfXuDcIFBIBk3TmEr0EmJjKKq
 oYWXLduLIvgcFYY1Q6jsusRD60wdTxnnOVnzw11VRKFYBud1Nzjb/s1VqBWWsJWodBiG
 0ZF2sGvX2uV1e2Q+ZAhnymp999YpMWTWgBz2Oo6V31hKUlZerEhOrkTYREeZtSlV1+zB
 gSSvVpIWPLX0Up3cbs1vzJLSzMnEQ57h41KJZBLvk9XWCyJq96Kt1YlIWZcnxVMYY+Ok
 KVptdsHmcHEDJ0RS2kPRd67IiCrdGjjb6zB6GHeG3M0OcP0V5z+AG+ZDuIa8qtv1+q4X
 ritA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=TcZZuIvVyj0z6vIyD3VaMMy6CbXx3fo98S/yFrzl8bc=;
 b=K6qjYVgPvMx0Az4deaylE2k+PPINjjiH5Chmk+NoKuxeu3/0/vu7cCQL3kSzoqogdF
 kHjdsifCf5oeDQCpea+MYUiDCFGJjXqEFlti0cewcjmhvuu/WAmp4fZYUMz4lSAOVWTR
 a2EBWrNJra0OSZmo80O+Z1NP1wRIfYAQWFOelsq6OTMZ0Uk2k9+XAy9EHpM2ZE5CKAvU
 v32uIJDwvxwqElUvvWfPLmH4Whny6h1A0+EGU3XjULgiV5rk0Y+eu0GFmDWS8ASD/Xo0
 PU+u+Uw/2XsFGOWxsUkOS+1D1oVnvjGh5ebmKW3D/jhRE3IJMIFDGLGXc0uRSgL6lCXN
 c4jw==
X-Gm-Message-State: APjAAAUatjpQSoXs3lxMpSS0fl3qTKkewCDz+EE7B3mmH2Pkm/RN1car
 qxfCWxFZSz+gjI5vVD1yWSaAnqmsFP8PNRPJhQ==
X-Google-Smtp-Source: APXvYqwHzBXbsZRq6YCN0fE9bd1ULPLPuD3NQPA7gwXKkhkcxfpJkQJeDHU6SHlnRpHAwhdYSbU134Ul4KM5OH44x5M=
X-Received: by 2002:a1f:7d4e:: with SMTP id y75mr13565164vkc.53.1553504110899; 
 Mon, 25 Mar 2019 01:55:10 -0700 (PDT)
MIME-Version: 1.0
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Mon, 25 Mar 2019 08:54:59 +0000
Message-ID: <CALjTZvZ8W9x1dxYvOFL8JqxYtiY+a05ihJkOiEjPUjDx-Gz2KA@mail.gmail.com>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
To: ben@decadent.org.uk
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi, Ben

> Presumably you have CONFIG_PPC_BOOK3S_64 enabled and CONFIG_SPARSEMEM disabled?
> Was this configuration actually usable?

I just noticed these build warnings too. FWIW, I've been using
CONFIG_FLATMEM on my Power Mac G5 for about three years, so I guess
the answer is "yes" (for this specific machine, at least).

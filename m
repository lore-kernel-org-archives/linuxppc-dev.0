Return-Path: <SRS0=uOHI=ZR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD025C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 20:24:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6472520727
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Nov 2019 20:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Tvfmu6fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6472520727
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47MJRF3z9dzDqbv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Nov 2019 07:24:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=ndesaulniers@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Tvfmu6fN"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47MJPK5PH0zDqZL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2019 07:22:45 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id f9so6998069plr.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2019 12:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XE60qzqDDu/QSjZjM0/sTKyHZau5FHQqXZ2FkpPYMQ4=;
 b=Tvfmu6fNo0X7N2hDoy1ZSL5LaOeluQOOtwT+s5EGjVd6BOcRLYs4xGowdfCdk51tO6
 AhMuMoJNLGPjiTx3JdosGUR4BFsD3dbMLWPgodWZYMtGvgXPtNVnwQH/VbpyP6sA3GqC
 skb5v6u+BoD56WLQ2UhJ0lzRcKLqv+uvyd553G3k7VZO8xO3IH81VyVziblEBh8hsyRW
 fBl0mYMeRIVesm+JZZB8iL8n1sr/ASSIuhO5/p2vPmUdO+g4TO0ypBpnF1vuKC90i+IG
 RkPNLrs5bZrJRNBh8fjBNm2oH4mnKvMyBLhpLH6pDqhZ34I3eubl5ETq0//t7QdHOgNE
 xGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XE60qzqDDu/QSjZjM0/sTKyHZau5FHQqXZ2FkpPYMQ4=;
 b=inpZnmnt2klCKc4a6hdHEOGIRSsWkZmdmpmh0wBTnP3BLOcl1gNuOAE2NUi/USSUlb
 EfEoPq5/ysnGb2s/oG9IzFnNeg5Vc7+IDUnwFx8Kc88V3n51oHDLbMmR7regiHzkvgq3
 Ay78RG9o/WMcZxD93g7QoHu3woW2yksagZAAnOzeLWPQUqGTR9UP719h0tfH91fOMN/0
 uBiJWQepKyXI7VyKY+CsWjFEt0JBCLZIFYg8Zi0SowzZr0bh/WCc4APCkAwkZLR59CvV
 AVXHfxIbJSDgyUQDNqxE4ZAqZ0vlTVrLOHZFL92Uo82RTXR1M/J0yexxVmRlqdfqnkt9
 TyMA==
X-Gm-Message-State: APjAAAXWFQJoFlczxA/qncCocNdou+NnYS3wSZe/+3SQeAeFjthfL7PX
 GNIpqh71NG39k8gf+ruxNyJsbFQ9rpYyLzSo39uCRw==
X-Google-Smtp-Source: APXvYqwZYrafkMC3y4LZBHlZmLbkinEnmRRGqd2iB0KYH6aoz+ch5bNaghIA+nnyiYgF9bK/LY57MupABQMOzzPNfv0=
X-Received: by 2002:a17:90a:be05:: with SMTP id
 a5mr1039257pjs.73.1574712928322; 
 Mon, 25 Nov 2019 12:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20191014025101.18567-1-natechancellor@gmail.com>
 <20191119045712.39633-1-natechancellor@gmail.com>
In-Reply-To: <20191119045712.39633-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 25 Nov 2019 12:15:17 -0800
Message-ID: <CAKwvOd=3Ok8A8V30fccK5UzWFZ7zwG_zvGQV44S2BK4o2akbgw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] LLVM/Clang fixes for a few defconfigs
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,
Do you have feedback for Nathan? Rebasing these patches is becoming a
nuisance for our CI, and we would like to keep building PPC w/ Clang.

On Mon, Nov 18, 2019 at 8:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi all,
>
> This series includes a set of fixes for LLVM/Clang when building
> a few defconfigs (powernv, ppc44x, and pseries are the ones that our
> CI configuration tests [1]). The first patch fixes pseries_defconfig,
> which has never worked in mainline. The second and third patches fixes
> issues with all of these configs due to internal changes to LLVM, which
> point out issues with the kernel.
>
> These have been broken since July/August, it would be nice to get these
> reviewed and applied. Please let me know what I can do to get these
> applied soon so we can stop applying them out of tree.
>
> [1]: https://github.com/ClangBuiltLinux/continuous-integration
>
> Previous versions:
>
> v3: https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/
>
> v4: https://lore.kernel.org/lkml/20191014025101.18567-1-natechancellor@gmail.com/
>
> Cheers,
> Nathan
>
>


-- 
Thanks,
~Nick Desaulniers

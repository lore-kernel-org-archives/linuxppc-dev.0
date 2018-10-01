Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229DCC004D2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 01:13:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8582075E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 01:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd9kRkuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8582075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nkn811jpzF36m
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 11:13:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nd9kRkuw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nd9kRkuw"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Nkkb5hZnzF36b
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 11:11:18 +1000 (AEST)
Received: by mail-ed1-x541.google.com with SMTP id n2-v6so2590318edo.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9q40iAszCjFBdVbdWRyM2UC4c2MRuO4LGgNpy/+d5tQ=;
 b=nd9kRkuwrouzWwutlgNfagggNoEuL72cR4ATYBeAli64ybEV/nqBHnuCPYd4eNQYCB
 WMq0fL6nMfaxLz1FMtgQ1M6qFxG/kfKinE9f20O9Hl8Lzs/oxdDX10aPHcq8OpcbavNg
 Bo870iB1ZkL1fj/LMODktZfM56N9BvL4HQdzDqVr4cxlIPB2NqdoTnVFkrJnOEOwZDjY
 ex0XR7AyCvjWmhFVO0KM5J08aqst2ivP6w1AsSQCBvXNCx+HoI2grt1toP4He0wyic84
 plhHdsbaTiN9xDjxmRBsqew9m4msxJZ/sS3TwiavPK6BO6NS4U+G5Yu8GKiiWNEzx5Pj
 8SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9q40iAszCjFBdVbdWRyM2UC4c2MRuO4LGgNpy/+d5tQ=;
 b=RpTdXK5e3a0v5wJ+kFakfHTIUICj9JM/Tm5pQtBOxq3n16EQTh+MO9yVCM5TR9Q4lZ
 kv8z/XELg7e+Gu65SR3IgkqzzDfB86nYoFNhgpis2307FKOLQB1MiwqmnAjPK/FfnhoE
 xS8RBZ6bWeJD0Ipe0cHJGw/XYD6zeFBO/cYxuIvtpTS57UHq11abYkO3sZNp1ReA8DD4
 qeMv/YrsXzupovICvcWJSbkOzquqqnARl90D5uQdTN3Bx2hyM1sYYPwM95wtZc7ktUY0
 yEqeDIlrQeKxt1UlslT9QsGxdPXO+2tOwv44npZH+k3KtleHNulRLqezSBQSaVAxk8CP
 mHGg==
X-Gm-Message-State: ABuFfoizNBGjj10VLRsuHTkmkqCmDEcTTAFe4Q1LB3IIPKHdtkYl3dxi
 wbmDXxxvIRy+cbgVYEk0At+c8TxmgSuy8hhTMUIzfNuk
X-Google-Smtp-Source: ACcGV63HaDRufZxTTdxY+RnHDNUMjCFHLojKX7JBCRf+i9W2r21c5Nfv1bmkwLeZQq90ueNKdYThdxRXUppPl1rLug8=
X-Received: by 2002:a50:de03:: with SMTP id
 z3-v6mr14875111edk.245.1538356275636; 
 Sun, 30 Sep 2018 18:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
 <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
In-Reply-To: <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 1 Oct 2018 09:11:04 +0800
Message-ID: <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit kernel
 to 512 bytes
To: npiggin@gmail.com
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nick,

On Mon, Oct 1, 2018 at 7:27 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Sat, 29 Sep 2018 23:25:20 -0700
> Bin Meng <bmeng.cn@gmail.com> wrote:
>
> > commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> > userspace to 512 bytes") only changes stack userspace redzone size.
> > We need increase the kernel one to 512 bytes too per ABIv2 spec.
>
> You're right we need 512 to be compatible with ABIv2, but as the
> comment says, gcc limits this to 288 bytes so that's what is used
> to save stack space. We can use a compiler version test to change
> this if llvm or a new version of gcc does something different.
>

I believe what the comment says is for ABIv1. At the time when commit
573ebfa6601f was submitted, kernel had not switched to ABIv2 build
yet.

Regards,
Bin

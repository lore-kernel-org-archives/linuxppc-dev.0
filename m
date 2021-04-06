Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A91C43460
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 07:05:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A45F61242
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 07:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A45F61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDz7h3hFCz3bs6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=sSdhwSHA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e;
 helo=mail-pf1-x42e.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=sSdhwSHA; dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDz7C3qFtz302V
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Apr 2021 17:05:10 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id c204so5999214pfc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Apr 2021 00:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=uS28LyyI+bi1kiY9qrGEaoICmXPsK96cE5clEwvIrlg=;
 b=sSdhwSHAEMAVPq/5SsZDPjDoQcLo+Zikg+iGPRxKIf5+QYQbULlfuzEinZ25/EKbhJ
 GwInAZPZnHPChlXonmvJv9wBJpe57D4161koWuqYKabgoaHxIdpdHdqVcvIYzwVa7A2F
 Y1jGyPxyWa3G3bxKJsWds70VNd+boE5ceZ7ya6lV0rqBlHl5SP9vK7KNjfnVOlwSYd3y
 +SoZaQbhFc9uhojgKwcDEdsT438f2Fo//g21WRjdoyKHHXB5tsyvuQpD8vF6aLBng4Uu
 pHiHTzoemc7RBhLPf/mW8Xm8UoO9GmwiYBjTLVP40s6G9AE3DOPJnsYsZl4HslrUvuBm
 8cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=uS28LyyI+bi1kiY9qrGEaoICmXPsK96cE5clEwvIrlg=;
 b=acJS4B5Lmzh1ekUbo4TZ+QXWc1B4t7nrXbYEtGpnOzqkodRMVjNmwkJor9vwAxtbtD
 5c7LfeC7vJBYQFVz3FRxJHvMDpNVDVOtcg/u5YKC3Cq+D1kPGODWT6TTQDDdASF62RHy
 YjhIaHfBBGtEPZFO5A8DejO8MvEgd05FAbbkGS3qOGHl23xf0VIiq3f3fI6896FHmaY8
 GyD5kC7tHWQpi1JJwGzuYIrnQu9RFni6sHI1Bjm6oUBVrQukcV+3f93E2Ehn25hazPSv
 LkWjf3LsOYLwMV4g25tkU/YyvaumwK+yo7qaKlegxzipx7wRoiIpvqLWe65Ny541T41T
 5Y3g==
X-Gm-Message-State: AOAM533QT7dt/Q3gp72QO5WZoqHsF15IF5LItvgZw1ncYPfwhZAXfYxv
 G5iwIs7L+MvdhVy34tj9wNQ=
X-Google-Smtp-Source: ABdhPJysgIrCHm/aCWkegmz+8NxzSXzD7Ogyz29u24a/n5t1b7BdMPRYR4a3HFgP7ULGgs3wd9Ye4A==
X-Received: by 2002:aa7:9804:0:b029:1f1:5340:77c1 with SMTP id
 e4-20020aa798040000b02901f1534077c1mr26329965pfl.72.1617692705503; 
 Tue, 06 Apr 2021 00:05:05 -0700 (PDT)
Received: from localhost ([144.130.156.129])
 by smtp.gmail.com with ESMTPSA id x7sm18114838pff.12.2021.04.06.00.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 00:05:05 -0700 (PDT)
Date: Tue, 06 Apr 2021 17:04:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 16/48] KVM: PPC: Book3S 64: Move interrupt early
 register setup to KVM
To: Paul Mackerras <paulus@ozlabs.org>
References: <20210405011948.675354-1-npiggin@gmail.com>
 <20210405011948.675354-17-npiggin@gmail.com>
 <YGvlguoc6IjjwybE@thinks.paulus.ozlabs.org>
In-Reply-To: <YGvlguoc6IjjwybE@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Message-Id: <1617692548.qxsokwkl3x.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Paul Mackerras's message of April 6, 2021 2:37 pm:
> On Mon, Apr 05, 2021 at 11:19:16AM +1000, Nicholas Piggin wrote:
>> Like the earlier patch for hcalls, KVM interrupt entry requires a
>> different calling convention than the Linux interrupt handlers
>> set up. Move the code that converts from one to the other into KVM.
>=20
> I don't see where you do anything to enable the new KVM entry code to
> access the PACA_EXSLB area when handling DSegI and ISegI interrupts.
> Have I missed something, or are you not testing PR KVM at all?

We just got rid of PACA_EXSLB, commit ac7c5e9b08ac ("powerpc/64s:
Remove EXSLB interrupt save area").

Thanks,
Nick

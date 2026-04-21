Return-Path: <linuxppc-dev+bounces-19910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEEAF94CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 18:16:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Vsz5NFlz30Wd;
	Wed, 22 Apr 2026 04:16:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1336" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776795383;
	cv=pass; b=H5Ae9BvPBtQHSN4oqJl/L36NwcStLTG6WgkPFn9ZrRIAO0Yv/MxtE7HhheijQVK9eT4ymXZZOC4WTwEk18ttrzEq1BhDK2SngJUBlVUbTTcbALpZ6KH056bDj04Mv+65Ki+XvXDRQUCTv0YCamqn7+VdtT+hqU0zqHp7E5mA2NEKrdg+lxu+h0ZfzorY/Tg5rkKCGb2AJ5l3bhcyBSNPmMzVUOR2mKYcqA0CSKPOieZkwKeQbTety/45d0ZwyDQ/KqjMra/3sr/ujdEKbaAQMn5yzNdJ7PvktYwVprkD3h4Ie7nr6+h0sTeZaCu/zirbSuKf0KBfbKR4vMq1bMfUeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776795383; c=relaxed/relaxed;
	bh=3GaZDx0rQ9Fksiy9siV3i5pz9Hl2Ce5uUtde21t7sAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkBtdhbgIvqrc33MleST/64zI53T/Z1lFl6/x25AAq8a59qWBJ1Up1wRzEj1asBR2QRvmFOrgV4yLL//vpQiSSMNlxdd9Z52b/X9FGZMKUyESbXSinqqwSLFXrqmnPACc8LPvCiUuvH3YtkkxFeeChUIPVpvHr6P9/M3nTNS6d2LYdFae7ny9KjmKqIkVQlaQFn2l5qshdHjIgQ12Upd00OMJCB9wVjBfyaW3bcmMWDRP7dRP1xFjB/5pAjdXIe0DXJoxDL6xxf+l2zzbSazbL7aUWSJF86gjpUKKdkNEVVMDYP97xadTYr+ksEQVfAOvw2ov2/jhSRy03QgeISQqQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BurLZPCx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BurLZPCx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Vsy69sTz30Wb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 04:16:22 +1000 (AEST)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2d9472c97dbso425282eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 11:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776795380; cv=none;
        d=google.com; s=arc-20240605;
        b=Uvx4dplX2oQ8zc/5rwG62wIZgf3rFqTI+bSfYQZ1RGs57Df9vKoBl2c0sWFY3BJhec
         UHGWnduIXBf+HphNWywz49EH7Rw2GMBX87baNmthl+Shyu/k3gGH9mKQRxG/eCG683jd
         4iy6XPbYe+trcWY7gdLmsHLjqjdhz5zBePw+V0DwiENglhiNofiNS1AJlnHd4SkLrRdv
         9KshtKLi3MiFhm/Nx0GBnamaCycOayx+Nk/u+SIq5oqrIiS1c7sHPO1Umvyp2YUg6BzQ
         ju/N++hknbbKkWyWCTIrF8wI+F0nurwl66hBGXly4FzZSYlrmdw9uxaHvBh4OiTuUdDN
         tYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GaZDx0rQ9Fksiy9siV3i5pz9Hl2Ce5uUtde21t7sAA=;
        fh=GFGXZR2MCydPM2U9Et89ijf2YWQOGACWrcLkarWosgg=;
        b=QykUIRzKZEeNJoNQW+0Qd7kCYZ72kgWFSLzyYkoc8S75/No4MdeWVlIjkfiZsHcMTS
         Iv5vsFICRAISwrgK2QLWMakpyKtpJTTdH2nDb89db+GghK0I032jR/Xff+3CMRLOHbKR
         ut+XcUHNm71ycU3LNZSn9XtR4FYTFagSa/Jnf6nbSjMyPXB1fvs1tVvvDpR6xRfKWSep
         i2V7aDHTEEm524chJzforp9M1Qk0vuzRHXXbr1OgA2ZAw895JvkBXZ4B8CVrvfeXd/VZ
         +7o6OquuaA5cl8jOUHYrGUPrXfdnRufm7hyknunlPj1mLL9oNIkT8WsNDrJKd6xxU8oF
         HrSQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795380; x=1777400180; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GaZDx0rQ9Fksiy9siV3i5pz9Hl2Ce5uUtde21t7sAA=;
        b=BurLZPCxVOHpW1fOQLiWGQ0y3iMN+Z4VP2+4FXYpGxpHNeDW3MJeK420CcnthyTDVy
         Ecw80U7ZlZchvMURCSL0I+Dw3z/Yu54g+S7gVBfq40TTKmTqBQUpSVtAyRLhDQEhKtyf
         0u5ErY4SuyyQWC3pJXT6/gmOVccnLdyQ21i5H7HxRb9JbDHihhJgiZdFJd+SryMV+axr
         xBWsVT9gyiRfmKrSOIQAKxz0u0jph4Z32OHGfIcExkZswf+wMDJYUix0s/ApV+z5AMRr
         vDqY19qShX/ScUUijf3MHmFuBpFiJyCAkGN+xb27Wn3FL7z6MBROKRIv9EmtLQHu01YT
         Mstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795380; x=1777400180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3GaZDx0rQ9Fksiy9siV3i5pz9Hl2Ce5uUtde21t7sAA=;
        b=ZoNA+JpkusKW6Uzopb2u/B9UDlIG4OTEKMBLDK5E5VPYfsPppdIubdwhERNdJmTdj5
         qil5wt2cNlKO7jOR3HxV93w+/4maQMKot2l+m08iTtV8cwoBAGbbvjhI6On3dmeI8ltA
         Kr00tXcaF217J6sW+OJeRJRPN4lnfy8vLddWFkAn3q4VO2XXlSNTmC9X7ioRhhkeYtUU
         QzdkRD4opAYqM/jKzI+1tzNq4Ctse05gUGygyy9fmQKQktLwnm/2fRjPowx+DXLcX1Pa
         easAtJ42+6k89omCjrHuUk66+v8lHFXETh3Ymp75NqjK6i2NOHnNzrnOuuMtBtU1QWbv
         M5Rw==
X-Forwarded-Encrypted: i=1; AFNElJ9u74tT0ldPAQYahHfXNBLoRShDXim5c5Yf3g27KiGHLbhRf69aM/D3uJ8FKFbzc3+RCXun6twFjtwPXhc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxeX/57Lnqxm8R84ed166dJ91jzMNVUsmz4OzP6aB3uELY28oR0
	YTNUDz0Wkf8eWBDh4u6izJaIvEpRi5pZ7GygRoNOdU1/1tN1F1DyRhup6SqmyLTZYVrQqwiDeHa
	xZHPGMKNZoTOQWXgd9xWvghqdGli4gMg=
X-Gm-Gg: AeBDieu9ydFlS1lsWluFSkbMef6KakNJZ5KX8HL16ejAp0oTmhJqcyWTAialVY5Feif
	3hFI59Y72HajLffnLOcwGvZlbRLwF2bh8kues5lIp7kXQ4y5HGwlr/GfQES/cnzlbL7DcsI/cH1
	D1iamHG+bIqfHZbQHEl/1+D/IqWDGp14N2T38TwJBXjif6sezVCIvpOHZVR/bMhAlhPoCK/9dbe
	FSbaqyCGtQl7YHDpAyIdoUH8TLuVXF4o/ZzdgqdYoLxzcBMqv3/hA9OxqDSqGtgfjf5Ypgaz+G8
	3AJ2toW2k5UI5vXC2DlbqcL4MH8Z8KjfNrND24dKvhRM3pd/9oGvn3mnfK7GXDVUYyQPp3DkavA
	ep8gVIZGiphI2kHCTwJyxYMSckv7iEtgiBg==
X-Received: by 2002:a05:693c:414c:20b0:2e5:5bf4:886c with SMTP id
 5a478bee46e88-2e55bf49d87mr2808147eec.5.1776795380309; Tue, 21 Apr 2026
 11:16:20 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260417152253.2312961-1-mkchauras@gmail.com> <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna> <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna> <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna> <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DHYYG7A745M5.VQY4GMDJNC1Y@garyguo.net> <aee3ivM9VkbqdQby@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aee3ivM9VkbqdQby@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Apr 2026 20:16:06 +0200
X-Gm-Features: AQROBzC9mHOnbDZIzSWs7JSPScbJTWmOkJB9BCTbBPzo_hv4xsJtqwnMLc9zKx0
Message-ID: <CANiq72k7HXYE+1hhbT8xfL+pwhBwVqCQaN=1xXUuTnMhH0J7QQ@mail.gmail.com>
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Link Mauve <linkmauve@linkmauve.fr>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 7:47=E2=80=AFPM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> There are some other build errors apart from this on 1.85. So few months
> back in the meeting with LLVM team we concluded that for sometime
> powerpc will be ahead of other archs at 1.95 till others catch up.

In that case you may want to modify `scripts/min-tool-version.sh` in
this series too.

I hope that helps!

Cheers,
Miguel


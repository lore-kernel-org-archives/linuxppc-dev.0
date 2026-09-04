Return-Path: <linuxppc-dev+bounces-26526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95410C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:14:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmPj1Mjbz2yHT;
	Fri, 04 Sep 2026 16:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502441;
	cv=pass; b=gkxb+nr7f9PXbB2FXCbLBbNRQCR5pWOLsI/Jm4N2b42ar9VbxqUd71VaEuDuvvAp3dKeELtLnUq3qEHZXHfBaqemdzVsL3Knuffrb0LqJ4MPOn6fdJqJL2MckmmjAseCJyPCayD20Dce1stfjDEthXwzyiedDe2oZizyZhpbMi/aG2VOjy8IkQSUaRdoM1aAAAh81U9crM1qOJNg4AcdoYXG+5ptEFeoUKSxfj1v9bSxtloZmvAxrWhucq/QATgIldhiZzt1RPtZKLyATkQcNpJoj8YChYrtXIRa7VzhguSSSQ1U10lySf6vfWNKQTBpA+E7K4NdUdecDx4qGqkzAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502441; c=relaxed/relaxed;
	bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuLxdsxIMPBr0y4Ei1eNniGVBFHiYsSqumlOXERA31i8nsEcFGtW0YNkDZkmUWU0b0R0rtnkJeIfketQQsaa5Kn/rqOljvxHKZES8BnnP5aB//rX2aJBQh11W8NGA6bYnf5TSSImlnaBXUeY542FuqeIwgpUxMatEBacZWXy4VPosASy6MUWxwFbwtfeH9V7q9G2dtpDyxTix6aJrBsKIJzy+JUtcBAR7Uu0G5996wWbP/KOx6SC6G++HkLNiXnXSR5vMJwXPjzYgHqNkb/jXc0Wq6arGmV80ikuFKPWiKaP/dxuCTH7kVfra6B3ub0yXaC1CQQudA6KdSS+JOPotQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WL2BzBsu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WL2BzBsu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmPh0Nqnz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:13:59 +1000 (AEST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so872260a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 23:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788502436; cv=none;
        d=google.com; s=arc-20260327;
        b=X/BXknPB3GDkUg6/pZidPbiWOET/3rH+jARYFIQQ1BCrTzM3IXnYTI7D13rc6aQSNf
         jUgaWjpj3kTS4M9Cxgt+JfXlybQk1TY3P4S/85lpEK0SC1pTp86q/7jRPzl5mWNTNtHW
         PV4/e8BLX6HV1AKNLFqphXhT/RiJBTkcCSH9UJZMOPrqYSi+R8+gS4GOb1j8Cic5WXVm
         P0sEO2Tz0PUh5kTCyuN1UqEZe73TovvjZjs+UC+mROxkgpbtFfGhvG8KCsDRg4eauJ/W
         nyE3tiYWX2cWaNGPyndkyJpiDwkwA0Iviq3+5S6qhCr1x/U0hW4nQtHlHyLywuUYxdN0
         LQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        fh=5dYHDovaM05/3AeflwHJLvDfhMV11mMPirPnrZWLFrQ=;
        b=VOq/nd3Josa8my7VasbcDhQYVo0UZmD2Bd9JVcsut7niC3a72YPAW/d6qjbsGmRNjE
         8EhnxE70XuzQJtBrFEktTMirLznHNAyp2l1W6XE12Mg+Y86MnTEYa71u1XC+gJnkRuSy
         JubuOijtwqkpSulkbI8KRDrmsp2jqt9UHqt3WAMSCWTZ4ENjMatXElgYhBEY1DDioNqQ
         6Yutbr83AmPC5VtBeyLmcY+3jNc4U4Xq9tEx26iF2ufytmSFvyfjbR/pwjGIrsCoaA/h
         0zcL9Nm0DTnnVpgnP6onwIMK/E1VpYK/xFIfPb+qyPk+O7mVnjBwZLIlFl1+Xce9Yus8
         FY0A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788502436; x=1789107236; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=WL2BzBsuwqdJcYtHSghv7SRi35UeA/B59vh82gZJs8HsSufVSo9l6ClWI/cpLhLAO/
         01ppAkXH30L/msXho3Pmk9Jo1B3u7I45ppXVnfA60XD6P08dIrn01t7A5FdyvlIrUCKk
         X39llKD0AYHie5GXV/YJ6kRckDBdP3vVJfGcrbl10gitTtX6F8DTdPrL/5fyhl0eAFwf
         VV7bjKwBrlvk86yy7N6D+hjkCOEdxEaPj03SS75U04NvslwFjDnA6tHQttNLAHg+9fnY
         5YlZraczaIGRIeg21rBr8l9iLj3OqD/5OrQw52VFgOkDHhHMbSJMpJpM+zQ5iB0Gvl+C
         EslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788502436; x=1789107236;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=hHSw/BzkW3bGkMJONiQW3AgW0xlXYTFKV8ZmCgAVVbr75CUHuTQ2l1uXV4w8NBqcll
         cP7Kb1E1T6AakA88VjJSavsisGpdPThdlgDyKcBs5clildKIED5xH7mWnKbHgHRPCo4C
         BqcesvJAQZMWzqhl5vGkxu+Bbhu4B8M6WfHmqPqcaf+pND/phty3Hyok+ZOEKIdvTJtl
         rDwJzgDlg0ShnYaNxv84nSpo4nGgD0Ly2oQ8rcrfes9ntpBMHsJUI2qBjDVasIQvfjx3
         5wiey83Z94dx6HcIYMovEhMwivCxj7d1PDycKFA+3ca933krtVEM2wKlRzjco7T4H0sM
         FlRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwt6SW3+sZFEzMjliNBxgzrvReLHf6zCiJM5aXlMlPzXXpjA1m6nkBdOosDTTT8XTJHn/aq6AMKBdwPvoc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l33IgDxp2JT9+mb6uU3pmma3GII+vjoBdsBbGZMmG6Fx6AeAHy
	lKPdlAN8NRtT2xKiTvcKQyDWpIjckduH1LQCRxE/4lpD6MlJ1xIAiXZuy8PbBEAs+5NoQFcBM3L
	l0In4nI08b1kxND86V9A+vkRxxy4kJBI=
X-Gm-Gg: AYBFou0nuxTkwkKB5Dikz7uS6KeeqYEX3rlUORQhYvmFUXPT3UqXzJz8ao512zO0h4g
	IXlbFFRxIDZ4rdXe1PmpuIvuxf+iPyn0xkMPJkPNE4IEts/XD7XPBRqemjgViKwbqA7gm9CrzmH
	3RtpPbx4athBEbtkULc1ejJ8FIzKxsv5fC0RgdBZkbPGAncEDPwZDW3TbVdnqIb0XLtnVoduUsU
	fNJlGjlIT1JsIccrPWnt7j80Nz9jH2ufW/CqgOa0kn3bIRWDsI4L8jAUNkb81d7H91C3fDN3DTj
	3DLWNaueM9h6tEn8sqIFDXh/wuNmZce0QVeFgQAxmULLjYoILlgJ8SF8TKS05AiIUmTuH8QdvWH
	sQukFUg4ECkjiATjotbS2UxWZtS6xfjQ=
X-Received: by 2002:a05:6402:46d0:b0:6a5:f44e:a009 with SMTP id
 4fb4d7f45d1cf-6a7e8d5a9f1mr1690015a12.7.1788502435914; Thu, 03 Sep 2026
 23:13:55 -0700 (PDT)
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
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com> <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
In-Reply-To: <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 4 Sep 2026 08:13:44 +0200
X-Gm-Features: AcwNN1VrnhEuSNjXaQkRHQ6SzaIw81uvdMaGdmatxDoxs1iIKPoZwAWCS6BhE2g
Message-ID: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Adding Michael, Yoshinori, Rich and Adrian directly, although this
is an alpha series, patch 3/3 also touches the shared soft-fp code in
include/math-emu/ (op-common.h, soft-fp.h), which your architectures
build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
includes of those headers; parisc/m68k/mips/x86 have their own
separate math-emu and aren't touched).
The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
intent is no behavioural change on your side. The new guard it adds
in op-common.h is a regular runtime `if` rather than `#if` though, so
it still gets compiled against your macro instantiations even if it
should dead-code-eliminate at -O.
No action needed if it builds fine for you, just flagging since it's
tagged for stable. Let us know if it causes any problems, or feel
free to ack if you're happy with it.
I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
Tested-by posted).

Thanks,
Magnus


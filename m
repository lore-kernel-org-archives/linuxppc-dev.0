Return-Path: <linuxppc-dev+bounces-22496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B975BCD98CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:34:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gblXw6WMZz3brC;
	Fri, 12 Jun 2026 00:34:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781188496;
	cv=pass; b=kjejfJ+YKPC8CmKvGNpCknf5c9ChpndBBj13MbY5WCzagZ09/5MtwacpdaqIXP4BHlH0ZzeSCsriMZcqVZK3UWoCKgKnTg+MpkGYpD+NwfUcP1mPuH+ueUdbM6QZbq9BK7pekXmMNTjtExXB71Wn2rtOubi5RWQMQ0y8orAPUC7/HKDYAlc5W/c4Jn7tU5Qjuhsyfu0roW/VAgpR3utlWVwHp8oEdT3ToObANgj60w0C/TF2Uh3JRMiktXL6qL+xT40KffTn/zVIkybjHZISZHbMFnNiqoEs4RuOxHo1YJeyOjgzFoLOnTXeiT5M/wQugtGlo6bh0iP3aI9HS1yIYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781188496; c=relaxed/relaxed;
	bh=ut/DfUchADgor0Cp2q/aAjkhxcFZIOC7eymWGcDYKdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoAXYQQsi8xJpF7XCJ6daP1Deqxb5UbI6gz2dxR3hfHKovm1MNarzq459IviFn4cB2Vsg/JhEzhrSttge3Qnce0Rq5w1d2J5JZAACTU0o34hhsj8CcV6JYkHisf8QxzYyc6zMZUp6RLVxkM2FbiJv3WB//7ZtPCIzY7lp6OtxxZFgoNELJTSiwb/yM2UKYTGrOnWQgWwR4wVF1DqCQegF4QTCi884WJlLgE886sFZISJp0JImcou1zwdTt3XdZN+dj5APAyOSaZICJRyErrcUGtsnr7Ch+Flp2Fiy5x05Y0lqBkumGi/b65cl/7X3rLXKx4SCU66Ud7Avb/hc7/Xog==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWLILdL+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=nphamcs@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWLILdL+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=nphamcs@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gblXv1vxBz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 00:34:54 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso4262220f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 07:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781188490; cv=none;
        d=google.com; s=arc-20240605;
        b=C6FY25C+BuTalLx8AQgesKMQXEwl/HcU2Q5jINAW4CrW64TJAIO0jy+tKAT9S8qcMN
         TWXlZMCMXWDwp4h3k9nwuqp9j4UNu6LywkKG0KuF8/lVki67LFwqTFlINDC7iFeABhLO
         VRqDx3+GheFSzL2EMY3T3ZKQOkCToUxcjr7Oai7pEQ5pBQJDw2oRuVvJe1yZgW83cd7A
         eVPciJXOBgspdKk5oT3TUIcDI06Rt9hiFQjKEnYJxLshkneI5Di8hYmF/n/2LxEmWuYc
         TI8oGvjA0lQjgsNL+KSQMg+rNQE8vyIpemKUlltnqO6ELGNPgufQrHEFLac1fgQuaaxj
         Pwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ut/DfUchADgor0Cp2q/aAjkhxcFZIOC7eymWGcDYKdE=;
        fh=yGhglKV9HSka+BPMG2Z5QDxgXMcEip24oKmuSoA5VWA=;
        b=HD97AdHJfpy5wKI/l8yktFmNEtMZqoodEoD/8rirX2yVIFgN29ghQPQ5jSh60pwwgU
         us7dzGGd/8aJiOYQdSCrkGac54TrK7QuyMf2GZh2WbRkuHQc2DoJfnK9xims3sV5jLRk
         25JvVncWGJTNegydct+lwfuDyqJO4/p3snk4S5hehg1Vis4kHcvV3/AGZQTZHtGBO8CO
         +Yg62PKqYQk82gGW4YJCANWjXzsFu1q2UzzPM5KpdRNY4ilDdXK4eWIBAv5k3jOJ9Q71
         clPXm3ksoQGYfBNezfDqNdAx+vYAhWsc8eYgE2a5JDiRIOdQfNN8tA4YUhpeUxZI3fUe
         hkdw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781188490; x=1781793290; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut/DfUchADgor0Cp2q/aAjkhxcFZIOC7eymWGcDYKdE=;
        b=GWLILdL+NNy1qsK+aX49Su1/Hv/sw6gMFPE/km5BYZoA3PHsPh/dWF+WoHwSVXSujb
         na5qcJ9oQp5CxX8BGDV40QpKZ86w6pdI1aMusfPS6ukG6yPtiacJRlFGWp/zJ83F4Dcc
         QnjPtl8qggT0WzzrotHzMiRiWnyMloDRElNcw80LgbQI2XQ21sCWZ4CSQT2m61Gh2sCG
         ZzHqQNMf8TCflmFTx2HnSexG7MrrI1lyYEgC9fKB3zS+s8lalHUxmO+zwq6fmgghWwFq
         RqjrJr1bwbrPy18oUyv+X9kDJWGm2+LGmIZTap1Oh2lnGzyKEc/O8rtvtnU1oAd6cGBA
         71DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781188490; x=1781793290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ut/DfUchADgor0Cp2q/aAjkhxcFZIOC7eymWGcDYKdE=;
        b=FWHj1q7L6G+E6rX9MuXBiVhdIQgnQzs2t1c921Tmr9CkW4GUGqshMKzAFhtR1ph6pB
         i8V+LI/0Hj84noOY6jSdejRm0wyJVA7KEmWAwKf3wdKJud7iz2CKl3ibjIAK6r0EE2+W
         jTO5f2FELDFpDAT0SN4ghon8ZhBJ6N+ABKpUI1bNid/dS4i+3u+T35rSnl4S/3sF2AS0
         XDjpmuvHMDxXs4tFMQ354qcaSDBbWbwGRkTY14nWmLIf3T8Z2z7G3xV0C7T+o6+n56uq
         XMcJcBLqOWD0pvSss4tUPxIUGxvGDnh71oAQFUQG83C5UsUVoXR8nOkt8ab67ALBsmW6
         8gEA==
X-Forwarded-Encrypted: i=1; AFNElJ9U0/UgUuvKpiyC4AWRtefGDEW88ArZURY5G5kzPLsSEM1qQDfnQ2F0ESCOtEPNwdIT9Lo6CLNpe0Cao9U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywd0jRR5XXDUE2bBAqpftHDIw2PEeEIYeK0/uy9ww7bli9h0KFa
	9FkXgx0Rp/iFCBKVXNafAGPA/IAV3IIkUGDnU2esGuXUIIamTMhuua67nliJZ6f2m/6oEkpVLSE
	wEkrpwqQ0QPYf1T03k2fHWwfAieHEfyE=
X-Gm-Gg: Acq92OFON3BoQG3yGch2TfmmC8umZaAycCEkqhFpg8Fd9vCrA82DUfQv/acb62Q43H2
	hYUTo0gasgazD+KEZH/C6GyBfFDFy7zV2lP+ZMBKvR48t4agLMqv1dhkhc76OJ02OkrdzT+1u4m
	1AAN2b5pgqrZfF0ddUtUiEv/1wt8Ys+jPrbCYTXMmLxX+Ot2D229e9I8vf8cZzMYAs0l4Z7HA7h
	tA4m7VXvi3XhXgQmUIIJOsLLvsdvYMqV+JB0Yzepnbr/YKlbzWv2tRG5dEoeDFQvwFkI/Qwvxit
	RY0ZaACWXuX7PymZhAv0qN/sseyi/1H2lA9eVyfMjGFoHI5ITBl2INrb/1SeSbr5qw==
X-Received: by 2002:a05:6000:4601:b0:460:1223:a044 with SMTP id
 ffacd0b85a97d-460673e4332mr4735791f8f.0.1781188490040; Thu, 11 Jun 2026
 07:34:50 -0700 (PDT)
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
References: <68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com>
In-Reply-To: <68591daf0d679e5a0072d63751f187d14613e2b0.1781146877.git.ritesh.list@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 11 Jun 2026 07:34:38 -0700
X-Gm-Features: AVVi8Cc67aBqHzlDAuJ0qAbJB0jvuy-UkqEt02YoWxrCpURlNsgxYvsvLcCS2fI
Message-ID: <CAKEwX=OvF=8TAgsA1iV35Si4ABMnFNa=XUp8JCz6fQM5z+4x3g@mail.gmail.com>
Subject: Re: [PATCH v2] include/linux/swap.h: Remove unused leftovers
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 8:09=E2=80=AFPM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
>
> This removed unused leftovers, most of them are forward structure
> declarations. Also removes SWAP_BATCH macro which isn't used any
> where in the code.
>
> Found these during manual code review.
>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>


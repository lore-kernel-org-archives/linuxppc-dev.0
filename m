Return-Path: <linuxppc-dev+bounces-23703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1ACC44500
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 13:24:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvhlZ3XS3z2xWY;
	Tue, 07 Jul 2026 23:24:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b135" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783430666;
	cv=pass; b=eWNUSRCSc0zo6358C24MtkkvuGyNYAhViRS5R9vkZ2KWw4lcxaZZw5sPgipumyUHvQ1uki3sVQF6tdIwvU0fMXATMhpI33ZnIbR74WQw/Zq5HFzo0kd98OB2f2S0xL0CESqxeq/AngH4uTMsq6Df9jEnFOANU3FxtdljBZP1MAYblOZQEnWuiUR33fRWS0BYXGR4EJswzppmBBxdCA/7/fNDH9EJ0ZWsHSx5xUa1GpKnyn3yoMdvV1on7Sxwnj7HuBdeGWrwulumq8HsLHyMORAzklPr1LFvu/BYwNb+ko+S1OoUDZWH5WOoOaWxupc2FY98TOfzFerxmTXvP5tulw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783430666; c=relaxed/relaxed;
	bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfNwIjyd43tQpYwMQAVANuc+K460dphev5nym0od6KmySFepbAuqGG+D53fERh/0YpWDnBAjYK0R560kj8IK5oyXidnm9Per24JYu2VP4+7zJGmH2vyLLt3iUDJgtNomKCvfMqInj42/YObX/oJxGZ7Rg60MboVcDFenSmDyNYKk8qTdu4slEbMpE+THZ+WyqhIiYWHFzxyQLqsOsyntOS3fSal7A3b/eLFreIbYOgPrx9xe0L9naH4+Zi8AB94ROYRdSR5jGiv8v0TuLz84kfma7KwVFH213OiiTDzutEyYF8t28jVTAhT8W0PgpRE9N3knUHr/TPk6T+2V7eRJ7A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b5INa23w; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b5INa23w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com [IPv6:2607:f8b0:4864:20::b135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvhlX6Dmrz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 23:24:24 +1000 (AEST)
Received: by mail-yx1-xb135.google.com with SMTP id 956f58d0204a3-664c6304683so4052758d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 06:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783430661; cv=none;
        d=google.com; s=arc-20260327;
        b=sDuKoEa9CH0AgIhjqnKHF2xX4XsqUDUuyI3hl2chk0oN/q+lhRbx1y0VNwJDsn0CIK
         9FLBUh2gh5VZftTK0kItdFgixhj078BY61Ak8tfG4C/MLsRuWO9zQ1jArZxMey0ux3pA
         hm5lriMul6qPxM4DgEzW/H8QpZcWAhmO/jTuACHI+RxNKK4BpT3q80H3Gqqj6pZW97B0
         HmxNIqTOg2qS/3pAG6iZlcQetBFGQmS4SFItp7otJyOAwm7LwS9GhdV0qWoukDaFxVm8
         oNXgmL8I7SpX178NZ7N1qcHkbQkMmNb8jRRpiZW3PcDirqYY22zK7upBtTPpNFx1JHT8
         TGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
        fh=E0aX/UjUUeaOCUwrO78cK7IA35kmoJX7bdrK//ksSM0=;
        b=RfENlsfMuhC+MNokmQhWa9JdeQh+bpzEaCkm5x54kFndKNO8Wo1/XQgd3Q7xRHDQLM
         mwyyH24yXCd2RBqAonuj6nXWzcO+UHK4IqIYnzxQXuAvkkhnCa9fOcGjv6+4gguAndrK
         pwg1SIodqU0WnpIUowG5WwKitn/RbvDsTpxrKxD286xTAcrSfznKD10FeT2xq77a4VSL
         O84NTO2wkBFphq+0rLmLHVZAs7zN73mXikZ7dNP7cHTVaA+OtoV5kZOv5OjBQxx4zvTg
         O8B7vJv+vTk7AfT7UkLZlCqT5CIXyhsR9dFaOKtncJ/NwSR+Ab5kkBQVZz3UNPbTwfj6
         zofg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783430661; x=1784035461; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
        b=b5INa23w377DsaNREeUVOptjqO+Auw+YCY72ND3D5SdyyHX5GTVx3d4q5VrqhUXAtJ
         RyDa0NW5zmVjAEKqfRpi7VmtLXNCG9XSuLeYNY75QTWQ3N8JC/Rpbqyl1RgbtIVQBFxa
         JuCm3qSeRMcHHjm5A0qzEzGEPen+weNYpzCeT+F0NGJWEqC6LvDWcNI3jhinsA4UZ0uG
         U8m8MHAY1pxLfAHRBLUJmybUY9P7RHW72zn0iWCayPsXCcTzD+TiDSO3twbCV4osndD7
         QkknHIV5mLWb2yHG52m14aZ58Ndk+VkPCWOuk/geB15YIvcEARUtK/IGdCmywebPCUZI
         p+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430661; x=1784035461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
        b=TugZUtvG4KYUtifdnjGlZy3jrHSrgBYanyBKOrZYx+3N6d6tynOlPmEuVuZAp3XYhx
         1mNYn8CLVDjYGl/IGsqqUl3Yl80Q5sLEP+nwqt7szUjP7dpg02zFj8wX23VdP4/NR8tW
         guroicMzQV7GX0TGKdYmxPp8rNJnPpGQBGIA9QiNWwBSDv7Vy+IJh6EwgHqlUbM9+njX
         TiYJKpxJ/sji1Icw+Be4TU3TqHpEMLLI5X2yYlgDPU++AEKFHmw2AIBKasqufmXNCULx
         k+bUFLN/2Tp8ue9fE3tzXXOVOqkYhYlaX+bwHBcKKIkIzisMpRa2e/ozIS6gUhhBxtK1
         yoPA==
X-Forwarded-Encrypted: i=1; AHgh+Rqqs6+qOmRPTQD5KMAKcCtaXoQtLkZV6HeADeqw/k9ZgLhUeAvhLC8icifWydEcQmCHEdZnjGQk50mKdRk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0ng0GwzxhDCwY9rcf8Re7j4LQaU1ve4FAmmL/a8dB956A6j8m
	07aYUi0BdEz6Mk936QWtOxZ9Syuq/V31Wgxdw4MQwk6LMaGj1qje9pclC2Wkk6UnZ77ev/hTkEZ
	YZ49Q7zChWQKVRsBcqqf8ycP5KVCQwLM=
X-Gm-Gg: AfdE7cldAxIJCkPv6L6MH5I3NG7YeTE2hOie+drhITUlZTxF0rkuFy6B+4iqCGTRob8
	xeXkdKoyzYityAh8ydmsY6tQh79z1vLl3hFDVJF6XuXqKvxnrpqGKskMrtLn8ivoCAu9ZVWGmui
	MqqiBYvAoV7XXLrzOhwe/LSkL13WvwLdKyjrcMg8I5iysFBs22ENKcEuAgOThzwdzf5809H6gN2
	kpYcvQSkBMvJOIYmp928jzETl951vGPfDrdPmdDnBsVjK6VyEkmrTuerfDZpgvAqy6mmw==
X-Received: by 2002:a53:adcf:0:b0:667:8b90:2ecd with SMTP id
 956f58d0204a3-6678b9053c4mr1264848d50.108.1783430661475; Tue, 07 Jul 2026
 06:24:21 -0700 (PDT)
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
References: <20260706163753.193875-1-ekffu200098@gmail.com> <akyZ5DhIV_Grn1Kc@kernel.org>
In-Reply-To: <akyZ5DhIV_Grn1Kc@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 7 Jul 2026 22:24:09 +0900
X-Gm-Features: AVVi8CdmNSJCGxYOGWnK5wJL_8NTvAWhpJlXJNdpTu_SgODQvmfDBt7ZZCk7fE4
Message-ID: <CABFDxME7ig1SQDB39TUeUXoAOA2jSRhg6h-bm0kUHrHzGYeE-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] treewide: remove unreachable memblock_reserve()
 return value checks in early boot
To: Mike Rapoport <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Chris Zankel <chris@zankel.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, 
	Thomas Gleixner <tglx@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mm@kvack.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, Jul 7, 2026 at 3:17=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> Hi Sang-Heon,
>
> On Tue, Jul 07, 2026 at 01:37:48AM +0900, Sang-Heon Jeon wrote:
> > memblock_reserve() can only return an error after memblock_allow_resize=
()
> > has been called. Before that it either succeeds or panics, never return=
ing
> > an error.
> >
> > Before memblock_allow_resize() is called, the return value checks of
> > memblock_reserve() are unreachable and can be removed.
>
> I'd rather keep these checks.
>
> Removing them relies on internal details of memblock_reserve() implementa=
tion
> and the existing event sequence. If the code would move around relying on
> panic in memblock_reserve() may not be correct.
>
> And the few bytes and cycles the change saves do not worth the churn.

Makes sense to me.

But most early boot callers of memblock_reserve() don't check the
return value, so I thought we already rely on its internal behavior
anyway. So the few remaining checks just looked a bit inconsistent to
me.

Would you still prefer to keep these checks? If so, I'm fine with
dropping this patch series. It's not a big deal :)

Thank you for taking the time to review this series.

> --
> Sincerely yours,
> Mike.

Best Regards,
Sang-Heon Jeon


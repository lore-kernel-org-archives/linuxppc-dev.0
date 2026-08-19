Return-Path: <linuxppc-dev+bounces-25973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DAFC5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 10:02:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ2Dh5Qy7z2yCK;
	Wed, 19 Aug 2026 20:02:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787133748;
	cv=pass; b=LRWm70U74sPgTbVEGWVJH229umKb6mjS+iT3o1mr2EtWF+1dfWJynKqmb0r+xB1RVO7QMnWW7aJNuDiruY6dbcXWxmoDVMnD5Pjo/roEtOHhYiU5flSSdCni+1drurCbbWl8K3vfPZDcHRML+ccHI4XNnEQ42bGzXZ6dNiD6yoCf62CgrncRIL1zdN8ftQpWJmrqaPM2kQObPQbcOPEhCU81Fcp+ksUTKsvAqopoe36LxCv5LwC1xbx/O4ql+p4f0UJtDVjqj0Ko8x2E9X3uP5I1FpANby0Lby9w/Vmwk74FbhsB3HlOHrj/8OuhFjt+s6W+jBHdqCvNKggH25tjZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787133748; c=relaxed/relaxed;
	bh=e/ykeQ5QUSsTkkdxsh/CxYBDe9VSjwD6RqDbgwXYXlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNllasSJOLyVpW83p6PxQxa64YDjfAieNNff5TrDBVQst8W9pFhYYR2oSZDMIGpjzEaAXJgRBOIq98VMhuMT9LFcotDWH6G0QGCcumyf5V61hA1qY/rCViXvLnFeQGTpj+9dE6riA/4GL252sMoS7ctK4BvasDOy6GkPJtnMuKhcI/ofyfFYlyqkMVI5S/yafLN1CaJM46zDra8Pl2jayt03SQEqDzhyLy4MmHHPBd7dozuLQY1zBsjPOuhL6ktewHHOwo5qc5wLScGIprTMOIJWlX1pm9zq+63KBdoLl1sAIKPOgKbvoNrgz0FETwIQYW9jMCunLud3QUOdq8PLLA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eECfyupt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eECfyupt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ2Df3jmkz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 20:02:25 +1000 (AEST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5b477cb1f0fso100913e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 03:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787133740; cv=none;
        d=google.com; s=arc-20260327;
        b=SNzYBItsYFqLCDw9p5DmuAW4zN7nglO/keV8kAvpSVS5D/kcNO0sq3fGiAjZuLdptD
         po5yx0m7wuvr5HYLthfafOvXkJYEg/+olOtC69a6bTU94pyiLDB23PY+bsEOQaeSPqgv
         zbgEA0ocNPsmoTHzfgVwSKx0TQruc/DP7pPJJ53xM/inJIznDv7BfcAByen9kAVUgMAs
         1chBJOHVK8VWV7Nadh8kMmUiCQZDc3iZ2yx7hRPObgSxH+4j/rF9iNy3+uexmJs+QvRm
         ymVAl6U9RRUCwV1okyn/I+vComwjOcYyfNRV1NpEUOJpq1XZy01jaHibcl+B9x9nyQL6
         8rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e/ykeQ5QUSsTkkdxsh/CxYBDe9VSjwD6RqDbgwXYXlM=;
        fh=ODL/e7TBRklEizXJoBLNOwxJGeODkctw7tajmiqPs54=;
        b=Qq6aMLOK6eN+VcnL7JchmH2UW8iwFc3JMmEantVxAXwFCC+f0pJR0+gvMLini0v7Fi
         rl03giyon7v4Bz4Xs6KeIPvBm9rAysBFdIpuCMmO7TiHSRiRHjoenghi8cinQiBkvcnK
         X7TtoGPh2PTxw/HdhmZ1mdoT1C+mbkO+wO18Ej/LgOBKwDNcufnC8ZMafgsc3LnvZj1a
         WmC1kTP6NfBpqtVpBCR5x+/dnP6zrB8Wh1RmcgEbVXriHzlCT9ki1u6C8jYoNmZGafAy
         YuS9hsIkL1IwksGkodDLqTmT67Y4JSeqZ/r+CBygDtnh2LC8akWnyCjuGXTngYsZZ3Y2
         pn9g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787133740; x=1787738540; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e/ykeQ5QUSsTkkdxsh/CxYBDe9VSjwD6RqDbgwXYXlM=;
        b=eECfyupt9X5c2LrPEfmrTRqyy5QhxfGlVb36HsYNvGoU9c51Mn0trHIJ+flgf7Nmb9
         jy2zAshtHX9WtouUYLaEno3r61XRWcfm93zuM0Ak79LPAaUNrK9IXRhFNSw0v/UPnPuX
         MKKVS0/DrsJSIf05a6+x8VjQsj75PCYcTzXJi/dKso3KIfdGWWSbJL6pEUmJchl/MIVW
         PgeHjpjm/eVTk95R6p6ZY8FEePQwbq+cCcQIGVu83Mj/eyZ0VQL8oaZZ/nXogXqk4DSR
         rmAQ1hm2SfXQbnzVGnzDgT6FRpSIfBC7p3Us0DAYnn2pKxoguVCwlASu4cs2Nu8WFgR4
         wdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787133740; x=1787738540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/ykeQ5QUSsTkkdxsh/CxYBDe9VSjwD6RqDbgwXYXlM=;
        b=TV6HgNPCcs1Q87bJHpEQbJ5yn20xe96bpO1kMVeMNfNIGB0Bn2Z2vZGLyTwsqiz4YY
         FM9O4kYMX+LUBwFhyM2VKzQNs70zn/gYe3VUBuP6/zms7m/zRG1Wg+rR/spYe1fuismE
         InDJZUJisR/CkcSvywvC/dOnQpdwYKSgkt1tx42bcES7wAZgOBRND2Cjli+PCh1nvtrt
         b1h4WcA7WoX7nrsaGi0v61uvFPSRkt3nVVPPf0viWzKpmF14FTKHPEZr5dmQG9pYg6fw
         j4tWTgbTh1LcacN983vZaspRM+cjKiVnGzzrOC0Wg78F//63PfljrtuIBZDwhfuD2uZu
         BXqg==
X-Forwarded-Encrypted: i=1; AHgh+RoAyz674OWFOkeT9mimSvhLxg9Lpnj9sEpDNVF7xkHkR0D24sK9POXJfV/sVfnkcVvovWrHZP/fxrUjrMo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzsNXEjfkB8xnvUFENoPs6Oe6YyDpXcsKfznygbHl33rySJ8fHs
	xM4BPNxnWdminPMokB/ohO2+WTkTM+2Uc3JaQu9UkVI01MTKiTHha6FdXQaAK9of6SXAWlh2Af4
	WQ9c7Na3lkcCYVnB1BGmjjRqzACXdadY=
X-Gm-Gg: AR+sD12rEa0TNOfkVWWU0yex5oo+KKTMFCPrZA74p5+ycej7/MPEljdKCQWFB3pGBNQ
	3vtRUuhXlCogsRudI/bgZ40bZF96R0rVWfPQjTibOUCtlOP5cmrK6PUUuDu4rUu1ubvRgBgvAku
	cTbK+DmohjJctsHusbYmvx6rwTqAXcXK0WNHq0SQL+xLQazZqOHe//wyJVRqlD3pFj3qASaJD9f
	koSCcLK9JDliK6W81CyCfzKmbtPQ3hA3QzC3qgMa0UbBSv72fMpSNCjWIbtblt7FXoY57G3c3sd
	JfgKscGX/ZiX2RZQgbtHYej84EuxuCRPh5rRnqw18OkVBzARE9ExeklhFJkJKaggsH5+w9dItna
	pMQQc4njou1CPAk8TD7cpaXuOLGlb1Y667WOkKp0p+7fwxjZq546QpG0bvqqub3NN8Q==
X-Received: by 2002:ac2:51c6:0:b0:5b1:5e89:30f6 with SMTP id
 2adb3069b0e04-5b478bcb669mr579903e87.3.1787133739473; Wed, 19 Aug 2026
 03:02:19 -0700 (PDT)
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
References: <20260819084825.969116-1-mkchauras@gmail.com>
In-Reply-To: <20260819084825.969116-1-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Aug 2026 12:02:01 +0200
X-Gm-Features: AcwNN1Vu-RuAbNdoDEw2XNogoKXdWs1AZbTUBC5VtWKX5E0dSCywjtrmuOtTyPU
Message-ID: <CANiq72n=C68iaxuLVR5dbuBpf2FLMGwH8wtB+d5sNgOTv4BQ7A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
	work@onurozkan.dev, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <tomo@flapping.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:48=E2=80=AFAM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> This brings powerpc into line with x86, arm64, s390, and riscv, all of
> which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
>
> Suggested-by: FUJITA Tomonori <tomo@flapping.org>

Should this be Reported-by?

In addition, probably we want a Link to the original report, and a Fixes ta=
g.

Ideally, please include the error message in the commit message -- it
helps to triaging and also to search it later on etc.

Thanks!

Cheers,
Miguel


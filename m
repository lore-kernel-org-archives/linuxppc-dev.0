Return-Path: <linuxppc-dev+bounces-17977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D96FD4F29
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 19:19:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVkGJ6jl1z3bmM;
	Wed, 11 Mar 2026 06:19:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773170376;
	cv=pass; b=eQGvHqEBw95KIQ9V1BJyDuEU1hRJ/RQC0rEn2T3CXj3GpYUVkw4H0x0sQiVMQ0CAygOO9FC3BwTzkIHKmGfDAlZOaSVTLTTK3ostxgEbm4HZymFOhLoHUTK13CDOFc/XwyQSfaCmBcGWn5zRmcIjaenymhoSAs4YICC/q06hajmcbTUhJwi/UGNP4fll47ygunys3N/o3suU1W68PS8EhrOD95zLiZMX8sgtantKzfjd0kZo4jGD4zQYuUE8RVIEYxA/mBLCF9EcsbJZ3O2FCSr3lsuLJoVr8/a74hDiy88B1AHY/NH/G8Y6benusGfljcSUY6qEeqbTZ+Z8APU/9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773170376; c=relaxed/relaxed;
	bh=U6VxqmfQaZseJJ7vR2X1vkl0eCDrvXHEkhTypy0Kl1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq+KOBp5P18hizmsDYDXm57oSpd8QjhF6+ZoZna4vVgg+S39L3JWeF8V0HelKwyuyXRTA8EuuK/NH6DTFzpiQ0UuQzWURh2HZaJ9Z5d3vB8uUEpkbpcIDzcKpQDuHKiJXd2xo/Mt1kpCrXdIlN0uqhFJ1MBtxdTNX/kFyl8FWTw6r1Jk0JQhqemn2vHleTGRXf8WfKpqjEPw2GrodVDBGomcDpvvsDFZtwfPOoJAg64wQ+/lWwZl8VlySI5iSUU4tthZNhxPvWovpndI7fcmHslnaXwnyK+VjG5EbGuDn1FflQ/0xbWeNc3OBHKfa124YRIFmjrkH64tN9vkCYVzbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=R3x0iuZZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=R3x0iuZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVkGH20l1z3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 06:19:34 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3598df39444so6276971a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 12:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773170372; cv=none;
        d=google.com; s=arc-20240605;
        b=BnOyHNbWGGaog2giFVcWYxZ6z7LjF9x4sTwum/NgQzKOlkAtQiatKzi0hZ23HLyLLQ
         LVwnA/qXrLFFMaqH2bQJXbKJwuKAx17NAW08JaiF7rnP9OzBdcYaJEi64fG6GYF98g7B
         7CP0NrYiF9dsqZ6AdIKIGkKnEyRe4Sbnx7/ODiLB66zJEi/UWVWT4YSfjKp6gKycxuqm
         u+KW89OskDME/WXqmlxxn2rKAN3N9cphyFui3FIgP40ki6B2zLdQeQLY6YuSJs0hnAhc
         YLXZbHRMx9pQhkwhqF2BXPiDDAm/UjQsRr2lBwq+rC7JYG2Be0UVIch+bJpG9yXO/IHV
         nbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U6VxqmfQaZseJJ7vR2X1vkl0eCDrvXHEkhTypy0Kl1g=;
        fh=pJvzLWJfWwDvL/i9nZuOcwBoXKZlg8ORe+rTv2qVt94=;
        b=DVKjm8nSd/IoNhJyHusd1pNmoiaSoyByobzgSmQCHvpf3Grf9fYosY+Npup44RTAR9
         laEGHzk5DMw+bWwl2OZI3ytddtaBpF2VGjye7SIv7KW49BMPtdJbKvLspFcsWX8CvyCX
         UMkFvl1BZ2Z72fa6zWdbX/wM01WL93nV3ZwYnqdBOZ07rzeMNX9ZEbO5/nJUcGHx3nc1
         ewFf9YV69z3Hrf0f7pw9D2WJHbehfINqoMZk0BMi6nzdo5+DUju2ovCv+6hTZNf5L//Q
         lbf/1Bcp+QKiEvA2xfp/mYE9JH+0JBUAHyXKg0ljZM+VlO4VanE3VFt3PVa5z6zvRHL8
         0rpg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773170372; x=1773775172; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6VxqmfQaZseJJ7vR2X1vkl0eCDrvXHEkhTypy0Kl1g=;
        b=R3x0iuZZcUCJelGIf2dNW+iYQD+QAbli4Kmm/3mEXj8u7kCPS6O2j1QnbuK56zb8Ju
         qJ2jTiygQ1yEHqXg++0c/Xkb9Q0H4gsIFKYt7/gMVMyom81dxhKndSlxYFzJ/BZFbCqO
         +Sn/QyXQG+naMX/yIQRpw/ZZqfLM6GyVwt26kt++y77pQgvrRx0tAQOHlW9J2KvVhtPS
         RaBVHZ/Xh++9ptHYo8sFrMl+2cotv7R5V0LDYp/nC+4t1A6L38CLIOAMm+FJpEXUqp8P
         gyuy0WhdfLFi7b6LfDKZjSxiSiJJu+Qf6A8MO1mLdjmeYKMtN7xGqeEtNWoVLp7rQ19G
         3LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773170372; x=1773775172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U6VxqmfQaZseJJ7vR2X1vkl0eCDrvXHEkhTypy0Kl1g=;
        b=QE7AWzanuuxs88j86ZLjxocRFOAa/L27dHGZXy+vFMGmCCZxxSvc5n8Mkc+h1eyuta
         RGsk3SvCUVR+5X7Aumhn/Gqth+aF0hz13CIhvuzJ1/FPz4GjXJL8hwxsOl9KqNgXwGsa
         xwMbTMzDhpnncu2WiLW5g+ySDYSYNWJYTYHUstcO1JVCx48vnyN3LlK2m8L9D6dYRgPP
         7Slggjgh4r8ft9l6rnOZkRXoSa+PdLZervNFLLPTWR20Km+tmSQIroZ5aBBOkKXygvQv
         7kSjBDhM5hTwSWdvmGjEY7mMu6cds/PfSLDocK3jcWMULTlCigvbk5z1eeBaIAZC7zVq
         fnvw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7suNFcl2QZcKjwvnfGA4tzV5sMJAn66Mv3sgmOmOXiJ6vp2weT74mxm6Krf/Mx+dlxHkzb00LTnJphQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2bQXpVc2H7uvyxBRhDihxA0c3pgNWEgXWo74umBpyCLIj/S36
	ZByB4bwdRLU1s9tZcAvDT25+uoZREzlOr769zMsmU162SxkcMDRSKjPkBfdzC5YAPknvMgmaTYg
	VmGsVzfzIqJh6u3g3Y+f+b29a48cycHIoQh68yr/X
X-Gm-Gg: ATEYQzzXzrFzZ56YTioPT+vhetHmLG2tfYijseYZs18XAfJmwdHGBxBgpZYVPezTdm2
	93jUm6nzI9c3cPGGjT9noGkubaLj8yr5tPKAN+kJyJFXnqTS0qJ3ZkLYFRq/JyYgp201uH2Sawz
	f1kP1xEaklctU5TlsUZ3bjijKA9pdm3UGyOltt0yGvr436DvEQzNS5pE+AYCPEZwsKtqPkZdkdJ
	jIyrJyhdktRVzAbsnwa7r6Fx5had4kk7l6FaqusNwJohC63ypwvRaGwOgxi8IwZniqHGq8XW94b
	96raKdY=
X-Received: by 2002:a17:90b:3506:b0:359:87ff:f352 with SMTP id
 98e67ed59e1d1-35a01202655mr59010a91.8.1773170371992; Tue, 10 Mar 2026
 12:19:31 -0700 (PDT)
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
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
In-Reply-To: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 15:19:19 -0400
X-Gm-Features: AaiRm53eSE5v3aP0W_oG_AsIWqYfzaIoe1cP2U70PYN3EqAi5OekgDYF-nWk5uw
Message-ID: <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Eric Paris <eparis@redhat.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	audit@vger.kernel.org, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 11:08=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
>
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
>
> Convert powerpc to that bi-arch generic audit support.
>
> With this change generated text is similar.
>
> Thomas has confirmed that the previously failing filter_exclude/test
> is now successful both without and with this patch, see [1]
>
> [1] https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e=
6b437d0d67@linutronix.de/
>
> Link: https://github.com/linuxppc/issues/issues/412
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
> Venkat, a test result with https://github.com/linux-audit/audit-testsuite=
 would be appreciated.

Yes, I'd like to see confirmation that the audit test suite runs clean
on ppc systems with this patch applied, and unfortunately without a
ppc system I have no way to test this myself.

> v3: Rebased on v7.0-rc1
>
> v2: https://lore.kernel.org/all/a4b3951d1191d4183d92a07a6097566bde60d00a.=
1629812058.git.christophe.leroy@csgroup.eu/
> ---
>  arch/powerpc/Kconfig                |  5 +-
>  arch/powerpc/include/asm/unistd32.h |  7 +++
>  arch/powerpc/kernel/Makefile        |  3 -
>  arch/powerpc/kernel/audit.c         | 87 -----------------------------
>  arch/powerpc/kernel/compat_audit.c  | 49 ----------------
>  5 files changed, 8 insertions(+), 143 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/unistd32.h
>  delete mode 100644 arch/powerpc/kernel/audit.c
>  delete mode 100644 arch/powerpc/kernel/compat_audit.c

--=20
paul-moore.com


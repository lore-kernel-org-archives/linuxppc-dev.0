Return-Path: <linuxppc-dev+bounces-22497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CC6CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:45:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gblnW5p5pz3brM;
	Fri, 12 Jun 2026 00:45:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781189151;
	cv=pass; b=SqLhaywgbB6TI97rEqROaFUGWJvp44zhRfxv34R1l04JuP8xJxf2t6r9iaaOidk74YjvZ7oxKrCwCg87i9p4yB12PprHsTJ2vQH2Pm3l4O/L0QVhKLIkxxQYAzLOmikODVltAOVkYSfRqKQhNsAo8E90N4Atk29bO2sh1/EvrDnLjA/Zu6n9sOf0KXNvW+p7TizpUIFvrTUqgpIvRxAQLDmpgrFke/XoQ8RsWuuaKaLUsWBTL/57kaIyiJkg4t/12v4aCqP+4roBMyrOhO93McU25XFM+scweFzPvoGEieH2nVf39/ISZeEK7BGT8gUkrtAsYz4RrpisD12HUKKfCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781189151; c=relaxed/relaxed;
	bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNrWQHcUzNcSwnOBskA097K8NbKJoZ+ZFokpGAS+NPMCSwPzRvW1XDh5kje4obQjqTuQXdVWJd0SdTCJwcgn64EPSw13ohVJcUHwRdkSx2i1ko8ttJs1kRc/K18iBh3JSqcroHPTZzzrhED/6L4PSWd+jqfCQOLWEjky/zIF8dMoce2I31vLt5Iagmahr/cPJZfaDS8R7H/AYUn12wZ9mMwRLVs8FcLzCE4rZwBlTWNiTmTSPf4UbcTQcS+T/kfbJUZJEJdxkraeSKl4SxudA5V7owjpFiu/QWxMGZEUr0qCtAFmmUFcqd41AU2siYjdWx8OF+Xr6HBJaJ7T7SSyDg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q89qLAD4; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q89qLAD4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gblnT44zwz3brL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 00:45:47 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-befd83e0521so217767266b.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 07:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189144; cv=none;
        d=google.com; s=arc-20240605;
        b=We5BsNwtckJLZ6/D4pvDwpsA2ZA4RLUBc4jVHyVJGUUx+9brEdAa2ZefPPmPm2Epul
         PwEiFbkO9Q1ynZUkpSL+AGDiICBPMMI8xZFPuLq3ecYG7qWyBaoRwIAQuqRdh47pa52F
         qe4damxz7wI/vF3Pxv53kgX4R/BRvhSbgH1fqmdqNWWZuXVBCkXOMurfc4meXdyecSDU
         OS4AwWZ+1QGL8NYE28cpAkKXvbE6IEzyuztJTRl8Qc+X0tKccDqaAgDGKpNFaUxd7RTL
         BqGcN67LXq6syJ1/6gqH+MPMkAudJf9lb8ZcbPrRxHQ/pefhyQJWVLlXHO0wUcRN5TzS
         7mOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
        fh=mUyKmM4rj/OHbu93MVGk39cED/Eu4SgdHlo0g7zuH4A=;
        b=LyI2YczD2l+aD9oHrFPDMZdydvnRqSkHdV+BHTzG+HeX1jTcwdpoDrpRiRjYbb5+Ul
         zKSBIC4JXE4Br/gqXzBZnwBMFDG/HGbzORChfCM7UtkMZ7LkZ9Wo089vgqidSMSvqjyu
         39nqow/yFT59WzE67t1YjWxCTwaa9Od5DxNleXsRr2eJGOhYPIUJMm0nskSDJJ4ujAK0
         Of1ugJMV4ytEF35XifiHp9Mr2bmbDhqsDCqqJV2ipVUFvi1hxIT+ou7MGj9t4CfI5U49
         IbpZUwVmIbANAljHCISgbbP+Kl8RxVXt5MW+MEQZWdzRqGH1uKQbGkDL6+6u1VfeB2Sa
         7l8A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781189144; x=1781793944; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
        b=Q89qLAD4z8A3cwZqmd13TkqOPmaWO+U988dEULTyd2mpsnYaOtMV6fyIy8fbmbRZNL
         tc3WbWSw/WMh85qaRisWfVaz0yb3ZyAeNd29O/G3EthgjfCsUVuujdqd1RErbMhCHBch
         bh0cnMlq22awOwn7NGQCY9k9+YlEuFz4TQJLjb7bQzYMrePctSpoopd2oYt1M3zwzVOW
         wKixvT3P1k4/dH5WXMAaPGAogC8K6TLHDcDDUDVRWROxQtHJM0SsGKJO09lPy1KRdpxf
         I4dWzMfskMlENru6fwnLMwf/sL75Yq8TQwsDM48cIjoGmmj+9myCh4wbq35Kvqvz8EHw
         LECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781189144; x=1781793944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1Q6VrmJUx+o7NgXdFZxExU41NgoiFIjQElz0CF6684=;
        b=HuItkGioE2cIqzQa7RQCa4XYP/oVX1+wH6g2HbjrJ/UWwwCFMX4RdY7z+B0AmZFw1V
         7CT5DHSVhvv8vdYNrawB/PkyFWw/RPEX6RsvUKcN3ey56elYmUi0MrZmJBzq+OSiY55s
         usjHvxpALMLQl9dFE4kVBetvkH8QBqDhNxkzV/GyNORMv3jJQ024JWSoaOd1052iLeSk
         J2h4FZk7S37obFokhd6w0c6c/xu2w6r4jNolVaz2e6HBJgfq7eGQAfY5sv2S94vWfW6o
         CMj0NW1BdRhoRMlucTdVW+jUgSAWqMcwGepq5DIkiwKn6WPi0dOegcaJlItTIGCA634u
         43dw==
X-Forwarded-Encrypted: i=1; AFNElJ8R1+iueiUjidQrvW/j32PVJv9J4XpYrMBKlWqiHipjA6SdSF1lY5DzMp9+RfxIJjnUXidEgSncVGXQ2OM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxaJfF0c5BRG7tra65oTGn30moomXd/sXSMJv8c2uAem9uq1PHk
	BXV1IClNSSA5qOyut/FMeeZqIkKgykhsyjLwqnx4rS4halx7ZmbPtd2RlHur68uEgicQbQLLUyc
	j00IvgCQzc2XEsGF7e+leZDSGcJ/FjUxK/HInNnvp/g==
X-Gm-Gg: Acq92OEmLeOUEsyYf6KgOV0mudk9O3Dl2mLQXUJZP1UvexIuPx8tV2ygabcOln6kZGx
	3LfSg1iHKheg0fXHYo5ICVz3PogK47VkRzDSYPM7ko4SlbwzydfJlRAFfT6dnLXSYdWPKSIHdUg
	89zftD7h6gwUPnuvkfFjncZlaAeZjOSqOJjS5lBJUfDA/DelhJyzSlPeSncfMBDCK3WW3ZuEHd/
	PCpGFAKQzsKncnGHyJ0eWgHCLUJXuhAuPl3fMh/Y8i5uNlPAkELrG/UnlU95s9/fAARvLajJZKc
	Q09z2VzNFO8zyW8pBXbPGW1GQX+8lCP2exUHc6mIHVzgPs8cqhdFK600Bg==
X-Received: by 2002:a17:906:4fd1:b0:bee:a39b:ab7b with SMTP id
 a640c23a62f3a-bfc78ed6c4fmr158181366b.31.1781189144237; Thu, 11 Jun 2026
 07:45:44 -0700 (PDT)
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
References: <20260610142329.3836808-1-sumit.semwal@linaro.org> <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
In-Reply-To: <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 11 Jun 2026 20:15:32 +0530
X-Gm-Features: AVVi8CeA1CWJ3Tf7y-K-ZwxKVWTsZOKhQeXrR2LoMbjQ-zl-nOkzKd4bOJvB8OA
Message-ID: <CAO_48GHEfq7wpvM_4OXcMhgdASgH9J96nhEd0QFh2Rg8aPxpfw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
To: Jiri Pirko <jiri@resnulli.us>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, hch@infradead.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, djbw@kernel.org, thomas.lendacky@amd.com, 
	x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	mripard@kernel.org, afd@ti.com, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

On Thu, 11 Jun 2026 at 15:51, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Jun 10, 2026 at 04:23:29PM +0200, sumit.semwal@linaro.org wrote:
> >From: Arnd Bergmann <arnd@arndb.de>
> >
> >While system heap and system_cc_shared heap share a lot of code
> >and hence the same source file, their users have different needs.
> >
> >system heap users need it to be a loadable module, while
> >system_cc_shared heap users don't.
> >
> >Building as a loadable module breaks system_cc_shared heap on
> >powerpc and s390 due to un-exported set_memory_encrypted /
> >set_memory_decrypted functions.
> >
> >Fix these by reorganising code to put the system_cc_shared heap
> >under a new Kconfig symbol, which allows either building both
> >into the kernel, or leave encryption up to the consumers of the
> >system heap.
> >
> >Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
> >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> >---
> > drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
> > drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
> > 2 files changed, 18 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> >index e273fb18feca..a39decdcf067 100644
> >--- a/drivers/dma-buf/heaps/Kconfig
> >+++ b/drivers/dma-buf/heaps/Kconfig
> >@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
> >         Choose this option to enable the system dmabuf heap. The system heap
> >         is backed by pages from the buddy allocator. If in doubt, say Y.
> >
> >+config DMABUF_HEAPS_CC_SYSTEM
>
> Nit: "DMABUF_HEAPS_SYSTEM_CC_SHARED" to be consistent with the heap
> name?
>
> With or without it:
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
Thanks for catching this; I'll fix this while pushing to
drm-misc-next-fixes in a few minutes.

Best,
Sumit.


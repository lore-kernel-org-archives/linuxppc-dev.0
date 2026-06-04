Return-Path: <linuxppc-dev+bounces-22029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA5FCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:16:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQ890r80z2yRC;
	Thu, 04 Jun 2026 23:16:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780557735;
	cv=pass; b=idBeeSCiVWfjAN6roPtN6uRpHbnjMuVxKNLwS93Qvj0c9nlBpZ2WyhETFMMDPA5Ac0kG9RNYy3tBWTSjB10/zd8UsMcjuZSyrcwCJRNg+UFTcGhgJLISZOAMIGew8y541G6D+1AuGaRiO82gjNQuNg8s71X322xnAi1fJoeITBuSHOVUWPBBM6NORFn1iA6thhK0WArggbVKkZlPhB1QHTemjdjFpTOzbNTD09vT7OV9wgMrOTa3XuDDbIFBvgFbsQraaH8rlRgF3wbR005m8Xulf/uHa5zoEVZt2mWsZaQu8cwVWZQ0TyImmzsDPtn6rAMEUL87SGTPqGRflMUNCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780557735; c=relaxed/relaxed;
	bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/FjfnF4hmhYXUd5yuKql+DZq5Yzw1iKTviu57CXbcpOis/h47FxirvD3YkQykOuaDmFiV5JBaTThIeKsaCMWvrtc8Q62Bn9oxN/WljndQhvlpagYVYpwlCq9E3L0aE6eY/NQFmFjh9P56LG8CVytq/GMg/SIpRXkHs9aNgenBzA8h4r3dOSJsIQMeFOzrgfXLOag60RSSNzkcnt8F3+fOAAbGgFvu1ifXU+GQLWC8olCsQB0EX1l6b/p50OJLj2eQ7fIeSLJxLPBg9Sd91ahk7lCdEf7qvGFfsOqGU2LaE569EJ+B2jB36CPUxRwY+U9gljCGK07us2W14Ofa7WfQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Zf2Dg57D; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Zf2Dg57D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWGGq2vpbz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 17:22:09 +1000 (AEST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-beb7f26ed62so39760166b.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 00:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780557722; cv=none;
        d=google.com; s=arc-20240605;
        b=MxwQHV3144ktckLaTbF7+5R79BSEl6NHyqf+JRcPA6LAT63A07Tc0pipYwk8IPcioy
         habWlu8zQBDlm18yLV7akv4zsagIOTHPK0/VzZ/ISL3b98F0OdXguDpnjkvpHR6cfSPt
         q57ySR07Pg7RfrwnsV7haIQRkMrCHG1wH/jmH3F5A1rIy6DlykoxMzkMrJa7/tMzcV/v
         sIaVwtgeIjdSK1I5IEQi3BuJhnuasHiKHFAXMsyRo8MQ81T2g/vI7Ar7tQuvhIQmlbrp
         uU5q7xB59rZPfKoaegCfWZgaLEQSKMlo9PYcY1jYWliXFTBDviTSzBVzvdOQczKfQjn2
         +JaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        fh=+NYqJq5ES8dTQRjfDne3uLJ5JDL1EXXZKWfwerhMjmg=;
        b=lKE43q+pQPZGKPlHIlZQQAPLP1SG/RQNkPk48vGuzVJ8H9RqsGtMn+gB1ilKDyekmR
         dj951ICY0XreOyHkQcJeXO59PsC+s7lU5TzZ/WdBtEDAG542F6hE6Ve/7gsrNXXUfeXJ
         CWl92H25N21bkTu0bBo0AmyBxCZid5qEpWrU5no9ydjZ3t6HkYrSUsjs5GqA977VpiRW
         gcEz2lXrEeU+WIEUg38bqiNd+qcyOD/yvQbZZ9RIJD3PjmmEbRFA+MuXyD5m2HnYgDgr
         20B+5HzFBlI1lWgsdResmZv5Zf9SFtrChLEClt1dlLVd4uAxGG1FzkiWxRkdRSNRdf+Z
         mqpQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780557722; x=1781162522; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        b=Zf2Dg57D+gy8QBgMqK+1CiIIT6/qB0aCl1gctnG5PRCSuMt2Khc2cIFtzaOYx89LGa
         RZT3sYXksPgHyS6j1V11+NaBhlFECF1V8Jj3Kvohn8gHYKOrYV+gauxDt5sfWzdPiNvV
         Ba5WZBpHoCaTfiPcoTQBnz9KHOEqHWUKwhk4Hs7NidqKzOlwOgS6zXXxxqevfNpbn6iI
         xfZNzlZLuKEyMcyUZsSeTedf5Ad3X5G50rrbOMbn/hv6Wg7EEytLLiGQ0wluz5HR6cbm
         mNw2oRao+0nStOKYU3grBLdlZFkQHE7Tlk7kopL6wW4wcJ4vo/Bok5vZBaEOnAfMEO0i
         /ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557722; x=1781162522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        b=a8cyjRjB4UO42Uv9aUBUof6rDnJ/y128/hDVBfLzFwmTOoxXaUYAKM8/AA4OCtgp4o
         Km23pc5hhixsnf95xQqj95JCosQq0gf08/tqKTyGEiD06ofDOT3mZxjmOEN1Jnt6CkpK
         BDA8fOJxPIF8/3bHFbsj6u4tilu3cWbjr+AGq1cYC+yPTvI+/9TjjAVafiWCihdyAGJu
         6tlKrEp9qcY8md0cGzjqS7dMcjjt91eE/HmeSREiua1J9dtf7Qpc3OohyA5lLcQ39SMJ
         ku2PPXz+DS0YugW/feLR46om9SWgiXCDUtPd4AuEmifTf8NdcIi/5d8kqhED7EqbYuY0
         /6Og==
X-Forwarded-Encrypted: i=1; AFNElJ9T+6EGZETxo3PbO5UMO/FgPsSdpoKhueHVZbqaCKl8PRQAvXlIU4qs2rOUxOko5y0TCQC7KOsoSJv7voM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YznrKDRGLAJOz3mHROdXP5t9IWOAEZXKHzk6bjg9iRXlAo+G8Kx
	kQN35fWgKQKEUNAwHZSkJsLWx1bVNb00k2QN+lxFsvQSGaUyvNsQlKVBPxJzDSME4aKSKKwTqlN
	ngujFD0g1rRHtp6ELgR44jB3y/2gOmsF6xr3x9kA/Yw==
X-Gm-Gg: Acq92OGl9IJWPcbPu/SIn42DzWxskC0/osPpa0+sW2NSdCNbabPGOgN3zNe+jzBfOwT
	0zR/n63suqw5mf9zgjB9dGQ5c0rJNLgeX1YPYPUT1yafYPYd9RqcIo0/nMX4c73XY33jZnU/UuY
	KnqTcuoNAsxyD69NTzoHqxAccICndOsAz3fKE5FGP4jmIPXPQCFuzmnNwUO3n9oyYaOE8YGeFpW
	fXcAh/pxrrg9O6X1Txg5YtT+vX8brap/4x7+bV+x8cFiRMG0y1XYa1oFOAgi/0pQSOSf1Yqiedx
	HQc+APyGuEeVI/ec7iCp0D0m8liJalvVcOdKsnWd+YOPwMUWCw==
X-Received: by 2002:a17:907:cb89:b0:bee:45f5:3e with SMTP id
 a640c23a62f3a-bf0b4395beemr416640866b.47.1780557721718; Thu, 04 Jun 2026
 00:22:01 -0700 (PDT)
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
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
In-Reply-To: <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 4 Jun 2026 12:51:49 +0530
X-Gm-Features: AVHnY4LN7rgVW4AsJ6ueOLy3-gj_m35-QjBHqySb09IN1JOBtBY4T1wqgFsSviE
Message-ID: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>, 
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	lkp@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Thu, 4 Jun 2026 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > > > module") the system dma-buf heaps can be built as a module. The
> > > > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > > > but those functions are not exported on powerpc. This can result in a
> > > > build error like:
> > >
> > > I'd much rather revert the above commit.  Yes, x86 has exported these
> > > since 2017, but that's a really bad idea, and we should fix it instead
> > > of spreading the export.
> > >
> > > Setting memory decrypted is a dangerous operations and should only
> > > be available to core code.  We should have various allocators for
> > > decrypted code, but not export the functionality to random code.
> >
> > At the very least an EXPORT_SYMBOL_NS.
> >
> > Looks like there are about 3 modules using it already..
>
> So, I'm not really sure how to fix this now. Should we revert the patch
> making the system heap a module, or should we export the symbols for all
> archs?

Given that Christoph's objection is not really about the modules part,
but that the set_memory_{encrypted,decrypted} should not be used here,
one option is to revert 78b30c50a7ac until that issue is sorted out?

Jiri, any thoughts from you?
>
> Maxime

Best,
Sumit.


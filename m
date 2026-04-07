Return-Path: <linuxppc-dev+bounces-19449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA22FF512E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 17:52:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqv1P6HTHz2ydq;
	Wed, 08 Apr 2026 03:52:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775584377;
	cv=none; b=l5yOSG5hdA4PhQbih9P79z8bIE4UWUOjgyxWlVRHA4r83PPU5xlr4eZnLS1IqxLXt2lrOGvUiPzx91kQEFLOUWorgY8k1yUFNK4UAo5Not/v8bT5U26/v+6t36wA/rP8LwONbIto4ZCxoKIrEdBBZTvUjXb5/TfJdwRJ/S1X1NfiCLroBT5FYxn7A4Qt1X/bN8hL/RJeYJsc+58gFkYD/t0Rc6+GiR5yjnXx6GsX49cwHVu7b8UMVKP++I3av+5jKpHrksIbjS0v2nyEVhGMZYndfJY4HGy4WBZhT2+rCV+iA2x7afAoDYcDEPKqEL66I2ixVvt6PlmX7MdFMIkOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775584377; c=relaxed/relaxed;
	bh=X/MSOJp/AJlf7hUTMD/NXnVkTNNfR/Z7vvW8KkUYbLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezCqr9fyNvWk1I+MSpMlW25k9AFyI2dcdz2k+9qLv601p/kO6ZYkhBLw5/u2cbIt4mtTpNTfMuaURvdJHZwFaNuu54gU8IEfxu4GRBhcba0uzb/HSMGs7mhXFl4p6JLS9HV2Ec+BLLPgVrq0cWap44N0i0Jc67/FtzbXH/Mec4VIdhajKLUkbWAKyALL7QdsBGl8ojFlumaT/YMtkbKwAutj+kVeoeV7adNZno5yW0fXQl/zfBd8MtS+QTAb9bcXRnSOXTaFv5CKMxhprCdMQs/8VuOT+UpQChNraE6btNa6Z0lVmFYaXwlIWCcr0yyx9aPqaH88Mf9h+A6YlnUJ7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aDV8SmVi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3detvaqykdkczlhuqjnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aDV8SmVi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3detvaqykdkczlhuqjnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqv1N0t7Xz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 03:52:55 +1000 (AEST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-354490889b6so7942349a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775584373; x=1776189173; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/MSOJp/AJlf7hUTMD/NXnVkTNNfR/Z7vvW8KkUYbLI=;
        b=aDV8SmVi5pKTt41AfsJ5cIya4KoubWvH+11P1y6SpF21xjf38GlAhNRYs+YTbL5+6t
         ER2fPQBNDAjqjl90Xc16yE0ZE4wuNAiSSgPhDbgJ8ftxkkDXezb8d5KDhyXAbKMO20Nd
         +zAlzFB1TvJaTwA+xSOn1RztTnIdVfLuj+klgHFPRh2ov/m1uFAey8ZvV+PQvVUBEKIa
         a6qFlKMIXVqOhuba5AmW4W9BmopNYQLjPuNdzTAJEbOno0f3fIlzqQlTNzi/pk7HLfbB
         ORM/4RRWiztYmAJHvmpSZ5xDPzApeBjWaglZq/jZwPJCxwZncBBI4FPwoVY+Mf017O5A
         jMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584373; x=1776189173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/MSOJp/AJlf7hUTMD/NXnVkTNNfR/Z7vvW8KkUYbLI=;
        b=Jsr/WFHAZEE8DjUpxCH9TsBdd3Ju4mKc/e8Z2XW2ml+nR0p1V4LMNqD9FscqD3VD8o
         pPVjY6O0OcfB8CYGZSre7iYsXlwPfFnYP0d2aVF+6JiXogg95oIaMcVm9grZsPDpjs5g
         ctt0Hbn1R/8T4RTGPT1tj8PmoZP17ZGNqFW+SS+v90/WEtHVkPpKNBMaPO3UuIN5+gM8
         CaWQ1iDCzDbAFHkML8SoNZ1xavdhA+AHDEHaQxUf4GlgO3fr8354vslkLxlDaVY3L3eG
         nEL7hvIz4fdnnbiwyAq+pbdiLwPdrH3tg1xCyZpH0LOp13m0bxOA21ZehULd7FpPM1/Q
         Qc4g==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ze7SWRaJ48z5zuucnyDK55QCeTKbRUHsgSeWRzQ+ZCuqtPlaPrKHjbaOL8xY9qAX7+p+AEukUl58TdE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBrtLrlfMoyKA/IJbpKTvwo40lmZNO5I1TT6Zl0kqHcPI5R4xn
	kxNuG0DXD2Lnv8QoFJFakZ84w8N3RVt/9+9Yk7TVS/c6ZQ3z15jOZlRzLcLwGgG4PIJ9wp50xmW
	Tju4LgQ==
X-Received: from pjps16.prod.google.com ([2002:a17:90a:a110:b0:35d:94b3:bd6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2885:b0:35d:974d:8f7
 with SMTP id 98e67ed59e1d1-35de679c8ecmr16179304a91.1.1775584372473; Tue, 07
 Apr 2026 10:52:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:52:51 -0700
In-Reply-To: <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
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
Mime-Version: 1.0
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local> <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
 <adBJTXeE6G2vQNKX@google.com> <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
Message-ID: <adVEc4zUVVxRiEJG@google.com>
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
From: Sean Christopherson <seanjc@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, akpm@linux-foundation.org, david@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Baolin Wang wrote:
> On 4/4/26 7:12 AM, Sean Christopherson wrote:
> > On Fri, Mar 20, 2026, Baolin Wang wrote:
> > > > > -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
> > > > > -						unsigned long start,
> > > > > -						unsigned long end,
> > > > > -						gfn_handler_t handler,
> > > > > -						bool flush_on_ret)
> > > > > +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > > > +					      unsigned long start,
> > > > > +					      unsigned long end,
> > > > > +					      gfn_handler_t handler,
> > > > > +					      bool flush_on_ret)
> > > > 
> > > > Can we please fix this terrrible indentation while we're here :)?
> > > > 
> > > > static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > > 		unsigned long start, unsigned long end, gfn_handler_t handler,
> > > > 		bool flush_on_ret)
> > > > 
> > > > Would be nicer, thanks!
> > 
> > No, please keep this as-is.  KVM's preferred style is exactly this (and I personally
> > find mm's style much harder to parse).
> 
> Um, Andrew has already queued v2[1] into the mm-stable branch. Do you want
> me to send a follow-up patch to restore the original KVM coding style?

Nah, not worth the churn.  Thanks though!


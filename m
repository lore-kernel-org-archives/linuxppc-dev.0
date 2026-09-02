Return-Path: <linuxppc-dev+bounces-26452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB34C624D3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 17:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZr1z59rmz2xlv;
	Thu, 03 Sep 2026 03:53:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::447"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788371623;
	cv=none; b=aE+CfwCDJB+cDEpnDtw1nhT5jENEFXaPqPeqPn/DnYnCpLRimpxizaweWSXc0yC241d1BY/UH55QSWWR/s8htWRN0N+injbxosO0pUecE8VZitJ7W2FRDWzu0T+N4P7PjLyy14KrKxm9c8HvVwkSXmf3pitUUClG3y2jWqjG9q0NrGi4u1p8PJeBHUqWvPc3smhUxRPxGf50s/WKyVBNUuUX7xqCk6la1mH8bbhPPA/GVpPkfsp5mUs8/3WaMBRPNelt8ZOtk6VRRGCwHVXzg4ABVyNMX+YRwhxB27RAu1h+vr7HQAxLC8tiF7D9mnUrRixMBdOTkemYSc9OEg7NLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788371623; c=relaxed/relaxed;
	bh=SdKJUU1oimzE531v2SlLnET8xKOYeS+3soklD8mAhs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lr32/b360Y7sT+m5rD9cLcVo+T1WoqIL3CDra93+eMBH1IXTGaVGva0g6Ea0S+fUA0CcUzLyV4f9nVRM8C3pPN/Sobcim3+YX3V4EABDYlftaCt6sqc5vCTMb5ueG7ubG8IHTPv9y0R8ajw+hypxlieSe3lecFSuLP4H7AjoMsLYkajCR7LFlOn+lCtNirmTbBiKIB9veMg80+HNMEzgBF5GuYAuWbta1XatVS80XleWxFrEdUNUUueJcZr24mKgvjVZ8GB2jl7IVMaa1AN/8uFQ95UhFsmm38aCO8VEAKpdEmgKfdVWgAPrwq4fXsXX3dpEZlRxcf/DGorUpIVaGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pT4TxVnW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3omkyagykdcutfbokdhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pT4TxVnW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::447; helo=mail-pf1-x447.google.com; envelope-from=3omkyagykdcutfbokdhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com [IPv6:2607:f8b0:4864:20::447])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZr1y64P6z2xLd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 03:53:42 +1000 (AEST)
Received: by mail-pf1-x447.google.com with SMTP id d2e1a72fcca58-855315ccb64so1214810b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788371619; x=1788976419; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SdKJUU1oimzE531v2SlLnET8xKOYeS+3soklD8mAhs4=;
        b=pT4TxVnWQthpwI9zMGGKj5q3ZtX6qE2uFC859f9hV5srACYbJ0jDF/pl15fRrBX8HE
         EslvRnJGW0xMip/2L/AVU9NYkJiW4QJDnEEkKA77ujI/EKb7P8RnDiocZZSFwkMHz/d4
         65fa5avmDeqnt6D2AW/4HLYTxCojZIhzbZoxpopJX2RTJaACh2UK4yjyVCMD6rfohw0t
         0cfGcCmy7fyPc9iRDaCMh4A0ARrCPRdHbS/ZHHiTuoliwyICaGp61WLMsv18BN99GHLj
         CS2lPqx6ADPHBKVmhuObmzZxZydLewThGHhul6fxiBda73HpEhmBpTvYA1SFF8QVy90K
         e9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371619; x=1788976419;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdKJUU1oimzE531v2SlLnET8xKOYeS+3soklD8mAhs4=;
        b=oOheUO+bvlh+WVHqWNIfLT4QBCe8r8UcwIe7VLCqY9YowaOTnG6xyicbT/kD4D3/Yw
         AqWK1takZX/YhVk9/Ku1WEeLsTL8u/bxkqrWTKJty1Kvc82gLs8UqeIAdQAIgFIijBoS
         iasptl/TUKzZpVzEesAwLDiuj7tIgld15DdEZU+GuVZ7Jm/fl+tib2Oxm56fm2clTSUI
         yLQxzRSCFN19EJpGDjjJ3psFG5ZI7jVYC9Be6kTLz9OZMQfNNVVcqcFot5khFsTR9D8h
         XM2/f/16gMYi5ZOdPpXUSZlpX57ojyvPFJ4pYO8TWk/pwR2vjFIrwgs+wI7aozpwaAY0
         0pxA==
X-Forwarded-Encrypted: i=1; AKwUvBzt4nndONPp9TrHRseQ8rYYcXPuIji3I3KCJVINTsZi3zcd+JXI6AGgSNrxqNHB7rIypFFIITf/Vw4U35w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k08nrZII/Wv6a/DVl0NtQBGMVfUY+D1eKhFIpZ3Bz6uhAdZh/J
	WZ8Ju/WhwNq1W2m/aTE0gmtr5hnJohIFDPCD654mXl43lb5z1hGncQBmVrlCSp0Hx7VUdhbyOjT
	6q+46xA==
X-Received: from pfan9.prod.google.com ([2002:aa7:8a49:0:b0:842:83c0:8d73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440b:b0:847:9aa8:d3ce
 with SMTP id d2e1a72fcca58-85ed1b0e821mr10816352b3a.2.1788371618918; Wed, 02
 Sep 2026 10:53:38 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:53:38 -0700
In-Reply-To: <aphhKDm7Vx7G5ivr@Gautams-MacBook-Pro.local>
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
References: <20260826230511.972824-1-seanjc@google.com> <aphhKDm7Vx7G5ivr@Gautams-MacBook-Pro.local>
Message-ID: <aphioo_KTboUCtZd@google.com>
Subject: Re: [PATCH 00/20] KVM: selftests: PPC pre-enabling
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Gautam Menghani wrote:
> 
> + linuxppc-dev

Ah, shoot, I *just* posted v2.  I'll add linuxppc-dev to that cover letter.

https://lore.kernel.org/all/20260902164123.2546762-1-seanjc@google.com


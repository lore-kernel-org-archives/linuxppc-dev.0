Return-Path: <linuxppc-dev+bounces-24265-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28495C44507
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 18:43:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h07Vg5k8mz2xyj;
	Wed, 15 Jul 2026 04:43:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784054619;
	cv=none; b=ev6PWP49dNOPdacW6Xn/9L6IkCcnmfiWxDXoD5SjzzWeyC5C03wlIcTnsLO2DcWZRLJPYyyAEom+Vc0KX2g78Q6sTvr8FYka2nW0XUEczVhEon51qKxaB1nL/qhxOsqOL9+IVsdoXxnGLIiw2qLRT5URh7uihxCm5w75SWFicWCQWX+pEHSnn+9lnNLANif2Bkk7p3jwRQovqoPqspkTs+07STE0nYrsiKNqhjQ0psjMaWzO5qigJVobojArsxAzrPlCQqsyG847lOHdE3ivnDkJCzbPXOv1uIpIVb0E4shJ+TlJ046eYhaFbDRNLXHrfswDTLaf9FPNz9WZQSygoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784054619; c=relaxed/relaxed;
	bh=rFM73Nl0bWyUMJUomM5RdFpNF5aybZxuz1pkz9xV3sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l/OLQ9OZgL/S6/Mr3nl0VvmUw9LRn3og+b7qebQkF/a7Inq88JtSG59RSK7TtLUm5vewqvZidp3x0y2Be+6pC7IRwiTEgo+WxhPK+DLtmo7oXkjd7zW7XeWu6hdhKMCnuKf5e9Vl3YGSX0Ts0YivlTVGcOofeW1ZutiZEMf+VO09D7HAgq5dYXzjNdsxDNI3QkPwuWqlVChelEp38OxP2iN/zfmQ1FLaZhFuWndtH/Vur4PS2Aaq4h9P5pQBu3vY3pssLyx0LuVjrIxdX/Y8OWHYiREVeNfWV1MgZkHX1hkcL/bJgkKuwzsGBFA6XNcUhV1jBRL/myI/hCJooVQbjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DZh0kvuS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3vonwagykdbe9vr40tx55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DZh0kvuS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3vonwagykdbe9vr40tx55x2v.t532z4be66t-uvc2z9a9.5g2rs9.58x@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h07Vf0mJtz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 04:43:37 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-848d21bbb55so5898578b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054615; x=1784659415; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFM73Nl0bWyUMJUomM5RdFpNF5aybZxuz1pkz9xV3sw=;
        b=DZh0kvuSIlJLTJs0/POKqxYDFbTa/eER8XvHauAmwLKdXif2ciOcj0QaRuSg7K3R/k
         FzqnEh2au992tEGQ/b8uf4vTUGeFtUJsiaX84dtavVVxNN7LiPD6aUB9g8266IdErXyK
         uzaWbP4nd7RDh2Ka0d56NeZItrG1hTzXReQRzvoB4dX9fQgF9VcCWT5HsDyBUi1OVn3/
         QuIq+3gQ1ChXJRkUJLjIdHZacDRbqY5s4BC2saHx9qfSU96XCC6TS0+RHHNpCP7Wx8Q4
         iC6WhCmZB+/rj94i/gkz5OAxl+QVkpleU6+66dMR4yXNZ8DNYuZXgSCSnLhCqmuMocna
         GsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054615; x=1784659415;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFM73Nl0bWyUMJUomM5RdFpNF5aybZxuz1pkz9xV3sw=;
        b=ibxojw2Nmq8Oumgi9DJrDiQE7T04ZC5MOlkV2kREUd/MD8H5xDsjuj1BgtCV5+sznw
         UnU8Q+5goY7nnCjWC9w56g6ld4Cncp+3KXhXmpYMf8fnG2y+GRrdLIWzCxJ/mLnsB3iJ
         XgMd/UNgOcRbgJs3WVP6taXpD37469Ze1t4ERfbxIZPaPzsvLbtYEHhvF5UvhsumRXLD
         7YHHphwNSa0DkHufS2wbhAv0Kva/e/M9VmIjTh33+DUdzUS0Vf5cHgZye2AO4IRvxsC2
         rwHN6rd/ta+to28AOS4v2OGoZWD+JIptuaL9Zm0/Qgx/1bz6eZZLYqcNhD/fsLOoIMPV
         Qx7A==
X-Forwarded-Encrypted: i=1; AHgh+RpkLJ1EfX8RV9QVKeyHYXnpz6ZFGC4jDXRVE5894MePN26LlVq5b/bTdPCPg63QpiN3AdwO7N5xaCSnbkw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNy3cFgfQwsOKTmDFVidWz//0vWHqFe6voZL0F8/1/25tQ+aBe
	spqRi8z8IIbf0IpVF8Pbgd/fCUreF3E6LlXNhmCJeQxq0ZHTEyOaf7kLY6l4ZzKIQ9TlRPkMSox
	00dam0g==
X-Received: from pfnw16.prod.google.com ([2002:aa7:8590:0:b0:848:57f0:bf20])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d55:b0:845:4fec:3f8f
 with SMTP id d2e1a72fcca58-84a55894653mr3684533b3a.40.1784054614662; Tue, 14
 Jul 2026 11:43:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:09 -0700
In-Reply-To: <1782119051448443.14545.seg@mailgw.kylinos.cn>
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
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405354318.3120836.11122335012620649935.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, leixiang <leixiang@kylinos.cn>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 22 Jun 2026 15:51:01 +0800, leixiang wrote:
> The x86 and powerpc add_producer() callbacks set irqfd->producer before the
> fallible setup and never clear it on error.  The bypass manager doesn't
> register a producer whose add_producer() failed -- producer->eventfd is
> left NULL, so the later unregister early-returns and del_producer() is
> never called -- so nothing ever drops the pointer.
> 
> For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
> when the vector is disabled, after which a routing update dereferences the
> dangling pointer via kvm_arch_update_irqfd_routing().
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: Nullify irqfd->producer when add_producer() fails
      https://github.com/kvm-x86/linux/commit/ed446e8aa894

--
https://github.com/kvm-x86/linux/tree/next


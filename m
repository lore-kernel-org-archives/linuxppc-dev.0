Return-Path: <linuxppc-dev+bounces-20430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8047FF885A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 17:59:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8Tt91DYPz2xnK;
	Tue, 05 May 2026 03:59:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777917553;
	cv=none; b=O63/IHqS5W1n9TljbS94Hx4tCubFyzYsCj/uouueJjYdObeBGLGjEJHTCWxzpoiN4MfWwRWNVZd82+c3SN3uBLw9peWZYX/NFRa4/cHKaqGL6wGKGsb8ObxpQBK/bFLCXN2J/FmOwMJzQFyTE8ev2Ez4mcER787yF9Awvn5zSe0qIam70r49AoI03+LgSYPd4SYggrQ1iZNBKAS/6AhNlSAS5jAFwpVypZnahm5Lzq3KBr/jG2sk6FVzuCV+9ptCDEXXMcA3UFcge/zDykLnf8gM/qVMpQMRhwJyHMUrDEXvlmyf+8XEFAVArWeN7OQGegeX9Ok7CPjdfU/gYhckTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777917553; c=relaxed/relaxed;
	bh=zkucIX59KTNPBaVai4FthTKe5zTpFdhn5FHJDfPK5ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3UVLSmcN62Zyu91TkPnduoDUp9Tz2jIFFSJg24F1lqMbv+vgtqgE70+6L+2v6pymyo9Szgg0jSthyIfKCcwCsDjGqSKNQOMgyqw6xhl2ermsTSl9DSxWXB3jWxWPaveC5uOwV3aFgp6FLVV9tY5stsRFxzfJe0KU9ER2e5/mnddSM47dTcbckwRGWiqBntToChg76EkZYqCuaINVMOXxlgnpgKn2DI7otnjrcFWjlENmvu1vi5BFJrSDMBMbd0jlF68vznttXwmS12BChQNXHI+0sl/eHhqFKViX8PIDqjMF0VLLN+TNwWHFeITJSjGspUbyi5a9VjRNftzJJ1+lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VkEoLtc8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3bn74aqykdgmtfbokdhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VkEoLtc8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3bn74aqykdgmtfbokdhpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8Tt74fLgz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 03:59:11 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-83544d05c5aso731046b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777917549; x=1778522349; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkucIX59KTNPBaVai4FthTKe5zTpFdhn5FHJDfPK5ao=;
        b=VkEoLtc8CRWW+dPY6JVXo8B/s3paGiDMyyebf39JtB7XSBXiaMt9rzmD++upx+96Tn
         FzvYkcL1M/eIIhh2hgx/mosZSF4EB9QosNCf8tmJdy6FpcDl5PWTf2M/0MUJhl9JtPgZ
         GMikPTRGC5pytPOl/tX8PZhlRcHt4xL7MY4m04P3J9aE3zbZ7O49ZIo9EX74+qQneIRl
         kIvWZPS5vqnItEDe/Up0HiQLiiEaFhGPF3SJS1/1NQfnH9rwB0RwH+09j76SItTv7Q9Q
         kr1lxsK98yYhLjtj30IpG19CeYVj7EFPhV3i4GtRzrV3Y9n8ww+NC9Jja9+KVIZfX/cV
         8/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917549; x=1778522349;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zkucIX59KTNPBaVai4FthTKe5zTpFdhn5FHJDfPK5ao=;
        b=KVeVzZXmbTV2SKzCh4rcSQN85SHBbvG5gGcHJ+toKRZ6WnJa/fTBogPFY1V8mBzNUO
         WjnmeVW6N7LB3uAhv8oNWNjM4tEgky/sXyK4u9fBDkaPKeeDtiRLIoS5gCgf9JRFOrrS
         IaXLRu9VMtLnx7jEsuG880Dy2bOmLgYUXfRjCGPrvUT7OaUBkcUsptgS9GQRA4kdOdeZ
         1EZLU8EkHSo5N+V/SuMUvfymFGPqsh3XyGSV8M3E9DrR5JZnccMgQ0G/opBTuHuOhiox
         rQpdZ/8nC6gBFbAQbb/AC+JTouTSBil2UW+iGVaU6xG4PNhL2m89qDoyyIzSwtmDZVq8
         DuQg==
X-Forwarded-Encrypted: i=1; AFNElJ/HpS9qMLIYtVqwbRlozzR0iz3jIJWs3ZgmB9CpUcIyrKLHQC+TK+JOYGr4wuzXhJPu4PD+5KMmSE6CrSk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw5H7Eem18uPiNzeHpouZbDEJbvNOdw/Gm6Rz7l9S342UBN14cs
	rd65TxouX5QirU5ETdD02Vjh0KkFH54Gjdpu1nNf6J2Ra7rmT96rXszmuXW1xISZ19WQGSQJT3q
	0iek5/Q==
X-Received: from pfoo26.prod.google.com ([2002:a05:6a00:1a1a:b0:82f:b388:7a9e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a489:b0:835:685b:8e31
 with SMTP id d2e1a72fcca58-835685b9161mr6298997b3a.25.1777917548420; Mon, 04
 May 2026 10:59:08 -0700 (PDT)
Date: Mon, 4 May 2026 10:59:06 -0700
In-Reply-To: <20260427080554.GD1733452@pedri>
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
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <c2fad21764d2561469151f5dd5d35833ae8f76e6.camel@infradead.org> <20260427080554.GD1733452@pedri>
Message-ID: <afjeahNaSG0zsMgx@google.com>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]() usages
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Fred Griffoul <fgriffo@amazon.com>, Yosry Ahmed <yosry@kernel.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026, Peter Fang wrote:
> On Fri, Apr 24, 2026 at 11:27:03AM +0100, David Woodhouse wrote:
> >=20
> > Fred is already removing all the usage of kvm_vcpu_map() in nested VMX=
=C2=B9
> > and nested SVM probably wants the same treatment. And the PowerPC one
> > looks like it could just as easily operate on the userspace address?=20
> >=20
> > Could we just kill kvm_vcpu_map() completely?

Yeah, that's probably for the best in the long run.

> Thanks David!
>=20
> I think I'd need at least input from the maintainers on this but just by
> code inspection, the kvm_vcpu_map() usage in sev.c seems a bit tricky.
> Unmapping doesn't happen until right before switching to the guest, so
> this might fall into the "keep the mapping around for a longer time"
> category [1].

It definitely falls into that category.  But that code is also rather gross=
, i.e.
could use some cleanup no matter what, so I don't think it's a good argumen=
t for
keeping kvm_vcpu_map() around.

To avoid a bunch of pointless work and churn, let's hold off on hardening a=
nd/or
renaming kvm_vcpu_map() for now.  I'll take this v2 as-is; even though taki=
ng a
gpa instead of a gfn will conflict with the nVMX series, it's dead simple a=
nd a
worthwhile cleanup even if some of the conversions get discarded shortly af=
ter.


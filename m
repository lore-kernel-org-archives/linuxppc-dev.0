Return-Path: <linuxppc-dev+bounces-22410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A56CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:51:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5J13LTHz2yfD;
	Wed, 10 Jun 2026 22:51:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781095889;
	cv=none; b=GOCp2ThJ31Q6Bk3MU4mWVhTHRgk1dpyEV9WJh2dVIc/CrUiLXaYyWfOV8xRSR5owybN0OMbNnypg1pV6ez4fd8/HLUTU6Y7+Y2PTkDwc9ceUWRv/X71ndZJgd5VqB7InuYnimiGjO7Z2Oj3wubE+tXat2apW1Vwg+VzfxuN/SS+w343gkEpH1wzyf7NT8Gy9GqIB1qnNdVAJoMk0zcjo49VNazypFC2IDVNF4hICYsRYZ6A6gx88pGSboqNylOSmMacrjN0/JLqgDOSdUo7fTAPUjie3yIKYN/ixT22lDEfHPY2RnWV8NDF0lrkGxvEWqWpIFfd9DmZgnKbKhDOtog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781095889; c=relaxed/relaxed;
	bh=0/o+UCNV6jZFXH7IOUDDk1tmgi6aBRIROCOUfOa2J4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FgLeK5NGFiFwLY6AZRLs/D0DmimkQnjsyLh/+SQc0XJj5+uA9pRxmKUnCguN2vhIaUOwm/hS+nkO3xJZVUNiksY206Asx+zXBpWCWSBnxYFtBcXU1bhRU/w70u+NkRYauG6vTd9OMzH46ze9mEWAcHB9FC3Adw9+7RXKkopI33YCUgDGlj8f+VoI1zvaaSHN4SUgQknaGmduR2MBnHpnRtkm7wARoccCIvtTjs9inNt+7pEkVMxVa+gdqfQ+HbqaAZPiCDUz5gViL+JqbyU4QlHsbd36OppJQxyuPBMc75KaThdBR34+jZP1gljzw1iOwTebwTCQLhLqW/eCQaKuHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ut9kdN8h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3zv0pagykdiy2okxtmqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ut9kdN8h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3zv0pagykdiy2okxtmqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5J000WCz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:51:27 +1000 (AEST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2c0c20f7581so71291145ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781095885; x=1781700685; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/o+UCNV6jZFXH7IOUDDk1tmgi6aBRIROCOUfOa2J4c=;
        b=Ut9kdN8h1lCk+BTs0Mx46xBeRMf+odKLxxK33nGos5GWVHDmlhLXv1Vn9wTePqpHqa
         mZ6Uj5nBsRyRQb3I2Yi9GK5uSkQQepQ1AKM0hLTLUDrhcXlaqlC2YcM2muz09EiLD/nk
         vQrvRUdmhY3YMiPFqle3WeitjTxffjpikK9v3IGJRaFo1YKH3aY9C5AvyY8UaQkkCKXn
         EsD4LImQfMIJh9DSNVjw+L9ruvCJWDMSZqIjEUvXMTkoXicycVegwv/t2Kby/I/HldDH
         KzrlZLZTksRkRD+DoznhQDNi8+POO9oY2VtSFfCHLMkPnIQNIJcGP1U4XGKqAi3TuUbR
         Ongg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095885; x=1781700685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/o+UCNV6jZFXH7IOUDDk1tmgi6aBRIROCOUfOa2J4c=;
        b=D6em999PTwcJNZuJ3gX5Yw0T7PKNMu+rBxiUF4RQ1uch5tNJ9o/5vRUUUE5lToqQyg
         HxPifGehd80prl5m7WkQmxOEQdCORxi49zagbuJcKX7vbSx7IWsP59Ufk2QfVgd4Ebug
         yfwWEunjmDZhzNHggXyBM030JfLZvMGqyKWQwKJkbPk/1cdZY2Zdpo9TSKBUlSoWuI/+
         RsZCvhyZTqlyOWhfE8MQyswTKuavIYHDKcZmYQuWZNP+adTSY0uzrP9ozTtNI48VXuQC
         PSZv/W1lHZzQ0Dws4jjp1KpQUuTAp9YiRFVfJAcP8LspfPcTHYEhLgZAqwLu60AOYQSN
         m+tg==
X-Forwarded-Encrypted: i=1; AFNElJ/gPju69bVL3HeLcIIUQNMIuulAnpzgwjzVJavl/kTlbQUnb/W6kC5L85Vewaev4LBz7CUbXorNha3VIwc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyY9kSNWs03C9DUL86F5H9LWLRJhMpkdfDmQaHJ6rIytyE1DVuF
	tBTFgk5sUpkE2KQa/OWSgpnp8vCYaQPxeIpzRJIbWvuegCkupe9i9IYrbzgcQZckmV/VmBQV4O0
	jDVIW6g==
X-Received: from plch21.prod.google.com ([2002:a17:902:f2d5:b0:2bc:ae06:63be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3888:b0:2bd:606d:b339
 with SMTP id d9443c01a7336-2c1e80ec394mr315606005ad.21.1781095885232; Wed, 10
 Jun 2026 05:51:25 -0700 (PDT)
Date: Wed, 10 Jun 2026 05:51:18 -0700
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
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
References: <cover.1781093720.git.ritesh.list@gmail.com>
Message-ID: <aildxtZhqEFYygp2@google.com>
Subject: Re: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> Nicholas Piggin (4):
>   KVM: selftests: Move pgd_created check into virt_pgd_alloc
>   KVM: selftests: Add aligned guest physical page allocator
>   KVM: PPC: selftests: add support for powerpc
>   KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
> 
> Ritesh Harjani (IBM) (6):
>   KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
>   KVM: PPC: selftests: Use u64 instead of uint64_t
>   KVM: PPC: selftests: Use s64 instead of int64_t
>   KVM: PPC: selftests: Use u32 instead of uint32_t
>   KVM: PPC: selftests: Use u8 instead of uint8_t
>   KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and
>     gva_t

Squash these typedef changes into the patch where the "bad" typedefs are used.
Give yourself attribution for Co-developed-by if desired, but don't introduce
code only to immediately fix it.


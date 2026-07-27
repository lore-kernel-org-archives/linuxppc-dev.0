Return-Path: <linuxppc-dev+bounces-24908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31600C53209
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 16:51:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h84PZ23Jhz2yhD;
	Tue, 28 Jul 2026 02:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785171106;
	cv=none; b=KYmruGFN0FG+8lH1aVCyiGVWAobgcrQnp7RWIdNfFGluzjWgvtUVXxnghLM31EmDvlqjNVrvp6iSwM2Fy3FGU1WTJwN3jWXESJ5BA9Pm/0m3a+txk0/PN7ZI2a/U3YXWZ0a+lN2IR70Y8qCH+uQbS69iYoDj43xJldpY5KM6uACxv5OYvaSnGbDvdygPPZkKuPHgZmHk2BIjlGlADMRwkVYWbib0EaD8N/JILJ9kwrnH3EWWehpJEzv3itoN8PyRr9+nyuIDPrFoObH6N5Keevfmj1i6GFl/58YdWGWogQMdbxiLMlrGnP72jNBkp+stwZCAkURzlGvHb5BAQ5UdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785171106; c=relaxed/relaxed;
	bh=xxJEZg7vUALjJuP8RoVIiQSVR2Zrzga/oBqizYY9xTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gN0z5VXc4JahkVieVnrVgxXP3DXWlYpAzyfMDHlfj8jyZVVhpKRWbXuHwll118wKVQPX6p0VL4Uh5z30JQUH10LYU88jQ2g3tB1sqYo4pdqCc7FUgytLJX0nLrl3fdE6h6PzcXgLbiphM53DP2uJQ6x/DN2loXVC+Dgi9hb0owZRCcO9XGnJyQE071Mi0zeXJPFV2nCCEEh4f5zqHNlBUgdvslc/gxYQ4IoZ2Ds4y5T5SlPGHmnqbdYUe3vv9R+yAmCN/3QJ7tCAn0jaUD/yqfRIgD5oiDEvlrLvJy7drAcubLj2UEWQQy7kGqf8F7K1JQPBcAeZvl+MOVFUq0YOYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAHtcCYE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bAHtcCYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h84PX1H43z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 02:51:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9262140A10
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 16:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7584D1F00A3A
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171099;
	bh=xxJEZg7vUALjJuP8RoVIiQSVR2Zrzga/oBqizYY9xTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bAHtcCYEPLLZMcB12uriiK9CeM1tDIud+edM/OOPsFCsd73ujkTWp1xIJeaENrAPT
	 7DozkQDG6X9tfeEJB4HFBQvHSv8FUFnYe8gmCb62xdmaQNB0rHEfAP66VDT9h0oWfu
	 cXjvKyBI1ccNVDFh4yxqpSSPKrAjo8LrdYUeT26krAnVYF0ODNuxaQz/GsNOdzS5uH
	 3ruzuNXWWzsCwtnqBNy+zWvsVHH1WybPRXJ2IG1SrpqjDurmejKRp6pU+NBltqYWIi
	 jrs5kEUFh9VvyoknyTFJFpaDsOXAHt42ehs7Q8iKOUyj3omYXLOPaVGndj7Pta4A4d
	 OpW06MeL5V5dg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69f7130b47dso5090067a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 09:51:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RryI/C+fs9FS0/0+q3OdmJg/MAj9g32W4sx5gzqvF7MeUIqqDCl/93o2ECiEDneKpxAmOsyn7naFzUn6f4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvaZmsxI12HpRrePSwCWx1IAH6UKyPjTefRxA2PwCYL+Hz55hx
	g9LXm4dL36PUIx7fm8mw6LShLtEBVRZLk5ZsB8kVvJOsCXsIf17qVl3RFXr9p9pBQSKlGsd6wv7
	hTE2cNx8iXI4Wr75ZeFRzcvmBvQsyFZc=
X-Received: by 2002:a17:907:2684:b0:c15:cee4:5244 with SMTP id
 a640c23a62f3a-c1f1ed4d28bmr438177566b.21.1785171098345; Mon, 27 Jul 2026
 09:51:38 -0700 (PDT)
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
References: <20260724004757.131420-1-seanjc@google.com> <20260724004757.131420-2-seanjc@google.com>
In-Reply-To: <20260724004757.131420-2-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 09:51:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM+8yZaBgTWU7+1hkH05xKB5HXTA_LfL3XufAsmbchfBg@mail.gmail.com>
X-Gm-Features: AUfX_mwlM5e4kOP6Ulc-v-gUb2eG_h55GI6PTI7lcg4kw_x84uqtH3R6cnOk_Rg
Message-ID: <CAO9r8zM+8yZaBgTWU7+1hkH05xKB5HXTA_LfL3XufAsmbchfBg@mail.gmail.com>
Subject: Re: [PATCH 1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is
 cleared on VM-Exit
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:48=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Always check and clear KVM_REQ_GET_NESTED_STATE_PAGES when emulating a
> nested VM-Exit to ensure the request is cleared, even when KVM was built
> with CONFIG_KVM_HYPERV=3Dn, as KVM subtly relies on the "check" to clear
> the flag and thus avoid double-mapping the vmcs12 pages, e.g. if KVM
> manages to bail from VM-Enter without processing the request, and then
> emulates VMLAUNCH or VMRESUME.
>
> Fixes: b4f69df0f65e ("KVM: x86: Make Hyper-V emulation optional")
> Cc: stable@vger.kernel.org
> Reported-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b5460de4b1a7..f2518d67e7de 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5066,8 +5066,9 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32=
 vm_exit_reason,
>         /* trying to cancel vmlaunch/vmresume is a bug */
>         kvm_warn_on_nested_run_pending(vcpu);
>
> -#ifdef CONFIG_KVM_HYPERV
> +       /* Note, "checking" the request also clears the request. */

kvm_check_request() is in dire need of a rename.
kvm_test_clear_request()? Then we wouldn't need such a comment.
Obviously not as part of the stable fix, maybe another patch or even
separate from this series? I can also send a patch if you prefer so.

For this patch:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>


>         if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
> +#ifdef CONFIG_KVM_HYPERV
>                 /*
>                  * KVM_REQ_GET_NESTED_STATE_PAGES is also used to map
>                  * Enlightened VMCS after migration and we still need to
> @@ -5075,8 +5076,8 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32=
 vm_exit_reason,
>                  * the first L2 run.
>                  */
>                 (void)nested_get_evmcs_page(vcpu);
> -       }
>  #endif
> +       }
>
>         /* Service pending TLB flush requests for L2 before switching to =
L1. */
>         kvm_service_local_tlb_flush_requests(vcpu);
> --
> 2.55.0.229.g6434b31f56-goog
>


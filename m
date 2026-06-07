Return-Path: <linuxppc-dev+bounces-22154-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6A7CD8C88
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2026 04:41:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gY2ZV1Fq2z2ySD;
	Sun, 07 Jun 2026 14:41:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780807314;
	cv=none; b=Yrkfz9HNt0pOG0iz/UdgV0zX9Ln1BexI3O5vyByNaHVY0Fj3VAoHmkc4cDcRRB8f2Zm8f54jfDtUpF+TB1hKVvxRXXqAarS/5SpZdQlqy2MKoi+H7DOL4XNFJLhpGp3i/z/n0NoZV+j0H0DLgos2OwLCEJ/vFmwK/5+C6qOZqywTer0eEWPv0L6/jY6DZhDfbpb+AcGqdLaKEYraA/CqW42E9XrrixFyh3l49oNPRYSRNwP9+UFvzneijJsb2uV4SE0TUnFRFq6JB4ptPE34QiK6+fxcKW9VRUCs/vuTkdKmRUEZR9ESc49PUbkEtAC7oKGKPIgJ4kT1P/hrxxtlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780807314; c=relaxed/relaxed;
	bh=wjgnXGDtibQBEb4kF61nGsrg+xeD+keGIY9o1YJM9qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMM60eLOFSkIVhw5ujT6N7cPNtF3xhSLl9q72aGAoEklGx80upnAaCOxm/WAOL1z8mgtfmJx2pw6l5lcC2w4NjwkO6AOxo7sKP4VbxCeD9V2JJyWH/b5xGlCCcn/a1gz/93cKiFhd5OS1qgic+dJaeelXKLcbn3C9T3tAyl58rt3zvsvFlWiQKIuYwjXnRWFN9gO1rx19wzVH3qocah55Gng69YSKSwAnAmca2bBFrMHwBUKxz6o+Bes1CQHtj31+ARTn5apSOZDnSYwOrBsbsM6iqzuaL0FXMrezi4txrXrdczh35vMWPjWjI9VLGrULYgsHbgkCWsq4YC/vpT7+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fteKFm9Y; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fteKFm9Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chenhuacai@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gY2ZT0MCqz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 14:41:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1360C445BF
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jun 2026 04:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C741F00A00
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jun 2026 04:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780807309;
	bh=wjgnXGDtibQBEb4kF61nGsrg+xeD+keGIY9o1YJM9qM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fteKFm9YA4ySHooSBYi+3hZuo4tevzziErV6uJjyIEXwH0UO7GjxEBcE5HXqujuNK
	 QQUZ5UX206OAPY+ZO1oa+PoP2iHewnyZzlDuLVJiDPFq7baenTaDRGrHkD0b+zy6pn
	 V32Agy9vX6LQr7w+1r0u1gGPKR+Dh6g59R1iMaK4vOK5Lgn0BwhYiiQJnpnH8OvdwS
	 EST0L/tU/bQVA15oV6ejhUfMK0GyLIji6ltwn5dzZla/AtVanOWeVdBs5jW3TXlZw6
	 JzXT/GRQNb+HpmTTBXNPSnKU64DVmzisSr4kDiU8G3FGq99ouaUrtd+PxiYQ25iByF
	 I9rGL4hl3wofQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so3246283a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 21:41:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ931JfmBQaJxqEs3FhNlCzMrLL4Hl30ji1FYrYOOatLpchUz4kgB1gGpJNfVqk8uPVlRtV1qxfpORbdjc4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzfWroYi6H1lwxKgL7pW0TZPbVG59GnGT+9oa/2MIvrRGSnaPT8
	laRefEOJPt1kLhotKpTjLlFR3G7ivnSAGIOOLd4pYhWb3QUPIYIGdx7vs/0690YeM+GjoWKC58H
	vYZBcuvvXuWcrVN2Xc9Sk7K4C7eVtg1A=
X-Received: by 2002:a05:6402:51c7:b0:67c:a6d1:c48b with SMTP id
 4fb4d7f45d1cf-68fa4e2c7dbmr5058461a12.11.1780807308444; Sat, 06 Jun 2026
 21:41:48 -0700 (PDT)
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
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com> <20260531135326.2238555-2-yanfei.xu@bytedance.com>
In-Reply-To: <20260531135326.2238555-2-yanfei.xu@bytedance.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 7 Jun 2026 12:41:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Gk4dDek5HnKx5f_oSZ00ZWnk5Nf5ygiGKE22z8vDCqw@mail.gmail.com>
X-Gm-Features: AVVi8CfdV3X5ExYzOTFbLqmfRbAXzH21R98_Jvaw8v351jsO4seqkdKvp64fjAM
Message-ID: <CAAhV-H6Gk4dDek5HnKx5f_oSZ00ZWnk5Nf5ygiGKE22z8vDCqw@mail.gmail.com>
Subject: Re: [v2 1/2] KVM: LoongArch: Validate irqchip index in irqfd routing
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	maddy@linux.ibm.com, npiggin@gmail.com, sashiko-reviews@lists.linux.dev, 
	seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	stable@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com, 
	fangying.tommy@bytedance.com, isyanfei.xu@gmail.com, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Sun, May 31, 2026 at 9:54=E2=80=AFPM Yanfei Xu <yanfei.xu@bytedance.com>=
 wrote:
>
> Sashiko reported that the irqchip index is not validated for LoongArch.
> Add validation and reject out-of-range irqchip indexes to avoid indexing
> past the routing table's chip array.
>
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kern=
el.org/
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>  arch/loongarch/kvm/irqfd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index f4f953b22419..40ed1081c4b6 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -51,7 +51,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>                 e->irqchip.irqchip =3D ue->u.irqchip.irqchip;
>                 e->irqchip.pin =3D ue->u.irqchip.pin;
>
> -               if (e->irqchip.pin >=3D KVM_IRQCHIP_NUM_PINS)
> +               if (e->irqchip.pin >=3D KVM_IRQCHIP_NUM_PINS ||
> +                   e->irqchip.irqchip >=3D KVM_NR_IRQCHIPS)
>                         return -EINVAL;
>
>                 return 0;
> --
> 2.20.1
>


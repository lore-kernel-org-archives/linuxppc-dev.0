Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C3606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZI8yb8L
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXygV6GDpz2xGg;
	Mon, 23 Nov 2026 18:46:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795419990;
	cv=none; b=gIJwsCBcGBq4tE1EL2U2ESBajVL1rWMEuq0JFePeeBazPh7LGm+YxO5vkvsyXWASFECQ9oluKTucZJtUe31lC/epcZ9JrediB2BfQ1Iirz2i18xjPmZR22MClnMkwcREl9x8MiOm7cHiSuib49DbS23kBt88Ua3ddinZng1IxKbUyEfaSKdMnY2R4UIW3D0qKwyVguvQZCUvbfEg9SPYXb5SfWJzodcn5f4QjLfjZboS2Xws02wrGwtRVKH89HMFjl22Ni6KN/k2y38QOfvR1nY2OpsJ9YB6E8GKDza04D2hU2t50kkMc+XZ1R4aGU8MkqzEx19E4axI4TJWJpyIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795419990; c=relaxed/relaxed;
	bh=G46SljVUhLkLQuSEWLMybJUgwMzH8Uht7tF4gSH3iGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFIHQTqgcBDcivV/kzQpwFW6KWinODy0L4tMEDx5bg11Ba0Tj6hghyvcydojmI5aJ7KEq12iAq9EvqHs1g4tUn0/btOl/e8UKfFzESbNj8BaqULN6Bo1WWtRYE+ipI2nSqtZb+TQqrSyEyFH506Tb2oBRbR0Eis/VmdSz4xBZnNlWqyTOzf12hBY3JhG5Cv+57Mxq4ySdozH11P38fB3TkxtFbxdmB8D52PqzORDI76MLr4Asf+a2n9lQol3VhZlpDLv1rieVoXdDfjZO+HYn6XBaB9vTqyA//YnUDGo5zUFxmZ+DSZVMN8rhck7jUxTA8L0s+oZBRRYPK3lYsJTwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZI8yb8L; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZI8yb8L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXygV0S9Gz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:46:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C3F55408A0;
	Mon, 23 Nov 2026 07:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537931F000C6;
	Mon, 23 Nov 2026 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795419987;
	bh=G46SljVUhLkLQuSEWLMybJUgwMzH8Uht7tF4gSH3iGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CZI8yb8LlP1wNIcTPsNhNtIafBqdis8cmGzSD8bbOyq5NryPPJRiFpSYDhm7HlezF
	 jFdoNE0yZOfQ+4yPYh4egDAGtja+adFIXdGDVpA/Qga1cl9xlILz8f6cdcYS/zaPqO
	 97IUnfFeiLpiEtOJ5/6vHTotgTUFauvGubf9E1wsAZUQDS6c1NSbcIfSF8mmAByKxD
	 Wx4AhoDphVv7EEPSXqTSZW7CgYarxLnpt4CAY7FM54i5XOL+4B7hBQrdM36irPQebK
	 UQPXOi114FJ1AdPOrlT9nKB9Lm65dzwqE0cpklFbVrgF2LDUJO1CHJUkvPWDG5C2hU
	 MdhTtje12St7Q==
Message-ID: <91f869ee-8a2f-4016-8b91-893d26692b0f@kernel.org>
Date: Mon, 23 Nov 2026 08:46:22 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] powerpc32/bpf: fix argument passing for subprograms
To: Lukas Stockner <lukas@lukasstockner.de>,
 Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20261122194205.218543-1-lukas@lukasstockner.de>
 <20261122194205.218543-2-lukas@lukasstockner.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261122194205.218543-2-lukas@lukasstockner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 22/11/2026 à 20:42, Lukas Stockner a écrit :
> [Vous ne recevez pas souvent de courriers de lukas@lukasstockner.de. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Main programs receive a single 32-bit pointer as the first argument,
> so the current prologue converts it to the 64-bit BPF_REG_1 by moving
> R3 to R4 and zeroing R3.
> 
> However, subprograms are called like helper functions, so there the first
> argument already is 64-bit - but the prologue still does its conversion,
> so the argument ends up with its halves swapped and the upper one zeroed.
> The same problem applies to the return value.
> 
> In particular, in the common case where the first argument is a context
> pointer, the callee ends up with the upper (zeroed) 32 bits, which then
> triggers a kernel panic as soon as it's used.
> 
> Therefore, make JIT emit the appropriate 64-bit prologue/epilogue for
> subprograms.
> 
> Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")

Take care ctx->is_subprog only exists since commit 2ed2d8f6fb38 
("powerpc64/bpf: Support tailcalls with subprogs") which means automatic 
backport won't work.

> Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
> ---
>   arch/powerpc/net/bpf_jit_comp32.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index f5b9441cf46a..261ac0646b96 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -179,9 +179,11 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>          if (ctx->seen & SEEN_TAILCALL)
>                  EMIT(PPC_RAW_STW(_R4, _R1, bpf_jit_stack_offsetof(ctx, BPF_PPC_TC)));
> 
> -       /* First arg comes in as a 32 bits pointer. */
> -       EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
> -       EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
> +       /* Programs receive the first arg as a 32 bits pointer, subprograms don't. */
> +       if (!ctx->is_subprog) {
> +               EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
> +               EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
> +       }
> 
>          /*
>           * We need a stack frame, but we don't necessarily need to
> @@ -231,7 +233,13 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
> 
>   void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
> -       EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
> +       /* Programs return a 32-bit value, while subprograms return 64 bit. */
> +       if (ctx->is_subprog) {
> +               EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0) - 1));
> +               EMIT(PPC_RAW_MR(_R4, bpf_to_ppc(BPF_REG_0)));
> +       } else {
> +               EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
> +       }
> 
>          bpf_jit_emit_common_epilogue(image, ctx);
> 
> --
> 2.56.0
> 



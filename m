Return-Path: <linuxppc-dev+bounces-25029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041C5C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 16:45:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9J9p2Vlxz2xnp;
	Thu, 30 Jul 2026 02:45:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785343550;
	cv=none; b=jItAS6BkvyrWwUHrrxDxmkx7b6t+Gx/9Wsh/OIsSVyUXQmfAuHnS1mP4zq4PtOcNzZAEfxXnW7gFXyVEwLyMHRNhiVJ0/R5ehpWzmkO9yjv/uFti+4zlirWeP0B0qSA3wZDq8wuexBb8WbIgbtU1tcdKdLy/C7SpqYtxaxgZsAH4Wn9OnOvBsiD8CtgSFcqV+ADBpnvMODH9PPpa58MtdKL8+km8n0/VmmUUsz7iQPCDGg8ibifWWEtC3ULFDcev26H4LsCiGmZm3ZTOO8pPuFtTeu/QVNNd+mK9PdNTUEgZGnilPmOQHM4lOMbWVDnMpL6EqUTmbeQ59sMogl/GcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785343550; c=relaxed/relaxed;
	bh=fEVM9LDTkdkjBT40f5k0k+tzstOGdIlVX66IjRAKwZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+qL5A4lK2JC4idhBQZyi9DIyS4erbTZyKzPR1QwJOYVXz9Q1dM0JzU/lb8Phj0gDTd2VyHGfdKMfK3Twu1WJKW2vcjES+qribJusGChf4BuCvS799jfUgLhVyfQjuRr38DTZwzGkJYpp4IDz84XAQEhcvUEMr09V3KpVeaGKZfJeadPCEqytBbkkTQYm+LTXp+0U7pG7xAaE0DR+gLjSq/YitmNm9GzMXeEl4QWfGpAlhagV5e6ZyFhTIiZowbWXAeMithptH3YZNxZLh/l0fumG+3kC7i0+UweNg/7TJ4qvSvTHNz7pELkhINfvRu3Nmqsz2XWNUPD51lr4KBULQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7PU4flV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7PU4flV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9J9n1hWzz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 02:45:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E9594600AB;
	Wed, 29 Jul 2026 16:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A1F1F000E9;
	Wed, 29 Jul 2026 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343545;
	bh=fEVM9LDTkdkjBT40f5k0k+tzstOGdIlVX66IjRAKwZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k7PU4flVTv1a+BZ+UGI62Zo0muBhnbZtKgpBR4FEUS6Ko82gyoQvI78qWfVpadCfB
	 GHVsbUgobc8ocxb6NczKX26WeknZYlcSefgtfuS4lEDaPvEtjReUuFnWSWjR5sXQSb
	 tAEvwr9Sfcyo12hct7QM1Wm0bbbhD29N6wg1xm1DXVAJJzogdHcBSK/8MtqSg530Gf
	 SI8ihtFa2OgU61XMSRyCye1X2DufaxJAPMpNEdjNypBvmT22cmbfHj3Dx+Nvc9CPb7
	 1m1Npmk+h0H7gCNsZErspNJw7OeE9AVZlDxo/lItewa4U0QvwyLlojoJg8S5v2c8Qg
	 QEN0sG7ZS/KUQ==
Message-ID: <8e3aa8f3-c264-4568-a973-0595914f89df@kernel.org>
Date: Wed, 29 Jul 2026 18:45:39 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc64/bpf: Fix build break in
 bpf_jit_emit_func_call_rel()
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, hbathini@linux.ibm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1785339155.git.skb99@linux.ibm.com>
 <aafc721911eefc4ee376e27a0f4cebb82e3ee336.1785339155.git.skb99@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <aafc721911eefc4ee376e27a0f4cebb82e3ee336.1785339155.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 18:03, Saket Kumar Bhaskar a écrit :
> From: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:
> 
>    CC      mm/dmapool.o
>    CC      fs/readdir.o
> arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
> arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
>    475 |         int ret;
>        |             ^~~
> 
> commit b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> introduced "ret" variable to bpf_jit_emit_func_call_rel() and it is used only in
> else block of CONFIG_PPC_KERNEL_PCREL, fix by adding a "__maybe_unused"

__maybe_unused doesn't fix the problem, it just hides it under the carpet.

ret is used at only one place, move it's declaration their:

#else
	if (core_kernel_text(func_addr)) {
		int ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
		if (ret)
			return ret;
	} else {

> 
> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index dab106cae22b..63952ef19256 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -472,7 +472,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   {
>   	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
>   	long __maybe_unused reladdr;
> -	int ret;
> +	int __maybe_unused ret;
>   
>   	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
>   	if (!func) {



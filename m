Return-Path: <linuxppc-dev+bounces-29106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC10CA601D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 16:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1XGb4Rkcz30TQ;
	Sat, 10 Oct 2026 03:23:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791562999;
	cv=none; b=Evj3szkCH+DFZamep+vmhq/yau9ceowo5/amyca9KueuWtoolnNbOtK54XwHqW19FmTM+AwjibQ5hoqQHEdTMGvfkyHsOSNsg5/pHNffvERzm9QCXeO9eRxy2DMwzNhg++A6lWUviO05mktfJbre/mN9EH8vG1CqM2X8qSudgbR1faQvMhlVCthiNMaU6TT2IqQ2nEfYcKVY4GUf5y773/1B+Kpo1N8HWiUawYJg2uv+qx6wpopZZAG60NUlrdXSZxfrVJI88q7zyeATcTpULLPQrn0JMo8M187UpCFDzouXw70cH5N6IPZOdwqWRSSlMmb3dTuGaCk9fFReuYWgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791562999; c=relaxed/relaxed;
	bh=YfWBggPRcNUfmpocAPmpGBAvAjUX6S4h9gFS+GGWMfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyqTWyG6lDEENBKq4P2dJ0IHk/KBlKlsuA9Ije27O/yTQ4vwIgX7DnSuUorm/2/pNvQGNUgjDBL9C4I6dVYaCtD2h2EcC73FK8Yx3vt7a3XKfJ9j+g0facnOiyX2xOociBOM4ZQjzqPFv1o8m8QZjnJzlHiyMScRf0qAbL+c1AroF6r+GMuAjz6FyhjfB++FGOGLpPnqPSwCCf5crwCJdT00wEMbeLM2wAijW8VgIqGB7GzuBziD52G52ixmNoT/1osLiRQi5fH6Grj+Az1qqKuKvOWIO3osSXo3TBHzl8IE/y6hzH3dv8yDJzophOmnitA/tNlKCRMHuiW66HqHfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdqZDfCX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RdqZDfCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1XGZ4sr8z2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 03:23:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E6DA60098;
	Fri,  9 Oct 2026 16:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EB31F000FF;
	Fri,  9 Oct 2026 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791562995;
	bh=YfWBggPRcNUfmpocAPmpGBAvAjUX6S4h9gFS+GGWMfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RdqZDfCXJ+/1LS6pv+4dduHj4eW1XE2E6t7zJZQqkM6PoeYMuDwIyy7x/aqqF2jAg
	 pZpyADJFfR2Y/zGJLxoFOJSm3GM7AzHemdtW82eB528KrITgGYfpjErBMhxTIaNIRb
	 AtWwrVo4zGslaRl0SIrwyVXobipGuAx6KV9EI5tcxnz1/yrUeehqYh3f4vaFLAPCWK
	 twXdwvStfePpiuAM7XseTqi/1j78HWMV2XVUFE7GYndwfWizbfN20Oq/6FPrFMfC+s
	 TErWb4h0o3EAKHtlZ0ATAshCB0RepoAFAgMTnqHOliUoblfTNLooqDmmt41tAf8nOd
	 p2HL7bTxee0bA==
Message-ID: <509cac24-1b3b-4b85-8ad2-ef90da521dd6@kernel.org>
Date: Fri, 9 Oct 2026 18:23:10 +0200
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
Subject: Re: [PATCH] powerpc/lib: prefetch ahead in __csum_partial()
To: Rosen Penev <rosenp@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261008034932.3180490-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261008034932.3180490-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rosen,

Le 08/10/2026 à 05:49, Rosen Penev a écrit :
> __csum_partial() reads every byte of the buffer once and never touches
> it again, so on cores without a hardware prefetcher every cache line is
> a demand miss. After a non-coherent DMA the received data is never in
> the cache, which makes the GRO checksum validation of forwarded TCP
> traffic the top entry in the profile on a 464FP (APM82181): 22% of all
> cycles were spent in __csum_partial() when routing with GRO enabled.

Very nice patch. What is the new % after the change ?

How do you test that ? I'd like to do some performance test on 8xx and 83xx.


When you say "never touches it again", do you mean the data is not used 
again after that ? In that case would it help to do a 'dcbi' after using 
the data in order to make the cache line available again and avoid 
possible writeback to free a new cache line ?

> 
> Issue a dcbt four cache lines ahead in the main loop. dcbt is a hint and
> never faults, so prefetching past the end of the buffer is harmless.
> 
> On a Meraki MX60 (APM82181 at 800 MHz, single TCP stream routed through
> a qca8k DSA switch, iperf3 median of 3, A/B in the same boot):
> 
>    prefetch distance   LAN->WAN   WAN->LAN  (Mbit/s)
>    none                370        341
>    64 bytes            430        381
>    96 bytes            438        397
>    128 bytes           438        385
>    160 bytes           434        386
>    256 bytes           423        383

3x CACHE_SIZE distance seems the most efficient, why did you choose to 
implement 4x CACHE_SIZE ?

> 
> Prefetching the first lines before the loop made no measurable
> difference and is not done.
> 
> Assisted-by: LLM

In what way did LLM help ?

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   arch/powerpc/lib/checksum_32.S | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
> index cd00b9bdd772..5a14d45c7b9d 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
>   	bdnz	2b
>   21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
>   	beq	3f
> +	li	r9,4*L1_CACHE_BYTES	/* prefetch distance */
>   	lwz	r0,4(r3)
>   	mtctr	r6
>   	lwz	r6,8(r3)
> @@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
>   	lwzu	r8,16(r3)
>   	adde	r5,r5,r7
>   	bdz	23f
> -22:	lwz	r0,4(r3)
> +22:	dcbt	r3,r9
> +	lwz	r0,4(r3)
>   	adde	r5,r5,r8
>   	lwz	r6,8(r3)
>   	adde	r5,r5,r0



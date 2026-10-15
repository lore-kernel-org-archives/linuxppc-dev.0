Return-Path: <linuxppc-dev+bounces-29545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2ECC6B2F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 04:58:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4wnP55D3z2yqT;
	Thu, 15 Oct 2026 15:58:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792040297;
	cv=none; b=gaWXAHhSJe3nivdvhXtPRrQbRSOMJ/EXs/P5FFxZvO+Nw3SJpNueCKE8kYeqzSu16L9jiDqSabICLGdz9115vXLRfcvM2KGt/IS9PKlP9GCex9nfpvB8kxutNyj0aGjGvWdL5CSTjU1N2zOSqp3jgBdDvGNf9ebZq1Kf8nZhWW4GNbSVW+BLaUHqDzdtaes5A3/LN6xEa4qXJr7+ko9C5NvEfGSAs5hMIcliWojADR1Ma0nieJ3dJUv20hNx6sRXUjJuwgJJwFDosRsyUCp85/+j25dKul4RDBl5NTcpqFBF3Wuxouv9dBXx9CzMoNIRw2HaDs4eKRLYfepfZAUX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792040297; c=relaxed/relaxed;
	bh=q158/zsMzI1U2HCglnHVdw7Kf32xTgm9ETONvsqEy24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv97DArNREA6hiU+p3XGRm+3oZ7SxP/tgyVX9wzCuZ6eMIlZ4pEDebdVO8dV6wOO5K5Hve2aB0hpxoiLt6zwXdQTYmL+5Q9Yz2y6gRMBggF3sdWPbDvY8tsEKLYReuhj1OyMRa757KSkLYCeWIXB9fDqYXn4sSYLR13XkhO+anbhERjwbnJKVIMh9/IZdv6GIM7+KhxEkavTIUlE3nmHF1BAQ1Xxb8g6DTntqcpuCiamWJopTz35ZnD/o5QYaaftoiuiOdia4fTAFcb5udxMBcWrUmUXQgWr8+KKA35G/kaJPef19MvpYCpV7EIeJg18h7Glb4dHaPUcxe6C7cgeEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAZgCBxL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAZgCBxL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4wnN4FNjz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 15:58:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FDB341646;
	Thu, 15 Oct 2026 04:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB101F000C4;
	Thu, 15 Oct 2026 04:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792040293;
	bh=q158/zsMzI1U2HCglnHVdw7Kf32xTgm9ETONvsqEy24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kAZgCBxL9eWGCOft6x1B3Pog4zCC7kP68oCE/+IqtiQssfKJzgyecNjIPYVuyDvr3
	 DapY5jl3T9nCv6zkcahRLR7KNOd3X7bJSca6JbZS+rsmlvq/vwwXJohuBGd1n3iIcs
	 F5weX3FU8nrEYHDmhrYXyxoXdLfFsH9EGLKlR3F1BalCENigpxBAhDifuQZoFGJkcO
	 XFIMn0a++kcA/qjozmXaewiefl9OcXSPt/lQKBJM/FhYDLKvO5cxHtdCkAGjBl5bu0
	 LLzggU2Jgp3lQwFFtMOobLqm9PQm85mW6Nid7G5iCNDUuFmvIYpUkZJXsF68bXBbo6
	 Z9F6yQQvM/aoA==
Message-ID: <9e10a74b-a73b-4899-a652-898e21de69a6@kernel.org>
Date: Thu, 15 Oct 2026 06:58:05 +0200
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
Subject: Re: [PATCH v3] powerpc/lib: prefetch ahead in __csum_partial()
To: Rosen Penev <rosenp@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Stapelberg <michael@stapelberg.de>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>
References: <20261014194818.11640-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261014194818.11640-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/10/2026 à 21:48, Rosen Penev a écrit :
> __csum_partial() walks the buffer linearly and reads each cache line
> exactly once. On cores without a hardware prefetcher, such as the 464FP
> in the APM82181, every new line is therefore a demand miss that stalls
> the loop. Packets received by non-coherent DMA are never in the cache,
> so this is the common case for GRO checksum validation: when routing
> TCP with GRO enabled on a Meraki MX60, __csum_partial() takes about 30%
> of all cycles and is the top entry in the profile.
> 
> Issue a dcbt MAX_COPY_PREFETCH cache lines ahead in the main loop,
> the same distance csum_partial_copy_generic() already uses. That is
> 128 bytes on the 44x. dcbt is only a hint and never faults, so
> prefetching past the end of the buffer is harmless. Lines that are
> already cached, for example when checksumming data the CPU just wrote,
> are left untouched.
> 
> Measured on a Meraki MX60 (APM82181 at 800 MHz), single TCP stream
> routed through a qca8k DSA switch, iperf3 median of 5. Only the dcbt
> was toggled at runtime, in the same boot:
> 
>                LAN->WAN               WAN->LAN
>                Mbit/s  csum cycles    Mbit/s  csum cycles
>    before      495     30.5%          439     27.2%
>    after       599     15.3%          520     13.7%
> 
> That is 58% less time spent in __csum_partial() per byte.
> 
> The prefetch distance was chosen with an earlier, slower driver
> configuration (median of 3, Mbit/s):
> 
>    distance    LAN->WAN   WAN->LAN
>    none        370        341
>    64 bytes    430        381
>    96 bytes    438        397
>    128 bytes   438        385
>    160 bytes   434        386
>    256 bytes   423        383
> 
> Prefetching the first lines before entering the loop made no
> measurable difference and is not done.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   v3: use MAX_COPY_PREFETCH
>   v2: reword commit message and retest numbers.
>   arch/powerpc/lib/checksum_32.S | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
> index cd00b9bdd772..5bb872e9e68f 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
>   	bdnz	2b
>   21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
>   	beq	3f
> +	li	r9,MAX_COPY_PREFETCH*L1_CACHE_BYTES /* prefetch distance */
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



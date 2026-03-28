Return-Path: <linuxppc-dev+bounces-18961-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AB110F3DCE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2026 12:09:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjbsz09PJz2yfK;
	Sat, 28 Mar 2026 23:09:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774699782;
	cv=none; b=NObwMk18PY7fT+4rBKNtjhmsSv5hEx7psxZyYJGSqiWQ4+T4eF/kzK920zgn52fUMV59kG6shYQ7U4HKbsw20r17neyBThKkJ52eGvvB9bs/P2QwIVZkGaUdCw5FuLgXcvMHNkDFCRKT3btOiwN4HdotTlKZtl/KKq0hfeLxo6gxtQE2bHcDeB88NebcqcXs8nVQosLgI/7TXpSLfeuAJzfyyLFAFrBmtMR/6bGpuU9jdQkK45pw/wSsC3bKFPixMm336Za9SiKlnB/MSxg55JptL5QFR4rFik8QJq7jDgpM2sX12SoD4rd6dv0ofNKvcwiGoXF94abbpsrhOAj4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774699782; c=relaxed/relaxed;
	bh=/gB2i70YY7tA8bB0dumzedAxykUOjDm3U5xR1oNIAtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lxaxyp60iyjU8ThnQv8ICBrn4WtSKwjHUyI0rcxAkZMe874m2QcRroe/E2CFao1Kr0nicIQsuFa3Y9JWgWOfLxq9F+54i1QsGkVhlYiJGdhQ9TTiSjGUQ7eRiPI+ojQJjAS0ZsPRE8uw6QCrZCX+13da/Ek2VWOzr6Jd3FojdguwQdD3zAftHmpvgL4DZEwjwzarJy4RV0szvtvRTR1PMQ/NX2nHQf2CbfJYduDZcsszo3EcBjYoxlFIQzLdwUx1Cn+oiSKw00aX+d4nFWRNmVGtX8S7jO4HeLXFPO1LnAqKvlTZMs/b0H3Q8ft5de/E8A21AhRi1ueemuD3DjUCAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k/r4m/ue; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k/r4m/ue;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjbsx5v4kz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 23:09:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F3F360008;
	Sat, 28 Mar 2026 12:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100CAC4CEF7;
	Sat, 28 Mar 2026 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774699777;
	bh=aj2WoZSD4Ghz0WN0CvxQLhesl3mrrJl9JZMEkXD6iJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/r4m/ueX4BHo3KpJu/EnzGu9hUWVECJ9zT43JbN/vOCG9z6Gnjl/MCj9KDym5wY7
	 neYO7SvL/1stOEBVXgVmmwlml7aAlX2WSW/IAPRNjXJPUFxhfnwk5xCehkqjQf7RDS
	 K1vNH4lR04IJWfDU+t/Betv8YLU8kJ4jUAQrTVP6vEZmNvQr1NHeH+vG6x99PokfiG
	 1P/ZhIc23nYpHyF33u6y5nhbBXp/hDkea3hwiGNz4EtbkgdjJOXtmm7ZgiNrmc7HuO
	 XWEtUeMRudf3FCXBvPIWjBPud2IEgBzp7fV6VgRWxoGkVbS8wy3w1q5ACAfXM9RS+Q
	 8HWkcVP97AgeQ==
Message-ID: <7d1b7aa6-aaa8-4116-abc2-382511823a9c@kernel.org>
Date: Sat, 28 Mar 2026 13:09:32 +0100
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
Subject: Re: [PATCH v2] soc: fsl: qe: panic on ioremap() failure in qe_reset()
To: Wang Jun <1742789905@qq.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn,
 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, stable@vger.kernel.org
References: <780c1ba3-6639-478e-896f-e35ec059b58c@kernel.org>
 <tencent_FED49CF5331CC0C7910618883332A08E2606@qq.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <tencent_FED49CF5331CC0C7910618883332A08E2606@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/03/2026 à 01:12, Wang Jun a écrit :
> [Vous ne recevez pas souvent de courriers de 1742789905@qq.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> When ioremap() fails in qe_reset(), the global pointer qe_immr remains
> NULL, leading to a subsequent NULL pointer dereference when the pointer
> is accessed. Since this happens early in the boot process, a failure to
> map a few bytes of I/O memory indicates a fatal error from which the
> system cannot recover.
> 
> Follow the same pattern as qe_sdma_init() and panic immediately when
> ioremap() fails. This avoids a silent NULL pointer dereference later
> and makes the error explicit.
> 
> Fixes: 986585385131 ("[POWERPC] Add QUICC Engine (QE) infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>   drivers/soc/fsl/qe/qe.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 70b6eddb867b..9f6223043ee3 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -86,8 +86,12 @@ static phys_addr_t get_qe_base(void)
> 
>   void qe_reset(void)
>   {
> -       if (qe_immr == NULL)
> +       if (qe_immr == NULL) {
>                  qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
> +               if (qe_immr == NULL) {
> +                       panic("QE:ioremap failed!");
> +               }
> +       }
> 
>          qe_snums_init();
> 

Applied, thanks.


Return-Path: <linuxppc-dev+bounces-18166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC66105F784
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 09:49:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKSc6G3Nz3cJk;
	Fri, 13 Mar 2026 20:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773395344;
	cv=none; b=ZUFvK1UThUkcQp7jTZUKXhPbbMX6qdPiQBlf2fIrQkajdyfZal/0MH2/osOWOW1kMeXBzrSV8aNouvfonKRtpHTvkICdlM/x66znYCODU/A71KBWY2du0pSUKArpUE9mrVEgO66bjkkqdFSpD8GbW6GXwlgvWkewbgeYgAX6kOypDaRg0KDa1+Ar6Oc9mRs6UVjdYBR53XaS4tjDTwn8rtMgaD2UBzSVScevL/fyk/oVE2fiLEXYF0y4hkxT0NTz/avFgg84OwUfHEFiYlJhvVtPcVn7GwQpSKq/H/rmF2Kb0N5DkO4qKAeEruZzHXceqcMHy2X2eRoz1UVoMKjQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773395344; c=relaxed/relaxed;
	bh=MHwYA1W1IQi+TgYZi6GrR6X4lMBE3zhq0tACs7lCsMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY1c+WwC8JHKMcdbHuhFQfl7elIFBhwtT0gmIKAaVNexKbodAj8YCPBqoy2vS/AiUuq+bFZhnJN9JjjR5S/d9XTjC0K+4iNocdai02k6FW7Zd8ZimDIkRxgBtQ6AC/IOLeEsobpCW9RrLWLKs6qfbD0HildZexhb9M0JfzbsxN6YsXuj5oj+db9M1cTKJY4mYxZhfCXWGl53tFYQKKcxndo/1ufSkTnjc/6vQbw9lBk2sWGyTEuGmZDd0DSK98cdoBoTMmCnRM84/LzTY0zrmt9vwQtc1wrZviGYAgStfMiP1yN4uVRuRFGW6ZoOuw2wRLrZ4bKhHTKWOpFUPgzFnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kTw1ztA3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kTw1ztA3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKSc0Ywrz3cGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 20:49:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BA84443B0C;
	Fri, 13 Mar 2026 09:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3000C2BC86;
	Fri, 13 Mar 2026 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773395341;
	bh=oAgFwrScPql2AWiBscKgibXmMr5JSzF2SqWNp5f2qZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kTw1ztA3KdCSP6Mv215qu8SBoPDb5oJ/cwv4S7mrqECq33qLuVHX/kyqNV3+oUyjF
	 nG+oU4DcMcQt+fXw6U7b1T0x6YE0K2N8AYSLzHhpMQzmRL0cQ7paognxx6gFHGHLtE
	 pmWm4TygnnqMZwLMLUVhNBuhGp4m/5On8thpLrkKqLHe6xQh3UcFgLF/vOFnUoR8kO
	 27KkcAsLYKGaRAA9dvTNKpYfOIbTNJHmiXU3tKiy6GxVI/sy2JcpxFPElSJOl4HdnL
	 xAH63oGiBMy+hHpuZF5TZtYENpYXxJgnGPVkigzqijfmLIhLSrOakYngzhFkQa6Xlt
	 VPhmZddj+fQaQ==
Message-ID: <7e0425c2-debe-448a-a5f9-26039de71db5@kernel.org>
Date: Fri, 13 Mar 2026 10:48:54 +0100
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
Subject: Re: [PATCH] soc: fsl: qe: Fix potential NULL pointer dereference in
 qe_reset()
To: Wang Jun <1742789905@qq.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn,
 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn
References: <tencent_770FE404794D670E2ACDFA144EFDA35AC305@qq.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <tencent_770FE404794D670E2ACDFA144EFDA35AC305@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/03/2026 à 13:11, Wang Jun a écrit :
> [Vous ne recevez pas souvent de courriers de 1742789905@qq.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> The function qe_reset() uses qe_immr without checking if it is NULL,
> which could happen if ioremap() failed earlier. Add a NULL check and
> perform ioremap() if needed; if it still fails, print an error and
> return to avoid crashing the system.

I don't understand what you are trying to say here. What you say is 
already what qe_reset() does: it does a NULL check and performs 
ioremap() when it is NULL:

	if (qe_immr == NULL)
		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);

You are adding a second NULL check and return early from qe_reset(). But 
it doesn't really fix the problem because qe_immr is used in many other 
places so you are just delaying the problem.

What needs to be done is that if qe_immr remap fails, all drivers 
depending on it don't get probed.

> 
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>   drivers/soc/fsl/qe/qe.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 70b6eddb867b..6dcfa340970a 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -86,8 +86,13 @@ static phys_addr_t get_qe_base(void)
> 
>   void qe_reset(void)
>   {
> -       if (qe_immr == NULL)
> +       if (qe_immr == NULL) {
>                  qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
> +               if (qe_immr == NULL) {
> +                       pr_err("QE: cannot remap IMMR\n");
> +                       return;
> +               }
> +       }
> 
>          qe_snums_init();
> 
> --
> 2.43.0
> 



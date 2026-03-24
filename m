Return-Path: <linuxppc-dev+bounces-18719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EDCF54ABA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 13:47:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgBDL6Nt6z2ykV;
	Wed, 25 Mar 2026 00:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774360034;
	cv=none; b=gyI0Y5fPMItOJoi+uc4Dv58bbBiM723r0h5Q4XORybxtspRyWvoYyen+L5Q+HVzi+bL3u7uxguX2gZv9FpFBNYhCcJCSl9w4a8DeaoVode41NDLUu41uk9V9YUZyRvlE3A4dTTraxQGPVfxb0NMSDkyBUkw3NRgnvJoGEru0og6DWnLr7MTVMUviEcfH8bx1YqmzGbsc2GAU95XZlVoMEMoWhzmMgCh1V/N7pT/wApYtu0Nucw03CrTW2NJBx55vwnKhVSyLFkPAnZ5FhPc0g/v/WaxueeudcQHYE6REdv8yP/JrPhsDnbR0W4u2Gvl4bvl1PU8kD34H3MNgPWsZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774360034; c=relaxed/relaxed;
	bh=Y6DylKeCYm3VDED+c7LS4O9E/kdD6gkIBVVmWVWmR3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8f7CMQeyYpr5pR9trGxHLDYbddT+gObhLorq1QxMolcYbhnzlHP3rmcsbLXdpKowVaLDKR1EfjETWUMWh95jBZeXZF8EmgAD3wBsrNv4qrCa7iJhHoQXUr4ovUzIGNQcKD3vO1uxqWRdR2I5qPqU8rulR0yp+xjb6C3VMhIO+h8rcCj4BxsfKyEkn2GZ7az+2QOyUW57tiDEhMABMSU3dGqFS5q1L+Tz8ZsQ85A2vLzYYLrJa9cQjRPzwFYGNoPi5XC84WVGiWU1OBHVREx9DBc4QaKC13Lo2vFauz4InI7RtoqPuBbHOpGD8jPkfskkjfVNT7p7p7MLSRRjKsq5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YTPWewIy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YTPWewIy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgBDK2ZK8z2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 00:47:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 416D26012A;
	Tue, 24 Mar 2026 13:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E28DC2BC87;
	Tue, 24 Mar 2026 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774360031;
	bh=P7hdlk9agELe0A1qr6nFer12udYaXk1PPxLMDqx39ZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YTPWewIy2XjmxYlPmx78726H6Q3b3o2/K/XUTePzsvwm3uznu6RxSQ9VVOI3XlzOG
	 HsrbKbDCx3m9YmyaD3qdFsMmBHphI8gV8cNWgVIhnQPUqzkVJcCVavloxupaiM3Bm6
	 gr3e0Px4RcxCPcL83D1wX9JJc6dId3W2C4QqzltZ/kcXDNKp3m5fD4ExEn6LR+XdUP
	 PelNtyhfO1qewjmDgvfR6vVAiq3X/L5HZs831H4nzB/UTtvqLpliKm4Brg2uWgVMzM
	 9xAQxVjmsfR7x8Rkzygwl+RYpr/4lCFYaT1TqD0D9iSWCxDdCbIPG8WQDVTWpttBID
	 43LOH87Q4rQ6Q==
Message-ID: <780c1ba3-6639-478e-896f-e35ec059b58c@kernel.org>
Date: Tue, 24 Mar 2026 14:47:06 +0100
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
Subject: Re: [PATCH] soc: fsl: qe: Fix potential NULL pointer dereference
 inqe_reset()
To: =?UTF-8?B?5pyq5ZCb?= <1742789905@qq.com>, "qiang.zhao"
 <qiang.zhao@nxp.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <tencent_770FE404794D670E2ACDFA144EFDA35AC305@qq.com>
 <7e0425c2-debe-448a-a5f9-26039de71db5@kernel.org>
 <tencent_89405091B7744EA070AC53E11A3FFA355609@qq.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <tencent_89405091B7744EA070AC53E11A3FFA355609@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 16/03/2026 à 04:28, 未君 a écrit :
> 	
> Vous n’obtenez pas souvent d’e-mail à partir de 1742789905@qq.com. 
> Pourquoi c’est important <https://aka.ms/LearnAboutSenderIdentification>
> 	
> 
> Hi,
> 
> Thank you for the detailed review. You are completely right.
> 
> My commit message was confusing, and returning early in qe_reset() just 
> shifts the NULL pointer dereference to the dependent drivers later on, 
> without actually fixing the root cause.
> 
> To achieve what you suggested ("if qe_immr remap fails, all drivers 
> depending on it don't get probed"), I plan to do the following in the v2 
> patch:
> 
> 1. Change the return type of qe_reset() from `void` to `int`.
> 2. Return `-ENOMEM` if the ioremap() fails.
> 3. Update the callers of qe_reset() (e.g., qe_probe() and other board- 
> specific setup functions) to check this return value. If qe_reset() 
> fails, the callers will abort their initialization/probing, which will 
> properly prevent the child devices from being probed.
> 
> Does this approach sound correct to you? If so, I will prepare and 
> submit the v2 patch accordingly.

Well, it would probably work but is it worth it ?

If the board is already unable to get a few bytes of memory that early 
in the boot process it is unlikely that it will be able to do much more 
work.

Wouldn't it be good enough to just panic() when ioremap() fails, similar 
to what happens when qe_sdma_init() fails, see 
https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/soc/fsl/qe/qe.c#L101

Christophe



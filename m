Return-Path: <linuxppc-dev+bounces-25797-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02230C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLG6F2d5Wz2ySS;
	Thu, 13 Aug 2026 16:43:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786603429;
	cv=none; b=fu4ZZtotIUFroFpXTDAqEGOkhV2nydoHOIF6mxyESPpNM03AfV77uWKMIQJAKPBFOtLQyMrqCnFAsbHclFw9VvY3oQRacqFNv/hRuFi44xtNrl43PcSTkYX/t+x8XP4sS3Z233Dzp9zgYEllVDoTuSsyJ58NSiJMICpIMkO5fkkZ6k7Xmzcwk0UPCDSUWUIuwWtSxDXYJnWQN689xIVzuNpD8jUnh4ZGTtCmMIaibHOp7TKPiJJDdoRmouOUGSaRCQIop/mS66YBVkYA30OV3mEPWJeeqSALN/L/gDeq5NxzHaTbmpIwWBAnrNU9106Hjnvoxogd6S64sOd/0wQO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786603429; c=relaxed/relaxed;
	bh=XFgKbxGCajP3coDmnIYjkiHQjHBbDuCyITOEdlOzPWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICihzTStVi9wIuBNkWFOjQ6eyyDgVdGBTwaDINBtHuPYgBgNmUykteTQjsSI0CoA2VklHROkDdTsNsX2mAn+0nESnwvbvPGtQyZQVwg6A36y/nVgtOaKQtCZ46538MYxGRqdyZ2S/wc0SUHclyDN0fNf68Ov6Z85pK7/DogO4OLz2QQ1MGFKAg3UocuZwa4Pjg0V6snKTXn823FKRj0MnscKCx0j1HW0mcAEXuJOMJK4u5yVjkfNk00BYnUyOdh6OHPpYJL7heHmhvcCtLncqS/vFFkrvSybzuzEaY6ij4Q8E7Q8IhXbsQrZjiYj8Ds9CIOgEIEr9rJmIqdc0ggriw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeMnT1w1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeMnT1w1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLG6D4xVjz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:43:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2E2DC600AD;
	Thu, 13 Aug 2026 06:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253F81F00A3A;
	Thu, 13 Aug 2026 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603425;
	bh=XFgKbxGCajP3coDmnIYjkiHQjHBbDuCyITOEdlOzPWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TeMnT1w1ZOfCKqhC28oZV/K31yfax4HzC23rO12QjLHxAgapoZX/0bdkgVXoDeNrs
	 V+mnJ8AXxwP5Pqyza+qmSXlWpv1o8ZStUFq2BNpD8Q8TTE5bJabWc6GQi4ta9Sqn7a
	 JeaHFvymVHFDCQDsTW2tnn7C523ebHSi9BANynD45Ljh1HN3zxyt9kxnexDuXMMGvg
	 50CKQORLSEg1qxp8UK19UflEWJpax63AnKqf0kurzZ78XTMeJK7Xr7P9gSzrAJ8fHx
	 xZlRJAnny8uinUMmfxq+lzia1EaoZYrR8gBVAlu/LOszrxry2pe5cLYujLbXCvjznC
	 Ku4Y5vWEU0mDw==
Message-ID: <94e0d202-ad52-475c-89c6-69f7b77e0ccf@kernel.org>
Date: Thu, 13 Aug 2026 08:43:39 +0200
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
Subject: Re: [PATCH v2] powerpc/pseries/pci: Fix misleading VF limit error
 message
To: Jiangshan Yi <yijiangshan@kylinos.cn>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, nayna@linux.ibm.com,
 gcwilson@linux.ibm.com, kees@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 13667453960@163.com
References: <20260813063731.399598-1-yijiangshan@kylinos.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260813063731.399598-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/08/2026 à 08:37, Jiangshan Yi a écrit :
> When the number of requested VFs exceeds MAX_VFS_FOR_MAP_PE, the
> message prints that limit but labels it "Configurable VFs". Report
> the configurable VF limit and the PE mapping limit with separate
> error messages.
> 
> Suggested-by: Christophe Leroy <chleroy@kernel.org>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

reviewed-by: Christophe Leroy <chleroy@kernel.org>

> ---
> v2:
> - rework as suggested by Christophe Leroy: split the two limit checks
>    into separate blocks, each with its own dev_err and error return
> 
>   arch/powerpc/platforms/pseries/pci.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index d11a64a086c1..6fc13f4a79a3 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -132,11 +132,14 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>   
>   	/* First integer stores max config */
>   	max_config_vfs = of_read_number(&max_vfs[0], 1);
> -	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
> -		dev_err(&pdev->dev,
> -			"Num VFs %x > %x Configurable VFs\n",
> -			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
> -			MAX_VFS_FOR_MAP_PE : max_config_vfs);
> +	if (max_config_vfs < num_vfs) {
> +		dev_err(&pdev->dev, "Num VFs %x > %x Configurable VFs\n",
> +			num_vfs, max_config_vfs);
> +		return -EINVAL;
> +	}
> +	if (num_vfs > MAX_VFS_FOR_MAP_PE) {
> +		dev_err(&pdev->dev, "Num VFs %x > %x PE mapping limit\n",
> +			num_vfs, MAX_VFS_FOR_MAP_PE);
>   		return -EINVAL;
>   	}
>   



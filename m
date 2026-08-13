Return-Path: <linuxppc-dev+bounces-25785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA3DC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 04:56:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLCkS1rrDz2yXj;
	Thu, 13 Aug 2026 14:56:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786596992;
	cv=none; b=gyA9gNCl6ibuCXpQKwOoivHHlQS8xpg/EjwjITUG4RvYu2zqvuGA7ixVlZxd7vFIQldq/IfHItO8z5R6FRjMAaci2z6+CcF7EnsXdDxzoL0B7tuFzAS2S40hVLjU14epZjbmPerRPkrX/N9Es9eKMN/skfCSB6clHq5Sw5mAzF4Z+gY7koopvK1qOTxe5MPLhXuFT0/fZ/4j77gOaKzooTrHQpS1xJ/dq24P78pfLgwEqGLkGfWgSuPlsqyMYSIPuxqHY5qC1+ItI+oqU0UC/Sb6L37sWsOJ/SaYOEQHeNVpkPjw3UGFGA5DkBhLidZWduf2AVzS5jRX2dFDdht31g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786596992; c=relaxed/relaxed;
	bh=oGTZ2lxO6SWnrcJg/cD07+Rv5kqoQMTTilWNtoVTqpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lm7SOHzrnV9L9YqL55K6gI2Uzkf4YSkQvKtauqgPbfMpLMtZEuD8mYblVLEm1aWU0XUsVPUFV+Ayr2f7El7PzGYzBP0nhQSAcqh03XwJRgBhbEtBf5i8bqjnhYeYky2sUypMm/X1wJOYGYa8GOce0Iox5cbw1YWpWfyA8ngBe5Fj1qNYFYk62kT5gf1QCNnFFc+81B2RUb7ZyBKGiEd9X7MRXAj1CaZFPrejr0Kg/gd1H23EVtrezW2CSa6ycbztBQVviOiSemi3InrbS1qgaqb1EUysiyn2pOVGQWg0/EUD+nmzYe3kUYyP2Qt/YVD63CjQoRRWl4JUe1HHDbfpwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfGPSSgC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfGPSSgC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLCkR03Wwz2yKD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 14:56:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AFEDB600AF;
	Thu, 13 Aug 2026 04:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78EA1F000E9;
	Thu, 13 Aug 2026 04:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786596987;
	bh=oGTZ2lxO6SWnrcJg/cD07+Rv5kqoQMTTilWNtoVTqpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kfGPSSgCQ190k/T7wCVbovGG/5MvL3mHscqlAwOcCT7tKWPOTaDF3DEUopRzoBS2M
	 26VdL9s2TKz9dcDd/muDZS65Qwxs30ZujuT7uU2smyBKIdQ0dNvzXnsFJS68RWF4DP
	 xyeJ6O3LFURYjxClQYbMwPdbCOjozJd+PZgNMoAyaKUEcHI64ULZ8j32T8UuMZ9Hs4
	 7IMTQPpSHi9yM7wyhhRWR/W0hXdZ+IAKqrTihwatjMctNCYzmQEkNjSa22c88m8eEz
	 EevZi1YTLDi1cZ4cU36c1psc0ZQWjoxX53Lty5EvPIsyckH48YuB1G1wgtRP3wca+x
	 EEmZYOIn2Nj2Q==
Message-ID: <0798e7f0-47fb-4cd1-9963-5b22f6564e03@kernel.org>
Date: Thu, 13 Aug 2026 06:56:20 +0200
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
Subject: Re: [PATCH] powerpc/pseries/pci: Fix misleading VF limit error
 message
To: Jiangshan Yi <yijiangshan@kylinos.cn>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, nayna@linux.ibm.com,
 gcwilson@linux.ibm.com, kees@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 13667453960@163.com
References: <20260813035323.245229-1-yijiangshan@kylinos.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260813035323.245229-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/08/2026 à 05:53, Jiangshan Yi a écrit :
> [Vous ne recevez pas souvent de courriers de yijiangshan@kylinos.cn. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> When the number of requested VFs exceeds MAX_VFS_FOR_MAP_PE, the
> message prints that limit but labels it "Configurable VFs". Print
> each limit with its own message so both are reported when both are
> exceeded.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>   arch/powerpc/platforms/pseries/pci.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index d11a64a086c1..1e1903bf3f1d 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -133,10 +133,12 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>          /* First integer stores max config */
>          max_config_vfs = of_read_number(&max_vfs[0], 1);
>          if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
> -               dev_err(&pdev->dev,
> -                       "Num VFs %x > %x Configurable VFs\n",
> -                       num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
> -                       MAX_VFS_FOR_MAP_PE : max_config_vfs);
> +               if (max_config_vfs < num_vfs)
> +                       dev_err(&pdev->dev, "Num VFs %x > %x Configurable VFs\n",
> +                               num_vfs, max_config_vfs);
> +               if (num_vfs > MAX_VFS_FOR_MAP_PE)
> +                       dev_err(&pdev->dev, "Num VFs %x > %x PE mapping limit\n",
> +                               num_vfs, MAX_VFS_FOR_MAP_PE);
>                  return -EINVAL;
>          }

What about the following instead, to avoid the double 'if' ?

diff --git a/arch/powerpc/platforms/pseries/pci.c 
b/arch/powerpc/platforms/pseries/pci.c
index d11a64a086c1..6fc13f4a79a3 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -132,11 +132,14 @@ static int pseries_pci_sriov_enable(struct pci_dev 
*pdev, u16 num_vfs)

  	/* First integer stores max config */
  	max_config_vfs = of_read_number(&max_vfs[0], 1);
-	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
-		dev_err(&pdev->dev,
-			"Num VFs %x > %x Configurable VFs\n",
-			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
-			MAX_VFS_FOR_MAP_PE : max_config_vfs);
+	if (max_config_vfs < num_vfs) {
+		dev_err(&pdev->dev, "Num VFs %x > %x Configurable VFs\n",
+			num_vfs, max_config_vfs);
+		return -EINVAL;
+	}
+	if (num_vfs > MAX_VFS_FOR_MAP_PE) {
+		dev_err(&pdev->dev, "Num VFs %x > %x PE mapping limit\n",
+			num_vfs, MAX_VFS_FOR_MAP_PE);
  		return -EINVAL;
  	}




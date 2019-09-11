Return-Path: <SRS0=eZMg=XG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C499ECDE27
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Sep 2019 06:33:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D85C21D79
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Sep 2019 06:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="b6kl3dFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D85C21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46SsY109MRzF239
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Sep 2019 16:33:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="b6kl3dFl"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46SsVw0kNWzF1wq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2019 16:31:35 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46SsVq6xQ7z9tyF9;
 Wed, 11 Sep 2019 08:31:31 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=b6kl3dFl; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ng78tZGiNtt0; Wed, 11 Sep 2019 08:31:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46SsVq5VFnz9tyFC;
 Wed, 11 Sep 2019 08:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1568183491; bh=nojXPAqUVEePkKOQkLHNj6GWteKz1LC7kcRc84VvO6E=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=b6kl3dFlkJC7mAmm1VNOX5xhi0oVmQyfv6QjvO0eR3a5/E2faZ1Pw3Ol6SQRSQVvg
 lB39Vr2dsELcbTERsAKxKvbgQDflN1XBSJ8Bbw8VZboF+Zscc87mTxVCQPx+TGMWig
 H+w220w1X9LX4e8cSS6+PZv1/5IxM2WGXgwPKhaE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A8D858B74C;
 Wed, 11 Sep 2019 08:31:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id f5_bsOKFZpbA; Wed, 11 Sep 2019 08:31:32 +0200 (CEST)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 746D08B7CA;
 Wed, 11 Sep 2019 08:31:32 +0200 (CEST)
Subject: Re: [PATCH 1/2] ASoC: fsl_mqs: add DT binding documentation
To: Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
 devicetree@vger.kernel.org
References: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fe34ba28-a961-0bf9-03b2-e9e3931f3888@c-s.fr>
Date: Wed, 11 Sep 2019 08:31:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

Your mail is dated in the future, its time is 16:42 (GMT+2) whereas it 
is still the morning.

Please fix your clock or timezone for future mails.

Thanks
Christophe

Le 11/09/2019 à 16:42, Shengjiu Wang a écrit :
> Add the DT binding documentation for NXP MQS driver
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>   .../devicetree/bindings/sound/fsl,mqs.txt     | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.txt b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
> new file mode 100644
> index 000000000000..a1dbe181204a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
> @@ -0,0 +1,20 @@
> +fsl,mqs audio CODEC
> +
> +Required properties:
> +
> +  - compatible : Must contain one of "fsl,imx6sx-mqs", "fsl,codec-mqs"
> +		"fsl,imx8qm-mqs", "fsl,imx8qxp-mqs".
> +  - clocks : A list of phandles + clock-specifiers, one for each entry in
> +	     clock-names
> +  - clock-names : Must contain "mclk"
> +  - gpr : The gpr node.
> +
> +Example:
> +
> +mqs: mqs {
> +	compatible = "fsl,imx6sx-mqs";
> +	gpr = <&gpr>;
> +	clocks = <&clks IMX6SX_CLK_SAI1>;
> +	clock-names = "mclk";
> +	status = "disabled";
> +};
> 

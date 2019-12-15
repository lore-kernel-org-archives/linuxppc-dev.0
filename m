Return-Path: <SRS0=g46S=2F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D0C43603
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 20:30:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF4E24676
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 20:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF4E24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47bbdM5MmrzDqbv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 07:30:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=kernel.org (client-ip=213.251.177.50;
 helo=inca-roads.misterjones.org; envelope-from=maz@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
X-Greylist: delayed 1278 seconds by postgrey-1.36 at bilbo;
 Sun, 15 Dec 2019 22:09:57 AEDT
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47bMBF4mt4zDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 22:09:56 +1100 (AEDT)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why)
 by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
 (Exim 4.80) (envelope-from <maz@kernel.org>)
 id 1igRRq-0007sB-2S; Sun, 15 Dec 2019 11:48:26 +0100
Date: Sun, 15 Dec 2019 10:48:24 +0000
From: Marc Zyngier <maz@kernel.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 10/10] soc: qcom: convert to devm_platform_ioremap_resource
Message-ID: <20191215104824.658889d3@why>
In-Reply-To: <20191214175447.25482-10-tiny.windzz@gmail.com>
References: <20191214175447.25482-1-tiny.windzz@gmail.com>
 <20191214175447.25482-10-tiny.windzz@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tiny.windzz@gmail.com, khilman@baylibre.com,
 leoyang.li@nxp.com, khalasa@piap.pl, john@phrozen.org, matthias.bgg@gmail.com,
 agross@kernel.org, bjorn.andersson@linaro.org, kgene@kernel.org,
 krzk@kernel.org, mripard@kernel.org, wens@csie.org, ssantosh@kernel.org,
 jun.nie@linaro.org, shawnguo@kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
X-Mailman-Approved-At: Mon, 16 Dec 2019 07:27:01 +1100
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
Cc: john@phrozen.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, khilman@baylibre.com, krzk@kernel.org,
 wens@csie.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
 mripard@kernel.org, khalasa@piap.pl, ssantosh@kernel.org,
 matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org,
 bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
 shawnguo@kernel.org, linux-mips@vger.kernel.org, leoyang.li@nxp.com,
 kgene@kernel.org, linux-mediatek@lists.infradead.org, jun.nie@linaro.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 14 Dec 2019 17:54:47 +0000
Yangtao Li <tiny.windzz@gmail.com> wrote:

> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c    | 7 +------
>  drivers/soc/qcom/qcom-geni-se.c | 4 +---
>  drivers/soc/qcom/qcom_aoss.c    | 4 +---
>  drivers/soc/qcom/qcom_gsbi.c    | 5 +----
>  drivers/soc/qcom/spm.c          | 4 +---
>  5 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 429b5a60a1ba..99e19df76889 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -387,7 +387,6 @@ static int qcom_llcc_remove(struct platform_device *pdev)
>  static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
>  		const char *name)
>  {
> -	struct resource *res;
>  	void __iomem *base;
>  	struct regmap_config llcc_regmap_config = {
>  		.reg_bits = 32,
> @@ -396,11 +395,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
>  		.fast_io = true,
>  	};
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> -	if (!res)
> -		return ERR_PTR(-ENODEV);
> -
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);

What guarantees do you have that entry 0 matches name?

I find these changes pointless: they don't add much to the readability
or maintainability of the code, and instead introduce creative bugs.

	M.
-- 
Jazz is not dead. It just smells funny...

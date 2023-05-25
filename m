Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF60C7EE2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 May 2023 16:28:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRtm80ncWz3fMj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 May 2023 02:28:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sEI6Kn0a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sEI6Kn0a;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRtk61Jcxz3f97
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2023 02:27:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=spc29Cm0a+oO128y4mo0IaM9JJ5/Y6pCdvJ8tr2Dfag=; b=sEI6Kn0a/+TFGY+DqA8SqsqAMN
	r7wV/N+GHENm2Gx0P3CUwavLtTrdIDeJfvkRnuCSc3HzFZzTQd67RxcBAT3dA7+CfxrwV85NQuG10
	zRwGHZMZ79ECgzmQGchKlnTlACoWCjc7DnZDP+G0S405EljESD4eSB/MtdNl5raXm245Eg0NWlGEf
	Hz6I5Yc+uVW2wh1GyuVmvu2tBufkFykrDMWiVbr6lPOV1EJhjKd5789WUng75huN0nTLl4IE+AMb0
	xJvhIHyFZSAAZIqnh4u87tCrTL07cphpiuPcS3XioCP/E/HEguj6wQubhuKM3Y84R3pHu+rEEvh5q
	KO5lmlHQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Dnk-00H5bT-26;
	Thu, 25 May 2023 16:26:56 +0000
Message-ID: <dd0e4fac-16ef-5ca6-db8d-21ecf1c0e802@infradead.org>
Date: Thu, 25 May 2023 09:26:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] soc: fsl: cpm1: Fix TSA and QMC dependencies in
 case of COMPILE_TEST
Content-Language: en-US
To: Herve Codina <herve.codina@bootlin.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
References: <20230523085902.75837-1-herve.codina@bootlin.com>
 <20230523085902.75837-2-herve.codina@bootlin.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230523085902.75837-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 5/23/23 01:59, Herve Codina wrote:
> In order to compile tsa.c and qmc.c, CONFIG_CPM must be set.
> 
> Without this dependency, the linker fails with some missing
> symbols for COMPILE_TEST configurations that need QMC without
> enabling CPM.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/

Fixes all of my CPM build issues. (with patch 2/2 also applied)
Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  drivers/soc/fsl/qe/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> index 7268c2fbcbc1..e0d096607fef 100644
> --- a/drivers/soc/fsl/qe/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -36,7 +36,7 @@ config UCC
>  config CPM_TSA
>  	tristate "CPM TSA support"
>  	depends on OF && HAS_IOMEM
> -	depends on CPM1 || COMPILE_TEST
> +	depends on CPM1 || (CPM && COMPILE_TEST)
>  	help
>  	  Freescale CPM Time Slot Assigner (TSA)
>  	  controller.
> @@ -47,7 +47,7 @@ config CPM_TSA
>  config CPM_QMC
>  	tristate "CPM QMC support"
>  	depends on OF && HAS_IOMEM
> -	depends on CPM1 || (FSL_SOC && COMPILE_TEST)
> +	depends on CPM1 || (FSL_SOC && CPM && COMPILE_TEST)
>  	depends on CPM_TSA
>  	help
>  	  Freescale CPM QUICC Multichannel Controller

-- 
~Randy

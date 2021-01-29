Return-Path: <SRS0=ow3e=HA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE04C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 17:38:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A095464E05
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 17:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A095464E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DS4LS3g0yzDsV9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Jan 2021 04:38:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=jarkko@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Egkn8VYL; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DS4J54zNBzDrpn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2021 04:36:05 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7881C64E06;
 Fri, 29 Jan 2021 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611941763;
 bh=UU3PVz9wczpUtXMLDgF1j7n5nGXjETwd6kHnGceGTmo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Egkn8VYL5xQe4bwWplZcAw7ap+1YC4uCHmi759G/EtZ/DcRoGHVBcCJLPUA8cUKFs
 YA/r7Rgqog5WXiGx4WxNizNqM/YK5Om5JUQ03O1c0PbWtj1HzMIu8V4g91GeM7GV37
 jGvCoAnmLaqgivjZsnI0pB1NfyBTC4IhIA2U1hc0K1ucVlPpEiVqvnq1uZ9+nLYSrP
 hl9X7Lq+qfkDCb4yH7sONyua1KVpTWmd4zrkEfqdg6NYUivDAxaW3RZ4Ru3Hc73y2K
 exlTX14UqhOGxgPaUdR8QW6WuscoiToTo0QSDcWNXsyc47+CarIgAwmRwu17e/xjSN
 bYTMlSvs9nlBg==
Date: Fri, 29 Jan 2021 19:35:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: fix error return code in
 tpm_ibmvtpm_probe()
Message-ID: <YBRHfZeqAirQolIN@kernel.org>
References: <20210126014753.340299-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126014753.340299-1-stefanb@linux.vnet.ibm.com>
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
Cc: Wang Hai <wanghai38@huawei.com>, linux-kernel@vger.kernel.org,
 Hulk Robot <hulkci@huawei.com>, paulus@samba.org,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 25, 2021 at 08:47:53PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Return error code -ETIMEDOUT rather than '0' when waiting for the
> rtce_buf to be set has timed out.
> 
> Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks! Should I add

Cc: stable@vger.kernel.org to this?

/Jarkko


>  drivers/char/tpm/tpm_ibmvtpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 994385bf37c0..813eb2cac0ce 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -687,6 +687,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  				ibmvtpm->rtce_buf != NULL,
>  				HZ)) {
>  		dev_err(dev, "CRQ response timed out\n");
> +		rc = -ETIMEDOUT;
>  		goto init_irq_cleanup;
>  	}
>  
> -- 
> 2.25.4
> 
> 

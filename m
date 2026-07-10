Return-Path: <linuxppc-dev+bounces-24012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDEEC44501
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 13:17:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxXRz5mCnz2ySg;
	Fri, 10 Jul 2026 23:17:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783689439;
	cv=none; b=DU8X53XZlG4lQwu+Jhjx0kc/Qqbnk6NxCOePE3M2TiLaUAg+Ctt3vRv9B5aqAMzeQFPHUVhl5oGz/ZkDQ7nQwsxe8z9MH3wohLPJM090UzcYEEXbTQe/q8+qqbLMCuj8ny8WZO3IwDL9uZ/ncGr6+UMdZnZBjDD6KQdvMiFqfu4voh5O7zPhmyEkD7+TRcZk7vl89LCG5QX5yKJm/tTEZhsY/A/qA7pAdGs3P5uICAc/JeiJOGXLtXRbilv6Pg6Jw28HzmnueNC5EtP8mq02ezfSRSugFB8yfSvWolrz5cYpn3Mgke65LQnsFhOPsRtT5/L5VqhgD86E45UYrMKdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783689439; c=relaxed/relaxed;
	bh=+nYP7CjrY+3szsPUQrIDMb/Ipdkfpw3EQZSw4BDdjPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke5pwgnn5xaH5NoFGlZja6bYfU7KaYWZ10Rq9wqgb4DlrLbC5X2A3uGCn45Q1iz5L2SpJZ8aZOSlHjEt9oQqE+TpDdkBg+oI/lJxAwY4GIRD8ULqSDjVVACJS22XHNE59LNAROdKFQxNXJuIHw52OsJPeLqkHfSBMsq2WWZMoZIDyTd+LKI5709tT0UtNRSd5s48Nh5T1in3AUxCcfkQvSeyeTU4dcyQbCmGRdaXV4KFlWa3oFtqRAqwsWYczjDsXKw609DOeaDBC9/LVMVt1sNPVMyRCdAtmE00rZTeNExOih5D61zYxgrX9lZCcwPYqsA5SR30GkpWhMdBa3cb0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=s+zq6Z+6; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=s+zq6Z+6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxXRy6t5Nz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 23:17:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A253240505;
	Fri, 10 Jul 2026 13:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113021F000E9;
	Fri, 10 Jul 2026 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783689436;
	bh=+nYP7CjrY+3szsPUQrIDMb/Ipdkfpw3EQZSw4BDdjPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=s+zq6Z+6eDayTaTZYGcUY57FltFrnTQlmULaKgC8lbPOHD4naiUWoG9CFoVzlsREq
	 35WSWNzTcwcs5u+PqqFMUQn31PUhP8aIwz6ud8R0rKrpE5ZN84+c+6mEj404KbGdgM
	 PgL1yHeSbLsvEJCxA0mZwnIEcKj+w4hip03Z1g7Y=
Date: Fri, 10 Jul 2026 15:17:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Duoming Zhou <duoming@zju.edu.cn>,
	Li Yang <leoyang.li@nxp.com>, Anatolij Gustschin <agust@denx.de>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: phy: fsl-usb: clear fsl_otg_dev after freeing it
Message-ID: <2026071054-cranial-manor-b4b6@gregkh>
References: <20260708064549.719147-1-lgs201920130244@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708064549.719147-1-lgs201920130244@gmail.com>

On Wed, Jul 08, 2026 at 02:45:49PM +0800, Guangshuo Li wrote:
> fsl_otg_dev is a file-scoped singleton pointer and is used by
> fsl_otg_conf() to decide whether the OTG device has already been
> initialized.
> 
> fsl_otg_remove() frees fsl_otg_dev but leaves the global pointer
> unchanged. A later bind can therefore see a non-NULL dangling pointer,
> skip initialization, and continue using freed memory through the global
> fsl_otg_dev pointer.
> 
> Clear fsl_otg_dev after freeing it so that a later probe does not treat a
> dangling pointer as an initialized device.
> 
> Fixes: 0807c500a1a6 ("USB: add Freescale USB OTG Transceiver driver")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/usb/phy/phy-fsl-usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index 35d79f11b03d..0b5e937633f4 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -997,6 +997,7 @@ static void fsl_otg_remove(struct platform_device *pdev)
>  	fsl_otg_uninit_timers();
>  	kfree(fsl_otg_dev->phy.otg);
>  	kfree(fsl_otg_dev);
> +	fsl_otg_dev = NULL;
>  
>  	if (pdata->exit)
>  		pdata->exit(pdev);
> -- 
> 2.43.0
> 
> 

For all of these patches, you have to document that you use an LLM.
Please resend them all with that information.

thanks,
greg k-h


Return-Path: <linuxppc-dev+bounces-26026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7239C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 01:16:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hR2T45WX1z2xcG;
	Fri, 21 Aug 2026 11:16:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787275000;
	cv=none; b=dRUIMn+i3EcrcfyUryabaeFvo0OKf/M1v5NF9EyVuLLWvhW6Ruu+7yLotjAc0+cud514ou+S6aTfP7UaVi0QGhR/260a3SvzTzGy2w+GbB9s4qtCgFPMGNoVE6IPEB5sE9GREuaU4DkXJt1dvNc7P8lNn6+BNO3F6/vPswNtKIT0FPLVu2xos865jkF2AQttW5o3xIhI/qVL5QMZnaDrp7MQ25exK78HAX04yzucAInqD71I0SsQHxfPWcZZ91/YwVcI11wp9tObCA4V50FQZCUKFAEzB7fNONFAVlre2eIlFtCQOh86lRrBhfxzq+my/rVuUs55QgCNucZd47TsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787275000; c=relaxed/relaxed;
	bh=ugQBOyFlZHE/AYxVsjIfj1b739XLxm2ahI6d8cBcsxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU9goi7myTflb7HRLYLp7vf6YnZSWSyk8ZeTKiqUZBmWIHLf8bcBKQ1+2MdDGwCXmAlQmzpS5eA7jDXnYXc8F8mFGWpjxYJriLZimhqak/dXS8cXOwKkRTwfkVfXDx/CnlV/WCmVj0Wz5be37nNxteYqxrhtWWObj6AsMolOrE2OPdVio3rBselHaICrwJwEmO1JEk/O/+DWezsnlKqoGJ9uMSX+snXei+mYkXXa2fizh2D/PkKYrQQhExp+5VOCmGcXLDTnGaObyv1MH2Kyb8b4yuUG5I/MnQHYkAcuWC4A5syZh5nFsvuPP300DWXt0kPBbAWQq1tZfxmrLf2gJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIM8U8Jv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIM8U8Jv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4hR2T36RMfz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 11:16:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 1E81B40DB8;
	Fri, 21 Aug 2026 01:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 71ED61F000E9;
	Fri, 21 Aug 2026 01:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787274997;
	bh=ugQBOyFlZHE/AYxVsjIfj1b739XLxm2ahI6d8cBcsxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIM8U8JvxLPhUSFhnl5sJ8ra6ChLW8lgQ25J2d0Qda64btmbzOntBgxxJIKg9LF9n
	 +c6AsAATr36C88tYXxmUBGUfJIV//spaTGCquumFtWHy6PITeTDUrCekJhBOjrpfAM
	 eg5kTBeEwGRr/h6wkis5teyMD/QObyLHW/917EekGfjdPAL3lWexd7iMzdVfBIF0qu
	 qtH3lNNdOBjQBv6TNv4zOOceKh6HMoSc/lM8LP0On156I637HdAOGq3z3TZZEYTxr7
	 ViqHJvypRKLq+uJWjcVP1g4zF5fsGtLcjmd4jkYUDjyWjevHgmqhlGxvdVNXm4tiwx
	 45qLPqJwUHAug==
Date: Fri, 21 Aug 2026 04:16:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power
 management
Message-ID: <aoem8QbOVD7QVwiG@kernel.org>
References: <20260819083547.2703228-1-lijun01@kylinos.cn>
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
In-Reply-To: <20260819083547.2703228-1-lijun01@kylinos.cn>

On Wed, Aug 19, 2026 at 04:35:47PM +0800, Li Jun wrote:
> Replace the manually defined dev_pm_ops structure with the
> SIMPLE_DEV_PM_OPS macro to simplify the power management code.
> This macro automatically handles CONFIG_PM_SLEEP configuration,
> generating the same suspend/resume callbacks while reducing
> boilerplate code.Add the value of 'thaw,freeze,poweroff,restore'.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 6fb4d30eb6f6..51c7e2add3d2 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -462,10 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
>  
> -static const struct dev_pm_ops tpm_ibmvtpm_pm_ops = {
> -	.suspend = tpm_ibmvtpm_suspend,
> -	.resume = tpm_ibmvtpm_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
>  
>  /**
>   * ibmvtpm_crq_get_next - Get next responded crq
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


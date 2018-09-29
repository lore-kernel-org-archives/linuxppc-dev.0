Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A9C43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 18:21:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAC02073F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 18:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaAMkvpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAC02073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MxhQ0VjTzF3DT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 04:21:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SaAMkvpp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SaAMkvpp"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MxdS0BVYzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 04:19:06 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id p12-v6so6438860pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tDXzf/udT2sLICh0F22dZmfyKcOE6GKdhC9TxcJib8o=;
 b=SaAMkvppvQTYGQVtNj3RcYow2tvFEWnQXsWIP7k1NdH5nlSz5e6+28aZq+J+Pcv/iB
 B5rHD6HcnlrnmBteGs4zByny8fsuelYReWqzCL4gF04tUbxjVDSd7Mv/4557Z0uNtpMy
 wY50UqQN3m0iBtq3DVB3Jfz4G21X17PxNhM91r08KpfXAE5GSagVtUNHEaeQP/IUcp6t
 pOyCCeQJOaO6n8NypCeiKaekdxXsSe3ZbfWSREMACao+dg47lkczR9RHLzgYil3N85R8
 0qsHRsyh8QphOh/dkCgT2KgOT5KJsIwZiPT/KfWQc4YTxM9KscW3Jz65SLpcivYK+EF4
 mzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=tDXzf/udT2sLICh0F22dZmfyKcOE6GKdhC9TxcJib8o=;
 b=KP9cY2Rghqu5ZLtloZE7rT6rQXX/2FB2C7FZCDQfy+EKtYJL1doDdOLYD1QIl0lteJ
 vFmPNDPGOshbBH1Rc95ImBDBbgvFpOrLSU6LPP9rSuGLzF/cvWyoZmGsS1vyW97PhyNM
 LiSDgLj1gYP4vXgeAeOxYaQrvqyREsmc/vgSz9uO11C1aIOoRfa8/tzWcV11hFbYMQCH
 DOxkf2b1zAOsR0/VNinpIdCOKwHKx1sdU17Xe1uxJ/yEXgCkLHyX1lDpO0nAMeDo1kCs
 u/BBRd46q5NX75yURyWTp1mcAYnlXNWnHsKIqPM3oK3Qyf2dTrgZJTBTRyNy6xOApv8U
 icKQ==
X-Gm-Message-State: ABuFfogYjVt/nbSGRGF4rYplRqS41BdXI34yJoWPIa5E9Zwx/jDVMZEa
 8icLKMS2VVz/8ClZhO51Da0=
X-Google-Smtp-Source: ACcGV63yscddTUXp+MU7pwVbHt+9bogVEYBKbUkq+SKLnTPEUkf/Tgd4Px4eTAUToGrGbYiuDHgscA==
X-Received: by 2002:a62:1a16:: with SMTP id
 a22-v6mr4025109pfa.237.1538245140891; 
 Sat, 29 Sep 2018 11:19:00 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net.
 [108.223.40.66])
 by smtp.gmail.com with ESMTPSA id u62-v6sm13227276pfu.69.2018.09.29.11.18.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Sep 2018 11:18:59 -0700 (PDT)
Date: Sat, 29 Sep 2018 11:18:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [v3,2/3] watchdog: mpc8xxx: provide boot status
Message-ID: <20180929181858.GA5758@roeck-us.net>
References: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Radu Rendec <radu.rendec@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 17, 2018 at 06:22:50AM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver supports the following platforms:
> - mpc8xx
> - mpc83xx
> - mpc86xx
> 
> Those three platforms have a 32 bits register which provides the
> reason of the last boot, including whether it was caused by the
> watchdog.
> 
> mpc8xx: Register RSR, bit SWRS (bit 3)
> mpc83xx: Register RSR, bit SWRS (bit 28)
> mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)
> 
> This patch maps the register as defined in the device tree and updates
> wdt.bootstatus based on the value of the watchdog related bit. Then
> the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.
> 
> Hereunder is an example of devicetree for mpc8xx,
> the Reset Status Register being at offset 0x288:
> 
> 		WDT: watchdog@0 {
> 			compatible = "fsl,mpc823-wdt";
> 			reg = <0x0 0x10 0x288 0x4>;
> 		};
> 
> On the mpc83xx, RSR is at offset 0x910
> On the mpc86xx, RSTRSCR is at offset 0xe0094
> 
> Suggested-by: Radu Rendec <radu.rendec@gmail.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 1dcf5f10cdd9..069072e6747d 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
>  struct mpc8xxx_wdt_type {
>  	int prescaler;
>  	bool hw_enabled;
> +	u32 rsr_mask;
>  };
>  
>  struct mpc8xxx_wdt_ddata {
> @@ -159,6 +160,24 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  		return -ENODEV;
>  	}
>  
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		bool status;
> +		u32 __iomem *rsr = ioremap(res->start, resource_size(res));
> +
> +		if (!rsr)
> +			return -ENOMEM;
> +
> +		status = in_be32(rsr) & wdt_type->rsr_mask;
> +		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
> +		 /* clear reset status bits related to watchdog timer */
> +		out_be32(rsr, wdt_type->rsr_mask);
> +		iounmap(rsr);
> +
> +		dev_info(dev, "Last boot was %scaused by watchdog\n",
> +			 status ? "" : "not ");
> +	}
> +
>  	spin_lock_init(&ddata->lock);
>  
>  	ddata->wdd.info = &mpc8xxx_wdt_info,
> @@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.compatible = "mpc83xx_wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
> +			.rsr_mask = BIT(3), /* RSR Bit SWRS */
>  		},
>  	},
>  	{
> @@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
>  		},
>  	},
>  	{
> @@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x800,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(28), /* RSR Bit SWRS */
>  		},
>  	},
>  	{},

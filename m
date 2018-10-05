Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA94C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 03:55:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197A220834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 03:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XM7RSLC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RGBg6Qf6zF3Fb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 13:55:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XM7RSLC/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="XM7RSLC/"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RG873pHgzDqf3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 13:53:39 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id t70-v6so4088926pgd.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 20:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LzPy8UTKfjTW+20bjD5GqbH2LTBCE+NllS30tb6ceM8=;
 b=XM7RSLC/MjCKgRp6FiYvy8UOtpx5vThjkLchnFI6uoo4JdHtS567+jU4ljBi7yzHj/
 bVqasklkvOx/kfVUHJF14hTRj2RrCp0doa5jPrSvso++wLdG8kaEglVhDeT5OntO6Qbe
 bzonSUVjwSv7w8FLyk30rleBgjMqw99DNSTj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LzPy8UTKfjTW+20bjD5GqbH2LTBCE+NllS30tb6ceM8=;
 b=X1W4M8c1C21rYeDcJoXibRylLHNbyCOQdwEEiTqDWPVkze82kctlZqJAXxvtdIbCIh
 9AgWBsSosXedbPQY/35SE3czx4kDvnPleV6wsAyN4DQmL81BcfaT6hHnT4W3GEB98MG+
 9tfaMsIzIlSjc8wV5WBw6QpUOsZjCqUgJX+8CsP082kjdCjP7duNRMYfFtThwNgmb116
 Bjb3rW6S4dQVOJjibo1fGSBqebfuqin+r5oaGrVbHxNAMQ6DA5CpZWgXVhJZrZwLiZo8
 QIkEi6Iyt6q0TVqr6ikMx637MBZ8VL+Z+PyIWXYR32l2G+TZ95r0ESwkIqgMOj6pdz/u
 mYlA==
X-Gm-Message-State: ABuFfohNl1Z7QdjIm1ubR/PrcSPsgu78AzZ0k+4ZFuywmG/3I1bdN75R
 3Juos632x4yZfuKjLRC+vx7zDQ==
X-Google-Smtp-Source: ACcGV63Ybb73teQjcAGvrj8m29AbMX8Ckgd0GtRmt+LDq5GBtbNo8yIS+b1HIQd9mWdo/kQ3AYYpAA==
X-Received: by 2002:a63:3642:: with SMTP id
 d63-v6mr8309284pga.404.1538711617799; 
 Thu, 04 Oct 2018 20:53:37 -0700 (PDT)
Received: from localhost ([122.172.76.11])
 by smtp.gmail.com with ESMTPSA id i5-v6sm5848340pgl.46.2018.10.04.20.53.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Oct 2018 20:53:36 -0700 (PDT)
Date: Fri, 5 Oct 2018 09:23:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v4 4/6] clk: qoriq: Add clockgen support for lx2160a
Message-ID: <20181005035332.4ogmxyxiwisok7xs@vireshk-i7>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-5-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538615031-7507-5-git-send-email-vabhav.sharma@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
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
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org,
 Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, linux-kernel-owner@vger.kernel.org,
 catalin.marinas@arm.com, mturquette@baylibre.com, will.deacon@arm.com,
 yamada.masahiro@socionext.com, linux-clk@vger.kernel.org,
 pankaj.bansal@nxp.com, udit.kumar@nxp.com, linux@armlinux.org.uk,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, oss@buserror.net, robh+dt@kernel.org,
 V.Sethi@nxp.com, linux-arm-kernel@lists.infradead.org,
 Tang Yuantian <andy.tang@nxp.com>, sboyd@kernel.org,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, sudeep.holla@arm.com, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04-10-18, 06:33, Vabhav Sharma wrote:
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 3d773f6..83921b7 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initconst = {
>  	{ .compatible = "fsl,ls1046a-clockgen", },
>  	{ .compatible = "fsl,ls1088a-clockgen", },
>  	{ .compatible = "fsl,ls2080a-clockgen", },
> +	{ .compatible = "fsl,lx2160a-clockgen", },
>  	{ .compatible = "fsl,p4080-clockgen", },
>  	{ .compatible = "fsl,qoriq-clockgen-1.0", },
>  	{ .compatible = "fsl,qoriq-clockgen-2.0", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

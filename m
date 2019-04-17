Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4DC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:55:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AC92173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqfWBwrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AC92173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kryd6yJJzDqLJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 04:55:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YqfWBwrm"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44krvv2SsDzDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:52:42 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id g8so12428708pgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HJHPz+R+CU544kFQAxOjPvxjaUk0WljUZxgaPbvIzcc=;
 b=YqfWBwrmfbl5Hv+1kfO451IuZw6K2fopkKRxOjVMmlqLtvfCD+8P8ulQ5lZgK/1Yuo
 wotciWLK1N9YFaKqnCC7KhDsWaBYCcT1dWVmNfqTTBO+DZ/5zjovCURXwfjLc4pQbepd
 VYPgFROhVk0Kz2SB9pI7EgoAvlIvb4aJVn2gBesvQmz74RGyw98dVBk0ZR4it8OA+gFO
 1vAu6X2c1JHJk0vVLXC27yg0uqDAWYDzdVGAfYoi6j8YgTrYpToOSc/dvRAfaZhyVRNC
 HlTYWRVSM1S292BTrmgfIvsUpIXINuwXvCLc9+m4MBwzQa93AZ+/J9BjehizbkejOG45
 tAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HJHPz+R+CU544kFQAxOjPvxjaUk0WljUZxgaPbvIzcc=;
 b=G+FOlyweYKyOqqxLU5EAelBNcgjOWKvxQVxMjzHGjysvj8aUcQqV8S2qVCey1FKhgh
 0Ezh1CBztrPK7yxHS3vlBTUTBuNtPskKvWK+Py05wjLeRMovSFgz9g2BhopdfAtOYq50
 98NDo5kCqyQNZnXJQG4pnUMc7LmXq99i3+AQoV64fsOp1EVvsfTc/wvjcHwd791ENcME
 Pi+s+qi5ENj+xqF0IqhgwEshmL4LSm0qCAdCvdBqTaA4TfOcOnAkjNCgNAffrz7mItZf
 XBiV1gOULsjaf8TD8J7n71DTkFnJK2sH1PgrH7h6JvSYz0WBFc3gaHHaFPH0+fJ2Zunp
 LzLQ==
X-Gm-Message-State: APjAAAXVhstMX8ka4pdRGig8F2m99NQ1YsdqLdQ41w1DZG1/owuwA/LP
 VPUf3Qz8yqn+jcZ0ZGu1poI=
X-Google-Smtp-Source: APXvYqykeKm2o2jK/pzbLZZWY60wLb9avMmElfMMhZG0aMKJkE8U0atALpGy9m1VS/GCrsA8DTYNug==
X-Received: by 2002:a63:2158:: with SMTP id s24mr38059731pgm.156.1555527159561; 
 Wed, 17 Apr 2019 11:52:39 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g5sm42888832pfo.53.2019.04.17.11.52.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Apr 2019 11:52:39 -0700 (PDT)
Date: Wed, 17 Apr 2019 11:52:36 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190417185236.GC5073@Asurada-Nvidia.nvidia.com>
References: <cover.1555491598.git.shengjiu.wang@nxp.com>
 <1eaeb882bdd69108c8ce897398c5c36ece6d49c5.1555491598.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eaeb882bdd69108c8ce897398c5c36ece6d49c5.1555491598.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

This looks better. Just a couple of more small comments inline.

On Wed, Apr 17, 2019 at 09:06:18AM +0000, S.j. Wang wrote:

> +static int fsl_asrc_sel_proc(int inrate, int outrate, int *pre_proc,
> +			     int *post_proc)

Just a nit: it looks better by grouping them two-two.

static int fsl_asrc_sel_proc(int inrate, int outrate,
			     int *pre_proc, int *post_proc)

> +	/* Condition for selection of post-processing */
> +	post_proc_cond2 = (inrate * 15 > outrate * 16 && outrate < 56000) ||
> +		(inrate > 56000 && outrate < 56000);

Could align the indentation:
	post_proc_cond2 = (inrate * 15 > outrate * 16 && outrate < 56000) ||
			  (inrate > 56000 && outrate < 56000);

Here:
> +	/* Does not support cases: Tsout > 8.125 * Tsin */
> +	if (inrate * 8 > 65 * outrate)
> +		return -EINVAL;
And here:
> +	ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

Instead of a general message, I was thinking of a more specific
one by telling users that the ratio between the two rates isn't
supported -- something similar to what I suggested previously:

	pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
		 outrate, inrate);

Thanks
Nicolin

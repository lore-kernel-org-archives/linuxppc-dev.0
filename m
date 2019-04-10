Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E445C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:28:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983BA20854
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFbEYz/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983BA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fB3x640FzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:28:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFbEYz/D"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fB205lxKzDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 14:26:46 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id y6so548053pll.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 21:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OEuIgKEoL3XlYMgHRfRqW0l+9//3AYpk3GfTEoHAzGQ=;
 b=XFbEYz/D0XuOfnl6ZermMNxyoRCw38GfZ7YCdyNrlKtL6EH0dE0QqakvT5fyiA29oB
 +7T8RUvMIUjRQyD+TqcyluqqDPGQn43on6Ce0Nw7er8val9HIpu0rJDTtP8Rasd55qx6
 EqHZnEP4aJtAgZ/GIuZvuUQ8LfUyoHxKSXZFQ83SsjMYruOPnsR6p01QDp9HX6Id3eTA
 QVsp88Q8oZk+Kwpg45+/CpJPLZVCTlL6t1Nk42yZMuWisOLdvOUITd2vrc7R3OUCuIfF
 VHiPSAX2oyjxw+gU3LMsds8YfJRqJYvWRa/a1it4GUyRXvgXl8EfaKfzCaqiCC80Ob3M
 1asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OEuIgKEoL3XlYMgHRfRqW0l+9//3AYpk3GfTEoHAzGQ=;
 b=fCHmEHS4sjd6PyqkluPEHJ1ZE8Id6Ew6glyfvi+xCqqt/2ibqakI9EHrDBUG0EcutY
 ptw4trprrtPUUXRvWAtIVYiF5UA4hKRUEw7Dv/uqLLQQjo5Uh4k5qoDQrpNrxKQeibHJ
 zDC4JHb/tSdsMH1+rRzKbnBhV3AWSlQqdVzq8V6HLqiZ/QJoQ3Elg8bM6qwiDpXwk+FF
 967NA0TtC/TYWltnhYbEZ6TED2HDmBL2Gsf1rHWnMjq3CeTMGO91g8qG90ihq1gdyMpU
 qR4YRXwmN9lpTcQ4uqsnsKElXp1PaqPWXSKKt6b/HiV+JS7fUU4Tppw4EqyOSiCJWGGE
 21UA==
X-Gm-Message-State: APjAAAUo7L6wXDL9NXFCsBHJzAjl4FDK5ms4ppvlWVCGfcIhpKiJdhCa
 mXx8+WqBs4rH5MxlAJcf7fg=
X-Google-Smtp-Source: APXvYqziEiSpeT6l/rEgej5kJcC4JoFDm+F9IguVgfLVo2th2XHBwi9j5k+yl4pQ7vCxvbZ8RyPEmg==
X-Received: by 2002:a17:902:ec0c:: with SMTP id
 cy12mr19388057plb.291.1554870402674; 
 Tue, 09 Apr 2019 21:26:42 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 j1sm22557445pgp.91.2019.04.09.21.26.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 21:26:42 -0700 (PDT)
Date: Tue, 9 Apr 2019 21:26:39 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: replace the process_option table with
 function
Message-ID: <20190410042638.GB3032@Asurada>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 03:15:26AM +0000, S.j. Wang wrote:
> The table is not flexible if supported sample rate is not in the
> table, so use a function to replace it.

Could you please elaborate a bit the special use case here?

The table was copied directly from the Reference Manual. We
also have listed all supported input and output sample rates
just right behind that table. If there're missing rates, we
probably should update those two lists also? Otherwise, how
could we have a driver limiting both I/O sample rates while
we still see something not in the table?

> +static int proc_autosel(int Fsin, int Fsout, int *pre_proc, int *post_proc)

Please add some comments to this function to explain what it
does, and how it works. And better to rename it to something
like "fsl_asrc_sel_proc".

> +{
> +	bool det_out_op2_cond;
> +	bool det_out_op0_cond;
> +
> +	det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
> +					((Fsin > 56000) & (Fsout < 56000)));
> +	det_out_op0_cond = (Fsin * 23 < Fsout * 8);

"detect output option condition"? Please explain a bit or add
comments to explain.

> +
> +	/*
> +	 * Not supported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.

Could be "unsupported". And it should fit within one line:
	/* Unsupported case: Tsout > 16.125 * Tsin, and Tsout > 8.125 * Tsin */

> +	 */
> +	if (Fsin * 8 > 129 * Fsout)
> +		*pre_proc = 5;
> +	else if (Fsin * 8 > 65 * Fsout)
> +		*pre_proc = 4;
> +	else if (Fsin * 8 > 33 * Fsout)
> +		*pre_proc = 2;
> +	else if (Fsin * 8 > 15 * Fsout) {
> +		if (Fsin > 152000)
> +			*pre_proc = 2;
> +		else
> +			*pre_proc = 1;
> +	} else if (Fsin < 76000)
> +		*pre_proc = 0;
> +	else if (Fsin > 152000)
> +		*pre_proc = 2;
> +	else
> +		*pre_proc = 1;
> +
> +	if (det_out_op2_cond)
> +		*post_proc = 2;
> +	else if (det_out_op0_cond)
> +		*post_proc = 0;
> +	else
> +		*post_proc = 1;
> +
> +	if (*pre_proc == 4 || *pre_proc == 5)
> +		return -EINVAL;

I think you'd better add some necessary comments here too.

> @@ -377,11 +404,17 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
>  			   ASRCTR_IDR(index) | ASRCTR_USR(index));
>  
> +	ret = proc_autosel(inrate, outrate, &pre_proc, &post_proc);
> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

I think we should do this earlier in this function, once We
know the inrate and outrate, instead of having all register
being configured then going for an error-out.

Another thing confuses me: so we could have supported sample
rates in the list but the hardware might not support some of
them because we couldn't calculate their processing options?

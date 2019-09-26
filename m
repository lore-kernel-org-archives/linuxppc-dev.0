Return-Path: <SRS0=Ic/D=XV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5099BC432C2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 01:51:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BE621A4A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 01:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmhqPRhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BE621A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46dyb53QwCzDqcF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Sep 2019 11:51:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmhqPRhl"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46dyY62dq6zDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2019 11:49:59 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id q12so727481pff.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 18:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uI3653QvRfDun5vRH9qyIawnNKEumCLQmRxicnF+xIE=;
 b=BmhqPRhlQgpby6NkH48NMswsV+CwXScc+2OJ4w/Kc48zNgHHAfS2FqHNPwzS+O0xB6
 6ocLda3/dxNOPh9j3Rv4CSYsH+9gMHSJKJblwGho55ICTrYxOb6AdPD8tdBI3DtrleLI
 i7Fcl/1yXHmmVQeNqf39ZNrySFVSen2JoClH6PQhbsFZWrxgPm9Gj4TxA+Vp7L7RnLTd
 Ogwiv5cMP6Lvy6MjRCbnuVAQkAw9iHmCnOiLSbdgQ/ybBe85RQkDQ63NhNgHiQ621/Zc
 DsHnR7LUv8gvc57oGKi1HAnqVnRM1qfPt0kZJFNzgXDQw+rWN+BfxVItLiGg/ED/h0c+
 tx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uI3653QvRfDun5vRH9qyIawnNKEumCLQmRxicnF+xIE=;
 b=qILJg92mNunD//Bp32rGwp8fVdN1RH7wJRSEtZ//1YwjZGgXk+vmBQsETGR98jaKR7
 HeMWFvtC6pR6kGTVK2jAfOE2MxvnN21JcB9Kox7rg0/WVSDTrNPhHqe442Dez1Varr5+
 gkOEsOMx4d0ne/JWulc6OpdA1XSH1iLfzyrw5KOa6QD8OLUmJsLkdJ19xChNMtbftm/N
 JQ/CGGBOs0fNX7ugTeT5u5UKrv15cP+PwHkFb+QESbo1QE/IXcHxgXi6phDSbtvZ/ynz
 1I/DPLR/LyXTPRp9vJ5eHKqGvNJe0cLk0pZXPkMgxhhiHnqjHOZ2+ZEBpkxdamUvJEmD
 7bzg==
X-Gm-Message-State: APjAAAVepXSk/Wpku2T8nzz6pWJgmPVSukoynXofzZbloTkqr/yGOVb4
 rI3tSRp/cMcF88enWP7DZeY=
X-Google-Smtp-Source: APXvYqxBJIYCpZx86R9ytnHhKp607PqA7avrf7WrBtzA3FCSAUzgHNDVzVxOo3YZNahIPTbhg92bhg==
X-Received: by 2002:a17:90a:1b46:: with SMTP id
 q64mr817457pjq.76.1569462593023; 
 Wed, 25 Sep 2019 18:49:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d14sm324463pfh.36.2019.09.25.18.49.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 25 Sep 2019 18:49:52 -0700 (PDT)
Date: Wed, 25 Sep 2019 18:49:06 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V5 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190926014905.GA24545@Asurada-Nvidia.nvidia.com>
References: <cover.1569387932.git.shengjiu.wang@nxp.com>
 <7c05d8396fd8c4f9d41c13a85e7486f3664bc73f.1569387932.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c05d8396fd8c4f9d41c13a85e7486f3664bc73f.1569387932.git.shengjiu.wang@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Just a small concern...

On Thu, Sep 26, 2019 at 09:29:51AM +0800, Shengjiu Wang wrote:
>  static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
>  {
> +
> +	release_pair = false;
> +	ret = snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);

This set_runtime_hwparams() always returns 0 for now, but if
one day it changes and it fails here, kfree() will be still
ignored although the startup() gets error-out.

We could avoid this if we continue to ignore the return value
like the current code. Or we may check ret at kfree() also?

> +
> +out:
> +	dma_release_channel(tmp_chan);
> +
> +dma_chan_err:
> +	fsl_asrc_release_pair(pair);
> +
> +req_pair_err:
> +	if (release_pair)
> +		kfree(pair);
> +
> +	return ret;
>  }

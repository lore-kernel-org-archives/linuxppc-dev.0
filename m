Return-Path: <linuxppc-dev+bounces-28382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F3EC9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htZxt0lcwz30WQ;
	Mon, 28 Sep 2026 18:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790585986;
	cv=none; b=Q2s7hVKWADvdFYIrr96/SBYE3+AIqqnZ1Mv/cs2DXs/mwaikHflDkAMNO/+n5+3oi2xChixtI3Yc5tqD50+M+Zrrh0ktnJ/oI/9f4yFo1yupfA37ncmQedBBAGqBJlM14cOKs/oIR9nFbTpbh7sAhx0aldAP9LNtCx59uS2E6oJG6loQXGX7VKlabU26lm5Pv0ta10Nu0tnF3jCTATGf7R1jdCISO4/6OZUCG/zCygXh6W9BX6P7IqeYW8eAqao8o2fjwtF78Rvw7XMdhoi1aKy9XmG+tTdN+B39wiV6vdvEb4t5CrTVlqE4mJlf0Hwe//tUc1zutl7cK/lL86KoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790585986; c=relaxed/relaxed;
	bh=/SlL0kZLxnoeyVQSeECCjt030Qh+aK0W4C1qEfK2kJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/j+QuXhK8eZXlJiJW+OB+y6aKRIgFlNA5WscsRqTs0LTDXNpfIGCi/GOVDxXQe3JVD1APwAEvoKEG2HjUtESl+ggntGrgeRS9F38Q6n0ViPpORoMrC/nSLRJvCMJp2Op5xuCoiuv+VLJ3Jp8+f9em38hTL4T6c0I+UoJ58lAdWyZqc8z0w8LEcIoWkRQq4B6H9rPEpKGiPmJaSZSXvWJwluXSaZ+mPTM+kqHSzJTwyczs7Pj0mxoTD+XgscUBrzumTWJNMrD6cYux19x/AUYB5s4wditOs4zC5vX1rnz9GrJ2kb+IhLVVALyltQ4+B57l6On1G41driokaNFrOSYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g/Slcn8A; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g/Slcn8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htZxq1NdWz30WF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:59:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790585983; x=1822121983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PLEGBtKzcmgBApbEY91eHyKAXFDhNXbJ0jMBrRglUA0=;
  b=g/Slcn8Amp1YlGiPrnroeic/ofrENEEMM/X+M0A852G8BgSXrvkm2CJP
   vp3vVSjPVN3bL/Ka59CnQQaYYQFKQqfU6Z56njcnTs+Xkq5isUBV1p4ra
   cDXaiwht2nqd17/DZKfWE3LB5k10Ri99DVGg4O9COj0wy136ZuieqcxlU
   3FDmi692yS5oCHor0uPnZbtuuU1R3933l+c8Hwh62gOgNGn8RLfzY1tnn
   R2euPMDkTW5yD+kjTDLdeevY3aeb9GdRuzeaQbhitKSj80Yp6RnlQ+RdZ
   WEnBHrjuYj7EZO8eSqfcNaiu9QEZ/Mm3asjVxEfRDlkTLQBiGe5n3E1Wk
   Q==;
X-CSE-ConnectionGUID: x+Ah9zD5QySQyz5N39OgJw==
X-CSE-MsgGUID: SO9AgSa5TUeNSDhdzCBRbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90322421"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90322421"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:59:37 -0700
X-CSE-ConnectionGUID: PRVHibLnRfK9oFEvRtuuMw==
X-CSE-MsgGUID: CnxizhdoSza8QKl8n0S4MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="272791669"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:59:34 -0700
Date: Mon, 28 Sep 2026 11:59:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Slavin Liu <bolin.liu@seu.edu.cn>
Cc: shengjiu.wang@gmail.com, xiubo.lee@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	festevam@gmail.com, nicoleotsuka@gmail.com, error27@gmail.com,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: fix second front-end channel check
Message-ID: <aroscgugYoeB-HKM@ashevche-desk.local>
References: <20260927000738.10105-1-bolin.liu@seu.edu.cn>
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
In-Reply-To: <20260927000738.10105-1-bolin.liu@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 27, 2026 at 08:07:38AM +0800, Slavin Liu wrote:
> Commit b045248399d0 ("ASoC: fsl_asrc: Replace dma_request_slave_channel()
> by dma_request_chan()") made ->get_dma_channel() propagate error
> pointers, so the !NULL check added by commit b4136c0d69ea ("ASoC:
> fsl_asrc: check the second front-end DMA channel") no longer catches
> failures and the error pointer would be dereferenced at
> tmp_chan->private.
> 
> Use IS_ERR() and propagate the error, keeping the release of the
> previously acquired persistent Front-End channel.

...

>  		/* Get DMA request of Front-End */
>  		tmp_chan = asrc->get_dma_channel(pair, dir);
> -		if (!tmp_chan) {
> +		if (IS_ERR(tmp_chan)) {
>  			dma_release_channel(pair->dma_chan[!dir]);

>  			pair->dma_chan[!dir] = NULL;

> -			return -EINVAL;
> +			return PTR_ERR(tmp_chan);

I believe this has to be left untouched as it might leak to user space.

>  		}

...

I also wondering why Sashiko hasn't pointed that out during the original
submission...

-- 
With Best Regards,
Andy Shevchenko




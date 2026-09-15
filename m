Return-Path: <linuxppc-dev+bounces-27320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F407FC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkf6m3Zs6z2yFW;
	Tue, 15 Sep 2026 20:54:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789469696;
	cv=none; b=I8j4VuO3AOqn4DSWm4VWJY02i/8PdTTcHu3dWEsOXSbUNrqyBJUgDSabh0mFtBv4p9gpTPjNOL+rb+dp3F1iiGwcFGxsghPxxB+AzS7gTt1HmC/xnbgoDdurq3dgO2+Sloovf+49JOMHqkm60xfHcvanbnkqFeFgOgVJ5ZB41ZQsguGPgg1DtNlHlnDDZulLxe/HOAdbnok7vXbrTiT/kt79AaIVPkAlKQMlH/wsKOkH9ASjPWqb+zJ3MdCIw8Vsrqq7rQG9BTtMJSQu6tqVIcTyRFdSoqDex+HWltkjysYDxf/LoFXO2CGzd5iGg2+T9wwJg0jGqZMA5vh1ZGGjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789469696; c=relaxed/relaxed;
	bh=3NcK+2D6AazFJjSTKxR7cSuvqpA99SwORYNVJbXxAeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIDLytJnsYS0LJTIyM+yZXk1xLoxGbGSYNDV6wP0aDBHp8IteJatNnSD/n6ZcXwzWn9h6x7Vz8QMkR2nT45L3ctVo9j5SS5JtBx9SDMKRkIEpIqx0Q4Mlm9PHnIAcek9nGWb95w7HdSlF1JnPoe6aVFpdTT1WmjFbry3+9X1yFbDoIgY4cUPG82yNYF5VkXqBPt/gsK6GC80l6kUcr2KJ8RU/RBKBRwE+FhIHmWZ1nUaPcKN7E6eY/VbQ7RWFp69COwIG47lh40cQPCIvlcsEj3fXIgb9xzyf6tRDf93Kdx/3UgiNaR6Hh7nDrXmTzyY6Tjrf8P0QVq8tFVCQL9AAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nyfVW78x; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nyfVW78x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkf6h5BXmz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:54:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789469684; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3NcK+2D6AazFJjSTKxR7cSuvqpA99SwORYNVJbXxAeM=;
	b=nyfVW78xanPnz77BrmiJiLsFyS2iBpuriK3VJWYHU70twcKIYFfzdpPuOehutbCX4AlertjxReS2z4IfNYm6xAFZgwJpRAfVTCpmZw7/3QwQu95WHnHl1iMi8oGQRnXjF5j69ET8qO3CyID5P9almkatSpkVZpl6cpnbocpLVgc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0XB1P4.X_1789469678;
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XB1P4.X_1789469678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 18:54:39 +0800
Message-ID: <ccd08979-d702-4dc7-90cd-f82c08c5182c@linux.alibaba.com>
Date: Tue, 15 Sep 2026 18:54:37 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] ASoC: sprd: Replace dma_request_slave_channel() by
 dma_request_chan()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, bui duc phuc <phucduc.bui@gmail.com>,
 Tianchu Chen <flynnnchen@tencent.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Cc: Dave Penkler <dpenkler@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Lars-Peter Clausen
 <lars@metafoo.de>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
 <20260915100931.3593242-3-andriy.shevchenko@linux.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260915100931.3593242-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/15/26 6:04 PM, Andy Shevchenko wrote:
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


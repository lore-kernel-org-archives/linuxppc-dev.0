Return-Path: <linuxppc-dev+bounces-27749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C19C982DE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 17:58:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmgMk1Sf3z2y22;
	Sat, 19 Sep 2026 03:58:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789754290;
	cv=none; b=KTZqutYOBNkByyc5VAQO3j6bnhN9wjrsHoO9KyKNduEgM4omlHnRsu4xYTlS3i7l0jeSVZr3rsPaQ0lvucTn9ki1GMv0S/xW/328ZeUZA3y1WyCHmVmiv2M2/gDJQaIACoPqfFoky7k6mnOOvqV7IbRLmyHyXm96f9JntVaxJQrpkt15l9cjgU9ZZoszK8s/OYus/4lzPZ9A1mFh9h+27C5GctF5HswSbYpqurRwd/Na2BVMjGRIoLRjwH6+8Z3hhzmYCkAmCgIKYc47zhdqg+mMgVSnXaXzVuQW8O1YA+EUZcj4dy+MUCbdBM8VLCoSJyZ+0ChBLl+KsgPUB5CHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789754290; c=relaxed/relaxed;
	bh=1l9FecZC20se1cRT+U2yFyGnQU1PHlnfgdsZtd2O88c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5QosaipIv2vQ7ZOiwOQ0eqNT5cl6ogU9Jgk1aDMBhKthOZNT12mGgBf7o0jWDgIT1OCGmK96nu2YPaQiv+0Xd+/4+lO+NVvvrREyRlWTTTN+ffnJmOBH/A5T3MqSCx1zzx4qMWoQaL/ef99Xn1JruafmcmaRRA45BgZKroYv0/XHf9nJLx9onM9NVWqicn7iJRp7RT9CNZMBlKyu3wbxF5mp1vWms9K5TFePavA/EwThjS+W7iJjkZ9cXPr3ChRt5Dq8LJt57Ly/06/sSEAm4T5UOcpgOPRk4+O8joSdwoxeY+yN3ikTrQaU4ySObgbXkqZBXCKNb2N6po+gK2BMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFMZj+mJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFMZj+mJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmgMj3DQ9z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 03:58:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8645A6057A;
	Fri, 18 Sep 2026 17:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E61F000FF;
	Fri, 18 Sep 2026 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789754286;
	bh=1l9FecZC20se1cRT+U2yFyGnQU1PHlnfgdsZtd2O88c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nFMZj+mJxhvA4HWpVg8jsWxsjw/8Tku/xdTQdIfmCtvNrKQzG71Pq6lO5l7ogAmu3
	 xSxmkOGz51hepFCStCNGeCu/+Ze5Hd4Fn69/4WxiIoM3QKK7tKKDKmxELKSqW0X9Fp
	 MSTVj0C6gLx6vnYO7pvWlRDtUefL9itkMCiphZ2iVsKY/0rWOf1+NOr2bwnqdQFuqD
	 u4KKWJz30R6brUDDVRIhYk63gWXR7L+QGUw8mSwfkwLZv0Zl8ZKiK8/3yrzQjZv775
	 XHh3z5QI+9nuenRHdEA4MblSnGphwadG3ucTl6ozc2y0hmaoE+g5hdfUnPX3Cuxxd0
	 awqMuDYbtnpEA==
Date: Fri, 18 Sep 2026 23:28:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 7/7] dmaengine: Remove deprecated
 dma_request_slave_channel()
Message-ID: <aq17qvmxF6nwclkR@parshuram>
References: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
 <20260918113727.1898998-8-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20260918113727.1898998-8-andriy.shevchenko@linux.intel.com>

On 18-09-26, 13:34, Andy Shevchenko wrote:
> No more users.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I thought I had acked earlier one. Here is it again


Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod


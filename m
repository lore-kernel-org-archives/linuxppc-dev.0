Return-Path: <linuxppc-dev+bounces-27440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA7C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:38:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkq3s1lBXz2yfH;
	Wed, 16 Sep 2026 03:38:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789493881;
	cv=none; b=WCS5b1SHSCm0dRrwgUhGNqj+NYT3vLwE9LRPW5ObLLwktb7eocZjsiJuseOFfs1F1XT3AYnuQQmioB2VVORkRFX8Ye3k+f0DWu6lEFiN2Sz5HsbDPl1F6r7J4dslKhGHX0RqkRJrpsy19poA0M1QVZarvA6AeOg9YQ1DGCziSchL8k2m4XhyxbU632kZzEEHfuJKxvMXeqTGvw+Rh0/OQXOyhropgK0+buW91he5lv1BxQAMyrrv81fp53XKKxw9AafQq6IRwOe8bhUTqadHbiX6Oo2pjAp969otqmkTigm6eK0buN4ryV9voZgFMJhgsGoiM+LFDAeewxA0Y2Vgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789493881; c=relaxed/relaxed;
	bh=lNOmklwMT3+8WwCRItuHkffYh/JkNHAawYZ2FWhI2k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/UOeAVKoXUuZ5POrlbHsA0j1EZyBbaXLT6wQeNpNZ/ntzuiA8LlvwQrJk0MLHNbZn3v+GdEasjx7aY7KsdhKnxPq1sF5I7UNZVnm2OhhJ1RQKhfVgeC6eFV6U4jlD+EtabZ7w51vqTX5+lAzDKw7jfnE29IXUYy6vky02EOhWmAecnwozN4IvBd3pUCcK1tSTcyvMo0Tg/oK5NN88FA0b1hoZK/PKxmwV4oWw9pU7spXOA18LUY9WUYp79KVeUgJwPp8pAGj9OP0OTBlHleeHUzBqnufpgZ3uTyvg56TMxIavOfFY57LqFp7Nsbh16xty4SG0yAFVFx1uP04x2YdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BamemBGZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BamemBGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkq3r4Py2z2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 03:38:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9EF58600D1;
	Tue, 15 Sep 2026 17:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F081F000FF;
	Tue, 15 Sep 2026 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493878;
	bh=lNOmklwMT3+8WwCRItuHkffYh/JkNHAawYZ2FWhI2k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BamemBGZLZEiNhzMEf53sH0aaBEGi/k7AS44kJ1lRb72jC2kMNobzBmsJjmYi4HPs
	 B3BxYdYFv/95wWGhWlLtkqBX084LIjizXy765ex13o62PZFGhuQviruML7X3jHwNl9
	 0pBZowc7i0vXoSJ36xFtqKoLH+7c4x2aqEU7AkRvQm/QJ8Z+CuVFktxBjV6HHmU4Am
	 SNP34f0gL9dnEuASoKHV0rsWJZA9AnRTZfio88imGgIc0sdlsWCvj7RHjEONeIg+/P
	 jmiGOUetPwMRYR6sordYsfjRBHVv/2mvRiomODvdIsnUBQPIotj1bZ6YcTKlGPOz3o
	 UbkETCel8UBVA==
Date: Tue, 15 Sep 2026 23:07:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Tianchu Chen <flynnnchen@tencent.com>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v1 7/7] dmaengine: Remove deprecated
 dma_request_slave_channel()
Message-ID: <aqmCcXRa3EIsIU6k@parshuram>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
 <20260915100931.3593242-8-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20260915100931.3593242-8-andriy.shevchenko@linux.intel.com>

On 15-09-26, 12:04, Andy Shevchenko wrote:
> No more users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod


Return-Path: <linuxppc-dev+bounces-17205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC59FFD45E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 19:35:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLlF55KDHz3fDd;
	Thu, 26 Feb 2026 06:35:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772048153;
	cv=none; b=EQ6fHFeDq0to2xoZwvO0HeJ00SsxV8eaIvQXjQzthAZ8WGZEy9rVAVyRJXUYiUYzHp37Y5tDhXOVzbu32QtQVP6dJnebSdKlpIqpzfx/GrQhdYAR0XxKt9hdB9HBKnPuwHEmVhKj9SFNARVfOkYH3Js4ntr/QV9gnbUteuuZmY85iuS0iZ48QtSuFw/WxJuk8i5GHFkQy2vZwl+PGRu3JVdS/1VV+7wUZZHrSuo51svOBRCw+V5d2jexv5IdMc6UhlA42zeBRTaybbM/ONYNVeIyvFOsNMr6bAHIXmfc9tP42SiEYdFZUvHjxajGdBV+dBz/lafgRMSyyoWj2Xfc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772048153; c=relaxed/relaxed;
	bh=tHZ5nRyU2kDhJOCF1SRfF9UCRr2RlD5jXmKCm3i5oHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWckx+Bd0Xu9fEy0zo1e6Slu6pkK8KVEkuGa8O457pqXHNsmmLu55T09JBdBp519GXHKksZExifGqn/GSDvqMlhP7YHAzBO8bIsQRSHFMuasGG7cQwE7U/AKNMOnfmCci5tGnE7XVkZKyB1LvF5wGiqRmxnqjWqbUN+An4I7sqYynxAm8jPqUEfCYNZx76RWG8pzkQKL1mUa0XJuK0odvM3hbMKmfXVE04OLtgL1XzjQ9smaKttjf3gUAR2tiPqrCKJmu9qlP6RWNNXA2h5aixzYAA6oPm/usUc6ydqptDloTqk3JjuL9Y2xHiyG1YzxgNcdHRdfP8D76KBdVAHRqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DuUm8457; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DuUm8457;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLlF444l9z3fDM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 06:35:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D347460054;
	Wed, 25 Feb 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BE2C116D0;
	Wed, 25 Feb 2026 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772048149;
	bh=LCcCGykLEqUy1dDs5e+ctne0AhEZqRPJSzXFbWQkanE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuUm8457BOfpyG2LF6Aawb2CnIyALtsyAAnPzQ6jyysWIOCEZuVVbN6gZRvd8ywmZ
	 SzdQ654EnIeoke7oBprsGnsOnJZG2OPZfs3zTBaWVXvDU7JbhiOuR/H/kqMdbuIAeq
	 EvDFGjc/OlaBxGldm7MJy1NU3GNJ2ct4NhEMmt9VH5eaJHj8gQHVKLDmMSDz9yZTFj
	 OCBw/WYQGBwPF34HcYWhKY02bWGUsbKSH02AO21SFnixMkxKz8ACdfyaBn6R5s3cOt
	 KE7dRgT9Ac9aQtvDKS4e47hYMQvUXtND9LHMlmF8pDKStiEQb3UvBkyolKAl9hUmIK
	 4Tqszr8GKHdmA==
Date: Wed, 25 Feb 2026 19:35:45 +0000
From: Simon Horman <horms@kernel.org>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/ibmveth: fix comment typos in imbveth.c
Message-ID: <aZ9PEaog5ZMr7LqW@horms.kernel.org>
References: <20260224153101.16935-1-abhindeka@gmail.com>
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
In-Reply-To: <20260224153101.16935-1-abhindeka@gmail.com>

On Tue, Feb 24, 2026 at 09:01:01PM +0530, Abhilekh Deka wrote:
> Correct spelling mistakes in comments:
> - Fix misspelling of gro_receive
> - Fix misspelling of Partition
> 
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>



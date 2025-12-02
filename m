Return-Path: <linuxppc-dev+bounces-14564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD7AD116F6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Dec 2025 14:48:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLNtP5WrPz3btn;
	Wed, 03 Dec 2025 01:48:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764686893;
	cv=none; b=UO3zztuLD+GosbtbNkw90qAu6d1oDy46m9V/F/bCnpZRTzj0O+lj2uplb/fddE79BUwky8o25gaFSpjT2VJ81G/sIcJjBicZUBCwOcg0QxMzUC4v0O9KrgS8zRnu4EZpDRL9Q03c9BYrG38oa6DaVoXDw7AxUAuDO9nSNp+aBZak7PNzcSgvuXxgjTHjZOfJjDVWdwyBV3UXuRQFj1KXKlfXxRZvxzmkQPhdnifjNgIs3/BkADZZGyYzq4nsbW7q8edM/ukylP0EHS+Rrnl3q8ohjCOAaGWKIfheohmEzfjN/1Z2Gw3Z3+d5TvESSh9r/d/kOyH0jSa5PeVnsqpvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764686893; c=relaxed/relaxed;
	bh=UBfH9eBIfu2N1OmJSZ0Lf/tj/sIgcp2KCszZ5Gl2Xao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh0GarhuTfAQs/ttQYsogCB8gLF5/XMrQuXfhIq815nF79Gq7thSF71wi8YiLSqw8hO63qzGudBgg4vrt4iF2kFPjOtRGxsYnxoYGJmk7v7JhHGUN8dx2fOIgKCJlua5TOQBoTetuDdxVacwHKr22yzfWNgHYNcuXy/SAppLKUp5BzfyNWGlD4J9oRfzEeXTv1PLQBINmfXr+tHEkETmVNxL19KG6nBsJFFpn5RiC0DaCIOYumjHlcCSTY3R2+ZN4VLL1B2PjQaFNbuNUx1CQu8gRVvYBqGB1tERIdYyX9MTp9CWx2cB7xPdsDIQDucUMcxszeKZBtX1+6JoL9rSTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Cu/BIwxu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Cu/BIwxu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLNtN1Kz0z3bsR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2025 01:48:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D2B7C408CA;
	Tue,  2 Dec 2025 14:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEB4C4CEF1;
	Tue,  2 Dec 2025 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764686888;
	bh=aSWRmzs9kwqAoinlWkEGTyeUnXsebkfgskozqDGtn6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cu/BIwxubIxfR5C1l0t+OiFORfnzO6pBvtbWp2jTjRaCTnSRhfdjAEcfPQABn2iSw
	 S9N2/5JqxQQ7Je7ETp9o1rkB8HGAXP2voJ42MAGqVdXGfCVakZ3ut3av3ZOevYkY0o
	 XBKhV/wHFTLEcRosEi9HSzTyKLmLsowjPda8nzfk=
Date: Tue, 2 Dec 2025 15:48:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bus: fsl-mc: Convert to bus callbacks
Message-ID: <2025120253-bullseye-diaper-8bd9@gregkh>
References: <cover.1764684327.git.u.kleine-koenig@baylibre.com>
 <848fffe5c479d899c04a4c99ccb5f0128ccc942d.1764684327.git.u.kleine-koenig@baylibre.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <848fffe5c479d899c04a4c99ccb5f0128ccc942d.1764684327.git.u.kleine-koenig@baylibre.com>

On Tue, Dec 02, 2025 at 03:09:20PM +0100, Uwe Kleine-König wrote:
> With the eventual goal to drop .probe(), .remove() and .shutdown() from
> struct device_driver, convert the fsl bus to use bus methods.

We can drop those functions?  Ok, that would be nice, didn't realize it
would be possible!

So, looks good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Return-Path: <linuxppc-dev+bounces-2197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877E0CFC51B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2024 08:58:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XRrjv6fmvz2ysv;
	Mon, 14 Oct 2024 19:58:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728896307;
	cv=none; b=CfwK19T1Kqq2CID4WCalB07i+QeK4Khoc6ULe1hTnD1SiBhna4fiPuuFc6uMXFXMZ/K884ZlS58bwwBVVNdk7TCK8tnE0+ekZ8c7tA2oKgQP4KG3nzK97dBS/ht2iRQSX8vn1ZvVdo57LzX/lrUaSH8A7DtqYfS7SOje8v2RxjLborCDffqvC5mY6ym7TMgKT7vkA5FTXYtbDenpOVXuRXt+Ui+7xio0vf/QfhcfT6bl+T/GAHTScJaEMSprZKlIrz/oTSOCbDjNIts1H8S2h68dWJUTTW/WGBmxKuZCFD+u4mzpIWgwA7V3CyPYylaE7eiwxUho8Xh5BSmp77wAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728896307; c=relaxed/relaxed;
	bh=QE4Uh/YZEwT5RcNMjXlkjI6JZ7PvHdMUeKerAQqVw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jElL4qC7oUAmZZ3YSX/71+ouH6zkHoYNgM+eB5cW71hzi7CQZufeEDhsF0vDonoxkNzetsdLaAtrtZXsItsYqLdBH4QouQufzbfjYpUNdZavTRP1ydIqzVtf7q+DyBfQOK+msTG6a3AKVOMeUIl5xTYBURBNQjtm2wg/6kjXmdd0zI5u80su1UKtRqzJIceloUZjZobjxaZ0YWTnSoZXI3y8VNIZsdf02SKcjB5RMH8IR8S8jfic197mWjil95UYJfRTskD9uVc0KsPubq/QwD8guvN3XPEoM+5k1NQblS5T9myJzoZzsziJ1Flo0891xs73d1DYAQOAlqS30QTifQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RkQUS2ip; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RkQUS2ip;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XRrjt5pkGz2yMF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2024 19:58:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A0668A4169E;
	Mon, 14 Oct 2024 08:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E721AC4CEC3;
	Mon, 14 Oct 2024 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728896303;
	bh=en97uQq/wU58/ojsiceIgcHAfChEIeCSY/86B7fnMGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkQUS2ipFVJvOJKlvZg2MsrjC5WG9NPlHUJGO2PM04x3y0W1uMDO0eyA4r4QIB1mh
	 R3gABoYQbJ59vdDERfO6qTkdYGKD2aBJRkyk3I/G4ZmA1ciQuCT/gTgI9qxPp1cba6
	 W6YlwNHRgPmXPsjOo3WbvPKCc5N5Ca65WAtUOLXjGOMA68sRYsYB+av/E54Pm1e4P5
	 KRN5ZMHXY8gp9uTPixE1WTe7upozapRI6c+FG+oaDeL/Fxij40NSBaRu4giU/LZxni
	 1+YOMvqsYuEgMZA5SxnbQczrQo+cE+X0BcdkVVZfacpx/TC9vnj0MVf3QuSxFaQubt
	 JfSWx+qVgy7qQ==
Date: Mon, 14 Oct 2024 09:58:19 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.12-rc3
Message-ID: <20241014085819.GO77519@kernel.org>
References: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>
 <20241014072731.3807160-1-geert@linux-m68k.org>
 <711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org>

On Mon, Oct 14, 2024 at 10:38:20AM +0200, Geert Uytterhoeven wrote:
> On Mon, 14 Oct 2024, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.12-rc3[1] to v6.12-rc2[3], the summaries are:
> >  - build errors: +3/-1
> 
>   + /kisskb/src/crypto/async_tx/async_tx.c: error: no previous prototype for '__async_tx_find_channel' [-Werror=missing-prototypes]:  => 43:1
> 
> powerpc-gcc{5,13}/ppc44x_allmodconfig
> 
>   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]:  => 126:37
>   + /kisskb/src/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]:  => 126:46

Hi Geert, all,

I wonder what the correct string format is in these cases?
I didn't have a good idea the last time I looked.

> 
> powerpc-gcc{5,13}/ppc85xx_allmodconfig
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8e929cb546ee42c9a61d24fae60605e9e3192354/ (all 194 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b/ (131 out of 194 configs)

...


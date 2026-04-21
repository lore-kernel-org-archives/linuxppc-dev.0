Return-Path: <linuxppc-dev+bounces-19878-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0673F8FA62
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 11:51:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0LKx2lM2z2ytx;
	Tue, 21 Apr 2026 21:51:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776772293;
	cv=none; b=kc3beImuTv9KZN1gvaPNZxqRadLQXPgpuGBX87UG4z+GPadbJ6dRoMMBG0QVoFpqAAg7C23WTIrug5g86X47oEfRIz0QmdfxVMn0pxiXJUUaoBpqydloBM39Omn3IATktE6FyUljf80fUIWouW7ofkgYk22R3iZeMhdeuXwUjQwoeb3Ky2vPuUDb70k3aK9RV8RDv3MGD8DDq4qUyfxzIwQ/t8YZQIZvycnfr4y4zZFCqh35m3Np5wQyJxcDPMLvySxsgWOw1guI669mzKSLiqaojbyTL/tQs8dbgk+pLuGVb6jZCgKcGHisYuVitD2vcWd+BOnO9w/1xOfSGb3FTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776772293; c=relaxed/relaxed;
	bh=OwjntzVNeDypYl+gb8gCC9m3YpwtU8u86yLeBxwqWjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLpphZEf7EgoDT9LBIaroI41L2dUrODzXhGCkewA4VWPtaUJ+bGVgVy0HzqUl4DYrVopdEkHBj3kmDvE9dWvPexW9omLF4Dz/7GrEZVzFts4NPouUAX8tzAr6658sZhXYF2vMzoKSmFwlC3juF5WnSRiOF3LmH50bmGACsRhnCZMgnFbHAnUf5QJ7HfKRE5Dfp/483eFd75BvxpIdIRSlzSiYfvm3A9I0swpWnaSKiUoyz7BtuitXvM54oKdqmJJ4po2YLDlP43BtsVTYrZn4URWb84TrhaW2+ycGLkWUibAsZb6vtAxoh79pCssVFiDOdrjwMM8Isb3C6qne7eAIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=cb0uNtWu; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=cb0uNtWu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0LKt6HM9z2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 21:51:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=OwjntzVNeDypYl+gb8gCC9m3YpwtU8u86yLeBxwqWjE=; 
	b=cb0uNtWuFWwCwtmeaDWAtvbkC3Y8S6XHqngK5Wla5CxIYXescDcvY0ZvESkjzs7A7+GGcSLzH1H
	aWkhry4AoKM/X34MbmXMSHJ8Jk5FJoJFRuz4aSSt3EHCuRn4km27h2yChnahNdoNEFROqX7IAyxH3
	/xS6JeQ6icnUP8PU3MGN5/2+Ht5vSSPmwSmMQFkpuTMrXo7vy9IEmNeZaMb0tQ0bPTcBc6Iqk1jzI
	9ofZNvzOr2qUKNoSsJObv4qmR8V8vXWaw9/Tzb7VitfQ1s6LO48RCOr5r397r2maHXmbic/hx0MFw
	QxqwwuA3NfDRVgGHR6H7wBEsAfpjnmVjwiKw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wF9c7-007h5o-3C;
	Tue, 21 Apr 2026 19:50:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 21 Apr 2026 19:49:59 +0800
Date: Tue, 21 Apr 2026 19:49:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@armlinux.org.uk,
	tsbogend@alpha.franken.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, 3chas3@gmail.com,
	razor@blackwall.org, idosch@nvidia.com, jani.nikula@intel.com,
	mchehab+huawei@kernel.org, tytso@mit.edu, geert@linux-m68k.org,
	ebiggers@kernel.org, johannes.berg@intel.com,
	jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
	fourier.thomas@gmail.com, andriy.shevchenko@intel.com,
	rdunlap@infradead.org, akpm@linux-foundation.org,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-deletions] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <aedkZ5bizasuBPI8@gondor.apana.org.au>
References: <20260421021943.1295109-1-kuba@kernel.org>
 <c7506c225ce22a71c03abc2673823cf84bbb5b0d.camel@infradead.org>
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
In-Reply-To: <c7506c225ce22a71c03abc2673823cf84bbb5b0d.camel@infradead.org>

On Tue, Apr 21, 2026 at 10:26:18AM +0100, David Woodhouse wrote:
>
> I suspect they don't have a huge amount of interest in the Solos any
> more, or the Geode-based SBC they sold with two of them on-board. But
> OpenWrt does still support them, and I even have one here (although no
> ADSL line to test it with). They were briefly popular as fully Linux-
> supported ADSL routers.

ADSL is history, it only ever made sense in rich countries where
physical copper cables were pre-installed in homes.  While rich
countries have moved to fibre, the rest of the world won't use
ADSL either because there is no copper cable to begin with.  So
it's actually cheaper to just lay a fibre cable for a new install.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


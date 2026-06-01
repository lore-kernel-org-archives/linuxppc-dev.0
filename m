Return-Path: <linuxppc-dev+bounces-21825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731ADCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 22:03:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTnzV17sXz2xKh;
	Tue, 02 Jun 2026 08:03:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780351430;
	cv=none; b=A+NJOFRYUIwdjdH5V6Uqet4x/VpnEsn82yBoIX7cp8CzIJHBDXwbvfg8KHAWRdkUotSqxissZKmEaBkmtoQNgCawMja8VtmnLDvLoSqXPIOg1Pg248kuVyy6Gl2cgvkjdtA8vvtJdxrlIcTioE+Y1b9/7qwcjTJmEm11rs5VH8aaUJnqW0hq9cJS8dDiPAwtpajtSzLrnOxJGgN57AzlVBTG9cf/CoboJAYRLxCqJUhn0icRDDsTUUoYx3BQPwiuKSFaTz3aiUMkfP+cbXcquSUI30QtX7UCbGHXaf1WiUv52Y5zLZN5sLwFSTx+xHqQ862A7EnUuWMQjwU56HDcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780351430; c=relaxed/relaxed;
	bh=077gy8AY+hyv37/kTC1iPbzz4eQKyCLUe7EWJcVomm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMjtuGr2pFKiSCf6S3ABw1sCbe2s22f8YQYUmlUl5VTE3PvBqF6v7EVM1DbKAqgpO4jMMalbU7Y2DhbDquYe3OVc0BeQgcxhsGQ4vQg2naQjiDUEKUG/TnC07N1PbXd2MVCZT3f22dXJy7x/RzMOdrrWutZdX08CPZbR4kbFdJ01bx/kV7PVknIXYD9O1SyBloTBx5XAnhdxbGsgYfe2T8l1NRpZWlTH1X6Nv0Eb1OUbUVbqoNFrOhfg/np9l99ZRIbdww+L0i3QXseUsVLd/jKaDFYb1rJCM5iPxu7iVIr1saiV/pNMr9MKLacdas8jZjv0ZWJJXzEFXpw/hqjQyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWFrhcDd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWFrhcDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTnzT4Jdwz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 08:03:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D0754364E;
	Mon,  1 Jun 2026 22:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277C31F00893;
	Mon,  1 Jun 2026 22:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780351427;
	bh=077gy8AY+hyv37/kTC1iPbzz4eQKyCLUe7EWJcVomm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZWFrhcDdDY/U0/zQADDGcCGETnhiX1SeCAaeSJrsfyCurAfijsUKMpw06iQAL+ykQ
	 B9gGN0OUHiVw0GAQdG+PuZu4q30933Bu2ktu4Zcute3mtRiVTGPbL9c3YcXiFRXtNi
	 hcZoAJFa3/MqKfttCuWFdMBmPx722TKlH0WsvE8a2YYTQBZc/sA3UlC1RfWDPrIa5E
	 aASRDVr48inKKRRJJyJVlTkejqmsqFt+VHq4GT/CFZNvzVbbY7ClbugpDzWp4+jvd1
	 sQ6yvGD0Hp2dHAAmimWolK8BBNgx+BvdrKsKBJgTFEx1oY3w67X3YABIkUdCvLs7ib
	 7Dr/1fB1Kw4NA==
Date: Mon, 1 Jun 2026 17:03:46 -0500
From: Rob Herring <robh@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, saravanak@kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] of/fdt: make early_init_dt_scan_chosen() return void
Message-ID: <20260601220346.GB54006-robh@kernel.org>
References: <20260510171353.1406018-1-ekffu200098@gmail.com>
 <20260510171353.1406018-3-ekffu200098@gmail.com>
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
In-Reply-To: <20260510171353.1406018-3-ekffu200098@gmail.com>

On Mon, May 11, 2026 at 02:13:53AM +0900, Sang-Heon Jeon wrote:
> Since commit 064e32dc5b03 ("of: fdt: Honor CONFIG_CMDLINE* even
> without /chosen node, take 2"), early_init_dt_scan_chosen() always
> returns 0, so the return value checks at its callers have become
> dead code.
> 
> Drop the return value, change the function to return void, and
> update its declaration and callers accordingly. No functional
> change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> dt-test result
> 
> [    0.684136] ### dt-test ### start of unittest - you will see error messages
> [    0.685849] ### dt-test ### EXPECT \ : Duplicate name in testcase-data, renamed to "duplicate-name#1"
> [    0.685870] Duplicate name in testcase-data, renamed to "duplicate-name#1"
> [    0.689496] ### dt-test ### EXPECT / : Duplicate name in testcase-data, renamed to "duplicate-name#1"
> 
> ...
> 
> [    1.693384] ### dt-test ### EXPECT / : OF: resolver: overlay phandle fixup failed: -22
> [    1.693386] ### dt-test ### EXPECT / : OF: resolver: node label 'this_label_does_not_exist' not found in live devicetree symbols table
> [    1.694968] ### dt-test ### end of unittest - 405 passed, 0 failed
> ---
>  drivers/of/fdt.c       | 10 ++--------
>  include/linux/of_fdt.h |  2 +-
>  2 files changed, 3 insertions(+), 9 deletions(-)

Looks like this is dependent on patch 1, so I'm assuming the PPC folks 
will take the series.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


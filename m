Return-Path: <linuxppc-dev+bounces-20023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064B3FDEE3F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:22:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1mFP3hkpz2yGf;
	Fri, 24 Apr 2026 05:22:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776972153;
	cv=none; b=gh3EJCcmlqOZY+hmZ3iDoYlDQeTnZZo0huUCueGUHMXM97/zf4TdWXETE6Pec6DibHX2wiiGIE4g+HFl3cIu4G7Pwf46Fn+BgQAkL/yj7RGpxxXQRsHrscxRbPUV/i7qe0NoqCvQmwuPJtbWYK37hXRecpPVCCYff+C9Lcrv8i6iEGXhnfhUFNlh8Bsr+bMQztXjDgAjd0XzGexgYOsqttXHrxyohCRdFzykgEPNik56VegMNL0sJRvqWxTjQ8I/2tcKXB/eLQLQullLImFluZV3KCFLfMvEvuK8xO5nZXj4aamCq2NbFt8djXcK3uXylfafpZoogCWlB7KJXyUQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776972153; c=relaxed/relaxed;
	bh=j0GPDBAm0I4zxAqI6YWcxfV5/1mdBezPe3eBd3FNm2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/lfVYRLDjb34+mU7NKlpqDsIwBVtqpdAaEqcrGzHa5ADwDMWx5rWgy9frIHiTd36sFi2C7jVz5Rnj8gV3hnQ243QHZjq41Y/x+il8ncar/Q55HhgEtyUU1b3tYd2j3l5NcgkV/SB7ninvfHrIRGv4RRF5elNjNwCPLuRxTFD1NAZFZpzyoxnSWALXq4KNMhBrhdAGEwMFj46f8F2MaI6workreZtUifejcctr5S4GrO7fb10SswNY9DRqkanGcIoeklpOhhrfapJLpAHXmt/F6GVY1d0VYTaMqDh4RzbsQfEPBDK9OBbB7gkseB5P8tX7vN2oAZUI+KDQ+8cLt5jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jkcJgQ3H; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jkcJgQ3H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1mFN6G0dz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 05:22:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 528A160018;
	Thu, 23 Apr 2026 19:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F940C2BCAF;
	Thu, 23 Apr 2026 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776972150;
	bh=j0GPDBAm0I4zxAqI6YWcxfV5/1mdBezPe3eBd3FNm2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jkcJgQ3HiRK14i/gFeArWLm8dfXNLDyZb/CpBpi/bg2TjV1D156Iw7VojatmxrCTw
	 Uk4tMSO0ptQJ3yEQ0ywEKSb1noOxH3OwK1MnLTfCM/vq9XfmghTzfaPgRrnppZ1Xgc
	 kFGzSEE8ml9Lbt3IukhfRveZZvqCqsyklMKvJD9kYlTLUyI39eU5IDbvCjRrrN4D+e
	 q1PAjGln/6wuqEz86fqtMAJMuyI2Y/8d/SXUWnZV3HJ0AWUZwmmzs7/C/dV6JI9dze
	 fRINV2aLL+GLGFZ48Gg+iryNpEsCaDM6wS6VAlLzaTOEQrnL0UAwaNb1jnF63pRK1a
	 pr6UfVB7Bhukg==
Date: Thu, 23 Apr 2026 12:22:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk,
 tsbogend@alpha.franken.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, 3chas3@gmail.com,
 razor@blackwall.org, idosch@nvidia.com, jani.nikula@intel.com,
 mchehab+huawei@kernel.org, tytso@mit.edu, herbert@gondor.apana.org.au,
 geert@linux-m68k.org, ebiggers@kernel.org, johannes.berg@intel.com,
 jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
 fourier.thomas@gmail.com, rdunlap@infradead.org, akpm@linux-foundation.org,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev, dwmw2@infradead.org
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <20260423122227.1454f68c@kernel.org>
In-Reply-To: <aeh0CV3UQw1quCXv@ashevche-desk.local>
References: <20260422041846.2035118-1-kuba@kernel.org>
	<aeh0CV3UQw1quCXv@ashevche-desk.local>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 10:08:57 +0300 Andy Shevchenko wrote:
> Since it's almost removal and it will go via netdev tree (same tree you are
> maintaining, I suppose) the -D would have a big help to review the changes
> (and not see removals at all, as 32k lines of one email is too much).

Good point, I'll remember for the future deletions


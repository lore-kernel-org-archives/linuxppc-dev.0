Return-Path: <linuxppc-dev+bounces-8720-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ABCC3ABDD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 May 2025 09:39:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1qJr5LlMz2ym3;
	Tue, 20 May 2025 19:39:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747733980;
	cv=none; b=FCQSWMO+EeitvVvPg+FT5va/kVkwkZwgb7Mxs/0EqmD4Ew+vojNUXGN5mgvSw7riRgt2LMqfdQUDS++AY/irUBJ2DrUZeOd7FBmQueMgyO54RC4AT+r+QSkS6wxijb50lgKjFSl9vaXPtuFNZUObZVdHFkHAH34sf3sCNC5C0f1n85mvfspGk+Nibpc2Tt/8CbsK/hRVtP2hPx4SWJReUlr3KDqzD6YdYwmu7ZWSItw5pvwOOqRn9V5SV+Ck5mOZ7gSVuHjfARVnsR8INkwjONiB+9vzpBug/n0EWJUcLYidNryJo0NGeQpke8A8UoCrFBjzI1GJzJp/TwYbUzyB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747733980; c=relaxed/relaxed;
	bh=GFdHKQJnrc7zqOCM2vKp5oxEqnJ6aQVyM9k/V+SM3Qs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grIgL3ydmbPpDIcu0k0fkbWRWeZy6sVCWfXhW0h1nxZDUGa0mkjVD4/GRibh1VxxGKmPh//YMD0Xa3RoQ8YYevT1pQinFfq8Hu97mp3OzWKPwW4JOD5Es7yRiqWRIctcJDIg8tDEXIX9gnr3AxaOKDuwEHUY9k56VaS/iM/uNEW0r92ouM/Lnv0hFbK+Z5XQLP8TfFKxqIhhmEyAGz2BCmZ3y2wCIKgdq2DnzKf9E1BJiFbuhIEp7VRLjoz6KNfZJPAnqfqPPlLuPCzHFUspmyPKz7Rjov0cI9TvRnqHt1R3F8uJIZB9mW+FF6d7gfrq7GuFNSwpyc7x+YiNpj30KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lZBsWk5f; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lZBsWk5f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1qJr06C4z2ygY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2025 19:39:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BF19C6115E;
	Tue, 20 May 2025 09:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1998C4CEEB;
	Tue, 20 May 2025 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733977;
	bh=dqwrQrWhJgRqFu/+w+3lHgg6iHrbHydwVyKCn+xleEo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=lZBsWk5f19wpeJWeh3xaGE0RM2RJa7mSGC2inPgseWO3kppFOw9l6ZWz74kdC7yOe
	 qJLwVOC5WjutEsmhQCm8mZIgf3Fna+4qHjLYifzWSnU3L7tfNKsvCXxsnyoZE8LrJh
	 aJRlmJ/yBA7ywoPpbGmeGwQ15/h0AqjNcAZpIAegOaL7xjMpbnKJRGpd0RiggPQPz4
	 tYqz25pX+HAjLFu1nxC/u3OvM8qXAtGnAQfe5ZI8jck19xLcn8W9u5e0KLFtXqsbbu
	 62edErBCnJYuyBnyfSDh++74hF1+II08SOf6QZBAV3r5bpzM+la5U2CYOe9gle7u8h
	 JVXs7bn8Q64Mg==
Date: Tue, 20 May 2025 11:39:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] i2c: powermac: convert of_node usage to fwnode
Message-ID: <2eannezxcjzazahbjfttvrcd6hod2tzamovqimbetwvdtqdnc4@myglh7pghrxp>
References: <20250519111311.2390-5-wsa+renesas@sang-engineering.com>
 <20250519111311.2390-6-wsa+renesas@sang-engineering.com>
 <enlo2gjoh5qua4phd3lnmmfr65zgx47vto35abwuwtpdy7ocp5@yd6mrc2yepws>
 <aCxIKd1QjIpaviBT@shikoro>
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
In-Reply-To: <aCxIKd1QjIpaviBT@shikoro>

Hi Wolfram,

On Tue, May 20, 2025 at 11:15:21AM +0200, Wolfram Sang wrote:
> 
> > I took this patch in i2c/i2c-host. Please let me know if you want
> > me to take also the others.
> 
> To avoid the dependency with your PR, is it okay if you drop it and I
> take this patch via my tree?

yes, sure! I will take it out.

Thanks,
Andi


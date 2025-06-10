Return-Path: <linuxppc-dev+bounces-9252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873F0C5B552
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Jun 2025 17:39:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGwyr5tKMz3blH;
	Wed, 11 Jun 2025 03:39:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749577172;
	cv=none; b=g5/T9iXM7+sEcfWjsr29j2JtpXI4ltrmySWRYKtJZzBkmVz57mnMXQ+b05kxE5tKjpuwGJUnqhlaSxLYIIhV1k/FE2Riyr60sH6M4/mwJKql173/n0plKce6VEmdCbiusoL7KyGpx2RpS31+3HEtKoSiPhEpKwnfphj7Smc9zzmKlG4HJLpHEmIWRKYGI9vtP6+lkRbFVQFiGAqIPhpct01qCwK+tdbsSM0TJWw9r8UiztXc+1ndZYUWG0px4igC7JnF4uqwotfKOxSd4SRpVxjNNcBnRNtNJWe8+nzEIaQmH4onrS0YgABBVxEg1OQXx9sSbh+0m76IhbEtQWPPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749577172; c=relaxed/relaxed;
	bh=ijj/kgQ1/3fFIkkk9vUFgfYNo0mzKr6rXHhJ9w9nI50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxzMTDgCm83WXHBddhrTBwAp2mQFD0XYPG5qxvvQvesknXV6ldExR25O8K5sm5atX9yqmhoi2V08SpkaZWAzZlE0nwo0EcwusOBc5V/yBvj862lovj3QEWOU46c0Dj3dMrA8HvbawbJsqftQs4jfaFHl0FfX/nCQ7nlqI1HTgN+eUwI4AZyxg+XEoBX4ptomUSkOYB6KZ+9OEJzjzSoe2kUzj4lqdhYYgvWcQq9bOyAYoZULLwsAXEkp+WlcmVASsYI6qm8HPGUvW3p5qDkM4jcp6MgkdEcmhvrJfRPmKHyvdwfuMNwGYWJzvlUKzlARi8iiHjcfLf3kGc83Huos6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=TLokPYgU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=63dn=yz=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=TLokPYgU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=63dn=yz=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGwyp3wBmz3blF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2025 03:39:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 041FA614AC;
	Tue, 10 Jun 2025 17:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D748C4CEED;
	Tue, 10 Jun 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TLokPYgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1749577164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijj/kgQ1/3fFIkkk9vUFgfYNo0mzKr6rXHhJ9w9nI50=;
	b=TLokPYgU2JOEdQndAvw9+JV28T5jssbviJD7hlMW/fJJWgwg7N1xBB6JMMINtsdD2jc1wR
	9vxPjpyhcdGVqfZKknbrL3tvYcbtlmFpSutoV8Knv518B4pawM2wjrJYa0svP2Pstv+4eW
	hu9USEEBUy1uuH8Mnd+AajCHjJgPyQQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dec6911f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Jun 2025 17:39:24 +0000 (UTC)
Date: Tue, 10 Jun 2025 11:39:22 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <aEhtyvBajGE80_2Z@zx2c4.com>
References: <20250607200454.73587-1-ebiggers@kernel.org>
 <aETPdvg8qXv18MDu@zx2c4.com>
 <20250608234817.GG1259@sol>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250608234817.GG1259@sol>

On Sun, Jun 08, 2025 at 04:48:17PM -0700, Eric Biggers wrote:
> On Sat, Jun 07, 2025 at 05:47:02PM -0600, Jason A. Donenfeld wrote:
> > On Sat, Jun 07, 2025 at 01:04:42PM -0700, Eric Biggers wrote:
> > > Having arch-specific code outside arch/ was somewhat controversial when
> > > Zinc proposed it back in 2018.  But I don't think the concerns are
> > > warranted.  It's better from a technical perspective, as it enables the
> > > improvements mentioned above.  This model is already successfully used
> > > in other places in the kernel such as lib/raid6/.  The community of each
> > > architecture still remains free to work on the code, even if it's not in
> > > arch/.  At the time there was also a desire to put the library code in
> > > the same files as the old-school crypto API, but that was a mistake; now
> > > that the library is separate, that's no longer a constraint either.
> > 
> > I can't express how happy I am to see this revived. It's clearly the
> > right way forward and makes it a lot simpler for us to dispatch to
> > various arch implementations and also is organizationally simpler.
> > 
> > Jason
> 
> Thanks!  Can I turn that into an Acked-by?

Took me a little while longer to fully review it. Sure,

    Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Side note: I wonder about eventually turning some of the static branches
into static calls.

Jason


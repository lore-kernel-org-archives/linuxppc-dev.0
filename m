Return-Path: <linuxppc-dev+bounces-26143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94007C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 08:03:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVvCn55mdz2xwN;
	Thu, 27 Aug 2026 18:03:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787817813;
	cv=none; b=R1FnZIpc07lfAabTkU9o44jjDj5/GdMOw209K24MOYx6PDfmCdI2p25BgZ6B4lYgtxGgM4TP5YBv6Q47EyDbouyu86sfbLdtoQCSrUlXngWW5QIdJavh2fIL37uWJg+pqSsnhFITC3Zj5UoKzO3dvJAsvd/KnokjsNOuvngfPJgRNfQ13XinTgn347TJNl8TOSorrfkVzH5HgXWJC2vnNOW4sz0tdhBSe5KX2eeGju9W9lg3zPoPftUX6DL9UVLU8YBnt8rZkpdnP2kB7ng2aCikqkEHXP3hVT8lHCSE5qcezE8YKxQbvoijqqro7nzXFwLBWQB+kaUp7qkIAui19g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787817813; c=relaxed/relaxed;
	bh=qXL2oS6rqznvftTLrf8LZgLPX4TTr2sqHZu9rHP27d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs2ctdO02DvhW9+EsBlJtB0yxs7hfMQWLfPOmcvBTg5eK88sLn3Y2+dvE9L9k9Y7EiQQdi4CuP2PhEl/s8lFrRiRHIGEt8oSdBWLdIfY5RgGoOzCX0FC8X6fsTTUpJEu3ZwmnMYB9EiejJ9W4A4tosXyE8lwPvhl6SUbjVGxD5/TttV/RFLfaHhf97XbtYYcE3f3pr1lba2+zcsJRWik3XlA+OcjzOKg8DIcTEMEHhKtJl57gH+DL5m4I7rNZOmwcJWdxivhiBFeUiP0l/aUZdZahyEK1WyxDFQCjJUl+jEyPtuXy1EdnBl9P2T3HKiRYzbvP4ZH3yQ/WlM5CdU0wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y59X1WvD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y59X1WvD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVvCm5q1Dz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 18:03:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 74BB6600D0;
	Thu, 27 Aug 2026 08:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E00A1F000E9;
	Thu, 27 Aug 2026 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787817809;
	bh=qXL2oS6rqznvftTLrf8LZgLPX4TTr2sqHZu9rHP27d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y59X1WvDiWVncqZBMXRihTdnQutjHIyDcTlQlCc4zknTmgdM6vTOl25vP36YLvKL6
	 YUBjX5anvmKQ7eJpIDQ14FxKSytIFMGy2w9mhR8fTUlkS+FtY0m7xKMA8HZW3CnJpV
	 hoOHxOBxY2OBO5H1q7Ze17kvx7eHIwORLcqvkrQ6X3YBStdrAKOKK+1yDiD2O3DdsR
	 S+f1RwI85rYYh7iyIerlzLMIn5UlEHAkHsCplAdn5GPKT1TndiL+0UMB2sw9Odk1xh
	 08/tBci7eh73lRSVGlra5NkC8LbfBjzShg9qo+DNPBuQN2aTKbwNgnHt/MMSUZqWrF
	 XDGwJ0FqV7FFQ==
Date: Thu, 27 Aug 2026 10:03:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Christophe Leroy <chleroy@kernel.org>, Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 0/2] powerpc: remove spufs coredump support
Message-ID: <20260827-teilen-flaggen-extensiv-61ce38f22855@brauner>
References: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
 <8ddf7d95-05b1-4758-9b5b-9360db77f904@app.fastmail.com>
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
In-Reply-To: <8ddf7d95-05b1-4758-9b5b-9360db77f904@app.fastmail.com>

On Wed, Aug 26, 2026 at 08:47:42PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 26, 2026, at 18:06, Christian Brauner wrote:
> > Note that the IBM Cell blades that shipped the Cell processor were
> > removed in commit 05bf59fbeef3 ("powerpc/cell: Remove support for IBM
> > Cell Blades"). The PlayStation 3 is the only platform left and nothing
> > there produces or reads these notes.
> 
> I don't see how you concluded the PS3 does not produce these
> notes: as far as I can tell, spufs on PS3 should still be able to do
> this if a process using an SPU crashes, and old gdb binaries should
> still be able to read them.
> 
> Whether anyone is still developing SPU programs on new kernels and
> would benefit from the information in the dump I don't know.

Sure, _old_ debuggers can do that. But new debuggers can't and have
dropped any support for this 6 years as I pointed out in the cut off
part. Similarly, gcc killed the SPU target 6 years ago in 10.1. So no
modern toolchain can build this. And the last supported kernel I found
is v6.12.

I deliberately left spufs itself in but I would really like to get rid
of the coredump special-sauce we need to have for this.

> > So remove it.
> >
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> 
> With clarifications in the changelog:

Ok, I'll point out that old tools can still do this.

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.


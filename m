Return-Path: <linuxppc-dev+bounces-22721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F7BCD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 15:49:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfryB5mjDz3bpx;
	Wed, 17 Jun 2026 01:49:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781624946;
	cv=none; b=PQHWa90e1tsiEC5Ho493suwsv9+s3I8pu+mAaNLdynSSQHsGEQO68sPUMbEw3dh93LLYsqr+KSPjThxjirqUV80D+uYO420QMI/AkqftryunZCfh9awZa40i2whx0nrPlgIFi3uhR9dYsi93NBUcvP7CNGfDn0AWj3pUqH8Xihpv4k3bZso1xEY/0z1Ar+GiXBmEku34nY29Fd1WzlrrIo1vsofY74zHlD1cPXWydk4qje+Nk8k50NhSUpJYKiW9KGNvr2N70atyYUSHIcEm3SK8fW9+CDVbVaSmRAX05/S9k8A3H4HmYC+6J46sr0Gzir6MUMsYFwjyq+1osBqz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781624946; c=relaxed/relaxed;
	bh=LwBPJI0zIYaGqkx1gEaeFo2rsRmh3p4qrOGbWDxyeO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbtHHXlE1Xfgs5+bpeOGz72oCkAjOuM0rTnZn5OWbOlOCeN+lsi0lUfYTICBmZPK0UBK4UpUHN0q6o6y1sNBSuOni5UraIqe+W8AwS2gnU7cI8z1QLP5BelrzvQZYpox1q/slPK5FABzaWFSU9IAbBRc3xy+DcrLTOU005HcPQ2t8n7j26i9CdpmOQI4ifcgw9Ly4g3qWeYaZKGqx0XfQnACLCaOAjzsWeUuAarvzbX0uRjDlDRKMWPO363LJnrR8cmnsS6iXn8OR7432PxhWiO+M+6ajYux3iJlDbn7KMVCeqXUBxwQoShQEyTEVRF04PSxXDJZqhgg/djnAjZrOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Zgu4IM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Zgu4IM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfry96Wtkz2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 01:49:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E7B15600AB;
	Tue, 16 Jun 2026 15:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13EC1F00A3A;
	Tue, 16 Jun 2026 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624942;
	bh=LwBPJI0zIYaGqkx1gEaeFo2rsRmh3p4qrOGbWDxyeO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K1Zgu4IMExh7jVVg+2IFXKcFfxCtgqqknPSgNk95pMqsypDLzD2QVFu6TptWzkDGZ
	 1YRTc4b7aRDRfRCJLepsIdRKV5PlqaJRGKGzjOzgErOK+HC6N+5vicmrEDClCyYvrG
	 YEm5iik1EYQiaWU5qzafp8VM/hJ1QPW6iusrwEaaSZWtD/CtGIzbai0Z2JCQJPH2nz
	 4I/CEpzHPrk0WGCzwnkZeJSrepcJ3biv4V1RH6JUebicDQcaPZifoORh3ZbSOpE+do
	 CDP1qjdZij4tJYT85PBnJMjWGjmTmywO1no7Rx4VzWJeyaIo6tBSEENR2qURrq5B8B
	 wOgf3aKc7W4kg==
Date: Tue, 16 Jun 2026 08:49:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carsten Strotmann <cas@strotmann.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <20260616084901.3319d82e@kernel.org>
In-Reply-To: <A3590144-073C-46D6-8425-90EE0C4D48E8@strotmann.de>
References: <20260615222935.947233-1-kuba@kernel.org>
	<c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
	<20260615175535.5bc56cfc@kernel.org>
	<A3590144-073C-46D6-8425-90EE0C4D48E8@strotmann.de>
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

On Tue, 16 Jun 2026 09:13:46 +0200 Carsten Strotmann wrote:
> I'm a user of AppleTalk and other "Retro"-Features in the Linux Kernel.
> 
> On 16 Jun 2026, at 2:55, Jakub Kicinski wrote:
> 
> > We can complain about the AI slop til the cows comes home.
> > I don't like it, you don't like it. What difference does it make?
> >
> > If y'all have real solutions please share. Complaining about
> > "commercial interests" and "nuk[ing] everything in a panic reaction"
> > is not helpful.  
> 
> the solution, as Adrian pointed out, is to leave these features in
> the Linux kernel but have them disabled by default.

I think y'all need to internalize that "just leave it in" means work.
_Someone_ has to handle the reports and patches. And since nobody is
doing that the code is going to GitHub, where it can continue to "just
be left" or whatever, without racking up CVEs for the Linux kernel
and leading to maintainer burn out :/

> Maybe put a warning message in the kernel config tools that people
> should only enable these if they know what they are doing.
> 
> These "retro"-features should not pose any security risk of they are
> not compiled into a kernel.

Nobody is stopping you from using this code! It's perfectly suitable 
to be an out of tree module. Maybe it'd be harder if someone wanted to
remove a CPU architecture you want to use, but protocols are perfectly
fine as loadable modules. You can continue to use the code from:
 https://github.com/linux-netdev/mod-orphan

Presumably you could get Debian to package that and you wouldn't even
know the sources no longer live in the kernel tree.


Return-Path: <linuxppc-dev+bounces-22675-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53907CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 00:55:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfT7J4hT4z3btJ;
	Tue, 16 Jun 2026 10:55:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781571340;
	cv=none; b=N8lBEQdB+E983ab708jdULb922zTAQke0kapjpGR9T9VwAhqe9S5x+tTiFqRqcCRr+FNg/wntfr5dF+7w/rhq0N0Eb91ZNvMtzD23mtoao3YdtChC24Ia+0r/2FwpSU9w9/8aGdpH5evYIyJlPdBjtr/48ii1PcpCDzkHaxUsTbYUGg9k1sfYjwkwZDc65AAQv2iG3TrUdW8235G5Wr8c+nDW8Zkc/Xfqo5gOeq0IKykm/C2WMVESNCRxr10PGkPY9dOLsLDl8Zo8aXQvGOFYm/u5GH4ll1aCUWTTJ8vDOWFXVjFkHexf9UyrzxZveyvOB606iz6jUqI9msI5xSUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781571340; c=relaxed/relaxed;
	bh=lskkInW4j+QflVmCtofwVhf2RQet1ZyLYb6x5LBakeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObYmfQgyM4HFc8LG0CTRXFhkM0zRzNLv63XKkaR2FnZhyaN2U/X+1Sg3Jsaf/CY6j8klAYfGggwAKZUcPE4LBZk0crD3gkYLlk4MNWrRqJCOyQr8W6dukD+sDYBV9oOc6XlfO8U2IXyY+2NZwUvP9HJrQZD0XNM7rIjMDh9J3XCI+e8jD6lMLmgMvg9QV4T8OSLnMNg7ysBgPybN9K3XzCjChFI/7p0ReQjxK7uuelIymabunB5rk3il4Mu+1CBbF+l6rls59GfZx/yeEaGaOrsXs/JC66nTQR8v/EFGWR/MWNxqmdu8ReBcndgZ/sLXCkrK6vSj10wCXY4b9z1guQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKZ5AFQI; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKZ5AFQI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfT7H5ln4z2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 10:55:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 726D5600AB;
	Tue, 16 Jun 2026 00:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A1E1F000E9;
	Tue, 16 Jun 2026 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571337;
	bh=lskkInW4j+QflVmCtofwVhf2RQet1ZyLYb6x5LBakeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TKZ5AFQIoVK5NtSIBcKZ+XK4QNf3pRkYbRoMsoZ4iDboN3wkJk1jZTJ2kwEkojwK7
	 56Er+BG+jd3/RoIUW9OY1xeprE5dYvsQL1SQ6eAS5vtjFyMGB1ovOkPQOJgcbnDvwK
	 IDBFmXEP3upDgEU88CBoP68UJPtrnWeWEKyUHx9kaowOkG/8QRvagZ4QGNTGXS8CWI
	 ex8JjIgvxHy/JHluGsl+c2NhPsbxVYSOUSDFitNKbpJ1P2CzQrLjPgbQ0NTazsuIDa
	 shXnbiP1zAA9/68Ma1G129w2dlqiLw6AAA79KKtVgfdkclrrkwgVm7yaUqvNB+RqXl
	 2r9jLauRxnyEQ==
Date: Mon, 15 Jun 2026 17:55:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <20260615175535.5bc56cfc@kernel.org>
In-Reply-To: <c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
References: <20260615222935.947233-1-kuba@kernel.org>
	<c3789160609a10e232ba3e27c4b13adbb170956c.camel@physik.fu-berlin.de>
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

On Tue, 16 Jun 2026 01:34:06 +0200 John Paul Adrian Glaubitz wrote:
> On Mon, 2026-06-15 at 15:29 -0700, Jakub Kicinski wrote:
> > This tiny series moves appletalk out of tree, to:
> > 
> >   https://github.com/linux-netdev/mod-orphan
> > 
> > Core maintainainers are unable to keep up with the rate of security
> > bug reports and fixes. Nobody seems to care about appletalk enough
> > to review the patches.  
> 
> Why would fixing these vulnerabilities be relevant? No one is going to
> expose an Apple Talk server to an untrusted network, are they? The same
> applies to hamradio and AX.25, they are all used by hobbyists in DMZ
> networks, so no one really cares about vulnerabilities in these protocols.
> 
> I find it sad that AI tools are basically used to shoot at the kernel
> to kill off features as some people are apparently getting scared by
> these AI reports and just nuke everything in a panic reaction as if it
> wouldn't just be possible to disable these protocols at compile time
> to reduce the attack surface.
> 
> > As Eric pointed out Mac OS dropped AppleTalk over a decade ago.  
> 
> That's not the point though. No one is going to use AppleTalk to network
> a Linux box to a modern macOS machine. The usefulness lies in hooking up
> a Linux box to a vintage Mac or other retro computer.
> 
> So far, one of the huge advantages of open source operating systems has
> always been that even niche use cases were supported and people could make
> use of old hardware by using open source operating systems over commercial
> offerings such as Windows or macOS.
> 
> With the advent of AI security reports, these niche use cases are more and
> more being killed off with the argument that a vulnerability in the harmradio
> code could pose a threat to a large SAP database running on a Linux enterprise
> distribution. However, if your enterprise distribution is enabling kernel
> features their customers aren't using and therefore enlarging the attack surface,
> it's more a problem of said enterprise distribution and not of these old and
> obscure network protocols.
> 
> I am trying my best to save as many classic features in the kernel as possible
> to enable retro computing but I am sometimes fearing that commercial interest
> in the kernel is taking over too much making my efforts harder every day.

We can complain about the AI slop til the cows comes home.
I don't like it, you don't like it. What difference does it make? 

If y'all have real solutions please share. Complaining about
"commercial interests" and "nuk[ing] everything in a panic reaction"
is not helpful.


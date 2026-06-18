Return-Path: <linuxppc-dev+bounces-22760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C166ACD98ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:32:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggv9514TLz2yNn;
	Thu, 18 Jun 2026 18:32:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781771529;
	cv=none; b=N5PpFSEGbpaqn+jRLxBeaMarEoxGDvKyx2ji3eMk2LWRNgCP+X97KQc6sWFA2hzA3ohe3jTi/FiQUHqpJ/nMUaNKEX6AKnTf8KQR0QBdFcHzD0J3gZUpaR8Pstpkb+T3aztnNG4t74V/FryKBHABFT9lCdM/XwbY7rHK6/LZXAbSpfcFqDXJF1BPj96oap3h2eRevjeXPg/1pyxL2K+/wD4Y/ohMqk9Q/JK+56kR9mkQupl3802RJmcSGv/m4GWCCxT4F6AvteNZyZNYx+MkwF/eTWIyJjHCpGzIfbNGDVk3tVZrKT9H4UcLMdMuwcSOwtjdCQj7h0ZsO3zjuLD8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781771529; c=relaxed/relaxed;
	bh=DX/5eoMehoRMx1NS0o3ilj6Cat8DUGz4t+h0dl/9b8w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M9Fbv1THBv5Ed7O2LHuy+QB0tThA3kR1LUGThkBBuPg4H260aMnsVWRgEEZktItHHsy2slcSFkLQuejpzZuZ5MEyCp+BG1fjDY83U8QM01k2fd2cNCfC3cRV4tAeLW8ebmZPwE8M3cL0C4xEisAWLvPCx9xH0fZI9Q6avX0UYQBXa1aqm0ngQ4lPdRYKYZ0exKjtsFf6LRENcG6pAimUrbG8KALt/rkMPpUqTXB3QiM6PPqsWPgzQ/urD0ywt4wZMtsmcPNid+yDqBrnumHk6KlJh2r4vX8YhjF7IOUVYA1eLtbzdYjo8RTtqCzhqjtTnX6GoqHPQRnF4VZPsInYSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=a7bLhF/a; dkim-atps=neutral; spf=pass (client-ip=103.168.172.148; helo=fout-a5-smtp.messagingengine.com; envelope-from=fthain@linux-m68k.org; receiver=lists.ozlabs.org) smtp.helo=fout-a5-smtp.messagingengine.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=a7bLhF/a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=fout-a5-smtp.messagingengine.com (client-ip=103.168.172.148; helo=fout-a5-smtp.messagingengine.com; envelope-from=fthain@linux-m68k.org; receiver=lists.ozlabs.org)
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggv932LHKz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 18:32:05 +1000 (AEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3EE3CEC0125;
	Thu, 18 Jun 2026 04:32:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 18 Jun 2026 04:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781771523; x=1781857923; bh=DX/5eoMehoRMx1NS0o3ilj6Cat8DUGz4t+h
	0dl/9b8w=; b=a7bLhF/avj96bs8ne8CbAjwUs9qrJycSakuzm7NpXWgZobZcDJd
	97IGbNu/qmA9gBGPBPbt6U3H4fdFM4Ur0JupUaEHSO1CuD6X4PIZLMTtBwmThK7i
	U1K6naJpXHb8f9MJiYh6yjbr0hBUvvqhMPCPjDVRva6rOovXq8ly7UXnRbt4ZDbg
	A+v+fWIpNl8XPIEeqB0lFds6r2JG1bp/DrNJ/AIHrPSN4kfZzbFG/96BV154YZ8H
	Iyd3xXzuZ++SsIQgH8q3kDj/dAiCf35oGVR7FTtQHR5st9k1DzeYsxZJO9Floa+Z
	hlZRD1hUJ3bwQVBJk9lTd5fPMPyiWj0rSUw==
X-ME-Sender: <xms:Aq0zap0az8UG10rexhGH9sHYzO9pzrr35k3cJscocbx9fclwlFKmww>
    <xme:Aq0zar-x1tU0MkrrIzSKKKWpEG0tzYj6npaSbBkuHvbftxLntPwZaEJd-o4icysvq
    zUrxB9pbwVJcwMpv77L-S5vGnRBGnFLTb3yNGU6Cge9H-Tr9Wp4wM0>
X-ME-Received: <xmr:Aq0zalYvQ3dpyrtCrpEs9-T8vfL3TYTjJEK2SFc4D32akizW3mvU9SyadFWk>
X-ME-Proxy-Cause: dmFkZTENUo1ZmJt29bGwYRxNLA/I+cx87fAWyEWHgTjdGerg5dLt/PVhI8bN6q9UjDukdN
    m0Dby0iAlLvdA93Tb246Tx53rTY4N97xRSicwUn+OaBVZmBlmlNSDPB2p9AXE4zW5ZBNBW
    yUZ9m5kMt9vA32mPt71DSoPh/ovPZiR47gjL2xWM+ZS/mKDMl5rHa8+816FK43bPOoOy8b
    t02nTTbmkFWULrtaps3qJnuK0Tk3EU0TIMz+GeRwZusioUwIrQomUDFx+fJXsjjHOyQOCr
    jpz2p58GQ6I3GuTa3sMzUx466v4Fc+qPeNgnVqY0VVIUZrbr6+0GKUwLT+vdJWuRcK8vee
    WcWB4I8H1UrY7YgFfyclVx12Iws2XY9FWqutabemH10TvAfLoiT37z3P9GxlG1YDSvgdoH
    RlI/XownDhkRbg1D3coHR/NFeU+nR4D14Kj/bm51Qh+dae1VZUfig7aa5sFTrcwkCBBsZV
    YtgvrT3AnUw5QnW/mqpbmFlnHSqTOBR9uxhYMi4aAAOnO1F5QCwS6fzO4ZAJJmthFxOaOH
    62E9AhfHlCCchvM25CyqKP+0Y95H0/OTIZVKwsq/nLDkfOk7JLve7rQhmJb8UEZysLtwwd
    tra4bDuA8Ph6lacrGYoSGWYSgNYu9xolAQX8hMIdjxopXjwiXuljwbJvaAGA
X-ME-Proxy: <xmx:Aq0zaqxV3a70epHyy_Xk7BDS6N4_GJHhP5-h8e4BOPLyNjr0dI3UmA>
    <xmx:Aq0zaj-7Me0Rt6HBSYVfAX_DliHHakKRqX1cDt3G7usLSRaIYxI4EA>
    <xmx:Aq0zamzq1qxfnDlMBwn1cqwNsiY__E9NIpjqXRijCKz6MuKgFSzRSg>
    <xmx:Aq0zaov5eHvAQNUxJ3oQ2L2z1tzg2WzOfTjPen8jL7kTCIU0X1uBxA>
    <xmx:A60zarQxTkwnS_YYBiQm1quQzacJKLs6ftsDWO2YEV-4YFzYy3Le3l4a>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 04:32:00 -0400 (EDT)
Date: Thu, 18 Jun 2026 18:31:55 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Andrew Lunn <andrew@lunn.ch>
cc: Carsten Strotmann <carsten@strotmann.de>, Jakub Kicinski <kuba@kernel.org>, 
    Carsten Strotmann <cas@strotmann.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
    pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
    geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com, 
    mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
In-Reply-To: <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
Message-ID: <4b08a56c-b209-22c8-7835-6fee7ac7a8b8@linux-m68k.org>
References: <20260616084901.3319d82e@kernel.org> <1781694488854.956546368.818588236@strotmann.de> <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org> <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
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


On Thu, 18 Jun 2026, Andrew Lunn wrote:

> appletalk is just one of many many drivers where the listed Maintainers 
> does not respond to patches, or there is no Maintainer at all. So a lot 
> of work falls on the top level netdev Maintainers.

It goes with the territory. If that messes up their performance reviews, I 
am okay with that. We all make our own choices.

> In fact, a lot of the AI driven bug fixes tend to fall into this 
> category of old drivers with no active Maintainers, since that tends to 
> be where the poorer quality code is.

That has not been my experience. I rarely see a review from sashiko-bot on 
the scsi mailing list that doesn't list as many pre-existing bugs as new 
bugs. This is almost always actively developed code, not mature code.

In anycase, quality is irrelevant here. I'm happy to see fixes for any 
code base whatever its level of quality and whatever the quality metric. 

What matters more to me than quality is utility.

> So top level netdev Maintainers are having to do a lot more work, on old 
> drivers which very few people care about. That is a poor use of their 
> talent, when we actually want them working on drivers for modern 
> hardware with a lot of users.
> 

Again, that has not been my experience. Linux often gets installed because 
the hardware is not modern enough so the vendor has abandoned it and so
there's no better alternative than Linux.

As for wasted talent, this industry discards skillsets just as fast as you 
discard e-waste. It goes with the territory. Moreover, if maintainers are 
not using AI to make themselves more effective then they should admit to 
retro-computing.


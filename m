Return-Path: <linuxppc-dev+bounces-22772-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA22CD98ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 11:24:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggyzj5zpmz2yRF;
	Thu, 18 Jun 2026 21:24:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781781857;
	cv=none; b=ivAQ2myvw+2CGMtCoXfuz/QTX356SMtgt8m450Ut6PLlEZisF9pHCk9ti80p6BSQwcXCSpMXdSGcPblEaKlMEhV6+CX2438Pbr8mPhQXW1kWaNE9zNUK6gcJf2MpTzMHrgfs3HUtwz56hP34n1mVRUcAhPKoesbuG8LuaUWHDrCJFN+p6sMCZCoQNBkDki5Uf9yuZzI3vLROAqtO19edtoWkDD4xeyABjqFZgvSDBiTfdv63HAeXF1PGk4zgLvrQu0uJniiorYYmwIJyHhXmTsWFIpQUeuAJt+zKFt0aoiTTT84H9jyEviR0BjQBS626sud8AB0/h+ouJjxCOcCdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781781857; c=relaxed/relaxed;
	bh=KIVhtGDOftKGMoqU6D8/d4TMAblKDzksnARw6vxVdcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5bfXvp/HPnPqahxlRdbyzAXoZNyJGqETeUyUIhbubm5uWb7hUtoXYeO8hSGtncwXvVqjZZhHUrk/KSkQ29UKlyGxjH0zdS2J4lfaQ9zaLugLLdealUt6RT/Rokizhiy4svV25YK+7hA2C1bsghsLEGDLlSXNF8HHXHWMbV313nFer6gz8/2/qm1RL7w4UlvJ7fcumgCEIOpyBBuq/nAKmZh9LsC71spAWO4q2wGOHgpU7dhAKliE4n7QKqr50TNxy+ET7Ac+7hblHKvdPT20ZWJfrWbpCjthWxU9wDP38/njgd687HPbLAb76nXHSTUoPfq0TGFmqJc7j8dPyAHLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=yXsum/2J; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=yXsum/2J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggyzh1VwMz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 21:24:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KIVhtGDOftKGMoqU6D8/d4TMAblKDzksnARw6vxVdcw=; b=yXsum/2JI2Ph64k4YrNglCS8tA
	xlEjQXaixDCl1NhwC4ls/bBCyr0q/m2NDKVMHhp1f+7/VPhNfLyGxO/oQ6N1kR51WUC2XHvhiK+Qt
	ON52Kx4BQSw8U6UUYRtbNVqEoghiP53xQpw77Oz8uevBbKio2CeNQ0mTr/XeC/O8fnjg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1waAqg-008KhB-Rm; Thu, 18 Jun 2026 13:23:54 +0200
Date: Thu, 18 Jun 2026 13:23:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@linux-m68k.org>,
	Carsten Strotmann <carsten@strotmann.de>,
	Jakub Kicinski <kuba@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	chleroy@kernel.org, npiggin@gmail.com, mpe@ellerman.id.au,
	maddy@linux.ibm.com, linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <91591775-3ac7-4b1f-91a3-9c58df96d9fc@lunn.ch>
References: <20260616084901.3319d82e@kernel.org>
 <1781694488854.956546368.818588236@strotmann.de>
 <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org>
 <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
 <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>
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
In-Reply-To: <CAMuHMdU0em2r-SixT_+EpWJnm4f0g8mReYKBXOw42=HGb_T8WQ@mail.gmail.com>

On Thu, Jun 18, 2026 at 10:13:08AM +0200, Geert Uytterhoeven wrote:
> Hi Andrew,
> 
> On Thu, 18 Jun 2026 at 10:01, Andrew Lunn <andrew@lunn.ch> wrote:
> > If the appletalk community can take the workload off the top level
> > maintainers, respond to all patches within 2 to 3 days, give
> > Reviewed-by, or make change requests, it can probably stay in the
> > Mainline kernel. Otherwise it will move out of tree.
> 
> "2 or 3 days" is rather short.  If we would have to move all code
> maintained by people who cannot respond to all patches within 2 to
> 3 days out of the mainline kernel, you'd end up with a networking
> subsystem without supporting OS ;-)

I do agree that every subsystem is different, but that is the speed
netdev goes, often faster. There are around 150 patches a day
submitted, and in order to not drown in those patches, they need to be
processed fast.

It is however known for a sub-subsystem to move out of netdev to a
mailing list and a git tree of its own, and just send git pull
requests to netdev. It can then move at its own speed.

	Andrew



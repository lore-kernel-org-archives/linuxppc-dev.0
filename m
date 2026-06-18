Return-Path: <linuxppc-dev+bounces-22758-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F6ACD98F0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:02:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggtVc2qv4z2xM7;
	Thu, 18 Jun 2026 18:02:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781769736;
	cv=none; b=IWHvpIjpoloBQ+iwKUvNBtktpUnk3wl4JeSRUCx/WM1Xz5mixDvtaKFknlFOAY9aCxwagkrPdabQ8kRBJG+BBmtc4xa8oIjlkLfC6cxrvlzRGqC+2IZgw38l3KO+uBay89qef33mEDbg9iIdNOwgy/IwTDirOwkkYKDHHe+su4L9xlpQ1LhKzibj4FksdFZcYahNr52bslwmImGh5alBfuX36Mgb67lqVpd+QZlBrK5Dhz+FlYOLL8heGonsRgWjJDQgKA+T3pfabfSQGRZTe7ncljKTDmO/P6nhxuN/BIHaVy/K0ZeFwViNqXzCasQFFDNeRSBT/W9e+vd9AUyzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781769736; c=relaxed/relaxed;
	bh=2voqrgEApl3hIFJ06xFwhIwE/g8LBCEOl7qjySZCqms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAzHbkXRrhU5BveO75wD6iOoACYL3IXtIERgUNdbq4MTHVduDAb8wl32VUqtOzAzCbgMG0qQq46byGPJ5Qk6yMZx/sbolwmeoy1EOz5L2zuBr1zRmKq7zcUhb2L/W9/tqVDk0KO07LO1S/6R7cfpMQ01s9OCz1SyUIRdUxW+QglfJBLAsChe4K8njSrF4CUnInXJVo59qD778dJ4x7+XXU0+p3GqYkrZYcEEg6wAIF3nWKTK3uERC5L/oFtZnP6dipV2gLV64x+XaiVlC/v65wLjCSLs5MUk0UB60fSNuTkA96h5QMlZoJMp5AJ9/va5MSGhrXW1LmCe3t+3YnoogA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LW+ddLGK; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LW+ddLGK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggtVZ5zKtz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 18:02:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2voqrgEApl3hIFJ06xFwhIwE/g8LBCEOl7qjySZCqms=; b=LW+ddLGKxdV1h2RvPd/Xsci0X0
	rcoxdFyymM9ZM1FayKR1jQVo+V93Jdyx7IX/LxXuNlk5xaZ3M6IJnRXqF1OzYrrZoT4ZBuml2kxv6
	InlbBdp22qDbCQEH3Lr7fff2Gl6N0CnqpIoEIBhNtfAwUFFQFV/a4ZAXlSQPGqAbQoUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wa7gx-008J4F-Gs; Thu, 18 Jun 2026 10:01:39 +0200
Date: Thu, 18 Jun 2026 10:01:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Carsten Strotmann <carsten@strotmann.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Carsten Strotmann <cas@strotmann.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
	mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Message-ID: <2791b2e3-bf58-4dce-9262-4f1d8d3241fb@lunn.ch>
References: <20260616084901.3319d82e@kernel.org>
 <1781694488854.956546368.818588236@strotmann.de>
 <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org>
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
In-Reply-To: <489024bc-b6e5-f601-3bce-444d75abbf5d@linux-m68k.org>

On Thu, Jun 18, 2026 at 10:55:54AM +1000, Finn Thain wrote:
> 
> On Wed, 17 Jun 2026, Carsten Strotmann wrote:
> 
> > > _Someone_ has to handle the reports and patches. And since nobody is 
> > > doing that the code is going to GitHub, where it can continue to "just 
> > > be left" or whatever, without racking up CVEs for the Linux kernel and 
> > > leading to maintainer burn out :/
> > > 
> > 
> > That's a good point. The large influx of reports is a problem, and burn 
> > out of maintainers is a too high cost.
> > 
> 
> Carsten, if, as a maintainer, you want to avoid burnout then

It is not necessarily Carsten who is heading towards burnout.
appletalk is just one of many many drivers where the listed
Maintainers does not respond to patches, or there is no Maintainer at
all. So a lot of work falls on the top level netdev Maintainers. In
fact, a lot of the AI driven bug fixes tend to fall into this category
of old drivers with no active Maintainers, since that tends to be
where the poorer quality code is. So top level netdev Maintainers are
having to do a lot more work, on old drivers which very few people
care about. That is a poor use of their talent, when we actually want
them working on drivers for modern hardware with a lot of users.

If the appletalk community can take the workload off the top level
maintainers, respond to all patches within 2 to 3 days, give
Reviewed-by, or make change requests, it can probably stay in the
Mainline kernel. Otherwise it will move out of tree.

     Andrew



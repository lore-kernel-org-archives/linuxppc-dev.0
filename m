Return-Path: <linuxppc-dev+bounces-29628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CE2CCF2C1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 17:40:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6TbL4d5Kz2xqr;
	Sun, 18 Oct 2026 04:39:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792258798;
	cv=none; b=eojdpgAwZ1l4zUYFSm56/0+T4ztgwtdIagPU/g2ILMRT4tLIJKcn51ssdetrD5VKNOr91LOhC2AZ5n5PvzAI0PrA/gLGBovRlRNElUPhzRaZXBgcJo8V+z8y0ZVSezGoVqM8WsP2ob8gnJkbP/03U8ErpEbSpZHmHdI4hqNSQosp9Q9FBjK9yQyByj8xVMMX2dtwgrVNUmNw3H72rtyq+Y/vpG30XUz13RyCxT3nAtBSfdoJttfJOFKWv/VmWf/HFOuaaWPvkaW10ktzqk5WqYQ/L4ZZnOTv1w6XkMJU8aPwllmHj6lhX3rnVbbr3hJngBBePjJBx7ztw2uYMXipNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792258798; c=relaxed/relaxed;
	bh=/3wyvCgF7xvp0uGxR/dqJ+LvnFcAl8T7SfLqaAeJ9Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AECuwssWNo/Rs4wvblds7JKbxHBh7DvVMP5A3ehs3x/3/AQaaOCVn3JmrNBPNassXjK5vKcfvtVV1vkZ2tRx67vI+Y2Wv2qvlTh8NdVd5rau14zv8gTYm1ng9Bpn5DIXSuqK/nLgayCkj1Qv3RQm3McO8EhbWruC7PybygCOx5zJee00ocXEcJLqhMHI0hb4t1g/Weuy6VbIEmw+Yg6kHdAxPBfPGV6mcWtn1GUZHuQcwz9/EsYvs4eUOW8AWew53bf8vy6DOKjUQJ5x9wfNKZ1T/ULMfq0OQyviWmcizF7qdUYO+AzJ22M14XZe+rrtbC3a1rRHN/BOevzOdu/EPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E0hKo2Fy; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E0hKo2Fy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6TbK1LNVz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 04:39:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/3wyvCgF7xvp0uGxR/dqJ+LvnFcAl8T7SfLqaAeJ9Rc=; b=E0hKo2Fyr9kBeq4dGcwbVc5YSE
	6briuCcRfeFiHCB07U89czZciGFAhsWpSB1M4TKmpxHfdWuk8n8L+nfoafbdM6OMCNY/SHwozuKSy
	h/m2jy1RCJ8aYzFoWZa7i6nheTrzusNZflefORJuyWhQ+ywTHMAXbM0iJSLwMEnFiAhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xI8NR-00BMvD-PW; Sat, 17 Oct 2026 19:39:25 +0200
Date: Sat, 17 Oct 2026 19:39:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Message-ID: <84dec379-cfcf-4b95-95a7-e86b312c52ac@lunn.ch>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com>
 <725fe351-bdd0-4b53-b551-0f638d02f98a@lunn.ch>
 <32239c97-e1dc-416d-8570-f681f91df0c8@nabladev.com>
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
In-Reply-To: <32239c97-e1dc-416d-8570-f681f91df0c8@nabladev.com>

> The clock would be way too fast, on MX95 that would be over 33 MHz.

O.K. I've run systems at ~ 12Mhz. The steps where quiet big, and it
was unreliable at the next possible speed. I guess you start needing
careful design, balanced lines, termination etc for really high speed.

	Andrew


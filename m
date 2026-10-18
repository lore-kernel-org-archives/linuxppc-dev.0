Return-Path: <linuxppc-dev+bounces-29658-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20377CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 15:51:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j737Y42Pcz2xg3;
	Mon, 19 Oct 2026 02:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792338681;
	cv=none; b=P9WGPG92HdP7ntNXHxIwpfW2EgrlgrDfQTEWxccd7/KATFzpN2NOBT9fCAedf066mR9dDwOohOfJDDDfgIL3tep7b9c7Vdi2ppjA7EIQT3udQtErzhhbgKObNkkmwI1wS2WQRzK0M7uOV4JUB3qJ6h5gv1apG0I+iDfFwT4oyqm/wjzmt3C7QhX7RjQ9I2wkNyCWwPwHdQ03l+Vc2snN5xzd4usLBiGNOtEt5Jk7vmTz9VZki30W5yIsbO7J02xwQ5oeYAuR6yXhtaND16GikvCPp9qhYClxxuYmvyEHU25ZRYgoaoLJUY9rz7iMDZ1Xg0Nt26pa2+pu/2mu3t/NUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792338681; c=relaxed/relaxed;
	bh=/GXMNXvu9Ucx8ydkf56R+nlJN3aAcHuHVa89lye6maQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBUK28NzvkIP2+DycOk2YVkZOM55GWjL/yHtX2KTJjZRnyxnfEPDB/EeVtQOJ3A11QbDqBq7mxtwp7uO3iOMDr3RSad3N40KSpkCNksKpeb0uDtA5GcNizKifQMqMwkIyDnt53LbFY0A0SpKK7gN5AAfy5OHLj/x+yQTYxOVO8G9eameH9xOMUTYHFHbTOicTg1OyHaM4jJkuAJggkeBGTs9UOkawIJBCFA9vb7t9bcI1W3DQwqjW/CPZzMAY0Wwe6mpT0XD5q0Lhib/ek4C0DvGGkOZNJHb55UEPSmVLSfzX1+KMGjR5qZY8/Dz72GghTN/KYOWHJfIE9OmtN2zaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JmSJjNfQ; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JmSJjNfQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j737V3jwJz2xXB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:51:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/GXMNXvu9Ucx8ydkf56R+nlJN3aAcHuHVa89lye6maQ=; b=Jm
	SJjNfQqNodHlr4SfFLNQ8bLBjhHmMOrV6SK9ZZJLq771tU4uqAbV7KI3Xc6l1glVGiyfSFKTyh34q
	nHUrIl6xVQkOdvowc+LsYFMzXu2crkXlkoK4Z/J00+oP/Jz/FxGGcLS3njy6FDD653ozfzD7c2ZqY
	kJRyEanfmesSRdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xITA8-00BVLw-OY; Sun, 18 Oct 2026 17:51:04 +0200
Date: Sun, 18 Oct 2026 17:51:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Describe switch PHYs on the
 MDIO bus
Message-ID: <cb96159f-c510-49ab-bc1d-20149222781a@lunn.ch>
References: <20261018015311.4822-1-pepe.schlehofer@gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018015311.4822-1-pepe.schlehofer@gmail.com>

On Sun, Oct 18, 2026 at 03:53:11AM +0200, Josef Schlehofer wrote:
> The QCA8337's integrated PHYs are visible on the same MDIO bus as the
> KSZ9031, at addresses 0–4. Since they are not described in the device
> tree, qca8k accesses them through the switch's MDIO master.
> 
> Describe the PHYs and reference them from the switch ports so phylib
> accesses them directly through the MDIO bus. This fixes intermittent
> WAN link recovery failures on Turris 1.x.
> 
> Tested on Turris 1.1: 40 WAN link down/up cycles across 3 boots and
> 10 LAN link down/up cycles passed.
> 
> Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


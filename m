Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930E606A330
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=m4xEfVgN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jX2Vq5Srfz2xQK;
	Sun, 22 Nov 2026 06:35:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795289747;
	cv=none; b=M0uuU0MW14W4TpSyrrol4m17IXMNUKhqj/r10vOq6LYaARFsXzNDrElMetSi0/YlZrPvN0/MJ9NX+BryskWBuAtx5MF1ecUOaCQ+/TSuRmMHgCo3VQmn1Qw7XIce4AHvyZf0fJV3BLfEdnq9bDOxwhCjVGm0YgglYXSzP31OonFsiJtFrp1D84idLriZ/afBDw85a8ttsn/rwCyJGjmXmrkmoB+iH3dWs2NX4GMMtHLkIafr7CXyYE7OUtmbmKl3izDcAxKpdjQdy+jU3GBGOIxwSevmZ/ru0a2lDY2gwt2Qlo97gEZBxmPSHy5Ult8HpbMFLsq3/KkiVM5BD3Zb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795289747; c=relaxed/relaxed;
	bh=woUgHZr0uil9VFYYYYRHm8aIGID2QxRLbWy19xVONnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/J/nTpQvRD0kJ7cjstIRq5+bdo+MqMH5uwy405ylGTnHGo6k1zuVrcDAnPx8y3RzWd9/3gJqjIWvoS9xZ/Ixv5DCMzUm3k006P8yFQ2TnPGSDvmdsn/r85yRiS/07sgz3Z0UzyEna6VRZgS04rHaa+9uCcj/BdYq8E/K6laB+SkuickbvZKhhM+20P/4wonsLcgMgXstDUSCwdF5YThpI5Dx8CvMnsElEIWVdLPupGJ96ILqSG6bgjjrJ1aMdYkqyvpre/Uzib+rQ1igNkujGu5TUicg9+RKkqlh235sQB/nyIuFoYPG6avI08KcJCaD7UHGtkygum5xH4PCZXPlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=m4xEfVgN; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=m4xEfVgN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jX2Vp121bz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 06:35:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=woUgHZr0uil9VFYYYYRHm8aIGID2QxRLbWy19xVONnI=; b=m4xEfVgNc9OZJR6z5iG+QnFB4H
	z2jVd4W5Tlhdl6kT5Soywj+i6duxMQH2z0hLPqfBsD/fomCJbEGIuKcacP7zSl/MJwOCQnYEkh2xU
	TX5EscvEBCTYuyM1rflJd/8BqT2tQ0nyBIo5EzCs+U4r3XoLtXk4sTezTgPk0xBQoE+w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xUqs4-000UAd-OU; Sat, 21 Nov 2026 20:35:36 +0100
Date: Sat, 21 Nov 2026 20:35:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ethernet: fs_enet: add missing
 MODULE_DESCRIPTION()s
Message-ID: <3cd99f54-d5ec-44ae-878f-e8b1cf841703@lunn.ch>
References: <20261121192343.932171-1-rdunlap@infradead.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121192343.932171-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 11:23:43AM -0800, Randy Dunlap wrote:
> Add 2 missing MODULE_DESCRIPTION()s that are now required.
> 
> WARNING: modpost: drivers/net/ethernet/freescale/fs_enet/mii-fec.ko:
>   missing MODULE_DESCRIPTION()
> WARNING: modpost: drivers/net/ethernet/freescale/fs_enet/mii-bitbang.ko:
>   missing MODULE_DESCRIPTION()
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Hi Randy

Please could you target net-next, not net:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The changes themselves look O.K, so when you repost, please add
my Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr


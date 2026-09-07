Return-Path: <linuxppc-dev+bounces-26694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3097AC79FA0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:27:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdwXc19CNz2xJJ;
	Tue, 08 Sep 2026 04:27:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788805648;
	cv=none; b=UBiPh4UE500M+bf05rRZj5pGtm/LlE3oKDZSjtn2YNhyqGVX5NdCzUx0eFYdGB9Bvi0RtsFRDNNluhSdls9oLnl1s9MxdUFOE8NBIo/CKTCvjlRROrExV93KHWdU69eARglrAAlt+juJHNzeNcOrlw2oDmiH6GwDIuJzzDI5xrSCDDDMggM+4RAQaGEQMS4JMOlBTGaaZxc6zxs5sw1PLZlMJHvjNNyPpNWamJvqjRFdrQVzh1l7vTlgnVakONIgZaUwTFwKR6vx9oo4dpMNPBF86BwKkPdnO13jz8JhBcPdZM7cZK1ZKsY6Kdm8iG01wlBgnUVcpdUp6g54pYcIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788805648; c=relaxed/relaxed;
	bh=5DGA5yGgA6WfP2iOigvVrpj/b8QvWE0uJAMX/rb27bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMIKBGckKlYjTYXP7DlwVl1nCCyyUGiqwM10d054KaIZkd340c4JkQG3HEykIHAeQRyWer3jyn7c8xcwYAUkA9W4AhTHh8icdD6QBXy+oRjwRgJpzFJl+Cit218gdj45gE5AlK0WooNcoWbxuNSsZoU+rUw4ueqQ75IpQPPx7dxgzuLB6aYKwfsoux9I2ynOOvrElHvY9CanLL97vO2oOL7/g3GvxR257ACG85JRNPuyJC+y0p2CPdsz3eozkPgV6Ioxuv5KUypgw6qCYqAbm/UClLRULNarcW/z51eSf3VlmoVkfns6a7+fOg5zGhqY7sC3ftXhitVA7IbrddSHfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WWLGjDwb; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WWLGjDwb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
X-Greylist: delayed 1307 seconds by postgrey-1.37 at boromir; Tue, 08 Sep 2026 04:27:25 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdwXY2R4mz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 04:27:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5DGA5yGgA6WfP2iOigvVrpj/b8QvWE0uJAMX/rb27bg=; b=WWLGjDwbVkls5zSmMFgX9TOmdZ
	Dzot4tUT+wMtcsWxNstt3dBm0YdnGl79RGTSdqvy9vUr0o3LhvHize+bmp6yR8+TrWfGSo+rg0aoN
	lySE9Wbm8qOkeu927q2KCdkeMFTSPnDrGXKrnMJnu4yXtRn7D5kWD4D3GMtUwzYzk8UE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3diO-003aXf-M0; Mon, 07 Sep 2026 20:05:08 +0200
Date: Mon, 7 Sep 2026 20:05:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] powerpc: fix typos and repeated words in comments
Message-ID: <b1f18b1e-dd7c-4e12-9a87-c7ee5e69697c@lunn.ch>
References: <20260907065153.33578-1-hemanth.selam@gmail.com>
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
In-Reply-To: <20260907065153.33578-1-hemanth.selam@gmail.com>

>  drivers/net/ethernet/ibm/ibmvnic.h                     |  4 ++--

Please split this one out and subnet it to netdev.

    Andrew

---
pw-bot: cr


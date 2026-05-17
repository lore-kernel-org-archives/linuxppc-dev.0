Return-Path: <linuxppc-dev+bounces-21022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A8CCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 20:57:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJYCl2HXbz2xfB;
	Mon, 18 May 2026 06:57:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779051443;
	cv=none; b=a6KBKs1Mtz1ncPvoVabaJ0SPVAGhDkn9rIbbDou5Qj9fKlk8UbY3qrkcGMxprj2dHM7LkeiT5LHhMtKR2y3QgG/sA2FBTH8hXp6u7LFMbBcmsTKLz63nVj/VksCKkI7+2QvALBHh7YhPtwK6t7Z8/3cQz7SGAEC1eVWf+SUSkQOi/A1ms9FqYoXAHzBYF64/3222SfWqaW1aJnk+eNW5s/eZeoa7z4lV2jSnlZSNEKh8nlqIOkVPicLqaoZ85XLNhA8LN5xd7Z3RJ70CG2wUbDG4QKouOxcy6wAx7xfanAE/OIqVhru58m1KSEofhyFJhO/99rWfoSUGPIBtSKO9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779051443; c=relaxed/relaxed;
	bh=nzqR2uTHRTBIkKyLc4Worvb9PoR6kTcoTyE6cR+jOQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAm/7NoBtubluO70TsxBb0jt6RPbSR11r7SA/WKZay1HVnLrG1CSk77csJfcXf8Y21BHiFQWlZtSBFzuL+c2MaAQ/2u3+E785suaZ8eyrFOIVG6z9jiCOmP4qwfesHwGBQPnoWrZf230wFLyWHZ+1Ud1aG2OkdvdBkcVMup1g0qHN/NmKgJbwcdeZh+xF41Ng2ByZ1AA75gWOfR2MQzv9GdB9b7EwrZ+FmaNsuH5I1ptX6klI5oIr/Vr5X7D21T9vLPzyqpLCLz3HqZqduNEYc/AHjrFdtLB/wI9DzWVe2PMEmmMGytxWL2qTCD+FufIE/VjB0CzuVD2D++ootahsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HuouPx8r; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HuouPx8r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
X-Greylist: delayed 1972 seconds by postgrey-1.37 at boromir; Mon, 18 May 2026 06:57:20 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJYCh5vfbz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 06:57:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nzqR2uTHRTBIkKyLc4Worvb9PoR6kTcoTyE6cR+jOQY=; b=HuouPx8rH+oh2FEfcOZm1bTuL8
	dvjwJSg7e4iBzIh+OVDeiVwkYr2bnRpXOXU9oiOt1d8dDaEaMwKENT/I2GaIAD+cU8Dw7ST5f1qia
	jzWangF81U5lKUlZWQ4UC5LNuQ8fow4VQTpj6H+UO4m04NS5VrxbmXhThILPYKgcgVhM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOi20-003Mhh-MG; Sun, 17 May 2026 22:24:12 +0200
Date: Sun, 17 May 2026 22:24:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <5ac9f5ca-4706-4617-a5fd-d3e6dd3b254a@lunn.ch>
References: <20260517192856.3925-1-rosenp@gmail.com>
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
In-Reply-To: <20260517192856.3925-1-rosenp@gmail.com>

On Sun, May 17, 2026 at 12:28:56PM -0700, Rosen Penev wrote:
> Collect received skbs on a local list during RX polling and pass the
> completed batch to netif_receive_skb_list(). This lets the networking
> stack process packets from a poll cycle in bulk instead of handing each
> skb up individually.

So my first through was, why is the core not doing this? The core NAPI
poll code can initialise the list. netif_receive_skb() withing the
driver poll would see there is a list and append to it. And when the
poll finished the NAPI core would pass the list up the stack? Maybe
this already exists and this driver is just using the wrong API?

	Andrew


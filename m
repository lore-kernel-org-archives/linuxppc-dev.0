Return-Path: <linuxppc-dev+bounces-21023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BE0CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 21:01:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJYJp5JQ2z2xfB;
	Mon, 18 May 2026 07:01:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779051706;
	cv=none; b=GKc5fRK4z18mkd8YFqniHa0WMLW2nR1ExwxLRViV0JM+/fv/9k47MwWhuUuIUFpfPiajT6PpoOxqGu3NA5mPYiEUn8FIF1d5+9BtR4TDjTInXpJaGC6/gNnCTg+q4IaX0zOY+szqu7bkCPKbMuAN7tfYqBNdr09z6o1gJXY7MHrkLNggWtsqKVr03JyNMAQvvpGytUkfPPP4IjPmw2rdAEfJT6Fj/Elk9cRi0i8raeCo5tlu99o4hBkQW9qLTnUvoOw4vFvwDm1nh24PBfLftJnfwTf9/Zelwa0fJNI55a3M/SC95yqHqEmT8IfO1TsRALmFHXym6UzqD9iRkEKSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779051706; c=relaxed/relaxed;
	bh=kD9WaT7LsOXwx3sJohzw9Q5hbHB01HbTUMrgACPB4m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRwDP6gkbntLJaE6MUmwpJdDgRtsB6m6agqb0cQBnd+FjztuUUgLsRQkIjlJdvC8uavYVCQDuUg+ukWA3ovn//xhKZ1+G3Wz7/EOF+Z0FU0PNm1WenpmPEXP5KGfxJkpF6DxIOrbm//feI+dByS/mU9mUDidgvr8pqK10wooKTmsDY6ny9naIl//1AmSNfCQrI5SN9k8XUG+3Ny9x2cBzcy9hzMa5+oxoYxMguYhHZ6ebU2DX8M3bTXeS3wY74XY4OlS7RGjASMvpruP1iZmmc/JmkSS+4hEGdzh0eASj+fs4MF8jgJ165/RVlwtxhqHlQbVYAFBmvkq/HB1ZWBaYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=g7tWDi06; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=g7tWDi06;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJYJn6Ph6z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 07:01:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kD9WaT7LsOXwx3sJohzw9Q5hbHB01HbTUMrgACPB4m4=; b=g7
	tWDi06DL7X6WwF5Ic3FM2gcis0NemQ0qyT2X5KFcMTBnCPfv91VDS+oKFnCIJLdE2DLwdy/OYZ/t8
	NwXoaZ5fgllxn1fCSjd4xGzQto400LwqjSvMIaZiQxtstxeAbQclCj6+pLw/+vo6YLviooji61FZu
	66RdjU68DHrwC+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOicD-003Mvv-Hj; Sun, 17 May 2026 23:01:37 +0200
Date: Sun, 17 May 2026 23:01:37 +0200
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
Message-ID: <ad7c3caf-7947-49c0-ad43-22085f9bb9ef@lunn.ch>
References: <20260517192856.3925-1-rosenp@gmail.com>
 <5ac9f5ca-4706-4617-a5fd-d3e6dd3b254a@lunn.ch>
 <CAKxU2N_SygFAKQuhwnZG7SP7jiRdkmwS_R+VwHap33UUfbQmAg@mail.gmail.com>
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
In-Reply-To: <CAKxU2N_SygFAKQuhwnZG7SP7jiRdkmwS_R+VwHap33UUfbQmAg@mail.gmail.com>

On Sun, May 17, 2026 at 01:44:40PM -0700, Rosen Penev wrote:
> On Sun, May 17, 2026 at 1:24 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Sun, May 17, 2026 at 12:28:56PM -0700, Rosen Penev wrote:
> > > Collect received skbs on a local list during RX polling and pass the
> > > completed batch to netif_receive_skb_list(). This lets the networking
> > > stack process packets from a poll cycle in bulk instead of handing each
> > > skb up individually.
> >
> > So my first through was, why is the core not doing this? The core NAPI
> > poll code can initialise the list. netif_receive_skb() withing the
> > driver poll would see there is a list and append to it. And when the
> > poll finished the NAPI core would pass the list up the stack? Maybe
> > this already exists and this driver is just using the wrong API?
> I do not know. I know several drivers are already using
> netif_receive_skb_list, some even which support hardware checksumming.
> See 0a25d92c6f4facaf2852f1aac4cebfe01dd57a91
> 
> The core seems to use netif_receive_skb_list_internal. I do not know
> the details.
> 
> Anyway, the performance difference is real.

I'm not disagreeing with that. But can a similar performance
difference be made for all drivers by doing this is the core?

That is the interesting question.

     Andrew


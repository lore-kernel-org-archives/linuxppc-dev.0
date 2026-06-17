Return-Path: <linuxppc-dev+bounces-22743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D879CD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 14:19:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggQvq6XfDz2xLq;
	Thu, 18 Jun 2026 00:19:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:4000:2:33f::5353"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781696532;
	cv=none; b=KfNZ3LLgGI7T/hyD4Z/vNrBxrWS9su4en4YFeM15k8n203GaCUpiTEq98B9/wboW9aaY3LwW1Rl7W6buWKuxTGw9+qPuKuGC8siYDaeDQd8SG3gPtZMKso0CMQXnxY8GtWALnfFv28+Ht4nEXt/yPCXi2ROPnRqW+qZqqzp+Vp5tL57h5+8llE/yLSjZy9ixyDahG09EYaQRhZ62ednIOvVP3rsasLGt1gR+mLB9Hom+fiMKU62gv4oPgqFgi+8B7UVRtn/37pPAuKjvite/KiinicyakGD3KQdih2FfMyHg/3ypt9siyrxkPDJfpMjYIQo0ISgNNlRfiUESWWvyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781696532; c=relaxed/relaxed;
	bh=jWQu9ui+XFS991Q8X1/dP27C4edJ837v8SKF/AgPIz8=;
	h=Content-Type:Message-Id:From:To:Cc:Subject:Date:In-Reply-To:
	 References:MIME-Version; b=Rny+58ZzC39KRAFzAR3y7n9DjrxzjrwopQyZIy0b+4bCRYTYwav8WSgd9FNCylWYuaSkbpBwWMrixIuCOL1eT/3Tbux/AYHTXe8kpji7sb6+UdEpulOZEP3x++6+GXAAkjzhJIeGnxxxE130C9k6J5L613aO/eFAZR2kH1CMaz5G7DRr/GD0OrervPhUmahQE/S2GH7z8VTxkutVVuQZACUtm9lbvP0i9RcYnYM3ALbFwSnQL84PKLc88BZizlaf7iG8KqEXMsUUy1LkE8D5PSejnrplBk6SDeaFRkvH5WaF4afYED8hoiSY0Ghtoj3qi3oc0LXMr4YQFLFkaIOTjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=strotmann.de; spf=pass (client-ip=2a03:4000:2:33f::5353; helo=strotmann.de; envelope-from=carsten@strotmann.de; receiver=lists.ozlabs.org) smtp.mailfrom=strotmann.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=strotmann.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=strotmann.de (client-ip=2a03:4000:2:33f::5353; helo=strotmann.de; envelope-from=carsten@strotmann.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 618 seconds by postgrey-1.37 at boromir; Wed, 17 Jun 2026 21:42:10 AEST
Received: from strotmann.de (smtp3.strotmann.de [IPv6:2a03:4000:2:33f::5353])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggMQp2N1wz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 21:42:09 +1000 (AEST)
Received: from smtp2.strotmann.de (unknown [IPv6:fd01::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp3.strotmann.de (Postfix) with ESMTPS id CB0837FD72;
	Wed, 17 Jun 2026 13:31:43 +0200 (CEST)
Received: from noip.localdomain (unknown [IPv6:fd00::1000])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp2.strotmann.de (Postfix) with ESMTPSA id 4ggLrR65XHzJZmg;
	Wed, 17 Jun 2026 13:15:51 +0200 (CEST)
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1781694488854.956546368.818588236@strotmann.de>
From: Carsten Strotmann <carsten@strotmann.de>
To: Jakub Kicinski <kuba@kernel.org>, Carsten Strotmann <cas@strotmann.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 geert@linux-m68k.org, chleroy@kernel.org, npiggin@gmail.com,
 mpe@ellerman.id.au, maddy@linux.ibm.com, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/2] appletalk: move the protocol out of tree
Date: Wed, 17 Jun 2026 11:15:50 +0000
In-Reply-To: <20260616084901.3319d82e@kernel.org>
References: <20260616084901.3319d82e@kernel.org>
Content-Transfer-Encoding: 7bit
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

Hi Jakub,

On Tuesday 16 June 2026 05:49:01 PM (+02:00), Jakub Kicinski wrote:

 > > the solution, as Adrian pointed out, is to leave these features in
 > > the Linux kernel but have them disabled by default.
 > 
 > I think y'all need to internalize that "just leave it in" means work.
 > _Someone_ has to handle the reports and patches. And since nobody is
 > doing that the code is going to GitHub, where it can continue to "just
 > be left" or whatever, without racking up CVEs for the Linux kernel
 > and leading to maintainer burn out :/
 > 

That's a good point. The large influx of reports is a problem, 
and burn out of maintainers is a too high cost.

 > > Maybe put a warning message in the kernel config tools that people
 > > should only enable these if they know what they are doing.
 > > 
 > > These "retro"-features should not pose any security risk of they are
 > > not compiled into a kernel.
 > 
 > Nobody is stopping you from using this code! It's perfectly suitable 
 > to be an out of tree module. Maybe it'd be harder if someone wanted to
 > remove a CPU architecture you want to use, but protocols are perfectly
 > fine as loadable modules. You can continue to use the code from:
 >  https://github.com/linux-netdev/mod-orphan
 > 
 > Presumably you could get Debian to package that and you wouldn't even
 > know the sources no longer live in the kernel tree.
 > 

It seems the current situation is the price of success (of Linux, which is 
good).

I guess the way to go would be to move these old drivers to userspace in 
order to 
reduce dependencies on the Linux Kernel. But that is not a task for the 
Linux-Maintainers, but for the Retro-Community.

Thanks for your work and the background information

Carsten

-- 
https://strotmann.de


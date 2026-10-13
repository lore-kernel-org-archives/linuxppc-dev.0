Return-Path: <linuxppc-dev+bounces-29366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBBCCA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:04:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3vgR3TKMz30VV;
	Wed, 14 Oct 2026 00:04:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791896675;
	cv=none; b=bICa5tdrcMzGWWSWXmmImsA0gYibPZTwKhGqvnxo7At7Yul0KuOM4g4QxZM0EhBKSfyzD3LyuhC58wR18VO5ZDyGEXnRByUE0gfZfQgzYpv5NoY2koeuHX/ecZjzDP480eSLioPo3RPttigQe3wsIudOGG9ffTHBbycls5v5eEIkJym4AkAib85wjOGm4DmeUND7DEAThca6nZBi/ZubU4Pk3ygsWYhk8aFQu+jPSFO8EYC3LRD1UB/adV6oli0ej0apv3+Tylv4BGujh4wFuTXpAmVJ2X8ITYJ/lVPAP+wc4eUbhWTpAfhJwXEdZe533w63GRhxWQrjTwscc2bdew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791896675; c=relaxed/relaxed;
	bh=hW+jPunfJ7Za+BdShY2Xz3GhIHdo+5N8veQ/6QlvyF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbpEnR3GarSDVUwoHgLPL2ElIIoZttrrlOzN9IyezX6wOXCMhqRtKLe6JRwiUgnSYQgy5U7mnzrM4UOAaQwHp9FaC710JgDbgAkgp8R5rV0tCmrZMsE+EVLcODZfSUDadfMCg218CZ6NbUPOtG6ddvMwm9lqzaNAat4wAevajoy7vQ4qRItguoeGn7+382jsqgYIHf4byI5SGMbCgJ/hfGqek1xeSzQl7CZZoUFyoITeJMwatBd/H+CNzZdAJ2q9Wt/RY20I+x8HItJ99XQ3TKdpIif+V0l1kW92M8zHqVwMeocXoqxPbL2DHGLWOH+o5bXty1CC38WorOSlhMcBTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CAlpIHMc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CAlpIHMc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3vgQ5D5zz2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 00:04:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5CAB743A97;
	Tue, 13 Oct 2026 13:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B311C1F00893;
	Tue, 13 Oct 2026 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791896671;
	bh=hW+jPunfJ7Za+BdShY2Xz3GhIHdo+5N8veQ/6QlvyF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CAlpIHMciK1QnMp9J66sGVr2jnbzUbco7OQ8bAp16pZpm8BK7Vv5md1P14960JZwY
	 mcxsrGasnOiiM+SvMOsFeP+UfWirPhZBv7bjXtgYXaGMpa8MWDJsjLe8/usW/4/83F
	 f7pBYbb95IP75Rew2Z4CD4pkkYMNt24Tte82OF54=
Date: Tue, 13 Oct 2026 15:04:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org, oleg@redhat.com
Subject: Re: [PATCH v3 8/8] hvc: add an M3000 firmware console backend
Message-ID: <2026101313-plank-outlet-d3da@gregkh>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-9-linmag7@gmail.com>
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
In-Reply-To: <20261012184826.986050-9-linmag7@gmail.com>

On Mon, Oct 12, 2026 at 08:48:09PM +0200, Magnus Lindholm wrote:
> Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
> the firmware model and console endpoints before registering it. Keep
> firmware buffers in locked kernel mappings and serialize their use in
> atomic console contexts through the existing SPARC p1275 interface.
> 
> Poll input while the TTY is open and synchronize close with timer
> rearming. Return zero on no progress so HVC retries buffered TTY output
> but drops stalled console chunks instead of spinning indefinitely.
> A firmware call that does not return remains unbounded.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  MAINTAINERS                 |   6 ++
>  drivers/tty/hvc/Kconfig     |  10 ++
>  drivers/tty/hvc/Makefile    |   1 +
>  drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 219 insertions(+)
>  create mode 100644 drivers/tty/hvc/hvc_m3000.c

I'm guessing this will go through the sparc tree, so:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h


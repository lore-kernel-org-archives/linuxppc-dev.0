Return-Path: <linuxppc-dev+bounces-4341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD3AE77188
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2024 01:59:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YDDHw3ZJDz30Nl;
	Thu, 19 Dec 2024 12:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734573564;
	cv=none; b=JCff5PtA/IH7ZByv2WswzDngmaJRo7YswtznqtEHefYER1rqapuZmqD7j+Kdwh7EaGYzW8/KQjNEzutQy/aNWfWqkCkSdAccyKY7rRKkvAO2sKEs5tMf86GcrRfPuTypg/3/TGixb2pT3tLEolE45t5mk+pHclRe5XK1kCIeY0M563jedg9oUyz9dXTW+y5bPTcA+7tcyzfrSeoMzA549htZN4Thmr6PVTM5ebd/28qqO+f0AAoryalxqee07HS4I3dGQ30js2dwB5y9KBsTM1EVXnDpp09eHHU3Mx+0y6OIplMcgJBCbdh1gT4aSfAPjXWG/pQbTP0rUaTCFf0rfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734573564; c=relaxed/relaxed;
	bh=uZuKyoys8hOyal2VCZEwlUdn9flAW1KfXaMim7ZfI7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUR6N4eWm2yA7Dyfxklk63AfhHgJfA5QaPlwnV/ob6pZThvuYo41Tjkx/i74iyU7ASX6SkmSfxRV5miAPhtDIbkY09rtl0XFGUVP+Vba/wFgg69zWD01Z8RPypEktJrVjXdeXwdIV7mv/2gGYHDBWbqFiK3oSG2hx98V0vxGDxGBoCtvaphYfVzSUdGKXrf1NDYkMQsuYyM1FBbNA/ptxnsP6CjEb7YdwjVkwsNaJHvlaQGApiltlYqxCUcYgeGgiiSAQPT/1rcVOw2ym0v0ytvVKlNuOehgnO8O8XIMLKdmvBJg+DjCUfKTQEMztvLY5jL8U22oof16t0UjsevMaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ngpPSi/h; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ngpPSi/h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YDDHv3yPSz2xBk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2024 12:59:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4EFCE5C5D17;
	Thu, 19 Dec 2024 01:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC054C4CECD;
	Thu, 19 Dec 2024 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573559;
	bh=JR6+SvnJS7toF5tgpQ4AdhWSNK2ATDlyzvS2ohd2Aw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngpPSi/hnQXRf0C3l1rqMZ6nIP7P7Lzms0aKn/EquABoVgxPw185DxumN0Q95qETL
	 rFW3fUpb9ZLwxMgnf9YGAc5VWJ4tneTzxYWrYuci+g0dt9begY+6Qw6L1LdcrivTTW
	 VNyO36GYyvwTmuOdxt3O8W1zfc84SGxJwMsHwttv5sDyKnyzUUkz2sGPz/U3dAO3iQ
	 z8b8/1HaQh2WJlcowC+Qrd8OTF8gf+NERO1o8EQt2X9k5XEUjEw2iwKg/3xp7H6lCy
	 FAejgepdnHjP6vNtrh87RStd5RytUnc+lZw5VsH4+2/CFAKLajI7wKQQ0sz1SNPCQf
	 zPrKXuBBLv1Ew==
Date: Wed, 18 Dec 2024 17:59:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@lists.ozlabs.org>, <arnd@arndb.de>, <jk@ozlabs.org>,
 <segher@kernel.crashing.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 24/25] net: spider_net: Remove powerpc Cell driver
Message-ID: <20241218175917.74a404c1@kernel.org>
In-Reply-To: <20241218105523.416573-24-mpe@ellerman.id.au>
References: <20241218105523.416573-1-mpe@ellerman.id.au>
	<20241218105523.416573-24-mpe@ellerman.id.au>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 21:55:12 +1100 Michael Ellerman wrote:
> This driver can no longer be built since support for IBM Cell Blades was
> removed, in particular PPC_IBM_CELL_BLADE.
> 
> Remove the driver and the documentation.
> Remove the MAINTAINERS entry, and add Ishizaki and Geoff to CREDITS.

Yay! Please let us know if you'd like us to take these, otherwise I'll
assume you'll take them via powerpc.


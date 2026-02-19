Return-Path: <linuxppc-dev+bounces-16953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04F9E9A054
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Feb 2026 19:41:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fH3fK27NCz2yFY;
	Fri, 20 Feb 2026 06:41:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771530089;
	cv=none; b=nokGvaLaaVY1NJn3PfdMo+ZxOtyJaouDPIoCm6c81umzTLMeuloJCJoFCHCjEZPbkq++soa8v70bWvX3Rwn/SGs/8zR8uKsxCqdHMSnNjcfNVL0+QzKEYUDIaoEKlPjw3SrUV9Tg0YaznjRU7OdiJZO5x+ZCg657MH0uxYgAcpsPfoNakdeGcw9Qm0iMQO0xP7+B8e4tN+VxgWvlL8hpeCQa5cjkvnkUq1ZrY/KaASCoaI1uPlM1tTMfuuzXJx8ZfqVlHH8Vv3hxEVK4qmFIIWyrGh6CB7ixJFjZbPow+k7/UkOYDvldXEB34tPQMJlWYj/GNIy7ka6SpYaS487BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771530089; c=relaxed/relaxed;
	bh=L3w7pmw/wKbb3HtA7ljGzrXlBgApnedzk1FmbGFZepk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvGtuaaOeEPdrZ4CP8yNsJOI8sGn72/UI5GuqyY+WkT+C85MvDpYq1ULanH28s6bWEvJ9esfQsAkPh2Hoq51NkF+YOrKxgcQNQNXzQ2tzHm2EII5aESIwIf2F7BUNFLq9S0IYewNwIvAv+Vcd/Wbg7/IGs15BgIUmZEWF6NPLePv740qwZV5zQIgqaxMx+euntjqXVb9O5EHN2AbRYihEG/N6ylff7strZqfdbDVMMeVxDwJvs0AT/CQJayhZmNJb3JiyVtf8QcACh8C+Is+xE5J8HGeRqXLx/GEPpHVr/c+wdgtD0gl6uS9MHsNsL/jzbJu+L5nZWo0RX2QNSyBAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mkl2KvYU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mkl2KvYU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fH3fJ37vjz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 06:41:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 27BBB60054;
	Thu, 19 Feb 2026 19:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2130C4CEF7;
	Thu, 19 Feb 2026 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771530083;
	bh=X/YpBpZHELPnaJx/3vhuFsswpFYW6glhYMozRGxU4LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mkl2KvYUp1F20IHclNSctcmg7lauq73IyKRQVwNswPbGoI6InqBDg3hg3+ZZjrC5+
	 5xmyGuTkpEHJV0pwMOSQD/AGbI7y/Gfu2tlqomWKRqJxzs0k7iyB5FgUZmbvEJN1Jr
	 143Utb+tQnNMyiVaUvN5yMocMVNw6pxSL0gpl782Qnl4kmKLvcRuzlSKeI/6HvCO0O
	 cEdBu7hbLoRa5DdaMkj5qAYzVx+cSc6FNnedSBfqttW3KBbws4+0p75nGaviS2XlKy
	 /DcvgKUxO7GDfsM+RyLVLnUcTPCg3V0w1icecFDyLIzQuKI5jIz6oCCYC+oui9lbvo
	 ctR3U1d0NfrUQ==
Date: Thu, 19 Feb 2026 11:41:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>, Antoine Tenart
 <atenart@kernel.org>, Christian Brauner <brauner@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>, Ingo Molnar <mingo@kernel.org>, James
 Clark <james.clark@linaro.org>, Jerin Jacob <jerinj@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Lukasz Luba <lukasz.luba@arm.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>, Xu Yilun
 <yilun.xu@intel.com>, Yajun Deng <yajun.deng@linux.dev>, Yury Norov
 <yury.norov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, hariprasad
 <hkelam@marvell.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] cleanup bitmaps printing in sysfs
Message-ID: <20260219114120.0f4408f7@kernel.org>
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Feb 2026 13:13:52 -0500 Yury Norov wrote:
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 28 +++----------
>  drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  6 +--
>  drivers/s390/net/qeth_core_main.c             |  6 +--
>  net/core/net-sysfs.c                          |  2 +-

Please split these changes out and submit them to the correct subsystem
after the merge window. Then push patch 12 during the next merge window.


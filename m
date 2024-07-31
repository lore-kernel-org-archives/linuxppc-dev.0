Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B8EC3DA7F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2024 08:46:41 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=amiMPkOX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WYm0w0gMwz3cHS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2024 18:46:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=amiMPkOX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WYm0621Qlz30TZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2024 18:45:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 878B8621D9;
	Wed, 31 Jul 2024 08:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B59C4AF10;
	Wed, 31 Jul 2024 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722415556;
	bh=2XLxAIc6IiUvdSzD2ExFN0aiYA4Po6apdRHywpfIuJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amiMPkOXaIEqDy8nSDola/nQWxqE60JDoCHCdcxkNowuGUEkYpe0F2flZzG0dG1ce
	 mD+E8nbaJxDzqx3ItGMLfsxAU4EvEWIFBZEgq/O3snn7fd4RHs/wfVZOdj9DRfinZ6
	 HoSWe+Tv/Z8LaaG9F7ZOtG8WhwJ0co+I8ASTG22nm+LzcyZrY6/uydTDOVc58LNN7d
	 rJwPOxvAeQwia32HtjQ0RPMxMEMUajWzONBo86Uhc0DNrwMrxSB2jY82wIe/lMrkWw
	 spFnmVZLjidrfQzkbkfsCuppSgO2L83TxQU1jB06psKADEB/P5ti4AniVd32gwtgn/
	 97fB0PlUDQREQ==
Date: Wed, 31 Jul 2024 09:45:51 +0100
From: Simon Horman <horms@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH net v1] net: wan: fsl_qmc_hdlc: Convert carrier_lock
 spinlock to a mutex
Message-ID: <20240731084551.GM1967603@kernel.org>
References: <20240730063104.179553-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730063104.179553-1-herve.codina@bootlin.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 30, 2024 at 08:31:04AM +0200, Herve Codina wrote:
> The carrier_lock spinlock protects the carrier detection. While it is
> hold, framer_get_status() is called witch in turn takes a mutex.
> This is not correct and can lead to a deadlock.
> 
> A run with PROVE_LOCKING enabled detected the issue:
>   [ BUG: Invalid wait context ]
>   ...
>   c204ddbc (&framer->mutex){+.+.}-{3:3}, at: framer_get_status+0x40/0x78
>   other info that might help us debug this:
>   context-{4:4}
>   2 locks held by ifconfig/146:
>   #0: c0926a38 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x12c/0x664
>   #1: c2006a40 (&qmc_hdlc->carrier_lock){....}-{2:2}, at: qmc_hdlc_framer_set_carrier+0x30/0x98
> 
> Avoid the spinlock usage and convert carrier_lock to a mutex.
> 
> Fixes: 54762918ca85 ("net: wan: fsl_qmc_hdlc: Add framer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


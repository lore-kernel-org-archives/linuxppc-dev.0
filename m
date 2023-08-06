Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3781EC001B0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Aug 2023 15:38:54 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jzXQcRhj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RJkBh4kD0z3cS0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Aug 2023 01:38:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jzXQcRhj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RJk9W70Yjz3c5T
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2023 01:37:51 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0E417611AF;
	Sun,  6 Aug 2023 15:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2507FC433C7;
	Sun,  6 Aug 2023 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691336269;
	bh=QBn8NPkWp6aHEu6yqGnfnqh3BbKlk/in2dLR6TFx3Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzXQcRhjhBj2ZK+T6UAU4DoxsC3QkltgzNCXm+GSy9pqhdQ/+PWTCOUGb+yZqMMwp
	 tBqu1TeODn5BWFhqfMxTyQaiP43OFpKKrTxeZ6QdIL5ZKWycbC/d5WvCxtZ4qyKpBe
	 izThVgiRrMgq6TH60LLS4bqc+eAtI0E2tlp6eOmrWIHVXlea2qJhPPhgvJlN83zv4u
	 O+dNfIEcfoRgDoDT2d8oiKxMOSmsLmViSzF6mMHN/k0Pf1ahfX5lKcQlb5vJUUy33E
	 FxlpINzYSxakrSfqXng59+OMSQ+IxvvJRHeU1+gytDUw+uStFPvwnZ71CdkL1bMnR8
	 XuSFNlfpwhlKA==
Date: Sun, 6 Aug 2023 17:37:44 +0200
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH net-next v2 00/10] net: fs_enet: Driver cleanup
Message-ID: <ZM++SM4xJ1K6bBxc@vergenet.net>
References: <cover.1691155346.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691155346.git.christophe.leroy@csgroup.eu>
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
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 04, 2023 at 03:30:10PM +0200, Christophe Leroy wrote:
> Over the years, platform and driver initialisation have evolved into
> more generic ways, and driver or platform specific stuff has gone
> away, leaving stale objects behind.
> 
> This series aims at cleaning all that up for fs_enet ethernet driver.
> 
> Changes in v2:
> - Remove a trailing whitespace in the old struct moved in patch 7.
> - Include powerpc people and list that I forgot when sending v1
> (and Rob as expected by Patchwork for patch 6, not sure why)

Thanks, this looks good to me.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


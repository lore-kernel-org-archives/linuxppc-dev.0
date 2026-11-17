Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEjDeXZt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT6tF66jFz2xqL;
	Tue, 17 Nov 2026 12:42:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794879749;
	cv=none; b=PLl5cska2N/joaxhv2HVBQH/nVDKJI/oM7UxoUOqZ8VjNqQOtBxk/PoDbOt5zUomA8Uq6fHXbPsQRktaZqSrPstCNbRWVpz+v5WajMPfYZVb3cPMc6T3ZQcLNPWrzM7zAyfaD9DiP0AOMkbQKFd9s6qEPDomN69E9cIAhlllrz4lFYuLjuARs5wffhmCPhlhVIvgl/9/lZZE/WvWJjMOtJQ1qJLteSU1U3hD/WqmjDlf1xfJnKR7dhrtgPMJEwZzRtb6J0HqT4+BRn2wwr5/CSntz4GGezQGvRaRNo8ztn6qfMtLlv5kl12e1GGQcmC79V8iYsB7Yno9eObAFMCAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794879749; c=relaxed/relaxed;
	bh=2qcJKNUTkGRZCr2oq+EUfBGTGp5J3/etKeRpOPwjgBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffq/cyeaQYBEn2tC9wJNRXE7h0eOxSMg70fSFr3DoL8+WdMN7qqTxMk99UQZWZkEt/v6mr63R2yYKDOAkbkLGap3Pkg5Ae3B4KSje2eAPOQ9wAM8EW0kXLpfp2AGg3vhZjFIIGKylff+lT+U6OGYnUq7qnYo0mN+8OHw+1xWdfHaxGWt0L37UACvNx74YRVBQ2LDHIWFMAB9pkmlbdvSHHTKvnvrUJ/WNuplbQwoWZAR9lAYO4opTl6zO7NmY+vlk9onTvfAZbu+yR+e0hnubnkMXxV5AIKoBMnQWBsni2j3oWXdgeYllhK7uLSwvZ9HdCU3UshYARW3+uXoqlNomA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEjDeXZt; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEjDeXZt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT6tD6hnLz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 12:42:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4ACDD446DD;
	Tue, 17 Nov 2026 01:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101DF1F000C4;
	Tue, 17 Nov 2026 01:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794879747;
	bh=2qcJKNUTkGRZCr2oq+EUfBGTGp5J3/etKeRpOPwjgBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LEjDeXZt7eQYEuuM1ubpwQ0N6SSeipR+V1OQXZYkso4dpkBIw+mF7uHgLiiJo++9V
	 XHtRdnhWQVb9w0IhQdBI+yHwi0Lhg+LeUNVkKzjKWXkF/6F22xTZ4ApAfh93ntjaYX
	 gHU8SeDtEs1mbBN6vZGNFRvTWBId2IhHZ6z7+DW55RbxITVrb3ioznp1EZU+Vl8zqT
	 0sMWJOCKeZA6rnXCl9q8dye5lXBCh/I2NxmMAYCD6OQ3+mS1yULS0cS7skWoa4Pod0
	 1Nh8qWRHq3sHFNWgy/7FP20PjHzIRgd+ZOgS0awZBayClRilH0kp1u0mTEmkZqUbnI
	 6P7blZrtQxjzA==
Date: Mon, 16 Nov 2026 17:42:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v8 00/15] ibmveth: Add multi-queue RX support
Message-ID: <20261116174225.7d9e9611@kernel.org>
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon,  9 Nov 2026 15:55:41 -0800 Mingming Cao wrote:
>  arch/powerpc/include/asm/hvcall.h   |    6 +-
>  drivers/net/ethernet/ibm/ibmveth.c  | 5007 ++++++++++++++++++++++-----
>  drivers/net/ethernet/ibm/ibmveth.h  |  240 +-
>  tools/perf/python/powerpc-hcalls.py |    4 +
>  4 files changed, 4318 insertions(+), 939 deletions(-)

This is way too large, I spent half an hour reviewing and only gotten
to patch 8. There's no reason for the series to be this big. The 15
patch limit doesn't mean you should try to cram as much as you can into
15 patches. Please split this up into (3?) smaller series.
-- 
pw-bot: cr


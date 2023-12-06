Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A963C4167B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Dec 2023 01:51:09 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fewuHwMf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlL3H5LCHz3dLS
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Dec 2023 12:51:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fewuHwMf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlKz75XYsz3cZ9
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2023 12:47:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AE333CE167C;
	Wed,  6 Dec 2023 01:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21887C433C7;
	Wed,  6 Dec 2023 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701827248;
	bh=m3OXxxaNOcCbca66NX0B9W3SqJV3ZbMjQp5zBskM9iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fewuHwMfF7zXS1KUN/yTlis/ON6ZzuoLEyVFUGPZ9e0JM1b5qkBEecx3SbLP+A37V
	 a/zKC02fLbBZZPpc0mgpq429kLVSQFKqQEsqzFL93X3zu5IVKo/cKFbVkKTZJd5Q1S
	 I2L71pZtRcUtVBwYOwdNraE0eqvY23jcqGWw4uVgmSE4wIEU4KSlFMWwupnyQK8GbX
	 qDztWGvvIwum5XxJAv2Io7HNrLcPdOjpN2LdpuMlMWWURAu3XVrGheH3uoeun4M6ab
	 Zotz94GIIYhaQu02K5yIPlbabSBak30TMDqUN3ctur3BFI+PwiYxSktdXmpiWbeWJJ
	 49ab9W3qz4atQ==
Date: Wed, 6 Dec 2023 02:47:14 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] i2c: cpm: Fix data type
Message-ID: <20231206014714.etrj4ecnt4tln5ev@zenone.zhora.eu>
References: <de07101166ac0e4649cf3b57fdf960748c9ecc75.1701800124.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de07101166ac0e4649cf3b57fdf960748c9ecc75.1701800124.git.christophe.leroy@csgroup.eu>
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
Cc: linux-i2c@vger.kernel.org, kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

On Tue, Dec 05, 2023 at 07:16:53PM +0100, Christophe Leroy wrote:
> sparse reports an error on some data that gets converted from be32.
> 
> That's because that data is typed u32 instead of __be32.
> 
> Fix it.

the reason for this sparse error is that the data variables is
then parsed with a be32_to_cpup() and I think that's not
necessary.

I think the real fix here is to not use be32_to_cpup().

Andi

Return-Path: <linuxppc-dev+bounces-9599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8A6C7115C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Jun 2025 21:29:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bP9b64XPBz30Pn;
	Sat, 21 Jun 2025 07:29:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750454946;
	cv=none; b=o1G5/QbT7q69A6tpaAL3ZuCnos9UgUnLUddTinsQJyUburle3jIBwNM5PqpTwzafreGe0VdN+Ch976t6WBw32nsu1rpMHN3a+fe+dbgjXcXpJP3/pEZB6hUeQV3Ex2iG5GRUWokeWSvJBMBM4bitYwuDh8B97obFS1z+bvJ9VRm/C8tu9CYT/DYmSPieYC6/XIlgs39eF9v0+/2R4MnfKD3+OykfbOGofM0G76LAJZ64j0p3rct0/oAtPLiKY0OYzTEfHibWdVzHjf89A8xF7N/veVqzt0TK9F66ILxSWfqX5w8IT11eVtywS5k0hmkirQildK+rjX8w60HBqCuseA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750454946; c=relaxed/relaxed;
	bh=0aP16q+YYya9SKQ9hbbNnoIlxq9x1cgeNkJP1z19gSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM6B4LshI3T9RxxFqjTKLXxLamRoItfLv3hx4YQKnn45wupPQ29k4GW5ucBodHuEMP37ozgurT73dl7xvOCE2xs1nddXBdXYRSKfI3rXy0/nmfhVCyXYSGnEFjUltwi0eKYR9owjkzUS5P4qouJmISbngi+sQR8LDPtD4y58YkUlONU994m+KYCjljsMxt5lEVCKx8qUfFqLQW6fMMp2EBk7K9m7XmGINoZoWP/QL52oz1eq2+31X9FQsTRlzWvghwnSl9KqZS60cwtfrdDXXVf8tlea7JVK71Q8/6/7Kq2UUCljs5xXn04udOpwwF7T6fTMqtZf/W22aYKOx9XRUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FC6E1Xcs; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FC6E1Xcs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bP9b56GtJz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2025 07:29:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9998C6155F;
	Fri, 20 Jun 2025 21:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F16C4CEE3;
	Fri, 20 Jun 2025 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750454943;
	bh=ps9ILEhzF10vdX7dPy5yWB5StkYw8T+IpOw27+HOqYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FC6E1Xcsnro+YOpDn8hTu0nsIFn++h4KBl0QuHYkEldKj/k+d4y6w6M6qTq1srOEb
	 nphAh45+luPlOza9k/LIGiTbnucAbyiaYQKu35fCeF/4UeE6qHizoUNUQ651lcrwy2
	 9B8AsOSU/IbiYESK+VnWwIDmkYyfPuZfhcxVI5jvUSzpyHXAwU3LfPV8cdlkFSPdBF
	 xMjNdQkGjmPO1/cWgdHC1ud81t7SJsdgZ+qBWAEQ83ndAMnkuPMMUOkbXi61DBaRZC
	 OYic/USnxpBjVMFFaIQ2ObMgL4xYVKNxAVGs0qognj4+skHnKSZZYyuLE926HJgkeW
	 3AzWwoBcF1kOA==
Date: Fri, 20 Jun 2025 14:29:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld " <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 0/9] lib/crypto: move arch/$(ARCH)/lib/crypto/ to
 lib/crypto/$(ARCH)/
Message-ID: <20250620212901.GC5460@quark>
References: <20250619191908.134235-1-ebiggers@kernel.org>
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
In-Reply-To: <20250619191908.134235-1-ebiggers@kernel.org>

On Thu, Jun 19, 2025 at 12:18:59PM -0700, Eric Biggers wrote:
> This series applies on top of
> https://lore.kernel.org/r/20250616014019.415791-1-ebiggers@kernel.org/
> and is also available in git at:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git arch-to-lib-crypto-v2

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

But as always, additional reviews and acks would be appreciated.

- Eric


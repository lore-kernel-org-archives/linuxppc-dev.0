Return-Path: <linuxppc-dev+bounces-20484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9D5FF8855
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 17:15:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g94sg0K3qz2xSF;
	Wed, 06 May 2026 03:15:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778001350;
	cv=none; b=nCj7Cut7He/xbVI3Sk9LhLiyxORDxgNkvLk0OesBpw6+HyRYN4W9EH7qXMl6vZ034Tq4WwZ/mJQhljiEzsay8ROimbHHB2zziA8C/uVIbsYUvPZ2guFIR7DoA+5sF76CyW+M2xAkhdVU0UXhkxPIR9eIlh1FHGeUfhy4pk+SEOEWcDCrmlq4wl7sByGRTtEPP/51us82FPiphMXKDRwvkOfT1ZCpYhaTv38zJQ99JSLVcWfvbhHk+s7NmbF0N1BRNBRyuIEYmbuAddCK3KJ/wEYaoXf4n7mveXscLBeU1jFPjWga0AVYGGeORI7abMW+YusvyUpLzMs4wIrGEFitbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778001350; c=relaxed/relaxed;
	bh=YXlEWiUVz4WCNvp1+Z5WvUPbQUYHYY0Ab0ojH/g0UZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjMBF/7TW3FO/btDRhBKlo+2DxY3FqGhlg77q7yOw8+tYGWciMBE1WoF+MmKJh/iCO59paKIj2/MN8Fvis73TpIrrO2Snhcf3A20ShSMgWzGSlzmLXQk1GQEcL+DnS/3f2GHUq/rrz/1Baf7VyjE2ytQHB72KBSy4rR+NvBHn9wSVEi9jHzc9v+bYvLYAS5UMEImizUN/xXHi41e/210SqvByPF0sd0I2IkUPc53HUixZvQ2yFK52r0hg9igk4JRG/0JZJVf03UCXIHXI81xIUnlvqxZOgVhZSHcEQhozwGrYuvqWNNVViRxVDDgBTp7KKz8Ac/zq4bSyTMJEyOpxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nwr0MUIZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nwr0MUIZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g94sZ5DQwz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 03:15:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3574360181;
	Tue,  5 May 2026 17:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B93C2BCB4;
	Tue,  5 May 2026 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778001343;
	bh=p+kXkUUsL0EOWDxii9ahd29pn2Z5VfXQoGjhwSebnZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwr0MUIZdxTY9BNcjP8SAD+u+Pno35zf4VXFMTNrj/LAnQ6IZp+eHfEtnG1V33X2I
	 00Q83Ml5MKgC3i7mU60vdbaHQQRmN3YoxV53SU4TSBQXVB2C5/oNZ4mXyywIfkio8D
	 1Af2Sx5+nKb2e5sKMAWSaPySo1FDUxzZipXeaiiqL+SuJxW/tV6pvLKThBsMlYXnmG
	 9yOjHmPugvqjNBxZ+f/EdlJKOiMeqR9P6Kof7CQWQfZuudVGfbHI1qzg+hvp10VFnR
	 coQVjVtcau6mdHMYe6sgmiMRkid0wc7FdzThTLAqlIoul+ha4wZvNPhTjW842z0lYt
	 henTv9pPjUH/A==
Date: Tue, 5 May 2026 10:14:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] lib/crypto: powerpc/md5: Drop powerpc optimized MD5 code
Message-ID: <20260505171424.GA2291@sol>
References: <20260504041448.15820-1-ebiggers@kernel.org>
 <111ea924-fef5-441e-9849-83f938c913a7@kernel.org>
 <20260504180044.GC2291@sol>
 <ac6b9bcf-0106-49fd-82ff-20ccc5612fa1@kernel.org>
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
In-Reply-To: <ac6b9bcf-0106-49fd-82ff-20ccc5612fa1@kernel.org>

On Tue, May 05, 2026 at 06:34:00PM +0200, Christophe Leroy (CS GROUP) wrote:
> With userspace MD5:
> 
> root@miae:~# time ./busybox md5sum avion.au
> 6513851d6109d42477b20cd56bf57f28  avion.au
> real    0m 2.38s
> user    0m 1.99s
> sys     0m 0.38s

Again, that's an unoptimized md5sum implementation, specifically
busybox's which is designed for size rather than speed.  You'll just
need to replace it with a speed-optimized one, if that's what you need.

As I said, you can even reuse the same asm file, as it doesn't contain
any privileged instructions.  However, there might be even faster code
out there (a GitHub search might be worthwhile).  The code that's in the
kernel often isn't the fastest code that's available/possible.

> Now, we are talking about MD5 which is obsolete and being replaced in our
> systems by SHA256. So a commit message ressembling to the one in commit
> 23e5c306a207 ("lib/crypto: sparc: Drop optimized MD5 code") would be better
> as a justification for the removal.

Sure, I'll update the commit message to cover that too.

> By the way, what are your plans for SHA1 ? I think SHA1 should likely go
> away as well for the same reason.

Eventually the same thing will happen, but it will be some years in the
future.

- Eric


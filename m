Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3061606A333
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EupygsBD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJvkw1zCwz2xSZ;
	Wed, 04 Nov 2026 03:52:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793724760;
	cv=none; b=R//W/OWhk5MP9L1QxtvLT4PowAD7VT2HzVrKjgDKu4vAWhSXq8Q0i/YkOtAw4/TzC/TgT1lQrNCuXA/06aC2W1mWtOw6jZBE4E3jsNpdfcPjQ9WVYjfnFQRCC3Ck1fEQ8Zcx01pVXCI8fm+FnbZPEQf5IPTh6W4E/Yphyzx3/LBBErLdhJeT3rJoGvj0m5AbFOI/oztb+NC8JPW0bOI/8QIpzCNcUUs6GHBXkbve3oguiTUgXsqp0JTQ0JE47JTj/IvWTl7t/eXbZ1h85s7IEhyT9/vlY5XNFT1i/moKvgt3hXwnOGg4K5dJqeIrSEjKvQbrvM222EtzL8m0YXz4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793724760; c=relaxed/relaxed;
	bh=lNlcpPLo7FBrO/QJvjnMbL90+K6TUMGiPf3gYVpjyjI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eC5qhd806vgReukg7aoRY1P1kbqCbvuJpyr1p5dchsRhtWCI+Tzubx3jIQJQRsXEBlrdfnrOVw3AcQFak0WQ2wYeuDGwKjb5GZW832NQhMa8ap5F+ryiSalHJKS8hDjX5zPv1VdZAba93Z/JOPBsQeZ7gLmowkB0A6xJjClfN/dkNDQYtyAka3H0xMszzFeJfOFv7xlEd2XrAtwIMp+ryYIGwl95JRmZm1rckAUHFlckEJftARAjX969eUD/70A1zgC1Osij2NkpCaP3pjtU239YUn8w9DMXG9K9ZcS4LCLDu/KBcaMBXnFa7T83oe1pw+VjhUhTr/fz+Djf4JaUag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EupygsBD; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EupygsBD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJvkv3vr1z2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:52:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A598A43E4F;
	Tue,  3 Nov 2026 16:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878361F000C1;
	Tue,  3 Nov 2026 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724756;
	bh=lNlcpPLo7FBrO/QJvjnMbL90+K6TUMGiPf3gYVpjyjI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EupygsBD3uzXVUovJisqhgzt+LGoP/Rpk+flj07K63weXGyyPWRChJxAJhJeH2LG0
	 0siQzFJGtwXDHa5+9zIcY6Gh/vC4NOYw3n1OBwHBozIqlSHAbTZ+4XkgmKSd+zSqxG
	 UX96tkXQoHElBiI17QAIKIfNa3m1alT7qQB37WMva/U2q6xBAYfsSHIVT4et6+ymko
	 uAsx+pno2MOOCpopFvigrq3vkaoaPDoFzHwqxsrtOxZnrGKZJkW/zTcZxHK5RIDuAX
	 2GGoJwU63nzuloquRD2j0WgDIPAFLQaer1MiqPb3CDAAAuW7xKQx3bcEZOry9m6xdr
	 VpaaY8V92GWBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D37E391AFFF;
	Tue,  3 Nov 2026 16:52:36 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto library fixes for v7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261102174428.GA1935@sol>
References: <20261102174428.GA1935@sol>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261102174428.GA1935@sol>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus
X-PR-Tracked-Commit-Id: 01ad209f122b7c173477bd60c7997564f9c65961
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2e7a7bbc127534b73936a505237f08758552252
Message-Id: <179372475516.1755341.2580594496121383266.pr-tracker-bot@kernel.org>
Date: Tue, 03 Nov 2026 16:52:35 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

The pull request you sent on Mon, 2 Nov 2026 09:44:28 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2e7a7bbc127534b73936a505237f08758552252

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


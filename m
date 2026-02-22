Return-Path: <linuxppc-dev+bounces-17013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD289C636B6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Feb 2026 20:35:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fJwjl6dFvz30Sv;
	Mon, 23 Feb 2026 07:35:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771792555;
	cv=none; b=U3YlqE9fWvYxgPSfrhn2CNlDDnPmxwl3gK5SG0S67rkHozJ60vF/NiJ1mC6+OnlIyt/aaVny8ZKW236H9noAsH3E+JpTNOKESLc+ixBdANO+EzblbOPj+QpmyzBv2UF5mvF/tcfsPZxUG6R8dYJZA2VhfryUQsROtuQiA4JABNJD1GmOa4L7E42MD65DYYKN76rL6wstLmCCmKtAMv5b8YJF4fwMzHx8THm45qVJgfZYqNxJjwFOveVH9QS107H4Bu19lWiFWMIK/kTiSXFWfMerCtHcsCIaxdRL6lykbPfuvUVAq+x8uZyj8qQlMG6tus+xhaTXAnZKIrviFlPx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771792555; c=relaxed/relaxed;
	bh=3xzRRRmViNAGGzFCOyOSpxr3hNQs6rZqyYgEBTOdeLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WPSngqav9b5nSymQIvxF3MvPgAOroloGEpZRo6Y/Uw93OJqCyXv5Las/f/VdKsEnSlyLyzozfSsnNY/NP8nzgBip48JK3Bbdup68KL+cdqVBWujdXAp3tG3yzbzfl74W+Kr+KPRxkHwgyZE8U9LNrRVS6KoPmxyrMv3WaxPAxlduG6hKASG0a5MlXgkpd0/E2E14VDBp54btBWVR4GfzkAmiErHP35R4w1ROIFYScJEP/8g1waMnYYQwXQnbUUlqG73wmAmqWagT0ZpFqiJIVlVUaMos/DMAZk5aax/7RBVxVamPz3iz177QGumRmrMAfhqoFRL/gC39nFyEEHIBuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h5VJEA6w; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h5VJEA6w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fJwjk3rqTz2xnj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2026 07:35:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 178C2444C0;
	Sun, 22 Feb 2026 20:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7D1C116D0;
	Sun, 22 Feb 2026 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771792552;
	bh=nB3wfhscOxQHp0LEV1GBvtP30jxZODZvLWMqMVvIqSc=;
	h=Date:From:To:Cc:Subject:From;
	b=h5VJEA6w+T7vpIgRUfEycWyh6a0iGlFk2yJkPJQqTmVchoUkeyLsRJc+/Ia9LyXYr
	 zDkrk20h7S7Z3wW8hqwwGxqKFzFxp8FG0mUI4ta/e91XCa0r8gNSnWfT6tkPbnubdE
	 fBD45a5Fwjub3UfFnU/wI9+pp2+vq+1Zi7snQAl0z1ZG18U16aBlU9nx4/PM8mravY
	 64TofNgrwSdEjCP2lCOhcZPTluC3+Rx+SbqCSXSQCHEfFWhfU9/19VhNDaTM2tO3Xg
	 rqWBT94HCaBXD+s5Z8IgVaqh/xiQj/r/KzUEOMnfYeTYEwhg3GQtc0WbvLllcoOWOs
	 ym+z7sYC+yx8A==
Date: Sun, 22 Feb 2026 12:35:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [GIT PULL] Crypto library fix for v7.0-rc1
Message-ID: <20260222203543.GC37806@quark>
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

The following changes since commit 23b0f90ba871f096474e1c27c3d14f455189d2d9:

  Merge tag 'sysctl-7.00-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl (2026-02-18 10:45:36 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus

for you to fetch changes up to beeebffc807531f69445356180238500f56951cc:

  lib/crypto: powerpc/aes: Fix rndkey_from_vsx() on big endian CPUs (2026-02-18 13:38:14 -0800)

----------------------------------------------------------------

Fix a big endian specific issue in the PPC64-optimized AES code.

----------------------------------------------------------------
Eric Biggers (1):
      lib/crypto: powerpc/aes: Fix rndkey_from_vsx() on big endian CPUs

 lib/crypto/powerpc/aes.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)


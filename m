Return-Path: <linuxppc-dev+bounces-25688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4698C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 17:02:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJgzl5xstz2yxN;
	Tue, 11 Aug 2026 03:02:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786381363;
	cv=none; b=BPkGonRjUN7BvGSkmuGYNB7nF/AOHl8bRJlILGhLodTeVG9bAzitBeVuvB+Q8mLokckIzCwY0GwLuVxs3fuAG1qzNFufW9hPnWjAgZKrkHMJi15QthG6BG3aVNYsVELeKy4+KzqDuQIuj3YDyJWnUYq3sEI9ip4oPJVYhnGvJ+MQNiIqrU87z8t3qF0gig0gJB6f0Yqzkh/K5n1RbL3jnKJn4qT561shh5+Pucg5uYCCrFOg/QluZpHSOU+cdD4PNhAJ10zNZoPMUiCn0Eurs/sDuwd/YTJFLXy6eTKgUziyk9pfZoStVFWh96VzQobVUwy3C0dDklPKI7TlxCOsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786381363; c=relaxed/relaxed;
	bh=iyAm3DmG38eKExCW4RstGp2TUqbRAp83MjdxOvvKRpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbouIwZaEQWJGptP7ZwK998bAoBU7uazw7++rCGPOyQygn+dge94BG8xjrHzEx5B63/wig0VZzHsrRn9ZxXp9CjB6wB/O5SOdZM1rQqT9Xapac0rBZXRS9g2fN+heL4CU3eeHGZsuS9ra8/Sk9tbGe1tl5Vrmnx/o3RWa4iR0/X3I9/sny+S1iO9CVuJRQvwEDA+TA4ex4yGO4M7fNryFProVVDUKyaD/OEBbsCAYnLCfAf1VEpEgw+Da5sq1W9eMuwAcltLBcozCUnNtvEZYSa4uuApQ6/94he9qV1RhEGa7T2J87NuEzFMHze+mqspzp4c6HB0E+PIjT6MB8QnbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kCIcuH5o; dkim-atps=neutral; spf=pass (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kCIcuH5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJgzk2rtsz2yxG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 03:02:22 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 368C640E02D8;
	Mon, 10 Aug 2026 17:02:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0QUmXrGJwqI8; Mon, 10 Aug 2026 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786381327; bh=iyAm3DmG38eKExCW4RstGp2TUqbRAp83MjdxOvvKRpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCIcuH5oeVaolaX/WBWZNfRc3yJ83M0lcvjZp9zLJE2RoUi5mw8GMY4OUbKq7xBMD
	 K6vXW7EZqEEcKX9ht9iyznm0hDimCXogbQ23aMtU9mEyEd1Ns+/GmriOfjXLrwAKIO
	 NeNEVEInTUYRr8hYmyn8iIuHjWdW/DFvUEodS4sReJnJ7PkskefIR4mD7asi7YivL5
	 LQJ2TLUCKzDYxuTfOGDYJOZyko9s9rbuG1KMDUFK3RH/7pAlmJsF3hIno7Q88ZVND4
	 v9z52gG4jDwpYAaJ32pLWn5r7T8yTqShk+C8er16+R88lOAuB+Ygbt5YeKY/BKAQeH
	 fedojyKnMEaGLHNibqpEQu13Fw4RzDXhVuxu/0+y1PFu29GciF14xZhaBMyx/GRrnI
	 s37bhX/4NZBmcBvXdHfW3NxPGTPCGAbIgR8IZrWUd3Z0RSG/dTTDAKoIpGgSN4DteD
	 b7Z3ejMExmJlCVUdRXeh3soE4GI3uowz/Rq6/S9HQX3wds4CDcTR+3OiBwDz+dm77W
	 hnhtUA2tdHHnPOGniHInOpw+jghgR68TNLZ/k+ivPF2nhBv3D7rLV/SPzUVJsQqoiZ
	 WqGCRHKHd0U/MxhzMGs5BfOzpqmMRtGqRTdXpcyH6ek4n0TeMJvOEkPOBRkADsWP5P
	 GH9mzOiMXpvdfC3l5Wr+5i+0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8681640E019E;
	Mon, 10 Aug 2026 17:01:53 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:01:49 -0700
From: Borislav Petkov <bp@alien8.de>
To: Michael Walle <mwalle@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, David Heidelberg <david@ixit.cz>,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH RESEND] powerpc/configs: enable CONFIG_RAS to fix EDAC
 support
Message-ID: <20260810170149.GCanoD_ZhL61i4rHsl@fat_crate.local>
References: <20260730105546.3658570-1-mwalle@kernel.org>
 <20260730185620.GDamueVIGV-8iIzozX@fat_crate.local>
 <DKC6Z5YGBF2O.TAJAN566BN0L@kernel.org>
 <20260731022855.GNamwIZw7Fz4Yhk__S@fat_crate.local>
 <DKL4118H7S5U.1FN3E4DBY4GHF@kernel.org>
 <20260810135020.GBannXHLXtUlqJjzqS@fat_crate.local>
 <DKLBIZ7ZBP1K.20VHSP02I6BW2@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKLBIZ7ZBP1K.20VHSP02I6BW2@kernel.org>

On Mon, Aug 10, 2026 at 04:03:17PM +0200, Michael Walle wrote:
> Thanks! Christophe already pointed out [1] that it should go via the
> same tree as the commit it fixed, i.e. the EDAC tree.

./scripts/get_maintainer.pl -f arch/powerpc/configs/85xx-hw.config
Madhavan Srinivasan <maddy@linux.ibm.com> (maintainer:LINUX FOR POWERPC (32-BIT AND 64-BIT))

and he said on that thread he'd pick it up.

But I can take it too if PPC people agree on who takes it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linuxppc-dev+bounces-23296-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5378AC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:59:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqv826rDVz2yN8;
	Wed, 01 Jul 2026 18:58:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782896338;
	cv=none; b=LCTel5GtAgJW8aw0jIY33eC9y42Cpiwy9P4bC9L+/+prSK/S59lG+adW6Pgi5WSNFUSyUf0lJg6FkFAAQGuttii4M/ooAqzSfYg5jrXGXQdJ4dxq/RmVZ9kdIVobaLyJXbosgE1Nqe53b5wHnwTK33OBMYN4uyn44hAS0Q6Qj5eX62ezzRFEA0tfJcpToyfyBJKk58hpy+DEIDPPbxl4X/z9bpilhhWDmggtqGwWTx24gGrZrQr4A5BSmUIk4PhdF1f4R1a9QXAsL+LtZYw33uzBLXxuQDdGQ6zm3XcoD6GV0Id6b1h5s5Vvc6FTKDuPAV28pDd75X/kAng942lToA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782896338; c=relaxed/relaxed;
	bh=HiCG4Cbn6n4Y1L6TtNSorzpqmwjMH1AWeUnLp2pMkQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVPHV3fbzhR4WC4JvZb+kdTeWhnB7AXwKLMuXlHPCFbzM0OmFu4RkzgSTwdlrcR1p/VJij7z1l7c2+LSZksjMha4QAOV+nT4YgLRrv5bZK44GzNY8k6y1b8sHnri9rqPHXmmvjf9uVbb13qlnDA+37lTQ9gtMc0HJm92fll1dEzzn9n5OwUrGYSDK7tabMXxGHwdoZNX3QunLKpWUrRv7jW+mtX/19eAHGyOD5zzQWK/30OTjTMQeD2rrthTe/TnGq2ime6oDBQ/JQNhlcDSWHL0Sr3RTxgjUUoBcELwbPBo7VgOXv39bRpAqvBtG0DDeeqqk/9Oj3TYWa6D4zvJBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGf/q91m; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGf/q91m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqv820GClz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:58:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB617601D6;
	Wed,  1 Jul 2026 08:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595901F000E9;
	Wed,  1 Jul 2026 08:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896335;
	bh=HiCG4Cbn6n4Y1L6TtNSorzpqmwjMH1AWeUnLp2pMkQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LGf/q91mXSMHqxoDmjvMdTtmCDJvU2Byy/ab6cOEztTpoyPetddQC/70fAE5bVS/w
	 LtiXTBvVc3Tm2n6tgdmSD0bW4cA8F7BEqxQFpnZuAGb1UarjQM3XefD6uk4jO0TE4K
	 2uQM08FH4xs1CjdhetKYbMhFb71tQnokmmvXk0ABfTVyWqFXpfOtC9s8/TFdn4r+Ng
	 8ZNQmUzFjLT782W5ujVB0HqLUkK2Bka22nsy3xNZ9JHMaDCNajiTIYpTbHm6NKU0Rt
	 0bvVyoh2L+rbZw9yD+Lf22jqbpnLkyq20zHWkD6WwcCO2z3VbkiPl4ItZxcXioDb+B
	 fsKMhdlpir6Zw==
Message-ID: <63bef5b9-01e9-4272-a47e-e7ba4583a1a2@kernel.org>
Date: Wed, 1 Jul 2026 10:58:52 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] powerpc/signal: Convert to scoped user access
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1780389863.git.chleroy@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <cover.1780389863.git.chleroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/06/2026 à 10:46, Christophe Leroy (CS GROUP) a écrit :
> This series converts powerpc architecture signal handling to scoped
> user access and enlarges some of the block accesses to minimise the
> number of times user access has to be opened and closed.
> 
> As mentioned in individual patches, some bring real performance
> improvement.
> 
> This series is built from previous series [1] which predates
> implementation of scoped user access.
> 
> [1] https://lore.kernel.org/all/1718f38859d5366f82d5bef531f255cedf537b5d.1631861883.git.christophe.leroy@csgroup.eu/T/#t

Sashiko made relevant comments, I need to rework this series.

> 
> Changes in v2:
> - Add a stub setup_tm_sigcontexts() for when CONFIG_PPC_TRANSACTIONAL_MEM is not set in patch 2
> 
> Christophe Leroy (CS GROUP) (8):
>    powerpc/signal32: Convert to scoped user access
>    powerpc/signal64: Untangle setup_tm_sigcontexts() and
>      user_access_begin()
>    powerpc/signal64: Convert to scoped user access
>    powerpc/signal64: Access function descriptor with scoped user access
>    powerpc/signal: Include the new stack frame inside the user access
>      block
>    signal: Add unsafe_copy_siginfo_to_user()
>    powerpc/uaccess: Add unsafe_clear_user()
>    powerpc/signal: Use unsafe_copy_siginfo_to_user()
> 
>   arch/powerpc/include/asm/uaccess.h |  20 ++
>   arch/powerpc/kernel/signal_32.c    | 498 ++++++++++++++---------------
>   arch/powerpc/kernel/signal_64.c    | 138 ++++----
>   include/linux/signal.h             |  15 +
>   include/linux/uaccess.h            |   1 +
>   kernel/signal.c                    |   5 -
>   6 files changed, 334 insertions(+), 343 deletions(-)
> 

--
pw-bot: cr




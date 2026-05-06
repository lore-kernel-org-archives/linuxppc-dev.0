Return-Path: <linuxppc-dev+bounces-20519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3486CD3436
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 11:42:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9YQ21tFrz30Pp;
	Wed, 06 May 2026 21:42:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778067722;
	cv=none; b=K0p6rfaw2/U/OHlruo5hhT9YEOuQHjgeOt8s2UpBLp2owTxgvueQVafuzoFco8+QNCKMNeqi+D7XvQsy2bazsBzmC95lXYGI1QuuUUa5bUXqBY3UHxHrZOHj5OQxX1bT6qFHl6LNqcLJXTm5SCQNqRFJ1KbxS1QoBGKAffsThzhs48ZkVcETy9OwS/AGwsXiV8joOHEcuM11cCndUWK2FAPlENldlIcZ8XBd5vNNfUz3oU4r8dUZaI/5F58jeb//eySjaDhFKSgskz0ZhYHBVv1M9+l3jsa2LI6hxy7sg9uW0tfgH1lbdYw/tNIEyJRLiiYlUBAh0xhpauk1njnRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778067722; c=relaxed/relaxed;
	bh=fcqNOLkyS9X7UmI9KGNzzo3dmL40eCZtHjkXdGy7ctc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3WDvEs8Dv3nYWzoBo6bc/8oSGpy8P6HO0JMhzsogxtXvVRDt7aOuX+Sgf2sXB8jPte/7o7ga8tHSwxMpnukd5JijBBPG2kLrhzLezr0Oba5Pgbil+uXqaY7SdUmHamUdtCq7kg6ZRwCRbxi7Kci8SpSpRoGSbFD5ut4MFQ02TCxZ5dZCmtQhkkjFsq+LEKpQafG381bGDl7ZQTZ9rEREvxZwQPKCfRDRRQ3P1cnInXp9zVG7mrs7Gxyr8LqSy1rBQhqVItbbbvGjijbuZKF/Kwq6uN9qvmPXbS5CUWSIRlKFe9hDo8xTVBvZXivzcuxsw25NwuBLVFTkLDxpw43uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y5TsLATe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y5TsLATe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9YQ12853z30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 21:42:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D898A60103;
	Wed,  6 May 2026 11:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEC4C2BCB8;
	Wed,  6 May 2026 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778067717;
	bh=Wv3zy7aSI+bkDo01+n8ABRrX9w1Ih2MP6pLk5PJnNWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y5TsLATexthF9+pRod+caVqwnMsKSK68bwwAZDairsJM0SZPCfctQKjd8zqjLkz8Y
	 ZJeM92szHWKm+aBGw0K+r18jJgpLwsK8kkwQ55TodgdDPPoCswVxroTlqWEIXbz9p6
	 hrVj9jrMvoLE7cAvmgXDHx97g94QGsnNNw7B/mVtbvG5TicTuqW1E3dTeu3la6KVWC
	 UM/dY0FMzLRX4ByYq3/keNa2VUpu0Xu64+Q6LYnuCFjDdJ5zB8TE80bwe4/BrH4VKk
	 RALqoZUTeAn3122yOB5W7tbsflq5y+Qv6SwcZSHxnx1xvEcuX80bhfQpy76LWaGNnS
	 fJrokj60aNrrQ==
Message-ID: <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
Date: Wed, 6 May 2026 21:41:51 +1000
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
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
To: Linus Walleij <linusw@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
Content-Language: en-US
From: Michael Ellerman <mpe@kernel.org>
In-Reply-To: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/2026 04:47, Linus Walleij wrote:
> The G5 defconfig is clearly intended for the G5 Powermac
> series, and that should enable all the available
> windfarm drivers, or the machine will overheat a short
> while after booting and shut itself down, which is
> annoying.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> I wonder why this never gets applied. Am I doing something wrong?
> Is the patch stupid? No-one cares?

Sorry it didn't get picked up.

I don't have any G5s anymore, but the ones I did have used the other 
windfarm drivers so I never hit this.

You might be the last person on earth booting Linux on those :)

> ---
> Changes in v3:
> - Rebased on v7.1-rc1
> - Link to v2: https://lore.kernel.org/r/20260120-powermac-g5-config-v2-1-cd8f1c8bfbae@kernel.org
> 
> Changes in v2:
> - Rebased on v6.19-rc1
> - Link to v1: https://lore.kernel.org/r/20251205-powermac-g5-config-v1-1-8609aa97c1c0@kernel.org
> 
> To: Madhavan Srinivasan <maddy@linux.ibm.com>
> To: Michael Ellerman <mpe@ellerman.id.au>
> To: Nicholas Piggin <npiggin@gmail.com>
> To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/powerpc/configs/g5_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
> index 04bbb37f5978..f74ccc06f4c1 100644
> --- a/arch/powerpc/configs/g5_defconfig
> +++ b/arch/powerpc/configs/g5_defconfig
> @@ -85,6 +85,8 @@ CONFIG_PMAC_SMU=y
>   CONFIG_MAC_EMUMOUSEBTN=y
>   CONFIG_WINDFARM=y
>   CONFIG_WINDFARM_PM81=y
> +CONFIG_WINDFARM_PM72=y
> +CONFIG_WINDFARM_RM31=y
>   CONFIG_WINDFARM_PM91=y
>   CONFIG_WINDFARM_PM112=y
>   CONFIG_WINDFARM_PM121=y
> 

Ack, LGTM.

Maddy can you pick this one up for next?

cheers


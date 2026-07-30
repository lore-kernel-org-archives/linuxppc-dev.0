Return-Path: <linuxppc-dev+bounces-25089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4816C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 10:19:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9lYj1Q07z2yYd;
	Thu, 30 Jul 2026 20:19:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785406777;
	cv=none; b=grYWWTkHVN/RUGzX3a75HK+qi+yw0obanDYWdiekosCvh1SvoPXyTq567HjStfUm3JPdh2Fag473OaDGVnHxRmMQsIxLgSCrjKDXWz4skHaGJBXfs3NNKhCDjG14OQvqY4mjIBQLNAReCbUCDhBJtpHuCkX0x73QFCMPZ44Yu1kG9xdjW5h8vpcgjOPi1eGWcr1VDtg/gPU197PK8T59EMKREz0s2R3TRjKlwAjClxT90k40p9uDsp2X6Bi/125SdEEAbrJ3kFbU/jxBQJ5JXahK6hpWeKZHnBwlU1i5CUKYfVNVUIicOsnr+EkiL+1ciD2YBr9PM8UsaVtQK9mHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785406777; c=relaxed/relaxed;
	bh=jAZk9t6IWX+imPwrssJXOBmmCd9PX3AtDQPV29JPbjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahASmjK/C/dBNepf/DBx7jXmBDn038PCpaygk8HpC56D60SQwn/YzwbKH8pMSTpYD62qG+cTRzoKtMiEdAPSrS3ubxij/uO+c8CZKF8EZTNgo8amJnt6TbB85EHvDeG+6q0YKloC/ocK5SyuSG9/gEwpOE1XneEAdKA+TYK7wQ0JTNP4PHiIIWzxm1hFiIZVXe7B61wXhsmXLGUQzMxC7dpSWYjrLqtltaQYcwQ7vrcJzxENpPovtrzBPoN1oNJCkkRwQSBLNPian9+OjjyS4k5ADsetD3WL421lsTDwsV2AIJ83mLL/aPd6KHeawmmlur6WRm25GDjTiJVFExoCtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJtS0CFk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJtS0CFk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9lYh1RwBz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 20:19:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 23EAE600AB;
	Thu, 30 Jul 2026 10:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD9F1F000E9;
	Thu, 30 Jul 2026 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785406772;
	bh=jAZk9t6IWX+imPwrssJXOBmmCd9PX3AtDQPV29JPbjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jJtS0CFkehYEgqdfZJCQmWtXYwMPLrqsP7dRKo5dtJCSvT5zdgFgVmK1kowGPcqMb
	 1vFmF7NhChjF+DoWObTeCgbOcwwurnSZFXMpmt23I0zyN4Y8tlEgqx0+DLbamAOJGu
	 oEscisFbJGCt6I0Rj1iT61ulEHwL6U6VAB0WETYb/PTBOrwSdE8QLyxcTjr4XnzOcP
	 XL5Lq4vyvB1VUd66FUPKdg5uz6Z4kyNnPT8bhjbDs0j/WxxwcWe5XLdgIKP511uzSM
	 reeUL1xbszh5kGxMMCpNvVTrhrppi5DFN9f4JoOA34wevQAkfvXjONFsj+l2k4TqIX
	 hasNnSLMmGzJQ==
Message-ID: <1500e19d-9bd3-4050-8568-31b546f0b22e@kernel.org>
Date: Thu, 30 Jul 2026 12:19:27 +0200
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
Subject: Re: [PATCH] powerpc/configs: enable CONFIG_RAS to fix EDAC support
To: Michael Walle <mwalle@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, David Heidelberg <david@ixit.cz>
References: <20260708142725.2113684-1-mwalle@kernel.org>
 <DKBTLXSZPBSV.2ER6IB1B83LP3@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <DKBTLXSZPBSV.2ER6IB1B83LP3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 12:06, Michael Walle a écrit :
> On Wed Jul 8, 2026 at 4:27 PM CEST, Michael Walle wrote:
>> Before commit e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC") EDAC_MM_EDAC
>> selected RAS, after that commit, EDAC depends on RAS, but nobody enables
>> it. Enable it in the config again.
>>
>> Fixes: e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC")
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
> 
> Since there were no replies for now: through which tree is this
> patch supposed to go?

I'd expect it to go via the same tree as the commit it fixes.

> 
> I forgot to add Cc: stable, so I'll probably have to resend it
> anyway.

Not really needed nowadays, as soon as there is a fixes tag Sasha Levin 
will apply it to stable.


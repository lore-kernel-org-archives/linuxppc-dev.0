Return-Path: <linuxppc-dev+bounces-25097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4639BC55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:04:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9ntg5Zkyz2yYd;
	Thu, 30 Jul 2026 22:04:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785413067;
	cv=none; b=hohc9M2Kk68ID0D7rggvXe6MbfeJUvf/AkW5k0gMDtQydckrLipzg/x9mslDpoy6m+yBr9SImaYenlKwcuFykaaQKAHIcUXTBDqdQaMFslC6alF45KH9LGwYzSOPC/fGCIQRreakbnH8JcG8KtrbUEH1JcIIIGey5fqQ8x2Ca5asc8iZJbptsF7jUJ/kx/SWHAqrbD4n0k+B98FKDhMldeBLPOfYzPLQTD1yT8EhTff4t7HRFsadjjNqOz0FhGt0VXPcEiZJer/2ALrcbVNiM7d49IkrKb6IOm3blWouB6y8ivQD27tsO4ZsGfp5i9Qw9rwpepF8+rg7ubck6uxdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785413067; c=relaxed/relaxed;
	bh=wCjYLQdx1BmxAeW8uae+DfbkSuHn2ffhF/4FzkxWyvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsAMVjMd6j5PLiHVjz2329fyJzS0grEchrT/Rra5MFV7eqzKFzaspOHY2dEzmJhQql54eD1VCDlvSFp7cz2EUbl2q8XZIBh5vSFBlk7noOPmKi5wK4BUBqOj0aHASCAIm5GmNGqAdf/1PvnWV++igNJsh9iwd1lO9IYFoz3lUUOPMHjf/xJn+PFHUdtWlCj7r0E/Thw5Wk3hS40xMLna6V+1JuSB1Ww2RHBRbrTeocy3EgAWoGdecTs3k0lAGOotfEbiOcGXyjPFOZRyk5SEY0R3NaL4oKZkY9LXN+kV1+Vr5it0O7W87+b39sjtZWQWGlyyQEOt0OZyko56dbJLFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maQ24lWj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maQ24lWj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9ntg16N5z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 22:04:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 15B41600BC;
	Thu, 30 Jul 2026 12:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39FA1F000E9;
	Thu, 30 Jul 2026 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413064;
	bh=wCjYLQdx1BmxAeW8uae+DfbkSuHn2ffhF/4FzkxWyvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=maQ24lWjVdvwS5tu2QP4A7MHaS2lo+RRlDELYhoaWu/ROi9KJE4BdVKcKER619gSG
	 uRpQaXZheS6nm6HUYNAcODnG12EIUuw4JH42pnNRnJFvrgqaGo8VSDpP/o1w++rtNZ
	 JGesTsTTccy0RSIPdxHiTgqfcfjy236i0rkNtbOkbdBOZ9TOSeghkjEaa9cw+jgnwo
	 laSZzCEW07LTj2Hfls9HQuReN2bsIxqseojidnYna1JrLVXrcNVWW1h3pom+TkCjjz
	 oVtMeygiB5o/aCdn8+iakgs0Li1oL8uDDtD7j8OkftEtXuP4NhjIf8odSrgXa1msCz
	 Uv9lrLjhTt34A==
Message-ID: <554e73bc-2aa9-4caf-8d36-c1f550500d9a@kernel.org>
Date: Thu, 30 Jul 2026 14:04:20 +0200
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
Subject: Re: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Paul Louvel <paul.louvel@bootlin.com>
References: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
 <178539922190.574381.1359588018451529893.b4-ty@kernel.org>
 <fb520f00-1331-4136-8421-d82bdd46c48a@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <fb520f00-1331-4136-8421-d82bdd46c48a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Le 30/07/2026 à 13:15, Krzysztof Kozlowski a écrit :
> On 30/07/2026 10:14, Christophe Leroy (CS GROUP) wrote:
>>
>> On Wed, 29 Jul 2026 16:10:36 +0200, Christophe Leroy (CS GROUP) wrote:
>>> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
>>> proper platform driver") qe_add_gpiochips() was walking the device
>>> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
>>>
>>> After that commit the discovery is handled by the platform core,
>>> therefore it is necessary to call of_platform_default_populate() on
>>> the par_io node.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] soc: fsl: qe: properly scan GPIO nodes at startup
>>        commit: cf91e5909e620b77164b53c9b316a5c1f11f9ea7
> 
> You left very little time to respond to this - one day - and introduced
> undocumented disallowed ABI. Please drop the patch. I will be objecting
> to the entire pull request.

Yes sorry for that, I thought the reviewed-by: GPIO maintainer + 
discussion with Herve was enough.

I'll fix it up before sending pull request. Thanks for reviewing and 
providing feedback.

Christophe


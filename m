Return-Path: <linuxppc-dev+bounces-21117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5203BCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 13:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJzkN0Wfxz2xrC;
	Mon, 18 May 2026 23:51:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779112316;
	cv=none; b=fQ0waQ5923g/0dr4d23Ha1geRqUG9Ug+wDiAzi3KGagGT3KrgHpk8I3kzT5J8I00sQbH0vMu1xJg1NPM5vqrSO0o9w6cIYYNYApdkQ6RtG9Uhvk945yrQb7PlTNz8U4oAODnM47y3BYdVDGCU736GUqT9a+mKjvfaJq7Qt+e4pZ7QPUKJoYMX9XfLiThYKV5oMVvDyjRc6r3mWssk0mjlKqQfWXOfZf+3nr6gn/6ww9zIh9OVV2JCgy+aHxfyQ4RsrJJTnCQvZb8dbyIh6U4PG5cLdeYamul4zMzuIDM+kAfp5GTqORri3QaMr+aWii9Jk9jTtd1Y2xL4kSbEKxgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779112316; c=relaxed/relaxed;
	bh=1wo+pAlvSm49r6D2GoIWRU76W7R/YCiyr2qsoo+pkb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0Lck/BdVQPsmsRT2tGihkKc7jdxW7OShulSBhPr6dylwDyo+7nmSmj1pc0iQYHmhvXOuQU8fcYiACKkEj6ytFVbIKAnDdDUSs8CLz0FUpvFTu9FtGdta2xaU5czfd9wTN7MEhBsP9CwU6FK0hzUvH2R71RgT4xeIz3DG0C49nI9j04vT9cJyRexeQXBrB/kg9kWkIdF5YtQrUuyTt95WegV+I190S2ynZ/ybdAzOegPzeRmtyqCp4nAlQc/NhDExg6d4hJ/VuMNkDmK1IJpBscjm6a34OE4fFF7G1LPh04NugnD1Ko6jNHcLujf3nBp49e0xJ+S1u8E9TIgSIRegg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KpVPMYOO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KpVPMYOO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJzkM1Y9Pz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 23:51:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B1E4944279;
	Mon, 18 May 2026 13:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A4C2BCB8;
	Mon, 18 May 2026 13:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779112312;
	bh=tTiSLoD171HOH9MG6UW2Ctw5fFKZ7i03l/tZXd81gA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KpVPMYOOQGSZUQyavZov1lTId0F2PnFZ5ubdKezcRZizgMLp0LPs1hklw+3/6K6LW
	 7BNdCNjZ1mYNLUPSPgPNP0Kes1UGCcZ/h2BAJ9TGgoNw73xdnoah1kb3Jh56JGcyro
	 eRh+o9IjS+j2TPCyxxpoBj8dVwYJLs/Wl7Yfdck1392G0aYpOkzoZw8UJSDqIr3Ww1
	 ii9ahi96yMY8BRaky6Ib59I5LV+mWCZh006nV+Pn6H3USUdbpHqYBYOUbctJZmhhXL
	 SvB/q2UZPZR/oq/nacuYEZe7tLh88cVtmTGnDdT3PlmeeUG8YLpkyxzx1iXyrB549K
	 NvIWXAwBsbpEg==
Message-ID: <4f34dc22-8dd7-42fb-8c16-4e359faf60d6@kernel.org>
Date: Mon, 18 May 2026 15:51:48 +0200
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
Subject: Re: [PATCH v2 0/6] fsl-mc: Move over to device MSI infrastructure
To: Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Thomas Gleixner <tglx@kernel.org>,
 Sascha Bischoff <sascha.bischoff@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <20260224100936.3752303-1-maz@kernel.org>
 <177209938125.547814.7154250802402503122.b4-ty@kernel.org>
 <87v7cva080.wl-maz@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <87v7cva080.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc,

Le 10/05/2026 à 15:00, Marc Zyngier a écrit :
> On Thu, 26 Feb 2026 09:50:43 +0000,
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
>>
>>
>> On Tue, 24 Feb 2026 10:09:30 +0000, Marc Zyngier wrote:
>>> This is the second drop of this cleanup series for the fsl-mc MSI
>>> infrastructure, initially posted at [1].
>>>
>>> * From v1 [1]:
>>>
>>>    - Drop the now unused DOMAIN_BUS_FSL_MC_MSI bus token
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/6] fsl-mc: Remove MSI domain propagation to sub-devices
>>        commit: 1fb7392ee3408494d4d62c09a8c3e5f5934caba7
>> [2/6] fsl-mc: Add minimal infrastructure to use platform MSI
>>        commit: 0c9f522f2d41c7e055a602a0d2c41dc7af01010b
>> [3/6] irqchip/gic-v3-its: Add fsl_mc device plumbing to the msi-parent handling
>>        commit: cf3179b4e53f527aba9f0c6c3b921619c8adf761
>> [4/6] fsl-mc: Switch over to per-device platform MSI
>>        commit: 4a958e47c246fa3fb8954f4303e0da15ab3d026d
>> [5/6] fsl-mc: Remove legacy MSI implementation
>>        commit: 14b1cbcc6cec0b02298f4adf717646cd943b7ef6
>> [6/6] platform-msi: Remove stale comment
>>        commit: f0a2eac6a597268034fd40d92c1469182438b53d
> 
> Is there any particular reason why this didn't make it into 7.1?

I sent a pull request [1] as early as possible after Easter break, but 
it was apparently too late. Or maybe that was because I did a last 
minute rebase, I'm not sure what the real reason. I tentatively sent an 
alternative pull request [2] the day after after rolling back the 
rebase, but I got no feedback.

> 
> I was really looking forward to some additional cleanups in the GICv3
> ITS code, and this gets in the way.

It is still in linux-next and finger crossed will go in 7.2

 > > Do I need to respin it?

No, I'd like to avoid having to rebase again. If you have changes to the 
series please send followup patches.

Christophe

[1] 
https://patchwork.kernel.org/project/linux-soc/patch/69cdadd6-523c-4a79-8cb3-1deff5910699@kernel.org/

[2] 
https://patchwork.kernel.org/project/linux-soc/patch/310b65ba-1d73-4ce0-b332-00cde70acc69@kernel.org/


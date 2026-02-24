Return-Path: <linuxppc-dev+bounces-17089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81059EFB809
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 06:52:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKpMG0yrmz3cGc;
	Tue, 24 Feb 2026 17:52:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771915978;
	cv=none; b=AqRCfESrAGARMaHkMw8rPBUGRwHiACVZi4TTAX6BlP36rHvD+V9pg2ZfkP6QdNuRy50lysBzOy1h6zXBqHAgEHebl/Ik0xYY+0vIv8qVvUtiksLVr/Cavt69RShREId5j4QdLELUZ66rTAnkwm/LmJwUuGDA02Bma9//KbTgoA13XobvRgHfHmiYjT5MbYnbPY7yTDd5osBs/V4K3yGm5xKewuiI/fXrzQRhNGnXAb3m/G5pv0S+oLARNbnZYrC1BUqS5ySK5OiIqFsujysh3551I2hMiM7Z2qGuwMQCuUSq/xcTU1Hdmy7wnjfd7uyIriLJmqRjXqA7QEBhjeKa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771915978; c=relaxed/relaxed;
	bh=yodi5QudEP1UO/eSIBA4j6uIKhLhBFgpzekv80+iugE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LM7Pxs9bNNVeWEmeZXpoQamkAtwkCZJstm8uXBvO+qAXovFSTQ7nJ16+mrVrA+su8Ftslq3zMKeyL1vHa2qjn9M0LHAfz7lhB4EFqdiUhWwGfGasy4XeTcJqpBwINTI9zq2TDZyGavjPCG/syfYSwUq4i6wWf+vjJfLDs49AGlRZarvZyV598+0tDyup7gHma53n6jcjHsZh/9TvUqHpFexk4WlEDErd+9lk9D/Rx/s+E3obVvNhlu8QYh+pVLY8/8wPPpvyl77qC6EjvhMib224KPqHHNO53usjxF3qY1AzPJRpIXKGjQRJgeHdUewteUGnk0J4F2tFlTpFv540/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qc5YGYUS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qc5YGYUS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKpMD5z60z3cFM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 17:52:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3D6DD4443E;
	Tue, 24 Feb 2026 06:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE8BC19424;
	Tue, 24 Feb 2026 06:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771915973;
	bh=aCu4SGTZ0u7PvY1QpTVV6+nX9QunCxrpSU1ytfQX0wQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qc5YGYUStAEoFm4R/vACZO7CmlUB7OtzCPVDthis/63rdRkb0x36arLCbf1FceUCa
	 KVb/9qRT5em4Qff50w0RGtmUbJziREpp596TVFs3LX1gEzGtPBpsyUELFU1LVH57Bq
	 AlHYyRRD2UMKv/N5a0xaPtPQdMiK1WFk9M7q9vXqBXyAO7T3GPitiRHBSCpiqDMbse
	 Bohia8HTR4/BE9qqYPwT73K8CTFXeAopfCPME3bphaKGUMcnKnX2Gy0Y9djGry7c5f
	 Z85mGC1xF9cfUYHIwRqPTt9IsnmAVwvWA0A/7lnb9iTRVdODW4LVKM6h3HUCF4ABvD
	 orCXkQBMpU7Fw==
From: Thomas Gleixner <tglx@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/6] irqchip/gic-v3-its: Add fsl_mc device plumbing to
 the msi-parent handling
In-Reply-To: <86o6lfa936.wl-maz@kernel.org>
References: <20260218135203.2267907-1-maz@kernel.org>
 <20260218135203.2267907-4-maz@kernel.org> <87seasv11z.ffs@tglx>
 <86qzqbal69.wl-maz@kernel.org> <87pl5vvchx.ffs@tglx>
 <86o6lfa936.wl-maz@kernel.org>
Date: Tue, 24 Feb 2026 07:52:49 +0100
Message-ID: <87jyw2vdj2.ffs@tglx>
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
Content-Type: text/plain

On Mon, Feb 23 2026 at 13:22, Marc Zyngier wrote:
> On Mon, 23 Feb 2026 13:02:50 +0000,
> Thomas Gleixner <tglx@kernel.org> wrote:
>> 
>> On Mon, Feb 23 2026 at 09:01, Marc Zyngier wrote:
>> > On Sun, 22 Feb 2026 22:57:44 +0000,
>> > Thomas Gleixner <tglx@kernel.org> wrote:
>> >> This rejects as you are building against an unmerged change (I assume
>> >> it's Lorenzos GIC5 stuff). I can fix it up when applying.
>> >
>> > That was against vanilla 6.19. I'll rebase on -rc1 to satisfy myself
>> > that this is still doing the right thing after the ACPI crap fest, and
>> > repost the result.
>> 
>> Ah. The other way round :)
>> 
>> My resolution is simple and it looks about right. Please note the
>> cosmetic changes I did on the way :)
>
> Yup, looks good to me. And yes, moving the include up is the right
> thing to do.
>
> I have another small change in my current stack that also drops
> DOMAIN_BUS_FSL_MC_MSI from include/linux/irqdomain_defs.h. Could be
> folded into patch #5.

Just resend the pile.


Return-Path: <linuxppc-dev+bounces-24211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734C0C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:43:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzzWC5P6rz2yH5;
	Tue, 14 Jul 2026 22:43:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784033015;
	cv=none; b=LObVXTiYl2zlW5K+D53e8N1C5bMVd9H9PVP/K96Bx+Xd8LGKu62xGg25oAwfKtEqex/81P2HKuuC7IHhEiJGg5QZdV9Wd4KWrG5tvVfvW+O4vcVlwK6z2K/eYspTA7v1CQhgkcqcBgCsCgQgJDgic/nTbqaWr+QOmKht3bqghsEYMwmNGR9uLAnBGx5w7wuyHUxg0M+aeM01zPbdGcW5OUIhVSwDHssP3fipaDESmyC/OhCqvEbvHyvHNvA1LJjXt1EDgeFYmordUiXLGjlZoJtQtlQByIsR6q3scrfATt+F5sm18AtaEFqxyWHV3Wo4rL1hpXb4lXj7L+ZaPbYRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784033015; c=relaxed/relaxed;
	bh=uDuJzr30NAJlJiPFtUSwPwG1ACdjUZ2KotIIPHp9q54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ+2i9droGsmGYrkuMjVe+koCSpJTZoOuZ6DWkUlueAmJOS4CNOme5edBFR/SWCONKJP5Lb0V8JouZBswm5s1kGBcQF29Ngnh47gF17Z9x0lKoymikD3Lo75GcYc9h7q4GwLI1rwkBPB3EYbdUq90CPq6pUurGDEy3gkvp2HTwOntdvNR8ULomCtSCdMNO+qg7V9Z7hvGIByRCIeaTcTEn2R9KCTa6jgFCoWzV8d277vf9rKHqPqggDKv+jS/aJWTGZwRrhULR3D+znZOIi76w0nubTNSrIHuxEueOvFHbOR4z7yvRZfSc042HbZSj/+A72n9Qxjm8biPGSxZQH4Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3z4fMr6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3z4fMr6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzzWB5Qtlz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:43:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0658060120;
	Tue, 14 Jul 2026 12:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916281F000E9;
	Tue, 14 Jul 2026 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033011;
	bh=uDuJzr30NAJlJiPFtUSwPwG1ACdjUZ2KotIIPHp9q54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3z4fMr6YW8/gKFJNOklBhP/5QHWLH+5FioqyN7UMdD8PVpGIoyCJpuAKuH97dhMD
	 35+7s2wV31ELe175wsrIJNMpRthd/JbxDbCQvFWco4FSaKSUfJd83h7X1j/E7xDcdm
	 6vSSkaYeZodBN7h/DZ60TCIfPy6EZBILeCh4ooSI4wpBe2/8k8MhbZJpPBc6riAmNX
	 3erVnpBel8lVTy/egpqG07XnVFzo5nmv0RdaFesxM7UIWl4rGMGx4ok4bqGfF36LX5
	 2h+uPjYHJFBBNNv7eqNYZqQmQ1J11TC84ENI3pJ2QbJsuujt7h3yVgzNm7SK4sYfrv
	 rzDTJgFzAbdtQ==
Date: Tue, 14 Jul 2026 13:43:27 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au,
	Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH net-next v3 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
Message-ID: <20260714124327.GJ1364329@horms.kernel.org>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
 <20260706193603.8039-6-mmc@linux.ibm.com>
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
In-Reply-To: <20260706193603.8039-6-mmc@linux.ibm.com>

On Mon, Jul 06, 2026 at 12:35:53PM -0700, Mingming Cao wrote:
> Queue 0 and subordinate RX queues use different interrupt control
> interfaces in PHYP:
> 
>   - queue 0: h_vio_signal() after h_register_logical_lan()
>   - queue N: H_VIOCTL against the queue handle/hwirq mapping
> 
> The current code is single-queue oriented and cannot safely scale to
> multiple RX queues in poll completion and open/close IRQ setup.
> 
> Introduce queue-indexed interrupt helpers:
> 
>   ibmveth_enable_irq(adapter, queue_index)
>   ibmveth_disable_irq(adapter, queue_index)
>   ibmveth_setup_rx_interrupts()
>   ibmveth_cleanup_rx_interrupts()
> 
> These helpers centralize queue0-vs-subordinate dispatch and make IRQ
> lifecycle symmetric across open/close and future resize paths.
> 
> request_irq() is wired with &adapter->napi[i] as dev_id per queue, so
> interrupt ownership follows the NAPI instance that services that RX
> queue.
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

Although it is added later in this patch set, I believe linux/irqdomain.h
needs to be included in this patch so that irq_dispose_mapping is defined.

Also, I think it would be best to add these helpers in the same patch(es)
that they are first used.  As this will avoid temporal compiler warnings
about declared but otherwise unused functions. Similarly for patch 13/15.

Overall, please make sure that when each patch of the series is applied
no new warnings or errors are introduced for allmodconfig W=1 builds.

FWIIW, I exercised this using gcc 16.1 from
https://www.kernel.org/pub/tools/crosstool/

...

-- 
pw-bot: changes-requested


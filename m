Return-Path: <linuxppc-dev+bounces-25528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C4EC56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:49:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGXr34nFz30Dq;
	Fri, 07 Aug 2026 04:49:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786042172;
	cv=none; b=KDGf9jLaTPzGReK13sWTDcfYaFVcPuFJISsLvH2B1WqPOwMGPtMOzaXhVnO5xyHrcbD6csNymVW3CoYmLTjC73YnK/ZyYApz13FKXy2o/3W6KAk6hGEe0ENNEANPZxpuPX+W2QM1d6N9xyWd175iXf2jH0/8rF8MLytOsaYxV4pKZMiq5NtsOmvbfgCWqeJxVl1f25xPfLiZUw07wVx1MZ5VD2x+DiKjQou9J5DfwIjxessl8SkMnt1iCwHeEqR0NERFsPTAf99USh3AkIPssyPaA4U4omOuhoHXtDaycHra1rT3pnNw7UyhGCXkJx3vl8htIS1SV+x67Y2pi0i//g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786042172; c=relaxed/relaxed;
	bh=K3lSD/y8TLLfT3QSIOcYK/1bKB7Bn58FgfNGm0YW9jE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bx/FqOKHKy1gO/DsPP643s6Qc5QQ7tEuukW9ozU5IWND7bSGJ+gYOGMG/21bMLF7aL6MsHMLkdkyvs8SuC0hKoUkQX6d8MchGe2D8pyuZW+ig9wC04VHvnY6liJNGYP88tvYi+hM0hnvs3jvTEhn+FU5JibhRWFUK/PxhVm4wUCUy7gEM1G1afjf3mOq2luAsaEZZOt4KOQHuXr4n20Hxp3O4fvUoIfCGTFPMKdsHJE1Nm6WwXRefjvbuqCFXoK2SapgY0keSerroPqUlNyWs4OnTvGTrwOnTJ5s8chSeFiGIT9UVGlFEkK/sMGB4SZHBDVOZ0y/bPusmyzoPqgmzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TML5eYOs; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TML5eYOs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGXq4l4zz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:49:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D913D4373E;
	Thu,  6 Aug 2026 18:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD2F1F000E9;
	Thu,  6 Aug 2026 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786042169;
	bh=K3lSD/y8TLLfT3QSIOcYK/1bKB7Bn58FgfNGm0YW9jE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TML5eYOsd5ouRIUF5mWZ6u7W/MnY6SfJjuVAtNP6UNQ3DX8+jSQI4T46pcqVzAZrn
	 4hF5L+8uN3g0Vsem5mqEt7RWIR4lqTbQB8fD6xgkKsVedVQa8MUIK+I9cFp0RCV6MC
	 6LL41dqzsa22OlDFdf57YIwmIboBkHvo2qk5Yo1Ap+HpMLpIWFyqdSBTNQEbvki3CX
	 TOT6VT8aGHENTMPh+KoPtvI+drIaRLdOVa+RZTbNYVCqB7TID+rg0uAmoYmvbkaE5y
	 93U9Dv2USEUmQ+NgsxegUazt5+ik4qojHHgF2jG0vi4BsjnzSuSdUJt11GEc2jHLhK
	 RnOcdv+cbijmA==
Date: Thu, 6 Aug 2026 11:49:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
 pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
 shaik.abdulla1@ibm.com, Dave Marquardt <davemarq@linux.ibm.com>
Subject: Re: [PATCH net-next v4 14/14] ibmveth: Fix MQ RX poll and shutdown
 hangs after queue resize
Message-ID: <20260806114928.3f4adfa9@kernel.org>
In-Reply-To: <6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
	<6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 17:47:17 -0700 Mingming Cao wrote:
> After aggressive ethtool -L cycling, PHYP can leave a VALID RX descriptor
> with a correlator that no longer matches the per-queue buffer pools. Poll
> treated this as fatal: ibmveth_rxq_get_buffer() WARNed and returned NULL
> without advancing the ring, then restart_poll retried the same slot
> forever.
> 
> Advance past bad correlators instead of spinning: validate correlators
> without WARN_ON, skip invalid slots in poll (count as invalid_buffers),
> and advance the RX ring when remove_buffer_from_pool cannot map the
> correlator. Rate-limit the bad correlator message.
> 
> Complete NAPI when the interface is down or napi_disable is pending so
> close/quiesce can finish. Do not restart_poll in that window. Close
> keeps hypervisor IRQ disable before napi_disable (via
> cleanup_rx_interrupts() / related cleanup helpers).
> 
> Also validate descriptor length against skb tailroom before skb_put(),
> and after napi_complete_done() on the budget-exhausted shutdown path
> return a value less than budget so NAPI does not immediately reschedule.

This patch looks very odd, like there's a bug somewhere and instead of
fixing it we're making the rx path more resilient. BTW minor coding
note - you're adding a bunch of heavily indented code to an already
long function. Please consider factoring things out. Similar comment
can be applied to other patches.


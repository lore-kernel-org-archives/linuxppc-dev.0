Return-Path: <linuxppc-dev+bounces-24595-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64CEC4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:08:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Hkf0xPPz2xqJ;
	Tue, 21 Jul 2026 23:08:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784639306;
	cv=none; b=TqIlAZZ7mE1QOXAWMDGSRa4WRHdbWy/DLJYNUP+Q2pRO0R5UozV2UKluS2w5HhFtzQwJomtRMmI7CVJhNF+0jh2rBMFKKn4XQ+gxuirMsoy7E64+th3pTSIkomOe+2Cd3PkKvfuxalKowE2VxFpu9uhQzcREYyjPMtnRD7+0rh8+eT5y7PN8bVbKpBrWlZrcO1oEGtinqnmMlyt03j7rFgJvqLgAXh5wJfYzUfSL6z7cEyD1gq2OWOWx0XXpRPtoQGaKiBX/18+EJEmlfwtQD7MiP2mWTOh28OmrMFOX63LW38HISM8UuKCHNlTlS8yIdBhBwNJu8Itv9lq1izGpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784639306; c=relaxed/relaxed;
	bh=TYa/G9Ikx6NJ1Cb3jjSRc0JJzXsBaNhe6e1UGVGm/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBYIzfPI+ENwvayis3dijmJOx+v9HX2orW1Hz019LycfAq5zZsB/i4481qxtcDuTgU34kQgdlMrEqLkeyauwkeJZykUxy1i9ssMji/Z3ovGxP7ggSeS8v2D8SPiWlbBXdX5qZJWK05GCzespp0AKx4qsO0zA65vq9Lp5chnB3tG4FJlLskCpFA0lq6MwhkroUnRCrwwKtn63812/0O5dc1ulpW+cntZvd0P87kMxralJxKNh6S1LSCSIJxOD6srK8j4DrFs2h5jyEtol+eDyUwkxBJVTBegeiB5b8JHyOoTLQ9dFaFrr2+8UpIGyhnV0RpqSJRerSkaGuLIwITbzVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d6/V2aPE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d6/V2aPE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Hkc6Y40z2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 23:08:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BA4841AC7;
	Tue, 21 Jul 2026 13:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A081F00A3A;
	Tue, 21 Jul 2026 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784639301;
	bh=TYa/G9Ikx6NJ1Cb3jjSRc0JJzXsBaNhe6e1UGVGm/9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d6/V2aPEpPAB2I6Ua7LPwlcHwngi1zJi/XHIgdgpWsC+OpJGb8lJA2aRw5XgvUCSk
	 5IZrdAIm+bmynNmQblXUQu5K3mThBRK4gT3ERximvLzMKDANxWBbmBkq/iBUG9clUc
	 4TcfxO32nUe0BTZC9S93Hw6aq20MtO0npuydVBV4=
Date: Tue, 21 Jul 2026 15:08:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 6.16.y 0/6] cBPF JIT spray hardening
Message-ID: <2026072151-outsell-suburb-64ea@gregkh>
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
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
In-Reply-To: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>

On Tue, Jul 14, 2026 at 11:58:24AM -0700, Pawan Gupta wrote:
> Hi,
> 
> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.
> 
> To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
> The flush is conditional to spectre-v2 mitigation applied.
> 
> Patch 1-2: Adds the predictor flush hook and enables it on x86 via IBPB.
> 
> 	  bpf: Support for hardening against JIT spraying
> 	  x86/bugs: Enable IBPB flush on BPF JIT allocation
> 
> Patch 3-6: Narrow the flush to only unprivileged JIT allocations
> 	   to avoid redundant flushes. Also adds pack-selection changes
> 	   that minimizes flushes.
> 
> 	  bpf: Restrict JIT predictor flush to cBPF
> 	  bpf: Skip redundant IBPB in pack allocator
> 	  bpf: Prefer packs that won't trigger an IBPB flush on allocation
> 	  bpf: Prefer dirty packs for eBPF allocations
> 
> This one is mostly similar to 6.18:
> 
>   https://lore.kernel.org/all/20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com/

There is no active 6.16.y kernel branch, so why is this being sent to
us?

confused,

greg k-h


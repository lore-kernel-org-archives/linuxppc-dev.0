Return-Path: <linuxppc-dev+bounces-24290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0776C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:13:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0Gpm3f3sz2yZf;
	Wed, 15 Jul 2026 10:13:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784074384;
	cv=none; b=d3Cndw/pF7DSiStfLLmO2x0wxFf3fgELxz52Eqy0ylqtTU/7tb4pxsz4mvHskyvkSLqv6KBbiy24xYAdlZcm+c0VV1Ju702N4TN3P6JtN5KAUfW+7zwg/V9MvivLxViaqqvXUaTtx/koGcSSbLk51pIISvx5ZIscstwyjaoaH1fq3cGNyQNBQRv6dikF+R6F5qfSN/sR6uD8th/Awr7OHWR7GZRNyMbtmiKKOa19J4/e8eToy9HrVZnLhEch0B2mPtso7siJH+ipUcRvfzQ7cY1atiRqp3SLSySnRqaixVjfshHQMwDNfwY83gWAyiVU8jM4Ak/QI9FljWQ6spCnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784074384; c=relaxed/relaxed;
	bh=SDbonQLIoOSfVB1dApPM6LkzNs1SHNxOM+rrSsaUBBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5g2MIZ+VQQmgKHK5CEee5BZGyHKS9QGeM4gghKQHvhj49ZBHJRsuLYoasZVhxWCp5D3hTL8jQ/pqn9NU3SfROY12k/WpQlNbR+ROMBHPopnP71kmsdsUX5M1kNunFsTFVpMZtFSSux0iIE/hx0sYZFiO9xWcpb49dEA/LoM9GLOlevyKVBQDYGLbBZtpuzBV8/7Yvsf/GOi51uNot1LwkCRf9KeiSTbSscZTa8Ycgrbqo0L8uNy7QtonC0EEXnlOBZiuASBHijWCYAZ5RDIQEsvQ6M9vqy+wj04SSjRxWSM8cBcNWt3Er1xoUa01FbJVrn/Evf1oovLHfAZTRPzfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMYw2Fig; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMYw2Fig;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0Gpl4rfNz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:13:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 274FB43CBC;
	Wed, 15 Jul 2026 00:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E381F000E9;
	Wed, 15 Jul 2026 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074376;
	bh=SDbonQLIoOSfVB1dApPM6LkzNs1SHNxOM+rrSsaUBBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMYw2FigPP7WfHBpvhgZlAhmWy0bpTPXB0dWdx6Sf2hHBsld1RyoxLlCa++abrtsP
	 6EV4GohitQfVk2wKCr8O71Tk0CdeD46bXWbAd2OqoAUCZQKX4FEbqODHs0l9VZXgHA
	 iRubQs5iHitl98Xt++qJSvdKnk6DPP7t4j7rCfrbbuns2ri1g0rNuDJt2wPVOI5RQC
	 Gkks8B8BofuZ3kPdXy6OKqse1ZB5GzONMooax7IYKIEDgxmK9JfdyAwMg8UBJjWMwL
	 te64+fdolGgdSWPyG5+w2q0ZQPCiYtxCHLkkE2gxADmGExi2IMa1LU+wdk/ZFNBGYW
	 n+XWGFINNchSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.18.y 0/6] cBPF JIT spray hardening
Date: Tue, 14 Jul 2026 20:12:40 -0400
Message-ID: <20260714200600.stable0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha


Return-Path: <linuxppc-dev+bounces-23235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5692C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 23:36:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqffQ74Jcz2ygh;
	Wed, 01 Jul 2026 09:35:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782862558;
	cv=none; b=DHIPMk/AegMwkb2kY/AzZlrApscUaIJ6KVsaH89UJyxLCXsoG9ZA/F48E1vjdZ+dq+e0sja96u3dmxvQhASn/NVa0EytSktHEYjXSXLmzN1nwAQE7b8+/LvQV3wSZadgb7sfjTya805Lr0wNfkSIYW20WTY9E85w3V/Y1ttpRRB+FBBOoeBQ5tnEPXnLSjg528QzDP+pZkSWnmrabES94kzqcBsOlBUx1zVN63S08E8d0ni12RZdT3oRE1Uu/zqt32NdKBQVjBi29rWygPwexJdARIdz8YeyciYMcvQwMvR+MlMkkEORyglhQ7AwhNEXYl6QcbfZEIrV/eeG2Yv38w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782862558; c=relaxed/relaxed;
	bh=MVsF4Zq1bqt6PKCqvYty9/BK1F1FZZH1RH6p0K8bIoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BTFIiecAvsTyMcvmyGq50DiOupdNTZtUwZ9RJza2Zq8OWzp0miHNrxveuVAWWxBoYJXgRuIg7b71uu8O0QgdjnJUK5cM2kkQFs6ybZRDrEWt/eu7t4eTxycbN6eafOy/PYo6fxkP4nSS3GR/XqxM8K1jztOI5PdTCfRo1Ai8eYyduvra05HRsOcnzG7hW7MMzhahTY9lbKy/iVUJ89JSfDkahLYDaG86cNjpH3dmrmYPA19N1zlqEbT6VWM0175M7hBYbFcGb1ceZDt+JlvK/ODzTZuUIEui8YFDM0xbzfLCB3UEjjSYrWyjSDqnZQJ23hON3oWr3nCMXd3p8E/VyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEt1WOqG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEt1WOqG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqffP4dVyz2ySD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 09:35:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D75F5408B2;
	Tue, 30 Jun 2026 23:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629C21F00A3A;
	Tue, 30 Jun 2026 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862554;
	bh=MVsF4Zq1bqt6PKCqvYty9/BK1F1FZZH1RH6p0K8bIoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mEt1WOqG5nf3EDsoJk3asrxMyX1r5lH1qRH0aTDR1DpikxsKQ8DRMYkwx8wgsTbFG
	 KRqfs8lBSnFnEixvQjF2HO+7hzXGVnBws3Le/ssz8VgPVFvzOqNsRlZSHS2PuIuKXz
	 ewBrClzoPwKl0iDFLX3KdFh+KgpG1nJA9trmyjt02+RYAfjfYY4iZZLp/p8+kjZZhV
	 +rRsuCKUyufqlNx8Xjx22w4IHEtHxMjIAFWFoHujNGye4AhF7D1QCnDtj891ILnKfQ
	 KD591wB94qixlJaYDgEZUGM2gj/rHipz4qYeSbIQjxnD+Nh3sBpLSb27uUpv16VkEU
	 p9YJnWNzl8c3Q==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 atrajeev@linux.ibm.com, Gautam Menghani <Gautam.Menghani@ibm.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
References: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
Subject: Re: [PATCH v2 1/2] perf script powerpc: Update the hcall list with
 new hcalls
Message-Id: <178286255436.2863034.15766902647466305951.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:54 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 02 Jun 2026 17:26:40 +0530, Gautam Menghani wrote:
> Update the hcall list with the newer hcalls in PPC.
> 
> [1]: github.com/torvalds/linux/blob/master/arch/powerpc/include/asm/hvcall.h
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung




Return-Path: <linuxppc-dev+bounces-22747-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBADCD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 18:48:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggXtn50fdz2xHK;
	Thu, 18 Jun 2026 04:48:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781722113;
	cv=none; b=L7x2er0kHE6baVg7X8n/psG+yV3YCsiE8Qc6FBizqLOyBnvltseQ6xrmovlIvcdV1ixilME+89xaiU6lV1PQrQPE/V2LDDk36Hw7VPkopUQ75sEzzWVZTWv1d4R6OCCPgnXXzI0WroQUz+Y8aMswsdyySZAenHU6eggkamq9euDKvF4vN+XIvii5XMuUAtprR87LdRVr1cfY1hSbqBQSNiOT0itvVhPTJ3P22AV1dMFT+FXwP2/tQCh1rHBbcA3JvU4l/hwajV2ovPq6VauUfmJxBEi9Au9BwsIVlPbqGTfmopbz+B8Z6EopnYv1ul+vBD+2qcBmQRVvPBrSHPmdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781722113; c=relaxed/relaxed;
	bh=wAJ/16SDwjLEOofHEjGBdhyMJ22bR01mfpkTmi9LqFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US6NI+FtdryAHP53PBrYlul0iKAtwwpfbtf8LhJMV5OWhRECMzJvzDfUA6YMGRFNdq2DPtk6xs/x3CXOix1jmJ+02rxXZSUJUs6BgmrOuPKokTLhcKre55ZcnYyJxf5MM9wYiq9H5sUPwxvfyFPSWAraLeE29h/gKQHT06dNBouiUCzZa8S5PEUdFuKg1UXx/wMzSQ5NcZydO5atYKl8hRy6p72ScSRPdJGf5tSRC9cdNERtuXDqJOC/jX/gpxHfW/ZBBt7sHd+mhjTLvamfzMIe3EfTUzqLL4wSMv7ORHq6w4IOBdIom3wxw8Erso5ycInc60doMQvCYW8xogJdOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0jjWACc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0jjWACc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggXtm5KTLz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 04:48:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 10CDD44340;
	Wed, 17 Jun 2026 18:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB851F000E9;
	Wed, 17 Jun 2026 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781722108;
	bh=wAJ/16SDwjLEOofHEjGBdhyMJ22bR01mfpkTmi9LqFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S0jjWACcAyI73k4vozNk2hdrYq1Z/OE/QQr/fRC/3Fl/wMR6SalSveexvcnvhtP8P
	 sq0k5gKrOkUnhySqDsFacXi4LLQFsE4ZV+6S6Ub2Ztim/SxxqlIirTQTZyDMRypJg5
	 kTkhhdh10kVYN7b1AVsMojdJHHdWirds7fJByCy/bVzEjtn4hCnNqlP4c2Q76E07+J
	 eG9/Y/c55qkexQaoCzKYrj0bGXa4hlplXuQ+cWnkw9qoLKXnMxH0IxuDBclIZDg6JE
	 0jZ9y0rnn+J0b0RDlvVliyoQmsfZfKdlnUO5gBx+frcYJ50r+myYpGn0tA3W9QyChl
	 toG4cYtw/dfLQ==
Date: Wed, 17 Jun 2026 21:48:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, rdunlap@infradead.org, peterz@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, kuba@kernel.org,
	lirongqing@baidu.com, ebiggers@kernel.org, paulmck@kernel.org,
	leitao@debian.org, coxu@redhat.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, osandov@fb.com, jbohac@suse.cz,
	cfsworks@gmail.com, tangyouling@kylinos.cn,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	adityag@linux.ibm.com, liaoyuanhong@vivo.com, seanjc@google.com,
	fuqiang.wang@easystack.cn, ardb@kernel.org, chenjiahao16@huawei.com,
	guoren@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v16 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <ajLr53EK6mJbng-7@kernel.org>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
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
In-Reply-To: <20260608073459.3119290-1-ruanjinjie@huawei.com>

Hi Jinjie,

On Mon, Jun 08, 2026 at 03:34:49PM +0800, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> This patch set is rebased on v7.1-rc1.

Please rebase this set on v7.2-rc1 once that's out.

I'm going to queue it in the liveupdate tree then to expose to the wider
testing.

Meanwhile it would be great to chase riscv and x86 maintainers for acks :)

-- 
Sincerely yours,
Mike.


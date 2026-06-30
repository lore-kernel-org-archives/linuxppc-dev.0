Return-Path: <linuxppc-dev+bounces-23224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F396FC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:50:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqSK84vzTz2yft;
	Wed, 01 Jul 2026 01:50:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782834620;
	cv=none; b=LwaBgyLgGv6BOG10cPYTrojRqgbWxasKvSJzSVuqkK1PVmt4AoZNCECeuG90q7moaRU8xldCkCyjoF1Fhc5xdiIsyt4z2tiH/e0L7Dg8pyOIqmQRfa60WKnUXbH6NH9bzzFyQeN/crmAYkBsFwyPmonwtKgq4uTHGIx4aclaEb+4aWxyVeY0O02R7uqXKS674E6Y7Xuw/EruRlUIYSHjLeId5y4GmVgPfx+sVH+YWFtfaJUsjHtvMAbBExu+6ks8fACtcKLdvYNhlCPYZ34mdsZ5nmQZ0mQXi3KLSdYfDtk8nuHuNiyqb9E/rgbVjlom+TzeOocRGLfj6GoA5hAIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782834620; c=relaxed/relaxed;
	bh=orBYolOiVh8P+Gs6dp8/inZibU5jKERhYsBdgyU7ewg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dkILXXQHQyCnRLyIpcJ3UmlXRKsF/932x94tfG8l6MZ+LKsfyioVnh0fY7gKYW+3GAA+nFeiBU49RNvffdEgtHhJLNB6KGCUK/Nw2o2zM0B3+RW3dYrTia0lneRS/bBeFlUFl//vqjZwJuUMTdNkRSu166DsSRFdVH9f3yusBCwQyp+SFxEwr8vtqsL1JolAdGSV3PNItLkyFErw9InqKIhXo98imK/Od8NC3rfxK1JD/M9txrw9b8EyZfP7GhUjLKeFUg+uEUIHBOl+3JAQ8gJJf/F00edlntEM4jbEFmrBt0R4uCDM7OiVswsVyFzKXoMUW5o18gpKsifomcgagQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYaFsO0F; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYaFsO0F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqSK76j4mz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 01:50:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ED39040314;
	Tue, 30 Jun 2026 15:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272C01F00A3A;
	Tue, 30 Jun 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834617;
	bh=orBYolOiVh8P+Gs6dp8/inZibU5jKERhYsBdgyU7ewg=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=hYaFsO0FH9QTvOvjL+VAVldlJ2YPFGk7Uv9Z6QoYCVHtTYFvz5GLpT1JPoGmvuzja
	 MTy6IgtdK2zMOgBks1ci94yQnYzuxOJiLmpU/slEb508GaEKc1CAdIz3+/Zq6Bt0w9
	 2FVSSC8lyJ1ZeKB8y1XDpUIRQvZEcPOZths6ZliY3SggfKoZOFKnqpC88EFu33XLTW
	 sn6AnFxz4EW0LATrsCAmY8ssBo7Q13rik2AkR7zp8ALgguCfUFUhwRyu2d3NhQu+/K
	 Y2AM6LawUcaWvPp3WCkTdmmqcN+TndJjAv7WwB1TzTqCVHBCGCID2JuhETb5Xb/WQQ
	 rTUnWQuYsWNdQ==
From: Mike Rapoport <rppt@kernel.org>
To: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, 
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
 saravanak@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 rdunlap@infradead.org, peterz@infradead.org, feng.tang@linux.alibaba.com, 
 dapeng1.mi@linux.intel.com, elver@google.com, enelsonmoore@gmail.com, 
 kuba@kernel.org, ebiggers@kernel.org, lirongqing@baidu.com, 
 leitao@debian.org, kees@kernel.org, coxu@redhat.com, cfsworks@gmail.com, 
 jbohac@suse.cz, osandov@fb.com, ryan.roberts@arm.com, 
 tangyouling@kylinos.cn, sourabhjain@linux.ibm.com, ritesh.list@gmail.com, 
 gaohan@iscas.ac.cn, david@kernel.org, wangruikang@iscas.ac.cn, 
 muchun.song@linux.dev, vishal.moola@gmail.com, junhui.liu@pigmoral.tech, 
 guoren@kernel.org, namcao@linutronix.de, rick.p.edgecombe@intel.com, 
 djbw@kernel.org, liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn, 
 vishal.l.verma@intel.com, chenjiahao16@huawei.com, x86@kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, kexec@lists.infradead.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260629094746.191843-1-ruanjinjie@huawei.com>
References: <20260629094746.191843-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH v17 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <178283459765.548295.14688999641870037803.b4-ty@b4>
Date: Tue, 30 Jun 2026 18:49:57 +0300
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
X-Mailer: b4 0.15.2

On Mon, 29 Jun 2026 17:47:36 +0800, Jinjie Ruan wrote:
> arm64/riscv: Add support for crashkernel CMA reservation
> 
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> [...]

Applied to crashkernel-cma branch of liveupdate/linux.git tree, thanks!

[01/10] riscv: kexec_file: Fix crashk_low_res not exclude bug
        commit: 5fc6e7d45373571d03cd04fd4c6069c0a97fa75a
[02/10] powerpc/crash: sort crash memory ranges before preparing elfcorehdr
        commit: 202b5de3ec34317d6a8944239fe227ef8f6853ec
[03/10] crash: Add crash_prepare_headers() to exclude crash kernel memory
        commit: 5beabef0cffaa1ea6e27e85dbd526b7a28e0e7c7
[04/10] arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
        commit: 201b561cbc6c594aa1ef718a1204dd45720d96dd
[05/10] x86/crash: Use crash_prepare_headers() helper to simplify code
        commit: a8f09f2a7485956c3653696f6cb94faadd243645
[06/10] riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
        commit: 7b078a0aa2753dcf5cae88e5349a25ac39998a9b
[07/10] LoongArch: kexec_file: Use crash_prepare_headers() helper to simplify code
        commit: 51ed0950adf05c99e393818887a2616dd4ab3e34
[08/10] powerpc/kexec_file: Use crash_exclude_core_ranges() helper
        commit: b0e06c5a30742bc6bc8523fe9c71c1a043a7661d
[09/10] arm64: kexec_file: Add support for crashkernel CMA reservation
        commit: c12c63d05dfe7088aa8b1b872fe261e25537c823
[10/10] riscv: kexec_file: Add support for crashkernel CMA reservation
        commit: a037fe3c58ed489ca8ad8531bd7e16b90a84badc

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: crashkernel-cma

--
Sincerely yours,
Mike.




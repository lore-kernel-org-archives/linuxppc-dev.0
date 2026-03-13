Return-Path: <linuxppc-dev+bounces-18182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3E2107BCE2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 21:57:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXdcf2Kv7z2yFd;
	Sat, 14 Mar 2026 08:57:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773439026;
	cv=none; b=UIZDi4xTUl3rWT90j+CTvN6KnZExvGnwR1i5Z6gT2LBDLysJynwTy9oD56lX2egmofwyUoXbkUIw8Qj97ZqSRb7Avn9IxB3EDqVYVh9m2A23N9K+aKEfz+ULkeKvfhtULhDRCKXV8kmrqiTcVdgHnT+ppR7ASFnzTKBD3ZRhyvTSLdkTaovQ+PskPbPWesvvLvqnSn8JwJ83/1gTAYg9mIKNqb/NGpQ0qJbRIXk/l241viTw/UT4SD+fwiAMJju5YJZy/n806+7y0ovOhWlalo56YpDCsep7ajkP09FLA+6gIbBAPpnoWL5C7M9spR2CwKvZ0xOzCAbBWlkLFlEZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773439026; c=relaxed/relaxed;
	bh=vLAllxmpQBHyjEZUnJBbo0v6FSDjNIHjm4dscAKVh54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS0DBCamNPoKficNqjb8N+V/g8ILr4mVMI4jVr1Hl4uUUd/QDfPOw3y6lQfw1a6VeSavwWBxvVQ2Z9iycmsPSTJCwzyYBAJHeolz3b1acMXlqpuyW5FaI3SKc/ZE708THL1bfsA5XGKwxaHSVzT460D1lM7Q4b2J0eCt5iaY8EuxACwmWPUQ42yZjTr/C/HlsbCiwcyE96kjHhfHFUovqxCQY5pY9+PYlIIRMF3Vjq9arXPtYQz2uLXNclrsD+jcSY22CqNI2//RCAFleUTEmxGSKUm54hidV9s91Okr+MIS7yP0WAbxLAQDpU7yyJ7OBZ2pou24hrNtVXuU38vgJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D8LFC/Y2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D8LFC/Y2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXdcc6mprz2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 08:57:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FEB56183F;
	Fri, 13 Mar 2026 21:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE5AC19421;
	Fri, 13 Mar 2026 21:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439021;
	bh=BwGIzF3Y1kGJ7LSzEz+7QIlkvRAEX1ybLPLbwYlypHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8LFC/Y2BvExaUUaQwCZ1enN784C4eGC3QLIYlLXoQRLLoZbcIPAW+9UHxunos89u
	 W2FcjOgbPlul4rkrHWNMnWcebVKNCNJBcZAC9W9bHqSllID/Yx8/g7Pg0waFNdbV1F
	 PZkKpvhQhygkjCvndRt4AGAp3O3ce5dB8Hf9tYRkl1Yd2G1/EC1V7ihRTEFOlFWtJD
	 TVRWH74L5h1udZNpGw4w/HeSz46hbFXg77yqFlXWTNDJcGX7icfPbrJEmetdc7x+30
	 MorgajnbJ3XPvDp3w4FMrauooCX4QG0hYbWRVYVLx7aMFlZXvlf6/A/GVpusGs1ME1
	 T/VOcVRh6Fn9Q==
Date: Fri, 13 Mar 2026 16:56:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: loongarch@lists.linux.dev, cfsworks@gmail.com, alex@ghiti.fr,
	skhan@linuxfoundation.org, liaoyuanhong@vivo.com,
	ritesh.list@gmail.com, linux-arm-kernel@lists.infradead.org,
	kees@kernel.org, leitao@debian.org, lirongqing@baidu.com,
	corbet@lwn.net, pmladek@suse.com, jbohac@suse.cz,
	eajames@linux.ibm.com, sourabhjain@linux.ibm.com,
	palmer@dabbelt.com, vishal.moola@gmail.com, npiggin@gmail.com,
	dapeng1.mi@linux.intel.com, brgerst@gmail.com, will@kernel.org,
	paulmck@kernel.org, tglx@kernel.org, rdunlap@infradead.org,
	hbathini@linux.ibm.com, kexec@lists.infradead.org, bhe@redhat.com,
	dyoung@redhat.com, x86@kernel.org, pjw@kernel.org, rppt@kernel.org,
	linux-doc@vger.kernel.org, kernel@xen0n.name,
	dave.hansen@linux.intel.com, catalin.marinas@arm.com,
	saravanak@kernel.org, samuel.holland@sifive.com,
	songshuaishuai@tinylab.org, coxu@redhat.com,
	fuqiang.wang@easystack.cn, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, osandov@fb.com, chenhuacai@kernel.org,
	aou@eecs.berkeley.edu, tangyouling@kylinos.cn, hpa@zytor.com,
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, bp@alien8.de,
	vgoyal@redhat.com, fvdl@google.com, kevin.brodsky@arm.com,
	mingo@redhat.com, maddy@linux.ibm.com, akpm@linux-foundation.org,
	junhui.liu@pigmoral.tech, ardb@kernel.org, mpe@ellerman.id.au,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 4/5] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <177343901948.3415566.6726187926870600451.robh@kernel.org>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
 <20260302035315.3892241-5-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302035315.3892241-5-ruanjinjie@huawei.com>


On Mon, 02 Mar 2026 11:53:14 +0800, Jinjie Ruan wrote:
> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
> 
> Crash kernel memory reservation wastes production resources if too
> large, risks kdump failure if too small, and faces allocation difficulties
> on fragmented systems due to contiguous block constraints. The new
> CMA-based crashkernel reservation scheme splits the "large fixed
> reservation" into a "small fixed region + large CMA dynamic region": the
> CMA memory is available to userspace during normal operation to avoid
> waste, and is reclaimed for kdump upon crash—saving memory while
> improving reliability.
> 
> So extend crashkernel CMA reservation support to arm64. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> arm64 architecture.
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v7:
> - Correct the inclusion of CMA-reserved ranges for kdump
>   kernel in of/kexec.
> v3:
> - Add Acked-by.
> v2:
> - Free cmem in prepare_elf_headers()
> - Add the mtivation.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  arch/arm64/kernel/machine_kexec_file.c          | 2 +-
>  arch/arm64/mm/init.c                            | 5 +++--
>  drivers/of/fdt.c                                | 9 +++++----
>  drivers/of/kexec.c                              | 9 +++++++++
>  5 files changed, 19 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



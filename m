Return-Path: <linuxppc-dev+bounces-29186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24CBCA6017
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 20:01:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2F4F61Fqz2yjp;
	Sun, 11 Oct 2026 07:01:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791662509;
	cv=none; b=Q7+fhQZQLQWRJJbXne39fABNzenLNczE/gCNzFKdN6XXAEopKI+k1pK1FC38QSFOiXt2vXkg299DyqC/+whv7t68KkJvZS6WXtrdmWN/Y2guiYvJQ6/NqcqoO7I7wsm4IG9oyfTXCp7mH4vwFzXpU/mcmML0MUFs623QJAUDCUSCm5k3ktUidhX0O+hkcxISudwvOgj0zwwGhWZU5fc+4n06//gRCwvbgLpJ0LK8WgkTc+XncdKVFLM7DC1AnGggtuaLtR4Q+4UocjTYc7G0nPC43ATzivtoKSDlTKbQ0paiZ1X1M+dnyQrFcvifkYydQL1qHdlY/G3KVfJwOVwmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791662509; c=relaxed/relaxed;
	bh=D5xIJ77nP8pyKk1j4aNr1bPe3m2dUcpcnAVPDVOA+vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnlxeMJpT3btHYTOahD6jRpRTzzh6y3ePqxVPpGuDzKue5zTfqud2Ii4fBTG3r1R0qqdpJ5umCawBN9jDw9/D91UP7disj0fvshTcmRsG0cQRjT/wI2jNwpKc0Lym7tU3KFx2LjDIwRt5+iWm4913FCZ1/NjCBS/d3LDXhCYqR6BL6I3bpiO0cEmmTOG80rW1Ba7VamF5Zx8kIUGyjoPL39HrkQ9glpVANyG0ftV1i5vyyix+jWzhNZmiDCU3dRf4shmYK3GHcWzdgBrRj0Sco89qQjjuIdttTW7wX6r7HRMwjVQFChjWoB61MALPTgYa42kAgV3fUjXAVLZQBEKXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WRSxdsDg; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WRSxdsDg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2F4C37Myz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 07:01:45 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC41E1692;
	Sat, 10 Oct 2026 13:01:08 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A0AC3F882;
	Sat, 10 Oct 2026 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791662472; bh=0ej4w9K2k1nE5MBAzVddXwAyLDwy2dxb36CJ0bopUEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRSxdsDg02jA7Wxmfp7hUM+7z5or2VN4zazCFutQjZjCNRVVo7Znbg22CVLNz7YAi
	 ObuzEMW4ie3Brz5P5fTbQVvsd7oFGit6h9P3YDLOgc08xfbI46WYb8fvEkIjCXqCBo
	 Fa+IHGI5x3Zu1VuORzdk3Muk8yB8P1D4NRA1la+w=
Date: Sat, 10 Oct 2026 21:00:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org,
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
	sshegde@linux.ibm.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, leitao@debian.org, yeoreum.yun@arm.com,
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com,
	kees@kernel.org, tangyouling@kylinos.cn, liukexin@kylinos.cn,
	zhangtianyang@loongson.cn, guodongtai@kylinos.cn,
	maqianga@uniontech.com, chao.gao@intel.com, kai.huang@intel.com,
	vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com,
	thuth@redhat.com, jbouron@amazon.com, me@linux.beauty,
	mclapinski@google.com, graf@amazon.com, bgwin@google.com,
	hbathini@linux.ibm.com, eric.devolder@oracle.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	palmer@rivosinc.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	driver-core@lists.linux.dev, kexec@lists.infradead.org
Subject: Re: [PATCH v6 05/14] arm64: kexec_file: Fix elf_headers memory leak
 in retry loop
Message-ID: <asqZcwg99QbA7Sma@arm.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-6-ruanjinjie@huawei.com>
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
In-Reply-To: <20260921090450.807575-6-ruanjinjie@huawei.com>

On Mon, Sep 21, 2026 at 05:04:41PM +0800, Jinjie Ruan wrote:
> If load_other_segments() fails after image->elf_headers is assigned,
> the memory lifecycle is safely managed by the global kimage object
> and will be freed in arch_kimage_file_post_load_cleanup().
> 
> However, during a retry loop in image_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
> 
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segments fails")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>


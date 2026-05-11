Return-Path: <linuxppc-dev+bounces-20696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B441FCD37B5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 09:49:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDZgn351bz2xlh;
	Mon, 11 May 2026 19:49:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778492965;
	cv=none; b=DU+WyfKVtZa6tZtQm0sSqqQibuWPqamwLp2W5/jJfy8bRG0R6KrTCviDjmq5DIIXgnQKgZPe78QbqbWifz0Lj/JKGqFHwnEB0I5v1iULoaXrQ1AJlRoknTz3tR8CM+gVGmErTkkDCze5546aimXY8b2tmsKldVgLrosiAoFXrAGujon0O0L7MpVMq+QQOmgvZY1Afx42yWX7BDmjEloK+UXyK7F0sBAWabBj/OlQAajlhyv3y9Z8TPIAryzuv4ON6F21LJzfM+MQqsCvR/nEgoaWHLf7MHRZWszFQv9AYDiPW4il2sy+ZeWVLphSYVz0U9wwQGsLQEc/Nscydj/scQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778492965; c=relaxed/relaxed;
	bh=TE+A8gVsi33ADWPRsTq1jFWiY76eVCOBjR9gXM5fMfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOFldLSWnGn857EFHFKCKe0AOqOYT0SG5OUfQVYdzzPkvx9OtA7DCJKjlstDVCqZLK92ljI7mMk8HTaAj1Pm/uuhF6wWQ21LaOo5rhmrIABuJ6baclBnb7H4kQFX4Y05T6SdQ9JQs813nGhAyfIqlfPphnz5Zdj7MNGwKuWOAreuxXxPMmq3IypVr55sulYHZNmth22A0XEMqLeNqWW0jKXea1aKBXipTkiRUiY+DkGlNt9eYDyjunYr7PXrMwJYLVuo2gxHrvajPh6QTgM9As4uuJHFfZl+o0FNsHd3ESpqqQ1MHVwOCOqdHOk7KCQhEJpkwQ4MBV0CmEp7H2YMsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=iJ89i0F6; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=iJ89i0F6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDZgl469Pz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 19:49:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TE+A8gVsi33ADWPRsTq1jFWiY76eVCOBjR9gXM5fMfY=; b=iJ89i0F6NFZsu5G0fxn0HLYT+r
	l0SLLEDLG/yPloRHV0v1HlL5Yc01WpUF7lWffNA1KFgex0k3+bKbm0zzSupULh+T5t4eluweHQo9j
	KONzV42jkP7COLxrhglXtoOrqeqKupykQcuDBWXlXTFdmgrp/0e6EKUyXkYNAaPD5wqH7A75PO6XF
	yxQ5UuXHCKGt/3yK7FkKYGJo+BpAX/OGsR6mPO0bp/LCIi37AD//k/7owe+QOGFpJx+fFlLJM7FPy
	Gn4D99g4S4bjwfYMkgC9jwdc9OCVfhBC8G4M6jOz+mJb7qKKoa9+ZukNTqJvhkRjgX4s1RX0VDpnX
	fPtEV+WQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMNE5-001VdZ-2m;
	Mon, 11 May 2026 09:47:02 +0000
Date: Mon, 11 May 2026 02:46:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, rdunlap@infradead.org, pmladek@suse.com, 
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com, kuba@kernel.org, 
	ebiggers@kernel.org, lirongqing@baidu.com, paulmck@kernel.org, 
	sourabhjain@linux.ibm.com, coxu@redhat.com, jbohac@suse.cz, ryan.roberts@arm.com, 
	osandov@fb.com, cfsworks@gmail.com, tangyouling@kylinos.cn, 
	ritesh.list@gmail.com, adityag@linux.ibm.com, guoren@kernel.org, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, vishal.moola@gmail.com, 
	junhui.liu@pigmoral.tech, wangruikang@iscas.ac.cn, namcao@linutronix.de, 
	chao.gao@intel.com, seanjc@google.com, fuqiang.wang@easystack.cn, ardb@kernel.org, 
	chenjiahao16@huawei.com, hbathini@linux.ibm.com, takahiro.akashi@linaro.org, 
	james.morse@arm.com, lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH v13 04/15] arm64: kexec_file: Fix potential buffer
 overflow in prepare_elf_headers()
Message-ID: <agGkvrg06KNDNfDi@gmail.com>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
 <20260511030454.1730881-5-ruanjinjie@huawei.com>
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
In-Reply-To: <20260511030454.1730881-5-ruanjinjie@huawei.com>
X-Debian-User: leitao

On Mon, May 11, 2026 at 11:04:43AM +0800, Jinjie Ruan wrote:
> There is a race condition between the kexec_load() system call
> (crash kernel loading path) and memory hotplug operations that can
> lead to buffer overflow and potential kernel crash.
> 
> During prepare_elf_headers(), the following steps occur:
> 1. The first for_each_mem_range() queries current System RAM memory ranges
> 2. Allocates buffer based on queried count
> 3. The 2st for_each_mem_range() populates ranges from memblock
> 
> If memory hotplug occurs between step 1 and step 3, the number of ranges
> can increase, causing out-of-bounds write when populating cmem->ranges[].
> 
> This happens because kexec_load() uses kexec_trylock (atomic_t) while
> memory hotplug uses device_hotplug_lock (mutex), so they don't serialize
> with each other.
> 
> Add the explicit bounds checking to prevent out-of-bounds access.

It seems you have a TOCTOU type of issue, and this seems to be shrinking
the window, but not fully solving it?

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
> Closes: https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie%40huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index e31fabed378a..a67e7b1abbab 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -59,6 +59,11 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	cmem->max_nr_ranges = nr_ranges;
>  	cmem->nr_ranges = 0;
>  	for_each_mem_range(i, &start, &end) {
> +		if (cmem->nr_ranges >= cmem->max_nr_ranges) {
> +			ret = -ENOMEM;

-ENOMEM seems to be the the wrong errno. This isn't an allocation
failure; it's a transient race. -EBUSY or -EAGAIN would be more honest


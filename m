Return-Path: <linuxppc-dev+bounces-24834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A48EC531F9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 07:10:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7CYc4dDVz2xyk;
	Sun, 26 Jul 2026 17:10:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785049844;
	cv=none; b=o0XbNlsdOA6EF+8RC9H3oTC+S9qsNynYOmi+MC/Ayx9g33hfiqpKo7B2eCSB00Ijm7/Ll+uNZRyNTW/Ru1N+pbNv2Xo4gMPuGlDrRP7NwDYpvXKGFlh825xzVGx0dc8rTLFBDQ9cmRcfdwVkLGwn+12vjWcGoOs3sfCGlwCkCFEbCpgy2EIIkFzY65wtzI69QY2ER1qDdYspZHYlS/7ZEcFMVTzV9kRETT7GFP+9Fsof68j0yAPOEtyocKw73EM76KjZd/BgkXrENPw1h+LURzesbQfopOej2otE31zvW5ifH7O32J+pEjjitkIG6DN3k9X1sTdabADfaVBoKbhGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785049844; c=relaxed/relaxed;
	bh=spr/SmfOjPmaJI8lzrFOgqnfwsvYYhOk1VLcniRBUcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oupefEX0z5dZeFayvwJfTN1LOs7NAO9P0gQbTVzd280ef02HxxLtoS8qV73ANKJT78nP2L1L1afxOqMr8hB1eMMZ3e5dbnUwKziNC4BpHNg74U102+ucQGz2KIBY/oyXIEQY+rR5BR6cJY+QmaQEQ446GQe4yafnXCMTm6G/nPJt0VE1bHzOaXt2S99hzptDX/D8m8dPz3tUVJMrtEo7rQnVgkgiujrmXjhSyNIVHYz8jKpR/utPn0GakLJJvlMHA4dvrLD7vaFQa7jcwisTvrwhX5jLNGMxV4cIZOgIkU78UvA8nONNNMmarAvqrVjRC4c4tnDQtqAHuEW+rD8gsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBlvMIxQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBlvMIxQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7CYb5sLyz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 17:10:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE63742BA3;
	Sun, 26 Jul 2026 07:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FEE1F000E9;
	Sun, 26 Jul 2026 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785049840;
	bh=spr/SmfOjPmaJI8lzrFOgqnfwsvYYhOk1VLcniRBUcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gBlvMIxQNWBBWE7Se28bgQLzPVqN60xYrY8DlKRT3aGhfXwM8DKtw8In3lCobQ+vh
	 g1alBRmrjg+8NOKIsr6dN74Qz13AjE1dQsVdjl6fwHz7Yb0wOX5eWvws0BGYptghk2
	 i4iSDdK5BoYB+vqxQipvZkJ2hIFjkGWGwrSZ3xFTcOPHJYt4S6nJ/H9u/L0wEKET8U
	 W5MyT1QYk4EwhlkHvjB/+6b9XzbffrdGgMPZjCN0vvyv74t8mMjAWQDBnADVb0bqdK
	 9IHJMRT6viJlszcCge90+kKqr6OeZq16xrvYmvl0Nne/PLbB/VO5iGADt/petKQbvO
	 uuZU1LSBTLg3Q==
Date: Sun, 26 Jul 2026 10:10:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	akpm@linux-foundation.org, baoquan.he@linux.dev,
	pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com,
	vladimir.murzin@arm.com, mark.rutland@arm.com, ardb@kernel.org,
	james.morse@arm.com, leitao@debian.org, yeoreum.yun@arm.com,
	robh@kernel.org, kees@kernel.org, coxu@redhat.com,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	adityag@linux.ibm.com, hbathini@linux.ibm.com, makb@juniper.net,
	piliu@redhat.com, graf@amazon.com, liaoyuanhong@vivo.com,
	jbouron@amazon.com, bauerman@linux.ibm.com, bgwin@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/8] arm64: crash: Add crash hotplug support
Message-ID: <amWy4u9tXoWX6Wtp@kernel.org>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>

Hi Jinjie,

On Thu, Jul 23, 2026 at 09:12:34PM +0800, Jinjie Ruan wrote:
> When CPU or memory hotplug events occur, the elfcorehdr in the kdump image
> becomes stale, potentially leading to incomplete crash dumps.
> 
> Currently, userspace udev rules reload the entire kdump image upon such
> events, which is inefficient and leaves kdump inactive for a long time.
> 
> Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
> support") introduced a kernel mechanism to update only the elfcorehdr.
> This patch set implements crash hotplug support for arm64.
> 
> It also addresses and fixes several critical pre-existing code issues
> and Sashiko AI review findings extracted from the previous patch set,
> following Baoquan's suggestions.
> 
> The major improvements and fixes included in this series are:
> 
> - Fix powerpc memory leak, null-ptr-def and overlapping memory
>   range truncation bug.
> 
> - Fix several memory leaks for arm64.
> 
> - Simplify arm64 load_other_segments().
> 
> - Implement infrastructure for arm64 crash memory hotplug support.
> 
> This patch set is rebased on liveupdate/crashkernel-cma.
> 
> Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> 
> Jinjie Ruan (8):
>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>   powerpc/kexec_file: Fix null-ptr-def in extra size calculation
>   powerpc/kexec_file: Prevent kexec range truncation

It's weird to see powerpc fixes in a series that adds a feature for arm64.
Judging by the subjects, they are completely unrelated to to crash support
for hotplug and should be sent as a separate set.

>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix image->elf_headers memory leak during retry
>     loop
>   arm64: kexec_file: Simplify load_other_segments()
>   arm64: crash: Add crash hotplug support
> 
>  arch/arm64/Kconfig                     |   3 +
>  arch/arm64/include/asm/kexec.h         |  13 +++
>  arch/arm64/kernel/Makefile             |   2 +-
>  arch/arm64/kernel/crash.c              | 148 +++++++++++++++++++++++++
>  arch/arm64/kernel/kexec_image.c        |   1 +
>  arch/arm64/kernel/machine_kexec_file.c |  76 ++++++-------
>  arch/powerpc/kexec/crash.c             |   2 +-
>  arch/powerpc/kexec/file_load_64.c      |   2 +-
>  arch/powerpc/kexec/ranges.c            |  12 +-
>  include/linux/kexec.h                  |   2 +
>  kernel/kexec_core.c                    |  25 +++--
>  11 files changed, 223 insertions(+), 63 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash.c
> 
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.


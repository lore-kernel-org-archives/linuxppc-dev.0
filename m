Return-Path: <SRS0=Ue3/=7K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04420C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 01:05:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2174207CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 01:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="A7fz2X4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2174207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XTy6675SzDqXg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 11:05:02 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XTwD13dDzDqWK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2020 11:03:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=A7fz2X4J; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49XTwB4G0Tz9sRK;
 Thu, 28 May 2020 11:03:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1590627803;
 bh=N/Z40R+KK3M6wyiKZjsa8P/TxBi0+LFYhTsyo1gvTKc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=A7fz2X4Jn/z7PCmN6BPHq89o5QO57U4B3BrvRBG77+sHqWD1fKk76BbL/eG4omIWp
 EkSpNcKmaDKWnZVFWJN2DMAchGRaEZVkFZRlpABlU/3gCgcRubN4hLALIhPOIcWL7m
 Cz2l+2XPkYJ9savJl+QDyInt60UXqb2l08HS1RaLYpFBxRg/nXc3ZY05pvUHnaSxTo
 4tEiTd4boJEjRBkb+aU0auwr5YSIwkFJgyjfkMHcfxkmDLAEG+A8Y3AQmv3LAKI3Cz
 4Zh6IEFX3iJtZW3qs6M0S9GRdMYwL9Y/qM/fnXxZBEyVH+GA2I5DFPLToku8qmn8ID
 8qfjDdBlYmyew==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] powerpc/bpf: Enable bpf_probe_read{,
 str}() on powerpc again
In-Reply-To: <20200527122844.19524-1-pmladek@suse.com>
References: <20200527122844.19524-1-pmladek@suse.com>
Date: Thu, 28 May 2020 11:03:43 +1000
Message-ID: <87ftbkkh00.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Petr Mladek <pmladek@suse.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Brendan Gregg <brendan.d.gregg@gmail.com>, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Petr Mladek <pmladek@suse.com> writes:
> The commit 0ebeea8ca8a4d1d453a ("bpf: Restrict bpf_probe_read{, str}() only
> to archs where they work") caused that bpf_probe_read{, str}() functions
> were not longer available on architectures where the same logical address
> might have different content in kernel and user memory mapping. These
> architectures should use probe_read_{user,kernel}_str helpers.
>
> For backward compatibility, the problematic functions are still available
> on architectures where the user and kernel address spaces are not
> overlapping. This is defined CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
>
> At the moment, these backward compatible functions are enabled only
> on x86_64, arm, and arm64. Let's do it also on powerpc that has
> the non overlapping address space as well.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

This seems like it should have a Fixes: tag and go into v5.7?

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d13b5328ca10..b29d7cb38368 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -126,6 +126,7 @@ config PPC
>  	select ARCH_HAS_MMIOWB			if PPC64
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_PMEM_API
> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
> -- 
> 2.26.2

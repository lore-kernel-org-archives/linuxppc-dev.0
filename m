Return-Path: <linuxppc-dev+bounces-22750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C73CD98E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 00:42:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gghlC0ryYz2xSb;
	Thu, 18 Jun 2026 10:42:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781743351;
	cv=none; b=Og+G7izrcvkdZ615wZ/CUoxY+78VjSuV2vJMJYIB4xOf0rJrZL7rhrVrq/2wJUHmxCsg7pLAvrspltxknYUCybCO7h/Vx8hEh8twSLR3auNF5CTCHditzR7WOXM+tNj5JYLs0i1T7siVN0Cs/z8sdEP6db2ljPj5CNShwwFBJFM93bGn0xYyXeL9A+9ysci7lAJqT+A3mxey+5w6dfsAhzqdCCQ7+38S2MdL3Goz1wnODPd9Jp0C/+sLqF3Jl5D8xOGzLUh1YNtp4AmTceGhVxRxse3FvdAXeMUjDfeEvJqfsaYmap5P/kdcRvygGZrbJBfXGtxNc17UC2XQKwtb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781743351; c=relaxed/relaxed;
	bh=IBHrtVXmPuRWQ7uBhktFTKcch7hAhRcfTxyn7mn7O4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXdxwECPX67XDBn//bUHtOdImPT6tc9LMhAZALEKKsLQ+6+bzXeIh8c4LdYQK3UnvRCiVnSkUfeM67nE3Ggvj3ubp+OixKpU9uEn/PtPejPITXb3dUIznHfE2P9tQW3B9UNFSCo69ZIUYkO+TSdfq2QWcNoVm1VI0our7WcPqpUa8099bippsQWQkdqUKj3ixtFmP8z8D27qPwNajvjzBvsK3Np45xV+9zJlGEO+859q+JJmuZ14eXbmeT2y8zqW+Fxccwg286+u9aaJsIup6Cpk5WoqNJ2B6nq87OLWr3g462URpiRYxi6KbYTBDPmQSPbjzRk0jO2CqQs6uidquA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V9/MYriX; dkim-atps=neutral; spf=pass (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V9/MYriX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gghl60fGPz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 10:42:24 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5878340E01C9;
	Thu, 18 Jun 2026 00:42:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YS4gZm3My4eS; Thu, 18 Jun 2026 00:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781743333; bh=IBHrtVXmPuRWQ7uBhktFTKcch7hAhRcfTxyn7mn7O4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9/MYriXywS0hZanHFwwPwHTRJ7pTlal7SUCalcLgv7ntOufAz/28XqFVfI6uKyYI
	 QOLvxM7ASQ95LAHtjtKQQSW5hRFWqG+Fvm3quBJrqpCYacEpBCfDudcD5TpKxYnvZo
	 jNW2AguPUE125tOpIJbJKnbPZfOdFjNmXWtJtg63elp1Q41omZP/GgbbwBjA8nAloc
	 PfGz8IIVcrme12XEvNdKQ2rv/GJag/unT3FlgXHVllVf0VJmtzm0IKtqLKpvRH2wud
	 N8ImwjHLKfpq4lXe+fjyh782pmKmP87f26PxEGVjPzocmND+8U8oZGxvs6gpq3HXsZ
	 RRdY/zh3823W1VfUzlz9XQHpfyKj3SugSAPLBNINUSipf0eUCFnf/ASD0chGphO2wd
	 33XUogK9sPdnD3sSmcICjzmOBuNMU2bfQmSk8K3+YNoAcCC5j9/trjk57f1Z1l85fX
	 sbPK3s36Q4+q3Rp8+7TUHJs/vXdR8gu2di4PbQr9EcAMuKEYesCn08iPjUwCw7VNCD
	 XvHeVcsZsQz0RLmL5/C1IdWqyRSi8anYr36UHtEYZc5Ih+oxGgNdo8Nwmeh6BJ3ht2
	 tqkphneIWVsqRJSVfAq1ynFwyWUfOHhtgqB+aDCAQiIvDR9Ri+cXHuftygbTEx6Z0P
	 o2dtfp1sQOOLVA3iM8/qRkMM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E63DE40E015B;
	Thu, 18 Jun 2026 00:41:08 +0000 (UTC)
Date: Wed, 17 Jun 2026 17:41:06 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, rppt@kernel.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev, rdunlap@infradead.org,
	peterz@infradead.org, feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com,
	kuba@kernel.org, lirongqing@baidu.com, ebiggers@kernel.org,
	paulmck@kernel.org, leitao@debian.org, coxu@redhat.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, osandov@fb.com,
	jbohac@suse.cz, cfsworks@gmail.com, tangyouling@kylinos.cn,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	adityag@linux.ibm.com, liaoyuanhong@vivo.com, seanjc@google.com,
	fuqiang.wang@easystack.cn, ardb@kernel.org, chenjiahao16@huawei.com,
	guoren@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v16 05/10] x86: kexec_file: Use crash_prepare_headers()
 helper to simplify code
Message-ID: <20260618004106.GCajM-oofpxU2jDsy0@fat_crate.local>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
 <20260608073459.3119290-6-ruanjinjie@huawei.com>
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
In-Reply-To: <20260608073459.3119290-6-ruanjinjie@huawei.com>

On Mon, Jun 08, 2026 at 03:34:54PM +0800, Jinjie Ruan wrote:

> Subject: Re: [PATCH v16 05/10] x86: kexec_file: Use crash_prepare_headers() helper to simplify code

Use proper subject prefix: "x86/crash: ..."

> Use the newly introduced crash_prepare_headers() function to replace
> the existing prepare_elf_headers(), allocate cmem and exclude crash kernel
> memory in the crash core, which reduce code duplication.
> 
> Only the following three architecture functions need to be implemented:
> - arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
>   to pre-count the max number of memory ranges.
> 
> - arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
>   to collect the memory ranges and fills them into cmem.
> 
> - arch_crash_exclude_ranges(). Exclude the low 1M for x86.
> 
> By the way, remove the unused "nr_mem_ranges" in

s/By the way/While at it/

> arch_crash_handle_hotplug_event().
> 
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/x86/kernel/crash.c | 89 +++++------------------------------------
>  1 file changed, 11 insertions(+), 78 deletions(-)

With those nitpicks above addressed:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


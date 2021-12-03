Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89CDC4332F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Dec 2021 19:01:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J5Mcf6PYSz3c7Y
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Dec 2021 06:01:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=cmarinas@kernel.org;
 receiver=<UNKNOWN>)
X-Greylist: delayed 382 seconds by postgrey-1.36 at boromir;
 Sat, 04 Dec 2021 06:01:11 AEDT
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J5Mc775MGz2yph
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Dec 2021 06:01:11 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3BD0F62CA9;
 Fri,  3 Dec 2021 18:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC384C53FCE;
 Fri,  3 Dec 2021 18:54:41 +0000 (UTC)
Date: Fri, 3 Dec 2021 18:54:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH RFC 1/4] mm: percpu: Generalize percpu related config
Message-ID: <Yapn7veWrVvWpskW@arm.com>
References: <20211121093557.139034-1-wangkefeng.wang@huawei.com>
 <20211121093557.139034-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121093557.139034-2-wangkefeng.wang@huawei.com>
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
Cc: linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com, will@kernel.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, mingo@redhat.com,
 dennis@kernel.org, aou@eecs.berkeley.edu, bp@alien8.de,
 paul.walmsley@sifive.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, tsbogend@alpha.franken.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 21, 2021 at 05:35:54PM +0800, Kefeng Wang wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..4ff73299f8a9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1135,6 +1135,10 @@ config NUMA
>  	select GENERIC_ARCH_NUMA
>  	select ACPI_NUMA if ACPI
>  	select OF_NUMA
> +	select HAVE_SETUP_PER_CPU_AREA
> +	select NEED_PER_CPU_EMBED_FIRST_CHUNK
> +	select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	select USE_PERCPU_NUMA_NODE_ID
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>  
> @@ -1151,22 +1155,6 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> -config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> -	depends on NUMA
> -
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_EMBED_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
> -config NEED_PER_CPU_PAGE_FIRST_CHUNK
> -	def_bool y
> -	depends on NUMA
> -
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SPARSEMEM_ENABLE

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

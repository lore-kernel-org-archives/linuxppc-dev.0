Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86486C2BB85
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2024 16:58:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W5NpR1dlhz3dHR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2024 02:58:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W5Nnz2BDRz3cY8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2024 02:57:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EDEAD62789;
	Fri, 21 Jun 2024 16:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F90CC2BBFC;
	Fri, 21 Jun 2024 16:57:36 +0000 (UTC)
Date: Fri, 21 Jun 2024 17:57:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v4 15/29] arm64: handle PKEY/POE faults
Message-ID: <ZnWw_tZZYgpOQVqf@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-16-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-16-joey.gouly@arm.com>
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
Cc: szabolcs.nagy@arm.com, dave.hansen@linux.intel.com, linux-mm@kvack.org, hpa@zytor.com, shuah@kernel.org, maz@kernel.org, x86@kernel.org, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, mingo@redhat.com, naveen.n.rao@linux.ibm.com, will@kernel.org, npiggin@gmail.com, broonie@kernel.org, bp@alien8.de, kvmarm@lists.linux.dev, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, oliver.upton@linux.dev, aneesh.kumar@linux.ibm.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 03, 2024 at 02:01:33PM +0100, Joey Gouly wrote:
> @@ -529,6 +547,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>  	unsigned long addr = untagged_addr(far);
>  	struct vm_area_struct *vma;
> +	bool pkey_fault = false;
> +	int pkey = -1;
>  
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;
> @@ -590,6 +610,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		vma_end_read(vma);
>  		goto lock_mmap;
>  	}
> +
> +	if (fault_from_pkey(esr, vma, mm_flags)) {
> +		vma_end_read(vma);
> +		goto lock_mmap;
> +	}
> +
>  	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
>  	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
>  		vma_end_read(vma);
> @@ -617,6 +643,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		goto done;
>  	}
>  
> +	if (fault_from_pkey(esr, vma, mm_flags)) {
> +		pkey_fault = true;
> +		pkey = vma_pkey(vma);
> +	}

I was wondering if we actually need to test this again. We know the
fault was from a pkey already above but I guess it matches what we do
with the vma->vm_flags check in case it races with some mprotect() call.

> +
>  	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs);

You'll need to rebase this on 6.10-rcX since this function disappeared.

Otherwise the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800ACC48BEB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Feb 2024 12:31:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tbrrp0cCfz3vjG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Feb 2024 23:31:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TbrrL5vRTz3by2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2024 23:30:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E44BB61F7A;
	Fri, 16 Feb 2024 12:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102C3C43394;
	Fri, 16 Feb 2024 12:30:50 +0000 (UTC)
Date: Fri, 16 Feb 2024 12:30:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v6 14/18] arm64/mm: Implement new
 [get_and_]clear_full_ptes() batch APIs
Message-ID: <Zc9VeMJpdpJG9LsH@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-15-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-15-ryan.roberts@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, x86@kernel.org, David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Alistair Popple <apopple@nvidia.com>, Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@redhat.com>, Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 15, 2024 at 10:32:01AM +0000, Ryan Roberts wrote:
> Optimize the contpte implementation to fix some of the
> exit/munmap/dontneed performance regression introduced by the initial
> contpte commit. Subsequent patches will solve it entirely.
> 
> During exit(), munmap() or madvise(MADV_DONTNEED), mappings must be
> cleared. Previously this was done 1 PTE at a time. But the core-mm
> supports batched clear via the new [get_and_]clear_full_ptes() APIs. So
> let's implement those APIs and for fully covered contpte mappings, we no
> longer need to unfold the contpte. This significantly reduces unfolding
> operations, reducing the number of tlbis that must be issued.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

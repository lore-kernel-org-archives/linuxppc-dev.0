Return-Path: <linuxppc-dev+bounces-21919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BEACD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 20:34:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVMyR3M6Vz2xRs;
	Wed, 03 Jun 2026 06:34:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780432495;
	cv=none; b=lv5e63CDMceaHVgupp48ikzGOMBoFOQwm41e6tcwirrUlpEjPZ6ifm659l+TNKgqUWRqVAIteVK4FwZb56QCoSakQ6GAaAwcCNJPvTy5efBc96Ss1QlzCA7+jcoNoc6kkcNhQDUIubjTWqq5coSow5OC8/JRjNSxQ4yLpf4VYk8rA3FTD4nIKB0rmUd/aTYBHs4/3TlRUD/CfV0ySEaGlBXaKKq17RA27+ZcQt9yUmm8N/BBPY+pQZ1wMKnvOCFGkPApqCcbZY5trwq0CVSVZyY5hwzktrpZuDBn5kOlxrmkzsgUvYfN7PSgEVW93EEvNvwN8+IwLQvdM7r1kML8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780432495; c=relaxed/relaxed;
	bh=S//fEDteJ4rzTnDBScY4eGHQWJlVMyyy6h7anmp3x+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdHNeEPU0koovU2Bg2x+OcHyj3JHSXtEJuhxxDlwXcPWlM4FU2YIOY7aiDslnXkdEYH4gKFqCeDpF8FHpu46LV6CCG3eQK0nA8smpaNYePXkC4fUV46MxOArBB+Etm3bnslCYjF1tGGD1JJVs4M18APhyLd4jkSsush3G7ilZBH856WRW57OMn29Brn5TukMeWVAEix0O7ywUmasxvocKyS9zXR0WRcvLfTSFe6eAVi1yh9q9cKYSySbHKKO/VSwM7cFGoKbjdh0J9voSMKGw1XC77HAW2nC5b5Klon6X+0Av+XnUkNlTz6Xe4GfwBJdZSvRf8S52vzHiDx9qU/vdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxfxWfdM; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxfxWfdM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=will@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVMyP42Bjz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 06:34:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 311214174C;
	Tue,  2 Jun 2026 20:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1437C1F00893;
	Tue,  2 Jun 2026 20:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780432490;
	bh=S//fEDteJ4rzTnDBScY4eGHQWJlVMyyy6h7anmp3x+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZxfxWfdMQ3+Vq+Ma03V2QSXlB3XRJ2M5Did8lMtEII0G+3I0Mn+KoGSxk5Mbv0z3I
	 eSifAuVTOlBV98gSsIUbmj8ujq+U/KmlZ/dQP7pUzZjY04CU58Y+sgkwr1wg6evnYM
	 IVoXvJxep7VzxPFXOGANf1mU6ye3Mafv+WmYKvzi7at8qUa+iZFeY7zqiUxCEvZFM/
	 fjusegJTSCUmjBP7CA/qHQtB8wTK8Jc4dadNTvYGMtjatVjBZN4rZEnYKHGBQHPrCt
	 j6I3SYxIA9f1IMqxFo73y3NYXAPu3pvvOvODplkrV/iUNmLrtqWvgusvQ/0MXkcYQw
	 RZn0bqJ/It5Ww==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>,
	Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v7 00/15] arm64: Unmap linear alias of kernel data/bss
Date: Tue,  2 Jun 2026 21:34:36 +0100
Message-ID: <178041415770.4024555.11336437584927054639.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
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
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 17:01:51 +0200, Ard Biesheuvel wrote:
> One of the reasons the lack of randomization of the linear map on arm64
> is considered problematic is the fact that bootloaders adhering to the
> original arm64 boot protocol (i.e., a substantial fraction of all
> Android phones) may place the kernel at the base of DRAM, and therefore
> at the base of the non-randomized linear map. This puts a writable alias
> of the kernel's data and bss regions at a predictable location, removing
> the need for an attacker to guess where KASLR mapped the kernel.
> 
> [...]

It would've been nice to hear from the ppc folks on patch 11, but I've
picked it up on the assumption that they'll love the negative diff stat.
Worst case, we can drop/revert stuff if they have late objections.

Applied to arm64 (for-next/mm), thanks!

[01/15] arm64: mm: Remove bogus stop condition from map_mem() loop
        https://git.kernel.org/arm64/c/36ca7f4be809
[02/15] arm64: mm: Drop redundant pgd_t* argument from map_mem()
        https://git.kernel.org/arm64/c/2e527667a3b9
[03/15] arm64: mm: Check for pud_/pmd_set_huge() failures on kernel mappings
        https://git.kernel.org/arm64/c/8dd640d9233d
[04/15] arm64: mm: Preserve existing table mappings when mapping DRAM
        https://git.kernel.org/arm64/c/a64293e993f6
[05/15] arm64: mm: Preserve non-contiguous descriptors when mapping DRAM
        https://git.kernel.org/arm64/c/ecda73ae92ca
[06/15] arm64: mm: Permit contiguous descriptors to be manipulated
        https://git.kernel.org/arm64/c/05c5c31e9d8d
[07/15] arm64: kfence: Avoid NOMAP tricks when mapping the early pool
        https://git.kernel.org/arm64/c/dfd73e574d38
[08/15] arm64: mm: Permit contiguous attribute for preliminary mappings
        https://git.kernel.org/arm64/c/28becb2c1d74
[09/15] arm64: Move fixmap and kasan page tables to end of kernel image
        https://git.kernel.org/arm64/c/382a03e12eba
[10/15] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
        https://git.kernel.org/arm64/c/d672a4b72c95
[11/15] powerpc/code-patching: Avoid r/w mapping of the zero page
        https://git.kernel.org/arm64/c/c0693153fb17
[12/15] sh: Drop cache flush of the zero page at boot
        https://git.kernel.org/arm64/c/99bad3e992e2
[13/15] mm: Make empty_zero_page[] const
        https://git.kernel.org/arm64/c/0aae825f1ed7
[14/15] arm64: mm: Map the kernel data/bss read-only in the linear map
        https://git.kernel.org/arm64/c/f2ba877402e5
[15/15] arm64: mm: Unmap kernel data/bss entirely from the linear map
        https://git.kernel.org/arm64/c/63e0b6a5b693

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


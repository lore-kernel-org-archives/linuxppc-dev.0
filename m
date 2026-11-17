Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F8606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/ijzxwQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTL583vJXz2xnZ;
	Tue, 17 Nov 2026 21:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794910060;
	cv=none; b=ddTCjJ5Jid8CB7M7mCtOE/8E6D4OdV9HEcRzhzn8On6MnknfsmAtY7SdGpHNIpXRmyHzH1IemtmiA73BrsEIL15oueNftU7B0azQZuj+QxKbs8lSyP5wSrvILLNdQyC4orLx4roVDFidv3Lnvq3Mc1JlZVYh/6YUI5uIMQ6JISNoQeOMKpVPP4oTgv6yjvwbuGYZJWVxUG2OTPjtu0FzzsADtOaNNHttVgl8D8zVE3cNlhL5dM9earN4ZxkALISS9Ic8UysKoyk4xNsIjwGu8I6oywMYGKrJBNT9EoNj/o7F5lpqe8cg5BsV0j8Xm8kJB4XrMfGKgVpcpUh5BoQ8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794910060; c=relaxed/relaxed;
	bh=bxF8qOjp6vNnHdNjUJYc2p7+hCu25MaSOgalSgx9SVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T11d9+PC8AaALVAyeFGLrLaZr1LEHYoS1nYOJoXpI5/RoM6aWBlVfIoAAdpHo5ipChvMtgTAEcuRvn3iI8ogiXJIk+9Pupar93b82RutDLqBbMesX2JvZZ3Shp9F0U3XXBff3cGhYj88T9L6ykEbYEOMs0VarzAZaEboT7YyK/X1CPFm0SZmDlgVGZw73cxTMmbNgEwKNe/hVNUXrGeUnepLfmr+hmNMjq/c1eIItaG3bR96HipU5w/RsHFiwspPqdvK8YDTNnDWNwQwY0mNhf6fqKUov+sJSWYGB8qWsk0+jzlgnQR8WtLiOb4ztZbY3B66KlihdOjnfojJ0myyuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/ijzxwQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/ijzxwQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTL571zB2z2xly
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 21:07:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 529D8628E1;
	Tue, 17 Nov 2026 10:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638F41F000C5;
	Tue, 17 Nov 2026 10:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910057;
	bh=bxF8qOjp6vNnHdNjUJYc2p7+hCu25MaSOgalSgx9SVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l/ijzxwQfcB+E2ocstph6eagwrpNqABEfE7SvWSCOkDKaUalJtZdDmiAgLI2bJoaE
	 CtC6S1E5swy7wP86FmjYf1ioj8udPqnMn25Iqjhp9sfCMmBsUF7l686s06ksbXhONk
	 j5SrmpfasYM7nlnNPG6KxnGdoWyyI3ZUQ0U66uLEK232hFRTEhm0UELjKeYCoNf0qg
	 CJJX4Y6+9vkc6r15BapCVJyj5xukbfCRqte5s1XC4rkuaCV3Tn1PI/15a9jSTtvU8y
	 QDKg3RAO1MSO7fHT96seDCFonUjcAzGnArvi3F1j4T54NmNJoKmbCyFa0DnrnEdXUq
	 pGXMHHxTAPzRw==
Message-ID: <badc4186-b60b-46a9-ab75-ea85ee6965b8@kernel.org>
Date: Tue, 17 Nov 2026 11:07:27 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] mm: highmem cleanups
To: Arnd Bergmann <arnd@kernel.org>, linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Linus Walleij <linusw@kernel.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Malin Jonsson <malin.jonsson@est.tech>, Matthew Wilcox
 <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Nishanth Menon <nm@ti.com>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20261116124832.662455-1-arnd@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 13:48, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is an updated series from what I posted last year [1] and
> last week[2].
> 
> At LPC 2025 [3], we got rough consensus on the plan to keep the
> funcationality present for the time being but instead reduce the scope
> of highmem in the kernel as much as we can without hurting users.
> 
> The short summary is a three stage process:
> 
>  1. Nudge users towards using a larger lowmem zone with the
>     CONFIG_VMSPLIT_* options if at all possible.
> 
>  2. Drop most __GFP_HIGHMEM allocations and corresponding kmap()
>     calls from the kernel, leaving only the subset that is likely
>     to contain the majority of the actual allocations.
>     Specifically we will keep anonymous and regular file backed
>     user mappings, zsmalloc, and huge pages.
> 
>  3. In a few years, also drop the page cache allocations and leave
>     perhaps only zsmalloc using a much simpler interface.  I suggested
>     five years as the time until we do this, but the timing depends a
>     lot on how the first two stages work out in practice, and how long
>     the remaining highmem users plan to keep updating their kernels.
> 
> This series implements stage 1, mostly using Kconfig changes to the
> default settings but leaving the traditional behavior as a CONFIG_EXPERT
> choice in Kconfig. With the new defaults, most installations that use
> highmem today with 1 GiB or 2 GiB of system RAM will see all of their
> RAM in the lowmem zone after upgrading their kernels. My estimate is
> that instead of 80% to 90% of maintained embedded 32-bit systems, this
> should cover over 98%.
> 
> As I don't actually have hardware in the category that still needs
> highmem, I tested this using a qemu-system for Armv7 and PPC6xx running a
> Debian userland with all combinations of VMSPLIT and HIGHMEM options. I
> ran some kernel builds on the Arm guest to ensure that the new options
> don't cause functional or performance regressions for regular workloads
> that don't exceed the virtual address space. I also ran some tests
> with Firefox and was positively surprised to see that this still works
> on the VMSPLIT_2G_OPT configuration without highmem, though it gets
> close to both the address space and lowmem size limits.
> 
> The change to use VMSPLIT_3G_OPT by default on Armv5 means that I could
> include a patch to no longer support highmem at all on VIVT caches,
> as suggested by Jason Gunthorpe. I also included the patch to drop
> HIGHPTE support now, as suggested by David Hildenbrand.
> 
> The patches from this series are available in [4] for testing.
> 
> Once there are no further concerns about the contents, I would
> suggest merging this through the asm-generic tree, as it touches
> mostly architecture specific code and that is not easily split
> from the core mm/* code. Merging everything through the mm
> tree would of course also work.
> 
>      Arnd
> 
> [1] https://lore.kernel.org/all/20251219161559.556737-1-arnd@kernel.org/  # v1
> [2] https://lore.kernel.org/all/20261112112528.1116405-1-arnd@kernel.org/ # v2
> [3] https://lwn.net/Articles/1051010/
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=highmem-7.4
> 
> Changes since v2:
> 
>  - Add preparation patch for Arm PXA [sashiko-bot] 
>  - Add preparation patch for powerpc32/kvm [sashiko-bot]
>  - Fix Arm ARCH_MMAP_RND_BITS_MAX calculation [sashiko-bot]
>  - Simplification for pte_alloc_one() [Mike Rapoport]
>  - Drop stale references to highpte [David Hildenbrand]
>  - improve __print_bad_page_map_pgtable()
>  - Split out Arm changes for CONFIG_VMSPLIT_2G_OPT
> 
> Changes since v1:
>  - rebase to v7.4-rc
>  - add patch to drop highpte
> 
> Arnd Bergmann (10):
>   ARM: remove support for highmem on VIVT
>   ARM: drop CONFIG_HIGHPTE support
>   ARM: pxa: support arbitrary PAGE_OFFSET
>   powerpc: kvm: allow flexible PAGE_OFFSET
>   arch/*: increase lowmem size to avoid highmem use
>   ARM: add CONFIG_VMSPLIT_2G_OPT option
>   ARM: defconfig: turn off highmem in favor of CONFIG_VMSPLIT_2G_OPT
>   mm: remove ARCH_NEEDS_KMAP_HIGH_GET
>   mm: drop HIGHPTE support altogether
>   mm: print pte in __print_bad_page_map_pgtable()
> 
>  arch/arm/Kconfig                            |  27 +++---
>  arch/arm/configs/aspeed_g5_defconfig        |   3 +-
>  arch/arm/configs/gemini_defconfig           |   1 -
>  arch/arm/configs/lpae.config                |   1 +
>  arch/arm/configs/multi_v5_defconfig         |   1 -
>  arch/arm/configs/multi_v7_defconfig         |   1 +
>  arch/arm/configs/mvebu_v5_defconfig         |   1 -
>  arch/arm/configs/omap2plus_defconfig        |   1 +
>  arch/arm/configs/u8500_defconfig            |   1 -
>  arch/arm/configs/vt8500_v6_v7_defconfig     |   2 -
>  arch/arm/include/asm/highmem.h              |  56 +----------
>  arch/arm/include/asm/pgalloc.h              |  13 +--
>  arch/arm/mach-omap2/Kconfig                 |   1 -
>  arch/arm/mach-pxa/pxa3xx.c                  |   2 +-
>  arch/arm/mm/cache-feroceon-l2.c             |  31 +-----
>  arch/arm/mm/cache-xsc3l2.c                  |  47 +--------
>  arch/arm/mm/dma-mapping.c                   |  12 +--
>  arch/arm/mm/flush.c                         |  19 +---
>  arch/microblaze/Kconfig                     |   9 +-
>  arch/microblaze/configs/mmu_defconfig       |   1 -
>  arch/powerpc/Kconfig                        |  24 +++--
>  arch/powerpc/configs/44x/akebono_defconfig  |   1 -
>  arch/powerpc/configs/85xx/ksi8560_defconfig |   1 -
>  arch/powerpc/configs/85xx/stx_gp3_defconfig |   1 -
>  arch/powerpc/kvm/book3s_32_sr.S             |   4 +-
>  arch/powerpc/kvm/booke_interrupts.S         |   4 +-
>  arch/powerpc/kvm/e500_mmu_host.c            |   3 +-
>  arch/x86/Kconfig                            |   4 +-
>  include/linux/hugetlb.h                     |   5 +-
>  include/linux/mm.h                          |   1 -
>  include/linux/pgtable.h                     |  13 ---
>  mm/highmem.c                                | 100 ++------------------
>  mm/memory.c                                 |  21 ++--
>  mm/pgtable-generic.c                        |  25 +++--
>  mm/userfaultfd.c                            |   6 +-

I can pick up the MM patches after the ARM stuff upstream, or the MM patches can
go upstream in the same go as the ARM stuff.

I don't expect conflicts in that area.

Just let me know what you+people prefer.

-- 
Cheers,

David


Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDX8q5DGGzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 11:44:43 +1000 (AEST)
Date: Wed, 17 Aug 2016 11:44:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build warnings after merge of the kbuild tree
Message-ID: <20160817114443.67675413@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) produced these warnings:

WARNING: 25 bad relocations
c000000000cf2570 R_PPC64_ADDR64    __crc___arch_hweight16
c000000000cf2578 R_PPC64_ADDR64    __crc___arch_hweight32
c000000000cf2580 R_PPC64_ADDR64    __crc___arch_hweight64
c000000000cf2588 R_PPC64_ADDR64    __crc___arch_hweight8
c000000000cf2678 R_PPC64_ADDR64    __crc___bswapdi2
c000000000cf2690 R_PPC64_ADDR64    __crc___clear_user
c000000000cf26b8 R_PPC64_ADDR64    __crc___copy_tofrom_user
c000000000cf2728 R_PPC64_ADDR64    __crc___csum_partial
c000000000cf3f90 R_PPC64_ADDR64    __crc_copy_page
c000000000cf40e0 R_PPC64_ADDR64    __crc_csum_partial_copy_generic
c000000000cf4100 R_PPC64_ADDR64    __crc_current_stack_pointer
c000000000cf4928 R_PPC64_ADDR64    __crc_empty_zero_page
c000000000cf4db0 R_PPC64_ADDR64    __crc_flush_dcache_range
c000000000cf4dc0 R_PPC64_ADDR64    __crc_flush_icache_range
c000000000cf6470 R_PPC64_ADDR64    __crc_load_fp_state
c000000000cf6488 R_PPC64_ADDR64    __crc_load_vr_state
c000000000cf68d0 R_PPC64_ADDR64    __crc_memchr
c000000000cf68e0 R_PPC64_ADDR64    __crc_memcmp
c000000000cf68e8 R_PPC64_ADDR64    __crc_memcpy
c000000000cf6900 R_PPC64_ADDR64    __crc_memmove
c000000000cf6988 R_PPC64_ADDR64    __crc_memset
c000000000cf9328 R_PPC64_ADDR64    __crc_store_fp_state
c000000000cf9330 R_PPC64_ADDR64    __crc_store_vr_state
c000000000cf93d0 R_PPC64_ADDR64    __crc_strncmp
c000000000cf93d8 R_PPC64_ADDR64    __crc_strncpy

Introduced by commit

  9445aa1a3062 ("ppc: move exports to definitions")

I have reverted that commit for today.

[cc-ing the ppc guys for clues - also involved is commit

  22823ab419d8 ("EXPORT_SYMBOL() for asm")
]

-- 
Cheers,
Stephen Rothwell

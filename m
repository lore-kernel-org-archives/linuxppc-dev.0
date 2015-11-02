Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DCC11A03E1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 20:41:31 +1100 (AEDT)
In-Reply-To: <1445426953-15934-1-git-send-email-kda@linux-powerpc.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org
Subject: Re: [v2] powerpc/msi: fix section mismatch warning
Message-Id: <20151102094131.4C7E4140F95@ozlabs.org>
Date: Mon,  2 Nov 2015 20:41:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-21-10 at 11:29:13 UTC, Denis Kirjanov wrote:
> Building with CONFIG_DEBUG_SECTION_MISMATCH
> gives the following warning:
> 
> WARNING: vmlinux.o(.text+0x41fa8): Section mismatch in reference from
> the function .msi_bitmap_alloc() to the function
> .init.text:.memblock_virt_alloc_try_nid()
> The function .msi_bitmap_alloc() references
> the function __init .memblock_virt_alloc_try_nid().
> This is often because .msi_bitmap_alloc lacks a __init
> annotation or the annotation of .memblock_virt_alloc_try_nid is wrong.
> 
> memory allocation in msi_bitmap_alloc use either slab allocator or
> memblock boot-time allocator so that's why we need the __init_refok
> for the latter case.
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ccde64b51b33821159d52b09

cheers

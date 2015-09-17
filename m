Return-Path: <catalin.marinas@arm.com>
Received: from eu-smtp-delivery-143.mimecast.com
 (eu-smtp-delivery-143.mimecast.com [207.82.80.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407A41A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 19:25:45 +1000 (AEST)
Date: Thu, 17 Sep 2015 10:25:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: msi: mark bitmap with kmemleak_not_leak()
Message-ID: <20150917092539.GJ25444@e104818-lin.cambridge.arm.com>
References: <1442431574-4575-1-git-send-email-kda@linux-powerpc.org>
MIME-Version: 1.0
In-Reply-To: <1442431574-4575-1-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset=WINDOWS-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 16, 2015 at 10:26:14PM +0300, Denis Kirjanov wrote:
> During the MSI bitmap test on boot kmemleak spews the following trace:
>=20
> unreferenced object 0xc00000016e86c900 (size 64):
>     comm "swapper/0", pid 1, jiffies 4294893173 (age 518.024s)
>     hex dump (first 32 bytes):
> =0900 00 01 ff 7f ff 7f 37 00 00 00 00 00 00 00 00
> =09.......7........
> =09ff ff ff ff ff ff ff ff 01 ff ff ff ff
> =09ff ff ff
> =09................
> =09backtrace:
> =09[<c00000000003eebc>] .zalloc_maybe_bootmem+0x3c/0x380
> =09[<c000000000042d6c>] .msi_bitmap_alloc+0x3c/0xb0
> =09[<c000000000a9aff8>] .msi_bitmap_selftest+0x30/0x2b4
> =09[<c0000000000090f4>] .do_one_initcall+0xd4/0x270
> =09[<c000000000a8e250>] .kernel_init_freeable+0x1a0/0x280
> =09[<c000000000009b5c>] .kernel_init+0x1c/0x120
> =09[<c000000000007fbc>] .ret_from_kernel_thread+0x58/0x9c
>=20
> Added a flag to msi_bitmap for tracking allocations
> from slab and memblock so we can properly free/handle
> memory in msi_bitmap_free().
>=20
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

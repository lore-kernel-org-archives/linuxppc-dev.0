Return-Path: <catalin.marinas@arm.com>
Received: from eu-smtp-delivery-143.mimecast.com
 (eu-smtp-delivery-143.mimecast.com [146.101.78.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C03021A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 19:15:37 +1000 (AEST)
Date: Mon, 14 Sep 2015 10:15:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: msi: mark bitmap with kmemleak_not_leak()
Message-ID: <20150914091529.GC22991@e104818-lin.cambridge.arm.com>
References: <1442169397-4271-1-git-send-email-kda@linux-powerpc.org>
 <1442210677.8149.1.camel@ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <1442210677.8149.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=WINDOWS-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2015 at 04:04:37PM +1000, Michael Ellerman wrote:
> On Sun, 2015-09-13 at 21:36 +0300, Denis Kirjanov wrote:
> > During the MSI bitmap test on boot kmemleak spews the following trace:
> >=20
> > unreferenced object 0xc00000016e86c900 (size 64):
> >     comm "swapper/0", pid 1, jiffies 4294893173 (age 518.024s)
> >     hex dump (first 32 bytes):
> > =0900 00 01 ff 7f ff 7f 37 00 00 00 00 00 00 00 00
> > =09.......7........
> > =09ff ff ff ff ff ff ff ff 01 ff ff ff ff ff ff ff
> > =09................
> > =09backtrace:
> > =09[<c00000000003eebc>] .zalloc_maybe_bootmem+0x3c/0x380
> > =09[<c000000000042d6c>] .msi_bitmap_alloc+0x3c/0xb0
> > =09[<c000000000a9aff8>]
> > =09.msi_bitmap_selftest+0x30/0x2b4
> > =09[<c0000000000090f4>]
> > =09.do_one_initcall+0xd4/0x270
> > =09[<c000000000a8e250>]
> > =09.kernel_init_freeable+0x1a0/0x280
> > =09[<c000000000009b5c>]
> > =09.kernel_init+0x1c/0x120
> > =09[<c000000000007fbc>]
> > =09.ret_from_kernel_thread+0x58/0x9c
> >=20
> > The comment in msi_bitmap_free() states that we can't free
> > the bitmap so mark it with the kmemleak_not_leak().
>=20
> Yeah, and I've always hated that comment :)
>=20
> I assume it's still true now that we don't use bootmem?

If it's not bootmem, it's probably memblock. Looking at the code, it
seems that msi_bitmap_free() cannot make the distinction between a slab
allocation and a bootmem/memblock one (allocated via
zalloc_maybe_bootmem).

You could add some flag to struct msi_bitmap based on mem_init_done to
be able to reclaim some slab memory later. If the bitmap is small and
such allocation doesn't happen outside boot, it may not be worth the
effort.

--=20
Catalin

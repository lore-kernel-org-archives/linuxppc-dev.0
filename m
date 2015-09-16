Return-Path: <catalin.marinas@arm.com>
Received: from eu-smtp-delivery-143.mimecast.com
 (eu-smtp-delivery-143.mimecast.com [207.82.80.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420E21A0272
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 20:46:22 +1000 (AEST)
Date: Wed, 16 Sep 2015 11:46:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: msi: mark bitmap with kmemleak_not_leak()
Message-ID: <20150916104616.GD25444@e104818-lin.cambridge.arm.com>
References: <1442337248-4295-1-git-send-email-kda@linux-powerpc.org>
MIME-Version: 1.0
In-Reply-To: <1442337248-4295-1-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset=WINDOWS-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2015 at 08:14:08PM +0300, Denis Kirjanov wrote:
> diff --git a/arch/powerpc/include/asm/msi_bitmap.h b/arch/powerpc/include=
/asm/msi_bitmap.h
> index 97ac3f4..9a1d2fb 100644
> --- a/arch/powerpc/include/asm/msi_bitmap.h
> +++ b/arch/powerpc/include/asm/msi_bitmap.h
> @@ -19,6 +19,7 @@ struct msi_bitmap {
>  =09unsigned long=09=09*bitmap;
>  =09spinlock_t=09=09lock;
>  =09unsigned int=09=09irq_count;
> +=09bool=09=09bitmap_from_slab;

Nitpick: same alignment for bitmap_from_slab with irq_count etc. (unless
it's just my mail client).

>  };
> =20
>  int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num);
> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_b=
itmap.c
> index 73b64c7..305ebe3 100644
> --- a/arch/powerpc/sysdev/msi_bitmap.c
> +++ b/arch/powerpc/sysdev/msi_bitmap.c
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/bitmap.h>
> +#include <linux/bootmem.h>
>  #include <asm/msi_bitmap.h>
>  #include <asm/setup.h>
> =20
> @@ -122,7 +123,12 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigne=
d int irq_count,
>  =09size =3D BITS_TO_LONGS(irq_count) * sizeof(long);
>  =09pr_debug("msi_bitmap: allocator bitmap size is 0x%x bytes\n", size);
> =20
> -=09bmp->bitmap =3D zalloc_maybe_bootmem(size, GFP_KERNEL);
> +=09if (slab_is_available()) {
> +=09=09bmp->bitmap =3D kzalloc(size, GFP_KERNEL);
> +=09=09bmp->bitmap_from_slab =3D true;
> +=09} else
> +=09=09bmp->bitmap =3D memblock_virt_alloc(size, 0);

I don't think bmp->bitmap_from_slab is always initialised, so you need
to explicitly set it to false here.

> +
>  =09if (!bmp->bitmap) {
>  =09=09pr_debug("msi_bitmap: ENOMEM allocating allocator bitmap!\n");
>  =09=09return -ENOMEM;
> @@ -138,7 +144,8 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned=
 int irq_count,
> =20
>  void msi_bitmap_free(struct msi_bitmap *bmp)
>  {
> -=09/* we can't free the bitmap we don't know if it's bootmem etc. */
> +=09if (bmp->bitmap_from_slab)
> +=09=09kfree(bmp->bitmap);
>  =09of_node_put(bmp->of_node);
>  =09bmp->bitmap =3D NULL;
>  }
> @@ -200,11 +207,11 @@ static void __init test_basics(void)
>  =09WARN_ON(rc < 0 && rc % 128 !=3D 0);
> =20
>  =09msi_bitmap_free(&bmp);
> +=09if (!bmp.bitmap_from_slab)
> +=09=09kmemleak_not_leak(bmp.bitmap);

As I mentioned in the other thread, I think you can call
kmemleak_not_leak() immediately after memblock_virt_alloc() (together
with a comment that this is never going to be freed). That would match
the other kmemleak API uses throughout the kernel.

--=20
Catalin

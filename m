Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B3561A034F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 20:57:12 +1000 (AEST)
Received: by ykdt18 with SMTP id t18so194278323ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 03:57:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150916104616.GD25444@e104818-lin.cambridge.arm.com>
References: <1442337248-4295-1-git-send-email-kda@linux-powerpc.org>
 <20150916104616.GD25444@e104818-lin.cambridge.arm.com>
Date: Wed, 16 Sep 2015 13:57:09 +0300
Message-ID: <CAOJe8K2gHDopLjrxMZue+T7NcHbA7D+NyHw6kn6QLpwPkim7hQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: msi: mark bitmap with kmemleak_not_leak()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/16/15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Sep 15, 2015 at 08:14:08PM +0300, Denis Kirjanov wrote:
>> diff --git a/arch/powerpc/include/asm/msi_bitmap.h
>> b/arch/powerpc/include/asm/msi_bitmap.h
>> index 97ac3f4..9a1d2fb 100644
>> --- a/arch/powerpc/include/asm/msi_bitmap.h
>> +++ b/arch/powerpc/include/asm/msi_bitmap.h
>> @@ -19,6 +19,7 @@ struct msi_bitmap {
>>  	unsigned long		*bitmap;
>>  	spinlock_t		lock;
>>  	unsigned int		irq_count;
>> +	bool		bitmap_from_slab;
>
> Nitpick: same alignment for bitmap_from_slab with irq_count etc. (unless
> it's just my mail client).
>
>>  };
>>
>>  int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num);
>> diff --git a/arch/powerpc/sysdev/msi_bitmap.c
>> b/arch/powerpc/sysdev/msi_bitmap.c
>> index 73b64c7..305ebe3 100644
>> --- a/arch/powerpc/sysdev/msi_bitmap.c
>> +++ b/arch/powerpc/sysdev/msi_bitmap.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/kernel.h>
>>  #include <linux/bitmap.h>
>> +#include <linux/bootmem.h>
>>  #include <asm/msi_bitmap.h>
>>  #include <asm/setup.h>
>>
>> @@ -122,7 +123,12 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned
>> int irq_count,
>>  	size = BITS_TO_LONGS(irq_count) * sizeof(long);
>>  	pr_debug("msi_bitmap: allocator bitmap size is 0x%x bytes\n", size);
>>
>> -	bmp->bitmap = zalloc_maybe_bootmem(size, GFP_KERNEL);
>> +	if (slab_is_available()) {
>> +		bmp->bitmap = kzalloc(size, GFP_KERNEL);
>> +		bmp->bitmap_from_slab = true;
>> +	} else
>> +		bmp->bitmap = memblock_virt_alloc(size, 0);
>
> I don't think bmp->bitmap_from_slab is always initialised, so you need
> to explicitly set it to false here.

Oops, right.

>
>> +
>>  	if (!bmp->bitmap) {
>>  		pr_debug("msi_bitmap: ENOMEM allocating allocator bitmap!\n");
>>  		return -ENOMEM;
>> @@ -138,7 +144,8 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned
>> int irq_count,
>>
>>  void msi_bitmap_free(struct msi_bitmap *bmp)
>>  {
>> -	/* we can't free the bitmap we don't know if it's bootmem etc. */
>> +	if (bmp->bitmap_from_slab)
>> +		kfree(bmp->bitmap);
>>  	of_node_put(bmp->of_node);
>>  	bmp->bitmap = NULL;
>>  }
>> @@ -200,11 +207,11 @@ static void __init test_basics(void)
>>  	WARN_ON(rc < 0 && rc % 128 != 0);
>>
>>  	msi_bitmap_free(&bmp);
>> +	if (!bmp.bitmap_from_slab)
>> +		kmemleak_not_leak(bmp.bitmap);
>
> As I mentioned in the other thread, I think you can call
> kmemleak_not_leak() immediately after memblock_virt_alloc() (together
> with a comment that this is never going to be freed). That would match
> the other kmemleak API uses throughout the kernel.

Ah, ok. Thanks for the review!
>
> --
> Catalin
>
>

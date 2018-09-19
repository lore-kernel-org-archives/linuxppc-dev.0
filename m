Return-Path: <oohall@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FVhp2xwJzDrcY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 16:44:42 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id e14-v6so6835767itf.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 23:44:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a3a97ebf-9a40-db6e-8225-7b9ccf9cfb4b@c-s.fr>
References: <20180918230756.26035-1-joel@jms.id.au>
 <a3a97ebf-9a40-db6e-8225-7b9ccf9cfb4b@c-s.fr>
From: Oliver <oohall@gmail.com>
Date: Wed, 19 Sep 2018 16:44:39 +1000
Message-ID: <CAOSf1CG3bFHNWS8hQVy-VrpfnwjLWBHSrr-c52AMQbsBRqeyZA@mail.gmail.com>
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 3:52 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 19/09/2018 =C3=A0 01:07, Joel Stanley a =C3=A9crit :
>>
>> This partially reverts faa16bc404d72a5 ("lib: Use existing define with
>> polynomial").
>>
>> The cleanup added a dependency on include/linux, which broke the PowerPC
>> boot wrapper/decompresser when KERNEL_XZ is enabled:
>>
>>    BOOTCC  arch/powerpc/boot/decompress.o
>>   In file included from
>> arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>>                   from arch/powerpc/boot/decompress.c:42:
>>   arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>>   linux/crc32poly.h: No such file or directory
>>    #include <linux/crc32poly.h>
>>             ^~~~~~~~~~~~~~~~~~~
>>
>> The powerpc decompressor is a hairy corner of the kernel. Even while
>> building
>> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid
>> including
>> files from include/linux.
>>
>> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> We need to clean up the powerpc boot decompresser but that work will be
>> more involved than we would include in a late -rc. Please consider
>> merging this fix for 4.19. Thanks!
>>
>>   lib/xz/xz_crc32.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
>> index 25a5d87e2e4c..34532d14fd4c 100644
>> --- a/lib/xz/xz_crc32.c
>> +++ b/lib/xz/xz_crc32.c
>> @@ -15,7 +15,6 @@
>>    * but they are bigger and use more memory for the lookup table.
>>    */
>>   -#include <linux/crc32poly.h>
>>   #include "xz_private.h"
>>     /*
>> @@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
>>     XZ_EXTERN void xz_crc32_init(void)
>>   {
>> -       const uint32_t poly =3D CRC32_POLY_LE;
>> +       const uint32_t poly =3D 0xEDB88320;
>
>
> Maybe avoid capital letters ?
>
> What about adding something like the following in xz_private.h instead:
>
> #define CRC32_POLY_LE 0xedb88320

The problem is that it's pulling in linux/crc32poly.h. To support old
systems with a 32bit Open Firmware we boot wrapper we build the boot
wrapper as a 32bit ELF even for a 64 bit kernel. The headers generated
by Kbuild are only valid for the 64bit kernel so we have to avoid
pulling them into the boot wrapper.

> Christophe
>
>>         uint32_t i;
>>         uint32_t j;
>>
>

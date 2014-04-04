Return-Path: <robherring2@gmail.com>
Received: from mail-ve0-x234.google.com (mail-ve0-x234.google.com
 [IPv6:2607:f8b0:400c:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43ACD140080
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Apr 2014 00:00:42 +1100 (EST)
Received: by mail-ve0-f180.google.com with SMTP id jz11so1373545veb.39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Apr 2014 06:00:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <533EA2B0.7080703@monstr.eu>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
 <1396563423-30893-10-git-send-email-robherring2@gmail.com>
 <533EA2B0.7080703@monstr.eu>
Date: Fri, 4 Apr 2014 08:00:38 -0500
Message-ID: <CAL_JsqKFK8YDoODYKg5b8SmDzqdNSS6UvYr3_atzhcL2uR-=rA@mail.gmail.com>
Subject: Re: [PATCH 09/20] of/fdt: create common debugfs
From: Rob Herring <robherring2@gmail.com>
To: Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 4, 2014 at 7:16 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 04/04/2014 12:16 AM, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> Both powerpc and microblaze have the same FDT blob in debugfs feature.
>> Move this to common location and remove the powerpc and microblaze
>> implementations. This feature could become more useful when FDT
>> overlay support is added.
>>
>> This changes the path of the blob from "$arch/flat-device-tree" to
>> "device-tree/flat-device-tree".

[snip]

>> -#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
>> -static struct debugfs_blob_wrapper flat_dt_blob;
>> -
>> -static int __init export_flat_device_tree(void)
>> -{
>> -     struct dentry *d;
>> -
>> -     flat_dt_blob.data = initial_boot_params;
>> -     flat_dt_blob.size = initial_boot_params->totalsize;
>
> As I see even microblaze version was buggy.

How so?

> ...
>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index fa16a91..2085d47 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/string.h>
>>  #include <linux/errno.h>
>>  #include <linux/slab.h>
>> +#include <linux/debugfs.h>
>>
>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>  #ifdef CONFIG_PPC
>> @@ -1084,4 +1085,27 @@ void __init unflatten_and_copy_device_tree(void)
>>       unflatten_device_tree();
>>  }
>>
>> +#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
>> +static struct debugfs_blob_wrapper flat_dt_blob;
>> +
>> +static int __init of_flat_dt_debugfs_export_fdt(void)
>> +{
>> +     struct dentry *d = debugfs_create_dir("device-tree", NULL);
>> +
>> +     if (!d)
>> +             return -ENOENT;
>> +
>> +     flat_dt_blob.data = initial_boot_params;
>> +     flat_dt_blob.size = fdt_totalsize(initial_boot_params);
>
> Have you tried to compile this?
>
> From my tests fdt_totalsize is not available for target just for host
> from libfdt.h
>
> drivers/of/fdt.c: In function 'of_flat_dt_debugfs_export_fdt':
> drivers/of/fdt.c:957:2: error: implicit declaration of function 'fdt_totalsize' [-Werror=implicit-function-declaration]

Ah, it needs to be re-ordered after the libfdt conversion when
libfdt.h gets added.

Rob

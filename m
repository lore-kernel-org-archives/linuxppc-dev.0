Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhXKX2FklzF1K8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:17:04 +1100 (AEDT)
Received: by mail-ua0-x243.google.com with SMTP id 47so14599657uau.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 13:17:04 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <dfdca2f9-bf75-cdd3-e149-f3a30944d4ae@redhat.com>
References: <20180207194439.32680-1-malat@debian.org>
 <dfdca2f9-bf75-cdd3-e149-f3a30944d4ae@redhat.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 14 Feb 2018 22:16:41 +0100
Message-ID: <CA+7wUsxBmw6WToqxpecZZ8vgz6yET5ATTVYkfqv0VLb_SDTWFQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/via-pmu: Fix section mismatch warning
To: Laurent Vivier <lvivier@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2018 at 7:54 PM, Laurent Vivier <lvivier@redhat.com> wrote:
> On 07/02/2018 20:44, Mathieu Malaterre wrote:
>> Remove the __init annotation from pmu_init() to avoid the
>> following warning.
>>
>> WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
>> The variable via_pmu_driver references
>> the function __init pmu_init()
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the variable:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>  drivers/macintosh/via-pmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
>> index 08849e33c567..5f378272d5b2 100644
>> --- a/drivers/macintosh/via-pmu.c
>> +++ b/drivers/macintosh/via-pmu.c
>> @@ -378,7 +378,7 @@ static int pmu_probe(void)
>>       return vias == NULL? -ENODEV: 0;
>>  }
>>
>> -static int __init pmu_init(void)
>> +static int pmu_init(void)
>>  {
>>       if (vias == NULL)
>>               return -ENODEV;
>>
>
> pmu_init() is really an init function only called by another init
> function (adb_init()).
>
> So I think it could be good to let the __init marker.
>
> Did you try:
>
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -198,7 +198,7 @@ static const struct file_operations
> pmu_battery_proc_fops;
>  static const struct file_operations pmu_options_proc_fops;
>
>  #ifdef CONFIG_ADB
> -struct adb_driver via_pmu_driver = {
> +const struct adb_driver via_pmu_driver = {
>         "PMU",
>         pmu_probe,
>         pmu_init,
>
>

Indeed much better !

Thanks

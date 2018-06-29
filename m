Return-Path: <keescook@google.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HVY703PpzF1dk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 07:44:35 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id j68-v6so528613ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 14:44:35 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
References: <20180629185339.GA37582@beast>
 <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 29 Jun 2018 14:44:32 -0700
Message-ID: <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
To: Arnd Bergmann <arnd@arndb.de>
Cc: Anatolij Gustschin <agust@denx.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Fri, Jun 29, 2018 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 29, 2018 at 8:53 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> switches to using a stack size large enough for the saved routine and
>> adds a sanity check.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> This seems particularly nice, not only avoids it the dynamic stack
> allocation, it
> also makes sure the new 0x500 handler doesn't overflow into the 0x600
> exception handler.
>
> It would help to explain how you arrived at that '256 byte' number in
> the changelog though.

Honestly, I just counted instructions, multiplied by 8 and rounded up
to the next nearest power of 2, and the result felt right for giving
some level of flexibility for code growth before tripping the WARN. :P

I'm happy to adjust, of course. :)

-Kees

> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

-Kees

>
>> ---
>>  arch/powerpc/platforms/52xx/mpc52xx_pm.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
>> index 31d3515672f3..b23da85fa73c 100644
>> --- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
>> @@ -117,7 +117,10 @@ int mpc52xx_pm_enter(suspend_state_t state)
>>         u32 intr_main_mask;
>>         void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
>>         unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
>> -       char saved_0x500[mpc52xx_ds_cached_size];
>> +       char saved_0x500[256];
>> +
>> +       if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
>> +               return -ENOMEM;
>>
>>         /* disable all interrupts in PIC */
>>         intr_main_mask = in_be32(&intr->main_mask);



-- 
Kees Cook
Pixel Security

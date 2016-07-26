Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzWKh6Y35zDqdp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 07:22:16 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id r9so2363795ywg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 14:22:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469519945.25630.105.camel@buserror.net>
References: <1469507114-5788-1-git-send-email-andrew.smirnov@gmail.com>
 <1469507114-5788-3-git-send-email-andrew.smirnov@gmail.com>
 <1469519945.25630.105.camel@buserror.net>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 26 Jul 2016 14:22:14 -0700
Message-ID: <CAHQ1cqE+-p00PwYCTA8SkAuqmQ+pkuzDfKJir7s+XR3GBzFZ2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: Convert fsl_rstcr_restart to a reset handler
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 26, 2016 at 12:59 AM, Scott Wood <oss@buserror.net> wrote:
> On Mon, 2016-07-25 at 21:25 -0700, Andrey Smirnov wrote:
>> Convert fsl_rstcr_restart into a function to be registered with
>> register_reset_handler() API and introduce fls_rstcr_restart_register()
>> function that can be added as an initcall that would do aforementioned
>> registration.
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Is there a particular motivation for this (e.g. new handlers you plan to
> register elsewhere)?

I have a MPC8548 based board that which uses, at least for time being,
SBC8548's init code(by claiming compatibility in DT) which has an
external watchdog that implements reset functionality. The driver for
watchdog is just a generic watchdog driver and having an ability to
register custom reset handlers is very handy.

I don't really have any motivation for fixing boards other than
SBC8548 and even that I can avoid doing by making a new custom board
file in my tree that would not populate .reset field. I can drop this
patch from the series if the code of those boards is in "don't touch
it unless absolutely have to" state.

>
>> diff --git a/arch/powerpc/platforms/85xx/bsc913x_qds.c
>> b/arch/powerpc/platforms/85xx/bsc913x_qds.c
>> index 07dd6ae..14ea7a0 100644
>> --- a/arch/powerpc/platforms/85xx/bsc913x_qds.c
>> +++ b/arch/powerpc/platforms/85xx/bsc913x_qds.c
>> @@ -53,6 +53,7 @@ static void __init bsc913x_qds_setup_arch(void)
>>  }
>>
>>  machine_arch_initcall(bsc9132_qds, mpc85xx_common_publish_devices);
>> +machine_arch_initcall(bsc9133_qds, fsl_rstcr_restart_register);
>
> Do we really still need to call the registration on a per-board basis, now
> that boards have a way of registering a higher-priority notifier?  Can't we
> just have setup_rstcr() do the registration when it finds the appropriate
> device tree node?

I think we could, that idea just never occurred to me. What you
describe should be a cleaner way to handle this change, I'll convert
the code to do that in v2.

>
>> +int fsl_rstcr_restart_register(void)
>> +{
>> +     static struct notifier_block restart_handler;
>> +
>> +     restart_handler.notifier_call = fsl_rstcr_restart;
>> +     restart_handler.priority = 128;
>> +
>> +     return register_restart_handler(&restart_handler);
>> +}
>> +EXPORT_SYMBOL(fsl_rstcr_restart_register);
>
> When would this ever get called from a module?

Probably never, that's just a mistake on my part. Will remove in v2.

Thanks,
Andrey

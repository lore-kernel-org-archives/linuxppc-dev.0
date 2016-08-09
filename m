Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s82pC12BszDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 04:28:02 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id j12so874248ywb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 11:28:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160801134734.05eaedd1@roar.ozlabs.ibm.com>
References: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
 <1469747238-17432-2-git-send-email-andrew.smirnov@gmail.com>
 <20160801134734.05eaedd1@roar.ozlabs.ibm.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 9 Aug 2016 11:27:58 -0700
Message-ID: <CAHQ1cqECPV=PLHhFRJH0pRnpGo2mUEHROiYah8h8Vc6174V0Jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc: Call chained reset handlers during reset
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Paul Mackerras <paulus@samba.org>, Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 31, 2016 at 8:47 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Thu, 28 Jul 2016 16:07:17 -0700
> Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
>> Call out to all restart handlers that were added via
>> register_restart_handler() API when restarting the machine.
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>
>> No changes compared to v1
>>
>>  arch/powerpc/kernel/setup-common.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/setup-common.c
>> b/arch/powerpc/kernel/setup-common.c index 5cd3283..205d073 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -145,6 +145,10 @@ void machine_restart(char *cmd)
>>               ppc_md.restart(cmd);
>>
>>       smp_send_stop();
>> +
>> +     do_kernel_restart(cmd);
>> +     mdelay(1000);
>> +
>>       machine_hang();
>>  }
>>
>
> Ah, I see why you don't move smp_send_stop(). 3 other architectures
> call do_kernel_restart(). arm and arm64 call it with
> local_irq_disabled().

I am not very familiar with low-level SPM code, so take all below with
a grain of salt.

>From my understanding of the code ARM's implementation of
smp_send_stop() is different from MIPS/PowerPC ones in that it just
raises an IPI with a special "stop" flag set, which can and probably
should be done with IRQs disabled. Both MIPS and PowerPC call
smp_call_fuction() in their smp_send_stop() implementation, which if I
read the documentation correctly should not be called with interrupts
disabled, so it looks like the call to local_irq_disabled() could only
be placed after the call to smp_send_stop() on those platforms.

> arm and mips insert the 1s delay. All call it
> after smp_send_stop(). I don't see the harm in the delay. Should we
> call it with local interrupts disabled?
>

With all above being said I don't see any harm in disabling interrupts.

Thanks,
Andrey

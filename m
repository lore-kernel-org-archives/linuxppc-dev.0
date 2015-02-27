Return-Path: <pc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0318E1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 00:28:17 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 27 Feb 2015 06:28:15 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id EA01D1FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 06:19:24 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1RDSCsY29360344
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 06:28:12 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1RDRmqU022213
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 06:27:48 -0700
Message-ID: <54F070CB.1060801@us.ibm.com>
Date: Fri, 27 Feb 2015 07:27:39 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: re-enable dynticks
References: <54DE52BC.3020303@us.ibm.com>
 <1424045319.3018.2.camel@ellerman.id.au> <54E76B3D.1010909@us.ibm.com>
 <20150221051845.GS5745@linux.vnet.ibm.com>
In-Reply-To: <20150221051845.GS5745@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It appears the discussion wrapped up on this, favorably.  Is there 
anything else I need to do to get this merged?

Regards,
PC

On 02/20/2015 11:18 PM, Paul E. McKenney wrote:
> On Fri, Feb 20, 2015 at 11:13:33AM -0600, Paul Clarke wrote:
>>
>> implement arch_irq_work_has_interrupt() for powerpc
>>
>> (resending because I messed up the e-mail addresses)
>>
>> Commit 9b01f5bf3 introduced a dependency on "IRQ work self-IPIs" for
>> full dynamic ticks to be enabled, by expecting architectures to
>> implement a suitable arch_irq_work_has_interrupt() routine.
>>
>> Several arches have implemented this routine, including x86
>> (3010279f) and arm (09f6edd4), but powerpc was omitted.
>>
>> This patch implements this routine for powerpc.
>>
>> The symptom, at boot (on powerpc arch systems) with "nohz_full=<CPU
>> list>" is displayed:
>>      NO_HZ: Can't run full dynticks because arch doesn't support irq
>> work self-IPIs
>>
>> after this patch:
>>      NO_HZ: Full dynticks CPUs: <CPU list>.
>>
>> Tested against 3.19.
>>
>> v2: changed "return 1" to "return true", per Michael Ellerman
>>
>> CC: Frederic Weisbecker <fweisbec@gmail.com>
>> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
>
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>
>> diff --git a/arch/powerpc/include/asm/irq_work.h
>> b/arch/powerpc/include/asm/irq_work.h
>> new file mode 100644
>> index 0000000..99cc0aa
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/irq_work.h
>> @@ -0,0 +1,11 @@
>> +#ifndef _ASM_IRQ_WORK_H
>> +#define _ASM_IRQ_WORK_H
>> +
>> +#include <asm/processor.h>
>> +
>> +static inline bool arch_irq_work_has_interrupt(void)
>> +{
>> +    return true;
>> +}
>> +
>> +#endif /* _ASM_IRQ_WORK_H */
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

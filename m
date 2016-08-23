Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJPzh0Y4jzDrK7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 19:20:09 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 8F1A8440DAD_7BC1544B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 09:20:04 +0000 (GMT)
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
 [209.85.220.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 F2D1943E090_7BC1542F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 09:20:02 +0000 (GMT)
Received: by mail-qk0-f169.google.com with SMTP id t7so101019040qkh.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 02:20:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed8c66dd-c567-35df-4a51-6bb3434fdc2b@c-s.fr>
References: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
 <1468965129.25630.15.camel@buserror.net>
 <601d732a-a137-3ba9-550d-19c7eb10337a@c-s.fr>
 <ed8c66dd-c567-35df-4a51-6bb3434fdc2b@c-s.fr>
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Tue, 23 Aug 2016 11:20:00 +0200
Message-ID: <CAPk1OjGR0gTAXvSUw=QUqkOrOZbmXCnd71Fu0mm5Pfrg46uc5w@mail.gmail.com>
Subject: Re: Suspected regression?
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

Sorry for delay in reply I was on vacation.

On 6 August 2016 at 11:29, christophe leroy <christophe.leroy@c-s.fr> wrote=
:
> Alessio,
>
>
> Le 05/08/2016 =C3=A0 09:51, Christophe Leroy a =C3=A9crit :
>>
>>
>>
>> Le 19/07/2016 =C3=A0 23:52, Scott Wood a =C3=A9crit :
>>>
>>> On Tue, 2016-07-19 at 12:00 +0200, Alessio Igor Bogani wrote:
>>>>
>>>> Hi all,
>>>>
>>>> I have got two boards MVME5100 (MPC7410 cpu) and MVME7100 (MPC8641D
>>>> cpu) for which I use the same cross-compiler (ppc7400).
>>>>
>>>> I tested these against kernel HEAD to found that these don't boot
>>>> anymore (PID 1 crash).
>>>>
>>>> Bisecting results in first offending commit:
>>>> 7aef4136566b0539a1a98391181e188905e33401
>>>>
>>>> Removing it from HEAD make boards boot properly again.
>>>>
>>>> A third system based on P2010 isn't affected at all.
>>>>
>>>> Is it a regression or I have made something wrong?
>>>
>>>
>>> I booted both my next branch, and Linus's master on MPC8641HPCN and
>>> didn't see
>>> this -- though possibly your RFS is doing something different.  Maybe
>>> that's
>>> the difference with P2010 as well.
>>>
>>> Is there any way you can debug the cause of the crash?  Or send me a
>>> minimal
>>> RFS that demonstrates the problem (ideally with debug symbols on the
>>> userspace
>>> binaries)?
>>>
>>
>> I got from Alessio the below information:
>>
>> systemd[1]: Caught <BUS>, core dump failed (child 137, code=3Dkilled,
>> status=3D7/BUS).
>> systemd[1]: Freezing execution.
>>
>>
>> What can generate SIGBUS ?
>> And shouldn't we also get some KERN_ERR trace, something like "unhandled
>> signal 7 at ....." ?
>>
>
> As far as I can see, SIGBUS is mainly generated from alignment exception.
> According to 7410 Reference Manual, alignment exception can happen in the
> following cases:
> * An operand of a dcbz instruction is on a page that is write-through or
> cache-inhibited for a virtual mode access.
> * An attempt to execute a dcbz instruction occurs when the cache is disab=
led
> or locked.
>
> Could try with below patch to check if the dcbz insn is causing the SIGBU=
S ?

Unfortunately that patch doesn't solve the problem.

Is there a chance that cache behavior could settled by board firmware
(PPCBug on the MPC7410 board and MotLoad on the MPC8641D one)?
In that case what do you suggest me to looking for?

> Christophe
>
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_3=
2.S
> index 68f6862..3ad782a 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -192,7 +192,7 @@ _GLOBAL(csum_partial_copy_generic)
>         mtctr   r8
>
>  53:    dcbt    r3,r4
> -54:    dcbz    r11,r6
> +54:    nop
>  /* the main body of the cacheline loop */
>         CSUM_COPY_16_BYTES_WITHEX(0)
>  #if L1_CACHE_BYTES >=3D 32

Thanks for your help!

Ciao,
Alessio

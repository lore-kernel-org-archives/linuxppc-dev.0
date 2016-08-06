Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5z0M1Vh0zDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 19:29:37 +1000 (AEST)
Subject: Re: Suspected regression?
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
References: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
 <1468965129.25630.15.camel@buserror.net>
 <601d732a-a137-3ba9-550d-19c7eb10337a@c-s.fr>
From: christophe leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <ed8c66dd-c567-35df-4a51-6bb3434fdc2b@c-s.fr>
Date: Sat, 6 Aug 2016 11:29:30 +0200
MIME-Version: 1.0
In-Reply-To: <601d732a-a137-3ba9-550d-19c7eb10337a@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alessio,

Le 05/08/2016 à 09:51, Christophe Leroy a écrit :
>
>
> Le 19/07/2016 à 23:52, Scott Wood a écrit :
>> On Tue, 2016-07-19 at 12:00 +0200, Alessio Igor Bogani wrote:
>>> Hi all,
>>>
>>> I have got two boards MVME5100 (MPC7410 cpu) and MVME7100 (MPC8641D
>>> cpu) for which I use the same cross-compiler (ppc7400).
>>>
>>> I tested these against kernel HEAD to found that these don't boot
>>> anymore (PID 1 crash).
>>>
>>> Bisecting results in first offending commit:
>>> 7aef4136566b0539a1a98391181e188905e33401
>>>
>>> Removing it from HEAD make boards boot properly again.
>>>
>>> A third system based on P2010 isn't affected at all.
>>>
>>> Is it a regression or I have made something wrong?
>>
>> I booted both my next branch, and Linus's master on MPC8641HPCN and
>> didn't see
>> this -- though possibly your RFS is doing something different.  Maybe
>> that's
>> the difference with P2010 as well.
>>
>> Is there any way you can debug the cause of the crash?  Or send me a
>> minimal
>> RFS that demonstrates the problem (ideally with debug symbols on the
>> userspace
>> binaries)?
>>
>
> I got from Alessio the below information:
>
> systemd[1]: Caught <BUS>, core dump failed (child 137, code=killed,
> status=7/BUS).
> systemd[1]: Freezing execution.
>
>
> What can generate SIGBUS ?
> And shouldn't we also get some KERN_ERR trace, something like "unhandled
> signal 7 at ....." ?
>

As far as I can see, SIGBUS is mainly generated from alignment exception.
According to 7410 Reference Manual, alignment exception can happen in 
the following cases:
* An operand of a dcbz instruction is on a page that is write-through or
cache-inhibited for a virtual mode access.
* An attempt to execute a dcbz instruction occurs when the cache is 
disabled or locked.

Could try with below patch to check if the dcbz insn is causing the SIGBUS ?

Christophe

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 68f6862..3ad782a 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -192,7 +192,7 @@ _GLOBAL(csum_partial_copy_generic)
  	mtctr	r8

  53:	dcbt	r3,r4
-54:	dcbz	r11,r6
+54:	nop
  /* the main body of the cacheline loop */
  	CSUM_COPY_16_BYTES_WITHEX(0)
  #if L1_CACHE_BYTES >= 32

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

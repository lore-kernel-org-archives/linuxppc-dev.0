Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLLQj6yvxzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 22:46:53 +1000 (AEST)
Subject: Re: Suspected regression?
To: Scott Wood <oss@buserror.net>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
References: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
 <1468965129.25630.15.camel@buserror.net>
 <601d732a-a137-3ba9-550d-19c7eb10337a@c-s.fr>
 <ed8c66dd-c567-35df-4a51-6bb3434fdc2b@c-s.fr>
 <CAPk1OjGR0gTAXvSUw=QUqkOrOZbmXCnd71Fu0mm5Pfrg46uc5w@mail.gmail.com>
 <b843cd6d-b9df-a5b2-4015-042c7894313f@c-s.fr>
 <1472178736.25630.288.camel@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <46ccc73b-72d9-3ae9-afce-1962d51bd967@c-s.fr>
Date: Fri, 26 Aug 2016 14:46:48 +0200
MIME-Version: 1.0
In-Reply-To: <1472178736.25630.288.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alessio,

Le 26/08/2016 à 04:32, Scott Wood a écrit :
> On Tue, 2016-08-23 at 13:34 +0200, Christophe Leroy wrote:
>>
>> Le 23/08/2016 à 11:20, Alessio Igor Bogani a écrit :
>>>
>>> Hi Christophe,
>>>
>>> Sorry for delay in reply I was on vacation.
>>>
>>> On 6 August 2016 at 11:29, christophe leroy <christophe.leroy@c-s.fr>
>>> wrote:
>>>>
>>>> Alessio,
>>>>
>>>>
>>>> Le 05/08/2016 à 09:51, Christophe Leroy a écrit :
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Le 19/07/2016 à 23:52, Scott Wood a écrit :
>>>>>>
>>>>>>
>>>>>> On Tue, 2016-07-19 at 12:00 +0200, Alessio Igor Bogani wrote:
>>>>>>>
>>>>>>>
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I have got two boards MVME5100 (MPC7410 cpu) and MVME7100
>>>>>>> (MPC8641D
>>>>>>> cpu) for which I use the same cross-compiler (ppc7400).
>>>>>>>
>>>>>>> I tested these against kernel HEAD to found that these don't boot
>>>>>>> anymore (PID 1 crash).
>>>>>>>
>>>>>>> Bisecting results in first offending commit:
>>>>>>> 7aef4136566b0539a1a98391181e188905e33401
>>>>>>>
>>>>>>> Removing it from HEAD make boards boot properly again.
>>>>>>>
>>>>>>> A third system based on P2010 isn't affected at all.
>>>>>>>
>>>>>>> Is it a regression or I have made something wrong?
>>>>>>
>>>>>> I booted both my next branch, and Linus's master on MPC8641HPCN and
>>>>>> didn't see
>>>>>> this -- though possibly your RFS is doing something
>>>>>> different.  Maybe
>>>>>> that's
>>>>>> the difference with P2010 as well.
>>>>>>
>>>>>> Is there any way you can debug the cause of the crash?  Or send me a
>>>>>> minimal
>>>>>> RFS that demonstrates the problem (ideally with debug symbols on the
>>>>>> userspace
>>>>>> binaries)?
>>>>>>
>>>>> I got from Alessio the below information:
>>>>>
>>>>> systemd[1]: Caught <BUS>, core dump failed (child 137, code=killed,
>>>>> status=7/BUS).
>>>>> systemd[1]: Freezing execution.
>>>>>
>>>>>
>>>>> What can generate SIGBUS ?
>>>>> And shouldn't we also get some KERN_ERR trace, something like
>>>>> "unhandled
>>>>> signal 7 at ....." ?
>>>>>
>>>> As far as I can see, SIGBUS is mainly generated from alignment
>>>> exception.
>>>> According to 7410 Reference Manual, alignment exception can happen in
>>>> the
>>>> following cases:
>>>> * An operand of a dcbz instruction is on a page that is write-through or
>>>> cache-inhibited for a virtual mode access.
>>>> * An attempt to execute a dcbz instruction occurs when the cache is
>>>> disabled
>>>> or locked.
>>>>
>>>> Could try with below patch to check if the dcbz insn is causing the
>>>> SIGBUS ?
>>> Unfortunately that patch doesn't solve the problem.
>>>
>>> Is there a chance that cache behavior could settled by board firmware
>>> (PPCBug on the MPC7410 board and MotLoad on the MPC8641D one)?
>>> In that case what do you suggest me to looking for?
>> If the removal of dcbz doesn't solve the issue, I don't think it is a
>> cache related issue.
>> As far as I understood, your init gets a SIGBUS signal, right ? Then we
>> must identify the reason for that sigbus.
>
> My guess would be errors demand-loading a page via NFS.
>
> One approach might be to hack up the code so that both versions of
> csum_partial_copy_generic() are present, and call both each time.  If the
> results differ or the copied bytes are wrong, then spit out a dump of the
> details.
>

Can you try the patch below ? I have identified that in case the packet 
is smaller than a cacheline, it doesn't get cache-aligned so the result 
shall not be rotated in case of odd dest address.

This patch goes in addition to the previous fix (1bc8b816cb805) as it 
fixes a different case.

Christophe

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 68f6862..3971cfb 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -127,18 +127,19 @@ _GLOBAL(csum_partial_copy_generic)
  	stw	r7,12(r1)
  	stw	r8,8(r1)

-	rlwinm	r0,r4,3,0x8
-	rlwnm	r6,r6,r0,0,31	/* odd destination address: rotate one byte */
-	cmplwi	cr7,r0,0	/* is destination address even ? */
  	addic	r12,r6,0
  	addi	r6,r4,-4
  	neg	r0,r4
  	addi	r4,r3,-4
  	andi.	r0,r0,CACHELINE_MASK	/* # bytes to start of cache line */
+	crset	4*cr7+eq
  	beq	58f

  	cmplw	0,r5,r0			/* is this more than total to do? */
  	blt	63f			/* if not much to do */
+	rlwinm	r7,r6,3,0x8
+	rlwnm	r12,r12,r7,0,31	/* odd destination address: rotate one byte */
+	cmplwi	cr7,r7,0	/* is destination address even ? */
  	andi.	r8,r0,3			/* get it word-aligned first */
  	mtctr	r8
  	beq+	61f
-- 

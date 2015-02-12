Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C23971A0A68
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 19:38:57 +1100 (AEDT)
Message-ID: <54DC6688.5080101@freescale.com>
Date: Thu, 12 Feb 2015 10:38:32 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Bogdan Purcareata
 <bogdan.purcareata@freescale.com>
Subject: Re: [PATCH v2 1/3] powerpc: Don't force ENOSYS as error on syscall
 fail
References: <1423643778-32525-1-git-send-email-bogdan.purcareata@freescale.com>	
 <1423643778-32525-2-git-send-email-bogdan.purcareata@freescale.com>
 <1423718679.24302.3.camel@ellerman.id.au>
In-Reply-To: <1423718679.24302.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: linux-kernel@vger.kernel.org, pmoore@redhat.com, paulus@samba.org,
 strosake@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12.02.2015 07:24, Michael Ellerman wrote:
> On Wed, 2015-02-11 at 08:36 +0000, Bogdan Purcareata wrote:
>> In certain scenarios - e.g. seccomp filtering with ERRNO as default action -
>> the system call fails for other reasons than the syscall not being available.
>> The seccomp filter can be configured to store a user-defined error code on
>> return from a blacklisted syscall. Don't always set ENOSYS on
>> do_syscall_trace_enter failure.
>>
>> v2:
>> - move setting ENOSYS as errno from the syscall entry assembly to
>>    do_syscall_trace_enter, only in the specific case
>
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index 194e46d..0111e04 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -269,7 +269,6 @@ syscall_dotrace:
>>   	b	.Lsyscall_dotrace_cont
>>
>>   syscall_enosys:
>> -	li	r3,-ENOSYS
>>   	b	syscall_exit
>
>
> This still looks wrong to me.
>
> On 64 bit we do:
>
> 	CURRENT_THREAD_INFO(r11, r1)
> 	ld	r10,TI_FLAGS(r11)
> 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
> 	bne	syscall_dotrace
> .Lsyscall_dotrace_cont:
> 	cmpldi	0,r0,NR_syscalls
> 	bge-	syscall_enosys
> ...
>
> syscall_enosys:
> 	li	r3,-ENOSYS
> 	b	.Lsyscall_exit
>
>
> Your patch removes the load of ENOSYS.
>
> Which means if we're not doing syscall tracing, and we get an out-of-bounds
> syscall number, we'll return with something random on r3. Won't we?

Thanks for pointing this out, you are absolutely right. Perhaps this is 
a fix for the issue - on 64 bit:

         ld      r10,TI_FLAGS(r11)
         andi.   r11,r10,_TIF_SYSCALL_T_OR_A
         bne     syscall_dotrace
-.Lsyscall_dotrace_cont:
         cmpldi  0,r0,NR_syscalls
         bge-    syscall_enosys

system_call:
...

syscall_enosys:
	li	r3,-ENOSYS
	b	.Lsyscall_exit
...

syscall_dotrace:
...
         addi    r9,r1,STACK_FRAME_OVERHEAD
         CURRENT_THREAD_INFO(r10, r1)
         ld      r10,TI_FLAGS(r10)
-       b       .Lsyscall_dotrace_cont
+       cmpldi  0,r0,NR_syscalls
+       bge     syscall_exit
+       b       system_call

So basically I leave the code for syscall_enosys unchanged, but I keep 
using it only when not doing syscall tracing. When doing syscall 
tracing, I'm assuming do_syscall_trace_enter will take care of setting 
the errno, and should it return an invalid syscall number, go directly 
to syscall_exit.

> The 32-bit code looks more or less similar, although the label has a different
> name.

Same thing for 32-bit:

_GLOBAL(DoSyscall)
         lwz     r11,TI_FLAGS(r10)
         andi.   r11,r11,_TIF_SYSCALL_T_OR_A
         bne-    syscall_dotrace
-syscall_dotrace_cont:
         cmplwi  0,r0,NR_syscalls
         lis     r10,sys_call_table@h
         ori     r10,r10,sys_call_table@l
         slwi    r0,r0,2
         bge     66f
+syscall_dotrace_cont:
         lwzx    r10,r10,r0      /* Fetch system call handler [ptr] */
         mtlr    r10
         addi    r9,r1,STACK_FRAME_OVERHEAD
...

66:	li	r3,-ENOSYS
	b	ret_from_syscall
...

syscall_dotrace:
         lwz     r7,GPR7(r1)
         lwz     r8,GPR8(r1)
         REST_NVGPRS(r1)
+       cmplwi  0,r0,NR_syscalls
+       lis     r10,sys_call_table@h
+       ori     r10,r10,sys_call_table@l
+       slwi    r0,r0,2
+       bge-    ret_from_syscall
         b       syscall_dotrace_cont

However I must admit that I don't like duplicating those 4 lines of code 
associated with verifying the syscall number. I can't think of any 
better way to do this. I also thought about leaving this check in one 
place, and then branch differently according to _TIF_SYSCALL_T_OR_A. Do 
you think that would be a better approach?

Thank you,
Bogdan P.

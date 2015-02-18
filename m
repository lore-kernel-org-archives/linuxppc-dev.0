Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0117.outbound.protection.outlook.com [157.56.111.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 941011A0A03
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 17:51:20 +1100 (AEDT)
Message-ID: <54E43650.20901@freescale.com>
Date: Wed, 18 Feb 2015 08:50:56 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Mike Strosaker <strosake@linux.vnet.ibm.com>, Bogdan Purcareata
 <bogdan.purcareata@freescale.com>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powerpc: Don't force ENOSYS as error on syscall
 fail
References: <1423815752-3013-1-git-send-email-bogdan.purcareata@freescale.com>
 <1423815752-3013-2-git-send-email-bogdan.purcareata@freescale.com>
 <54E4007F.5080603@linux.vnet.ibm.com>
In-Reply-To: <54E4007F.5080603@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Cc: pmoore@redhat.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.02.2015 05:01, Mike Strosaker wrote:
> This patch failed to build using pseries_le_defconfig.  With the change
> noted below in entry_64.S, the build succeeded and seccomp mode 2 worked
> correctly.
>
> Best,
> Mike Strosaker
>
> On 02/13/2015 02:22 AM, Bogdan Purcareata wrote:
>> In certain scenarios - e.g. seccomp filtering with ERRNO as default action -
>> the system call fails for other reasons than the syscall not being available.
>> The seccomp filter can be configured to store a user-defined error code on
>> return from a blacklisted syscall. Don't always set ENOSYS on
>> do_syscall_trace_enter failure.
>>
>> Delegate setting ENOSYS in case of failure, where appropriate, to
>> do_syscall_trace_enter.
>>
>> v3:
>> - keep setting ENOSYS in the syscall entry assembly for scenarios without
>>     syscall tracing
>>
>> v2:
>> - move setting ENOSYS as errno from the syscall entry assembly to
>>     do_syscall_trace_enter, only in the specific case
>>
>> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
>> ---
>>    arch/powerpc/kernel/entry_32.S | 7 ++++++-
>>    arch/powerpc/kernel/entry_64.S | 5 +++--
>>    arch/powerpc/kernel/ptrace.c   | 4 +++-
>>    3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>> index 46fc0f4..b2f88cd 100644
>> --- a/arch/powerpc/kernel/entry_32.S
>> +++ b/arch/powerpc/kernel/entry_32.S
>> @@ -333,12 +333,12 @@ _GLOBAL(DoSyscall)
>>    	lwz	r11,TI_FLAGS(r10)
>>    	andi.	r11,r11,_TIF_SYSCALL_DOTRACE
>>    	bne-	syscall_dotrace
>> -syscall_dotrace_cont:
>>    	cmplwi	0,r0,NR_syscalls
>>    	lis	r10,sys_call_table@h
>>    	ori	r10,r10,sys_call_table@l
>>    	slwi	r0,r0,2
>>    	bge-	66f
>> +syscall_dotrace_cont:
>>    	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
>>    	mtlr	r10
>>    	addi	r9,r1,STACK_FRAME_OVERHEAD
>> @@ -457,6 +457,11 @@ syscall_dotrace:
>>    	lwz	r7,GPR7(r1)
>>    	lwz	r8,GPR8(r1)
>>    	REST_NVGPRS(r1)
>> +	cmplwi	0,r0,NR_syscalls
>> +	lis	r10,sys_call_table@h
>> +	ori	r10,r10,sys_call_table@l
>> +	slwi	r0,r0,2
>> +	bge-	ret_from_syscall
>>    	b	syscall_dotrace_cont
>>
>>    syscall_exit_work:
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index d180caf2..0d22fa8 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -144,7 +144,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>>    	ld	r10,TI_FLAGS(r11)
>>    	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
>>    	bne	syscall_dotrace
>> -.Lsyscall_dotrace_cont:
>>    	cmpldi	0,r0,NR_syscalls
>>    	bge-	syscall_enosys
>>
>> @@ -253,7 +252,9 @@ syscall_dotrace:
>>    	addi	r9,r1,STACK_FRAME_OVERHEAD
>>    	CURRENT_THREAD_INFO(r10, r1)
>>    	ld	r10,TI_FLAGS(r10)
>> -	b	.Lsyscall_dotrace_cont
>> +	cmpldi	0,r0,NR_syscalls
>> +	bge-	syscall_exit
>
> Shouldn't this be .Lsyscall_exit?

Thanks for testing and spotting this! The kernel I tested with didn't 
have syscall_exit converted to a local label (commit 
4c3b21686111e0ac6018469dacbc5549f9915cf8).

Will resend with this change.

Bogdan P.

>> +	b	system_call
>>
>>    syscall_enosys:
>>    	li	r3,-ENOSYS
>> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
>> index f21897b..2edae06 100644
>> --- a/arch/powerpc/kernel/ptrace.c
>> +++ b/arch/powerpc/kernel/ptrace.c
>> @@ -1775,13 +1775,15 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>>    	secure_computing_strict(regs->gpr[0]);
>>
>>    	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
>> -	    tracehook_report_syscall_entry(regs))
>> +	    tracehook_report_syscall_entry(regs)) {
>>    		/*
>>    		 * Tracing decided this syscall should not happen.
>>    		 * We'll return a bogus call number to get an ENOSYS
>>    		 * error, but leave the original number in regs->gpr[0].
>>    		 */
>>    		ret = -1L;
>> +		syscall_set_return_value(current, regs, ENOSYS, 0);
>> +	}
>>
>>    	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
>>    		trace_sys_enter(regs, regs->gpr[0]);
>>
>

Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1836B1A084B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 18:59:47 +1100 (AEDT)
Message-ID: <54DB0BDD.2010807@freescale.com>
Date: Wed, 11 Feb 2015 09:59:25 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Bogdan Purcareata
 <bogdan.purcareata@freescale.com>
Subject: Re: [RFC][PATCH 1/3] powerpc: Don't force ENOSYS as error on syscall
 fail
References: <1423468516-8688-1-git-send-email-bogdan.purcareata@freescale.com>	
 <1423468516-8688-2-git-send-email-bogdan.purcareata@freescale.com>
 <1423623845.12568.1.camel@ellerman.id.au>
In-Reply-To: <1423623845.12568.1.camel@ellerman.id.au>
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

On 11.02.2015 05:04, Michael Ellerman wrote:
> On Mon, 2015-02-09 at 07:55 +0000, Bogdan Purcareata wrote:
>> In certain scenarios - e.g. seccomp filtering with ERRNO as default action -
>> the system call fails for other reasons than the syscall not being available.
>> The seccomp filter can be configured to store a user-defined error code on
>> return from a blacklisted syscall.
>>
>> The RFC is this: are there currently any user-space scenarios where it is
>> required that the system call return ENOSYS as error code on failure, no matter
>> the circumstances? I don't want to break userspace requirements. I have not
>> added code to force this error code in situations different than
>> secure_computing failure, in order to keep overhead at a minimum.
>>
>> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
>> ---
>>   arch/powerpc/kernel/entry_32.S | 3 ++-
>>   arch/powerpc/kernel/entry_64.S | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>> index 59848e5..52e48dd 100644
>> --- a/arch/powerpc/kernel/entry_32.S
>> +++ b/arch/powerpc/kernel/entry_32.S
>> @@ -425,7 +425,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>>   	b	1b
>>   #endif  /* CONFIG_44x */
>>
>> -66:	li	r3,-ENOSYS
>> +66:
>> +#	li	r3,-ENOSYS
>>   	b	ret_from_syscall
>>
>>   	.globl	ret_from_fork
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index e6bfe8e..80db02e 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -269,7 +269,7 @@ syscall_dotrace:
>>   	b	.Lsyscall_dotrace_cont
>>
>>   syscall_enosys:
>> -	li	r3,-ENOSYS
>> +#	li	r3,-ENOSYS
>>   	b	syscall_exit
>
> So what happens if you call this with a syscall number that's out of bounds?

As far as my current understanding goes, the call will return with -1 
with a errno that's undefined (or I've not seen it be defined anywhere).

I've thought more about this, and I guess the best option would be to 
move setting -ENOSYS as errno from the syscall entry assembly to 
do_syscall_trace_enter (as opposed to eliminating it at all). I was a 
little reluctant to do this at first in order to keep overhead to a 
minimum, but it's certainly not an option to change behavior if the 
syscall number is out of bounds.

v2 to come shortly.

Thanks,
Bogdan P.

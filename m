Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40986B20W4zF27J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 09:32:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: Re: [PATCH v3 3/6] powerpc/kexec: Disable ftrace before switching to
 the new kernel
In-Reply-To: <877epylba7.fsf@concordia.ellerman.id.au>
References: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
 <5589149f6dd1b627f5eadafa086fb5e716bc0622.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
 <877epylba7.fsf@concordia.ellerman.id.au>
Date: Tue, 27 Mar 2018 09:32:33 +1100
Message-ID: <874ll2lb7i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> If function_graph tracer is enabled during kexec, we see the below
>> exception in the simulator:
>> 	root@(none):/# kexec -e
>> 	kvm: exiting hardware virtualization
>> 	kexec_core: Starting new kernel
>> 	[   19.262020070,5] OPAL: Switch to big-endian OS
>> 	kexec: Starting switchover sequence.
>> 	Interrupt to 0xC000000000004380 from 0xC000000000004380
>> 	** Execution stopped: Continuous Interrupt, Instruction caused exception,  **
>>
>> Now that we have a more effective way to disable ftrace, let's use that
>> before switching to a new kernel during kexec.
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/machine_kexec.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
>> index 2694d078741d..4a1b24a9dd61 100644
>> --- a/arch/powerpc/kernel/machine_kexec.c
>> +++ b/arch/powerpc/kernel/machine_kexec.c
>> @@ -95,16 +95,14 @@ void arch_crash_save_vmcoreinfo(void)
>>   */
>>  void machine_kexec(struct kimage *image)
>>  {
>> -	int save_ftrace_enabled;
>> -
>> -	save_ftrace_enabled = __ftrace_enabled_save();
>> +	get_paca()->ftrace_disabled = 1;
>
> This doesn't compile on 32-bit:
>
>   Failed: powerpc-next/corenet32_smp_defconfig/powerpc-5.3		(http://kisskb.ozlabs.ibm.com/kisskb/buildresult/13314085/log/)
>     /kisskb/src/arch/powerpc/kernel/machine_kexec.c:105:12: error: invalid type argument of '->' (have 'int')
>     /kisskb/src/arch/powerpc/kernel/machine_kexec.c:98:12: error: invalid type argument of '->' (have 'int')
>     /kisskb/src/arch/powerpc/kernel/machine_kexec.c:98:2: error: implicit declaration of function 'get_paca' [-Werror=implicit-function-declaration]
>
>
> A wrapper is probably best that does nothing on 32-bit.

Actually it should probably do __ftrace_enabled_save() etc. on 32-bit,
like the existing code does.

cheers

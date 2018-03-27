Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409MDD41D4zF27p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 17:53:32 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2R6q1qT011463
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 02:53:29 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gyfrutt9g-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 02:53:29 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 27 Mar 2018 07:53:27 +0100
Date: Tue, 27 Mar 2018 12:23:23 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/6] powerpc/kexec: Disable ftrace before switching to
 the new kernel
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
References: <cover.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
 <5589149f6dd1b627f5eadafa086fb5e716bc0622.1521713762.git.naveen.n.rao@linux.vnet.ibm.com>
 <877epylba7.fsf@concordia.ellerman.id.au>
 <874ll2lb7i.fsf@concordia.ellerman.id.au>
In-Reply-To: <874ll2lb7i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1522133470.66h1c66sqp.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>=20
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>> If function_graph tracer is enabled during kexec, we see the below
>>> exception in the simulator:
>>> 	root@(none):/# kexec -e
>>> 	kvm: exiting hardware virtualization
>>> 	kexec_core: Starting new kernel
>>> 	[   19.262020070,5] OPAL: Switch to big-endian OS
>>> 	kexec: Starting switchover sequence.
>>> 	Interrupt to 0xC000000000004380 from 0xC000000000004380
>>> 	** Execution stopped: Continuous Interrupt, Instruction caused excepti=
on,  **
>>>
>>> Now that we have a more effective way to disable ftrace, let's use that
>>> before switching to a new kernel during kexec.
>>>
>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/machine_kexec.c | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/=
machine_kexec.c
>>> index 2694d078741d..4a1b24a9dd61 100644
>>> --- a/arch/powerpc/kernel/machine_kexec.c
>>> +++ b/arch/powerpc/kernel/machine_kexec.c
>>> @@ -95,16 +95,14 @@ void arch_crash_save_vmcoreinfo(void)
>>>   */
>>>  void machine_kexec(struct kimage *image)
>>>  {
>>> -	int save_ftrace_enabled;
>>> -
>>> -	save_ftrace_enabled =3D __ftrace_enabled_save();
>>> +	get_paca()->ftrace_disabled =3D 1;
>>
>> This doesn't compile on 32-bit:
>>
>>   Failed: powerpc-next/corenet32_smp_defconfig/powerpc-5.3		(http://kiss=
kb.ozlabs.ibm.com/kisskb/buildresult/13314085/log/)
>>     /kisskb/src/arch/powerpc/kernel/machine_kexec.c:105:12: error: inval=
id type argument of '->' (have 'int')
>>     /kisskb/src/arch/powerpc/kernel/machine_kexec.c:98:12: error: invali=
d type argument of '->' (have 'int')
>>     /kisskb/src/arch/powerpc/kernel/machine_kexec.c:98:2: error: implici=
t declaration of function 'get_paca' [-Werror=3Dimplicit-function-declarati=
on]

Hmm... pmac32_defconfig built fine for me, so I thought we are ok there.

>>
>>
>> A wrapper is probably best that does nothing on 32-bit.
>=20
> Actually it should probably do __ftrace_enabled_save() etc. on 32-bit,
> like the existing code does.

Agree. In hindsight, I'm not updating ftrace_32.S, so I think I will=20
gate this with CONFIG_PPC64.

Thanks,
Naveen

=

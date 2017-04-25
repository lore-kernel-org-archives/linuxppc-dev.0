Return-Path: <srs0=fxbt=4b=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBrN40LdLzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 14:49:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wBrN36rWQz8t08
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 14:49:23 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wBrN3323Vz9s2G
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 14:49:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3P4nILs056841
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 00:49:21 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a1jvgh4r7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 00:49:20 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 25 Apr 2017 14:49:10 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3P4mxmg7143816
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 14:49:07 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3P4mZI0022955
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 14:48:35 +1000
Subject: Re: [PATCH v2] powerpc/book3s: mce: Move add_taint() later in virtual
 mode.
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
 <874lxjbak1.fsf@possimpible.ozlabs.ibm.com>
 <87r30mtnc2.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 10:18:12 +0530
MIME-Version: 1.0
In-Reply-To: <87r30mtnc2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <113b0cd7-d845-41a6-2bae-2dde75b6ca8f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2017 09:37 AM, Michael Ellerman wrote:
> Daniel Axtens <dja@axtens.net> writes:
>>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>>> index a1475e6..b23b323 100644
>>> --- a/arch/powerpc/kernel/mce.c
>>> +++ b/arch/powerpc/kernel/mce.c
>>> @@ -221,6 +221,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
>>>  {
>>>  	int index;
>>>  
>>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>>> +
>> This bit makes sense...
>>
>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>>> index ff365f9..af97e81 100644
>>> --- a/arch/powerpc/kernel/traps.c
>>> +++ b/arch/powerpc/kernel/traps.c
>>> @@ -741,6 +739,8 @@ void machine_check_exception(struct pt_regs *regs)
>>>  
>>>  	__this_cpu_inc(irq_stat.mce_exceptions);
>>>  
>>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>>> +
>>
>> But this bit I'm not sure about.
>>
>> Isn't machine_check_exception called from asm in
>> kernel/exceptions-64s.S? As in, it's called really early/in real mode?
> 
> It is called from there, in asm, but not from real mode AFAICS.
> 
> There's a call from machine_check_common(), we're already in virtual
> mode there.
> 
> The other call is from unrecover_mce(), and both places that call that
> do so via rfid, using PACAKMSR, which should turn on virtual mode.
> 
> 
> But none of that really matters. The fundamental issue here is we can't
> recursively call OPAL, that's what matters.
> 
> So if we were in OPAL and take an MCE, then we must not call OPAL again
> from the MCE handler.
> 
> This fixes one case where we know that can happen, but AFAICS we are not
> protected in general from it.
> 
> For example if we take an MCE in OPAL, decide it's not recoverable and
> go to unrecover_mce(), that will call machine_check_exception() which
> can then call OPAL via printk.
> 
> Or maybe there's a check in there somewhere that makes it OK, but it's
> not clear to me.

There is no check, but for non-recoverable MCE in OPAL we print mce
event, go down to panic path and reboot. Hence we are fine. For
recoverable mce error in opal we would never end up in
machine_check_exception().

Thanks,
-Mahesh.

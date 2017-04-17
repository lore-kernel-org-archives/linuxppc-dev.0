Return-Path: <srs0=s9ui=3z=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w65QK656ZzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 21:19:53 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w65QK5D3vz8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 21:19:53 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w65QJ3dN8z9s0g
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 21:19:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3HBJVBD009462
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 07:19:48 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29udntspt4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 07:19:47 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 16:49:44 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3HBJgNt18940120
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 16:49:42 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3HBJg7l025928
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 16:49:42 +0530
Subject: Re: [PATCH 2/2] powerpc/book3s: mce: Use add_taint_no_warn() in
 machine_check_early().
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <148765088309.20315.15300624012053746538.stgit@jupiter.in.ibm.com>
 <148765089349.20315.11180051017586952500.stgit@jupiter.in.ibm.com>
 <87o9vvuxl7.fsf@possimpible.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 17 Apr 2017 16:49:41 +0530
MIME-Version: 1.0
In-Reply-To: <87o9vvuxl7.fsf@possimpible.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <b9136bed-c5c1-3c8d-a571-f0f1242d2f5b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/2017 04:09 PM, Daniel Axtens wrote:
> Hi Mahesh,
> 
>> Fixes: 27ea2c420cad powerpc: Set the correct kernel taint on machine check errors.
> 
> I notice this Fixes a commit I introduced. Please could you cc me when
> you do this? I am likely to miss it otherwise, especially since I have
> now left IBM.

Sure will do. :-)

> 
> Being cced allows me to provide an Ack or a review. And getting feedback
> on my changes is very helpful in becoming a better programmer.
> 
> In this case, as per Michael's comment, why don't we just move the
> add_taint from machine_check_early to
> machine_check_process_queued_event - the other side of the work queue.

Yes. That is what my plan is. Also, that is not the only place.
add_taint() need to be called from machine_check_exception() as well. So
it will be called from two places.

Thanks,
-Mahesh.

> 
> The work queue system is supposed to provide us with a safe place to do
> printing, etc., so it's an appropriate place. Also, we already do
> machine_check_print_event_info there, and adding the taint doesn't need
> to be done synchronously.
> 
> Regards,
> Daniel
> 
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> machine_check_early() gets called in real mode. The very first time when
>> add_taint() is called, it prints a warning which ends up calling opal
>> call (that uses OPAL_CALL wrapper) for writing it to console. If we get a
>> very first machine check while we are in opal we are doomed. OPAL_CALL
>> overwrites the PACASAVEDMSR in r13 and in this case when we are done with
>> MCE handling the original opal call will use this new MSR on it's way
>> back to opal_return. This usually leads unexpected behaviour or kernel
>> to panic. Instead use the add_taint_no_warn() that does not call printk.
>>
>> This is broken with current FW level. We got lucky so far for not getting
>> very first MCE hit while in OPAL. But easily reproducible on Mambo.
>> This should go to stable as well alongwith patch 1/2.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/traps.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index 62b587f..4a048dc 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -306,7 +306,7 @@ long machine_check_early(struct pt_regs *regs)
>>  
>>  	__this_cpu_inc(irq_stat.mce_exceptions);
>>  
>> -	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>> +	add_taint_no_warn(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>>  
>>  	/*
>>  	 * See if platform is capable of handling machine check. (e.g. PowerNV
> 

Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBDE41A0010
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 22:32:10 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 18:02:08 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AE48EE004B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:02:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s56CWolZ48234700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:02:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s56CW2eN019969
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:02:04 +0530
Message-ID: <5391B473.2050809@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 18:00:43 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
 <1401833365.3247.36.camel@pasglop> <20140604134649.GB27557@redhat.com>
In-Reply-To: <20140604134649.GB27557@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: ego@linux.vnet.ibm.com, matt@ozlabs.org, mahesh@linux.vnet.ibm.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com,
 ebiederm@xmission.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/2014 07:16 PM, Vivek Goyal wrote:
> On Wed, Jun 04, 2014 at 08:09:25AM +1000, Benjamin Herrenschmidt wrote:
>> On Wed, 2014-06-04 at 01:58 +0530, Srivatsa S. Bhat wrote:
>>> Yep, that makes sense. But unfortunately I don't have enough insight into
>>> why exactly powerpc has to online the CPUs before doing a kexec. I just
>>> know from the commit log and the comment mentioned above (and from my own
>>> experiments) that the CPUs will get stuck if they were offline. Perhaps
>>> somebody more knowledgeable can explain this in detail and suggest a proper
>>> long-term solution.
>>>
>>> Matt, Ben, any thoughts on this?
>>
>> The problem is with our "soft offline" which we do on some platforms. When we
>> offline we don't actually send the CPUs back to firmware or anything like that.
>>
>> We put them into a very low low power loop inside Linux.
>>
>> The new kernel has no way to extract them from that loop. So we must re-"online"
>> them before we kexec so they can be passed to the new kernel normally (or returned
>> to firmware like we do on powernv).
> 
> Srivatsa,
> 
> Looks like your patch has been merged.
> 
> I don't like the following change in arch independent code.
> 
> /*
>  * migrate_to_reboot_cpu() disables CPU hotplug assuming  that
>  * no further code needs to use CPU hotplug (which is true in
>  * the reboot case). However, the kexec path depends on  using
>  * CPU hotplug again; so re-enable it here. 
>  */
>                cpu_hotplug_enable();
> 
> As it is very powerpc specific requirement, can you enable hotplug in powerpc
> arch dependent code as a short term solution.
> 

I didn't do that because that would mean that the _disable() would be
performed inside kernel/kexec.c and the corresponding _enable() would
be performed in arch/powerpc/kernel/machine_kexec_64.c -- with no apparent
connection between them, which would have made them hard to relate.

> Ideally one needs to fix the requirement of online all cpus in powerpc
> as a long term solution and then get rid of hotplug enable call.
> 

Yes, I agree. I'm trying out a solution at the moment (see the 4
preliminary patches I sent in my reply to Ben). If that works, we won't
need the enable call on powerpc.

Regards,
Srivatsa S. Bhat

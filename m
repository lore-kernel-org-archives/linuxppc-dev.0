Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2D281A0AC2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 22:32:44 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 18:02:41 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 34373125805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:01:56 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s56CXNpV8716580
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:03:23 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s56CWa9O021598
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:02:36 +0530
Message-ID: <5391B494.6050908@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 18:01:16 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
 <20140604134108.GA27557@redhat.com>
In-Reply-To: <20140604134108.GA27557@redhat.com>
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

On 06/04/2014 07:11 PM, Vivek Goyal wrote:
> On Wed, Jun 04, 2014 at 01:58:40AM +0530, Srivatsa S. Bhat wrote:
>> On 05/28/2014 07:01 PM, Vivek Goyal wrote:
>>> On Tue, May 27, 2014 at 04:25:34PM +0530, Srivatsa S. Bhat wrote:
>>>> If we try to perform a kexec when the machine is in ST (Single-Threaded) mode
>>>> (ppc64_cpu --smt=off), the kexec operation doesn't succeed properly, and we
>>>> get the following messages during boot:
>>>>
[...]
>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>> index c8380ad..28c5706 100644
>>>> --- a/kernel/kexec.c
>>>> +++ b/kernel/kexec.c
>>>> @@ -1683,6 +1683,14 @@ int kernel_kexec(void)
>>>>  		kexec_in_progress = true;
>>>>  		kernel_restart_prepare(NULL);
>>>>  		migrate_to_reboot_cpu();
>>>> +
>>>> +		/*
>>>> +		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
>>>> +		 * no further code needs to use CPU hotplug (which is true in
>>>> +		 * the reboot case). However, the kexec path depends on using
>>>> +		 * CPU hotplug again; so re-enable it here.
>>>> +		 */
>>>> +		cpu_hotplug_enable();
>>>>  		printk(KERN_EMERG "Starting new kernel\n");
>>>>  		machine_shutdown();
>>>
>>> After migrate_to_reboot_cpu(), we are calling machine_shutdown() which
>>> calls disable_nonboot_cpus() and which in turn calls _cpu_down().
>>>
>>
>> Hmm? I see only 'arm' calling disable_nonboot_cpus() from machine_shutdown().
>> None of the other architectures call it. Is that a leftover in arm?
> 
> You are right. I did not notice that only arm is doing that. Looks like
> it is calling into some platform code, I am not sure what exactly arm
> does for disabling cpu.
> 
> x86 code calls stop_other_cpus() in machine_shutdown() which sends
> REBOOT_VECTOR to other cpus and calls stop_this_cpu() which in turn
> does.
> 
>         for (;;)
>                 halt();
> 
> IIUC, upon receipt of certain interrupts cpu will come out of halt state.
> Not sure how safe it is from kexec point of view as we will be replacing
> original kernel that means if cpu comes out of halt state it might be
> running some random code.
> 
> Eric/hpa might know better the context here and what safeguards us on x86.
> 
> So one should not make cpu spin on some code as kexec will change that
> code. It should be some other platform specific mechanism which brings
> cpu in to hlt like state. So that way arm seems to be doing right thing.
> 
> I am not sure what powerpc does to stop cpus.
> 

powerpc shepherds all CPUs to a safe state, by making them run kexec_smp_down(),
and eventually those CPUs end up calling kexec_wait() in assembly.

Regards,
Srivatsa S. Bhat

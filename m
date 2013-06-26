Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58B092C02C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 18:44:30 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 14:05:45 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 20032394004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 14:14:24 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5Q8iHnC24969286
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 14:14:18 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5Q8iIwt029082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 08:44:21 GMT
Message-ID: <51CAA921.7030906@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 14:11:05 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 29/45] kvm/vmx: Use get/put_online_cpus_atomic() to
 prevent CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625203043.16593.1600.stgit@srivatsabhat.in.ibm.com>
 <51CA9C5E.1030609@redhat.com> <51CAA116.2060906@linux.vnet.ibm.com>
 <51CAA514.8050609@redhat.com>
In-Reply-To: <51CAA514.8050609@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 oleg@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, walken@google.com,
 mingo@kernel.org, linux-arch@vger.kernel.org, vincent.guittot@linaro.org,
 Gleb Natapov <gleb@redhat.com>, x86@kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2013 01:53 PM, Paolo Bonzini wrote:
> Il 26/06/2013 10:06, Srivatsa S. Bhat ha scritto:
>> On 06/26/2013 01:16 PM, Paolo Bonzini wrote:
>>> Il 25/06/2013 22:30, Srivatsa S. Bhat ha scritto:
>>>> -	cpu = get_cpu();
>>>> +	cpu = get_online_cpus_atomic();
>>>>  	vmx_vcpu_load(&vmx->vcpu, cpu);
>>>>  	vmx->vcpu.cpu = cpu;
>>>>  	err = vmx_vcpu_setup(vmx);
>>>>  	vmx_vcpu_put(&vmx->vcpu);
>>>> -	put_cpu();
>>>> +	put_online_cpus_atomic();
>>>
>>> The new API has a weird name.  Why are you adding new functions instead
>>> of just modifying get/put_cpu?
>>>
>>
>> Because the purpose of those two functions are distinctly different
>> from each other.
>>
>> get/put_cpu() is used to disable preemption on the local CPU. (Which
>> also disables offlining the local CPU during that critical section).
> 
> Ok, then I understood correctly... and I acked the other KVM patch.
>

Thank you!
 
> However, keeping the code on the local CPU is exactly the point of this
> particular use of get_cpu()/put_cpu().  Why does it need to synchronize
> with offlining of other CPUs?
> 

Now that I looked at it again, I think you are right, get/put_cpu() is
good enough here.

But let me explain why I initially thought we needed full synchronization
with CPU offline. In short, I wanted to synchronize the calls to
__loaded_vmcs_clear(). We have the scenario shown below:

CPU offline:
	CPU_DYING:
		hardware_disable();
		->vmclear_local_loaded_vmcss();
		  ->__loaded_vmcs_clear(v);



And vmx_vcpu_load() (among others) can do:
       vmx_vcpu_load();
       -> loaded_vmcs_clear();
          -> __loaded_vmcs_clear();


So I wanted to avoid this race-condition and hence wrapped the code with
get/put_online_cpus_atomic().

But the point I missed earlier is that loaded_vmcs_clear() calls
__loaded_vmcs_clear() using smp_call_function_single(), which itself
synchronizes properly with CPU hotplug. So there is no need to add full
hotplug synchronization in the vmx code, as you noted above.

So, please ignore this patch, and sorry for the noise!

Regards,
Srivatsa S. Bhat

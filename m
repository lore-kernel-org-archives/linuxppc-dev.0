Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 585DD2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 18:25:11 +1000 (EST)
Message-ID: <51CAA514.8050609@redhat.com>
Date: Wed, 26 Jun 2013 10:23:48 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 29/45] kvm/vmx: Use get/put_online_cpus_atomic() to
 prevent CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625203043.16593.1600.stgit@srivatsabhat.in.ibm.com>
 <51CA9C5E.1030609@redhat.com> <51CAA116.2060906@linux.vnet.ibm.com>
In-Reply-To: <51CAA116.2060906@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Gleb Natapov <gleb@redhat.com>, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, kvm@vger.kernel.org, x86@kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 26/06/2013 10:06, Srivatsa S. Bhat ha scritto:
> On 06/26/2013 01:16 PM, Paolo Bonzini wrote:
>> Il 25/06/2013 22:30, Srivatsa S. Bhat ha scritto:
>>> -	cpu = get_cpu();
>>> +	cpu = get_online_cpus_atomic();
>>>  	vmx_vcpu_load(&vmx->vcpu, cpu);
>>>  	vmx->vcpu.cpu = cpu;
>>>  	err = vmx_vcpu_setup(vmx);
>>>  	vmx_vcpu_put(&vmx->vcpu);
>>> -	put_cpu();
>>> +	put_online_cpus_atomic();
>>
>> The new API has a weird name.  Why are you adding new functions instead
>> of just modifying get/put_cpu?
>>
> 
> Because the purpose of those two functions are distinctly different
> from each other.
> 
> get/put_cpu() is used to disable preemption on the local CPU. (Which
> also disables offlining the local CPU during that critical section).

Ok, then I understood correctly... and I acked the other KVM patch.

However, keeping the code on the local CPU is exactly the point of this
particular use of get_cpu()/put_cpu().  Why does it need to synchronize
with offlining of other CPUs?

Paolo

> What this patchset deals with is synchronizing with offline of *any*
> CPU. Typically, we use get_online_cpus()/put_online_cpus() for that
> purpose. But they can't be used in atomic context, because they take
> mutex locks and hence can sleep.
> 
> So the code that executes in atomic context and which wants to prevent
> *any* CPU from going offline, used to disable preemption around its
> critical section. Disabling preemption prevents stop_machine(), and
> CPU offline (of *any* CPU) was done via stop_machine(). So disabling
> preemption disabled any CPU from going offline, as a *side-effect*.
> 
> And this patchset prepares the ground for getting rid of stop_machine()
> in the CPU offline path. Which means, disabling preemption only prevents
> the *local* CPU from going offline. So if code in atomic context wants
> to prevent any CPU from going offline, we need a new set of APIs, like
> get/put_online_cpus(), but which can be invoked from atomic context.
> That's why I named it as get/put_online_cpus_atomic().
> 
> One of the key points here is that we want to preserve get/put_cpu()
> as it is, since its purpose is different - disable preemption and
> offline of the local CPU. There is no reason to change that API, its
> useful as it is.

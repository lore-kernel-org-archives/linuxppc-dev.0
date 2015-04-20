Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0141.outbound.protection.outlook.com [157.56.110.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B050C1A1972
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:53:55 +1000 (AEST)
Message-ID: <5534DAA4.3050809@freescale.com>
Date: Mon, 20 Apr 2015 13:53:24 +0300
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>				
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>				
 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>				
 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de>			
 <1424999159.4698.78.camel@freescale.com> <55158E6D.40304@freescale.com>		
 <1428016310.22867.289.camel@freescale.com>	 <551E4A41.1080705@freescale.com>
 <1428096375.22867.369.camel@freescale.com>	 <55262DD3.2050707@freescale.com>
 <1428623611.22867.561.camel@freescale.com>
In-Reply-To: <1428623611.22867.561.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10.04.2015 02:53, Scott Wood wrote:
> On Thu, 2015-04-09 at 10:44 +0300, Purcareata Bogdan wrote:
>> So at this point I was getting kinda frustrated so I decided to measure
>> the time spend in kvm_mpic_write and kvm_mpic_read. I assumed these were
>> the main entry points in the in-kernel MPIC and were basically executed
>> while holding the spinlock. The scenario was the same - 24 VCPUs guest,
>> with 24 virtio+vhost interfaces, only this time I ran 24 ping flood
>> threads to another board instead of netperf. I assumed this would impose
>> a heavier stress.
>>
>> The latencies look pretty ok, around 1-2 us on average, with the max
>> shown below:
>>
>> .kvm_mpic_read	14.560
>> .kvm_mpic_write	12.608
>>
>> Those are also microseconds. This was run for about 15 mins.
>
> What about other entry points such as kvm_set_msi() and
> kvmppc_mpic_set_epr()?

Thanks for the pointers! I redid the measurements, this time for the functions 
run with the openpic lock down:

.kvm_mpic_read_internal (.kvm_mpic_read)	1.664
.kvmppc_mpic_set_epr				6.880
.kvm_mpic_write_internal (.kvm_mpic_write)	7.840
.openpic_msi_write (.kvm_set_msi)		10.560

Same scenario, 15 mins, numbers are microseconds.

There was a weird situation for .kvmppc_mpic_set_epr - its corresponding inner 
function is kvmppc_set_epr, which is a static inline. Removing the static inline 
yields a compiler crash (Segmentation fault (core dumped) - 
scripts/Makefile.build:441: recipe for target 'arch/powerpc/kvm/kvm.o' failed), 
but that's a different story, so I just let it be for now. Point is the time may 
include other work after the lock has been released, but before the function 
actually returned. I noticed this was the case for .kvm_set_msi, which could 
work up to 90 ms, not actually under the lock. This made me change what I'm 
looking at.

So far it looks pretty decent. Are there any other MPIC entry points worthy of 
investigation? Or perhaps a different stress scenario involving a lot of VCPUs 
and external interrupts?

Thanks,
Bogdan P.

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 0FA75B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 20:34:58 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-9-git-send-email-agraf@suse.de>
	<4C27220D.7090508@redhat.com>
Message-Id: <C45453BB-0B06-4089-9E44-C9FED2D78646@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C27220D.7090508@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 08/26] KVM: PPC: Add PV guest critical sections
Date: Sun, 27 Jun 2010 12:35:22 +0200
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 27.06.2010 um 12:03 schrieb Avi Kivity <avi@redhat.com>:

> On 06/26/2010 02:24 AM, Alexander Graf wrote:
>> When running in hooked code we need a way to disable interrupts  
>> without
>> clobbering any interrupts or exiting out to the hypervisor.
>>
>> To achieve this, we have an additional critical field in the shared  
>> page. If
>> that field is equal to the r1 register of the guest, it tells the  
>> hypervisor
>> that we're in such a critical section and thus may not receive any  
>> interrupts.
>>
>>
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -251,14 +251,25 @@ int kvmppc_book3s_irqprio_deliver(struct  
>> kvm_vcpu *vcpu, unsigned int priority)
>>      int deliver = 1;
>>      int vec = 0;
>>      ulong flags = 0ULL;
>> +    ulong crit_raw = vcpu->arch.shared->critical;
>> +    ulong crit_r1 = kvmppc_get_gpr(vcpu, 1);
>> +    bool crit;
>> +
>> +    /* Truncate crit indicators in 32 bit mode */
>> +    if (!(vcpu->arch.shared->msr&  MSR_SF)) {
>> +        crit_raw&= 0xffffffff;
>> +        crit_r1&= 0xffffffff;
>> +    }
>> +
>> +    crit = (crit_raw == crit_r1);
>>
>
> I think you need to qualify that for supervisor mode only.   
> Otherwise guest userspace can guess the value of shared->critical  
> and disable interrupts.


Yes, you're right. Good catch!

Alex

>

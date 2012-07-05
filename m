Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24F9F2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 09:51:56 +1000 (EST)
Message-ID: <4FF62891.9020702@freescale.com>
Date: Thu, 5 Jul 2012 18:51:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-ppc] [RFC PATCH 04/17] KVM: PPC64: booke: Add guest
 computation mode for irq delivery
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-5-git-send-email-mihai.caraman@freescale.com>
 <E29E8A28-9993-4E6C-B41A-7C0AA51945F3@suse.de>
In-Reply-To: <E29E8A28-9993-4E6C-B41A-7C0AA51945F3@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: kvm-ppc@vger.kernel.org, Mihai Caraman <mihai.caraman@freescale.com>,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2012 08:40 AM, Alexander Graf wrote:
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>> @@ -381,7 +386,8 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
>> 			set_guest_esr(vcpu, vcpu->arch.queued_esr);
>> 		if (update_dear == true)
>> 			set_guest_dear(vcpu, vcpu->arch.queued_dear);
>> -		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
>> +		kvmppc_set_msr(vcpu, (vcpu->arch.shared->msr & msr_mask)
>> +				| msr_cm);
> 
> Please split this computation out into its own variable and apply the masking regardless. Something like
> 
> ulong new_msr = vcpu->arch.shared->msr;
> if (vcpu->arch.epcr & SPRN_EPCR_ICM)
>     new_msr |= MSR_CM;
> new_msr &= msr_mask;
> kvmppc_set_msr(vcpu, new_msr);

This will fail to clear MSR[CM] in the odd but legal situation where you
have MSR[CM] set but EPCR[ICM] unset.

-Scott

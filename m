Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 329032C0203
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 17:03:27 +1000 (EST)
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-5-git-send-email-mihai.caraman@freescale.com>
 <E29E8A28-9993-4E6C-B41A-7C0AA51945F3@suse.de>
 <4FF62891.9020702@freescale.com>
In-Reply-To: <4FF62891.9020702@freescale.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <54351CA8-0493-474C-B851-69E371E85911@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-ppc] [RFC PATCH 04/17] KVM: PPC64: booke: Add guest
 computation mode for irq delivery
Date: Fri, 6 Jul 2012 09:03:56 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 Mihai Caraman <mihai.caraman@freescale.com>,
 "<qemu-ppc@nongnu.org>" <qemu-ppc@nongnu.org>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06.07.2012, at 01:51, Scott Wood <scottwood@freescale.com> wrote:

> On 07/04/2012 08:40 AM, Alexander Graf wrote:
>> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>>> @@ -381,7 +386,8 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_v=
cpu *vcpu,
>>>            set_guest_esr(vcpu, vcpu->arch.queued_esr);
>>>        if (update_dear =3D=3D true)
>>>            set_guest_dear(vcpu, vcpu->arch.queued_dear);
>>> -        kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
>>> +        kvmppc_set_msr(vcpu, (vcpu->arch.shared->msr & msr_mask)
>>> +                | msr_cm);
>>=20
>> Please split this computation out into its own variable and apply the mas=
king regardless. Something like
>>=20
>> ulong new_msr =3D vcpu->arch.shared->msr;
>> if (vcpu->arch.epcr & SPRN_EPCR_ICM)
>>    new_msr |=3D MSR_CM;
>> new_msr &=3D msr_mask;
>> kvmppc_set_msr(vcpu, new_msr);
>=20
> This will fail to clear MSR[CM] in the odd but legal situation where you
> have MSR[CM] set but EPCR[ICM] unset.

Ah. Good point. Then leave the msr_mask logic as before and only stretch it o=
ut into its own variable.

Alex

>=20
> -Scott
>=20

Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93BF7B6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 01:24:09 +1000 (EST)
Message-ID: <4FEB258A.7010601@freescale.com>
Date: Wed, 27 Jun 2012 10:23:54 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Subject: Re: [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support in sregs
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
 <4FEA3907.8080500@freescale.com>
 <300B73AA675FCE4A93EB4FC1D42459FF151D68@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF151D68@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2012 06:41 AM, Caraman Mihai Claudiu-B02008 wrote:
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Wednesday, June 27, 2012 1:35 AM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
>> Subject: Re: [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support in
>> sregs
>>
>> On 06/25/2012 07:26 AM, Mihai Caraman wrote:
>>> Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs for
>>> 64-bit hosts.
>>>
>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>> ---
>>>  arch/powerpc/kvm/booke.c |   14 ++++++++++++++
>>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c index
>>> f9fa260..d15c4b5 100644
>>> --- a/arch/powerpc/kvm/booke.c
>>> +++ b/arch/powerpc/kvm/booke.c
>>> @@ -1052,6 +1052,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
>>>  	u64 tb = get_tb();
>>>
>>>  	sregs->u.e.features |= KVM_SREGS_E_BASE;
>>> +#ifdef CONFIG_64BIT
>>> +	sregs->u.e.features |= KVM_SREGS_E_64;0 #endif
>>>
>>>  	sregs->u.e.csrr0 = vcpu->arch.csrr0;
>>>  	sregs->u.e.csrr1 = vcpu->arch.csrr1; @@ -1063,6 +1066,9 @@ static
>>> void get_sregs_base(struct kvm_vcpu *vcpu,
>>>  	sregs->u.e.dec = kvmppc_get_dec(vcpu, tb);
>>>  	sregs->u.e.tb = tb;
>>>  	sregs->u.e.vrsave = vcpu->arch.vrsave;
>>> +#ifdef CONFIG_64BIT
>>> +	sregs->u.e.epcr = vcpu->arch.epcr;
>>> +#endif
>>>  }
>>>
>>>  static int set_sregs_base(struct kvm_vcpu *vcpu, @@ -1071,6 +1077,11
>>> @@ static int set_sregs_base(struct kvm_vcpu *vcpu,
>>>  	if (!(sregs->u.e.features & KVM_SREGS_E_BASE))
>>>  		return 0;
>>>
>>> +#ifdef CONFIG_64BIT
>>> +	if (!(sregs->u.e.features & KVM_SREGS_E_64))
>>> +		return 0;
>>> +#endif
>>
>> This means that a QEMU targeting a 32-bit guest won't be able to set any
>> special registers, if it sets feature bits manually rather than getting
>> them from GET_SREGS.
> 
> I had some concerns about his. I only check qemu ppc code which uses get/set
> approach and I followed the BASE model. Now I see that qemu x86 set them manually :(
> Why do we care if the caller set or not BASE?

BASE contains things which should be present on all booke chips.  If
that's not set something's wrong.

None of the other feature bits are handled that way.

-Scott

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC771B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 22:04:03 +1100 (EST)
Subject: Re: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F4BD95B.9010809@freescale.com>
Date: Tue, 28 Feb 2012 12:03:56 +0100
Message-Id: <8C85FFCE-616B-4A3C-BD43-08997DB1E0B1@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-25-git-send-email-agraf@suse.de>
 <4F4BD95B.9010809@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.02.2012, at 20:28, Scott Wood wrote:

> On 02/24/2012 08:26 AM, Alexander Graf wrote:
>> -void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>> +int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>> {
>> 	unsigned long *pending =3D &vcpu->arch.pending_exceptions;
>> 	unsigned long old_pending =3D vcpu->arch.pending_exceptions;
>> @@ -283,6 +283,8 @@ void kvmppc_core_prepare_to_enter(struct kvm_vcpu =
*vcpu)
>>=20
>> 	/* Tell the guest about our interrupt status */
>> 	kvmppc_update_int_pending(vcpu, *pending, old_pending);
>> +
>> +	return 0;
>> }
>>=20
>> pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn)
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 9979be1..3fcec2c 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -439,8 +439,9 @@ static void kvmppc_core_check_exceptions(struct =
kvm_vcpu *vcpu)
>> }
>>=20
>> /* Check pending exceptions and deliver one, if possible. */
>> -void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>> +int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
>> {
>> +	int r =3D 0;
>> 	WARN_ON_ONCE(!irqs_disabled());
>>=20
>> 	kvmppc_core_check_exceptions(vcpu);
>> @@ -451,8 +452,44 @@ void kvmppc_core_prepare_to_enter(struct =
kvm_vcpu *vcpu)
>> 		local_irq_disable();
>>=20
>> 		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
>> -		kvmppc_core_check_exceptions(vcpu);
>> +		r =3D 1;
>> 	};
>> +
>> +	return r;
>> +}
>> +
>> +/*
>> + * Common checks before entering the guest world.  Call with =
interrupts
>> + * disabled.
>> + *
>> + * returns !0 if a signal is pending and check_signal is true
>> + */
>> +static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu, bool =
check_signal)
>> +{
>> +	int r =3D 0;
>> +
>> +	WARN_ON_ONCE(!irqs_disabled());
>> +	while (true) {
>> +		if (need_resched()) {
>> +			local_irq_enable();
>> +			cond_resched();
>> +			local_irq_disable();
>> +			continue;
>> +		}
>> +
>> +		if (kvmppc_core_prepare_to_enter(vcpu)) {
>> +			/* interrupts got enabled in between, so we
>> +			   are back at square 1 */
>> +			continue;
>> +		}
>> +
>> +
>> +		if (check_signal && signal_pending(current))
>> +			r =3D 1;
>=20
> If there is a signal pending and MSR[WE] is set, we'll loop forever
> without reaching this check.

Good point. How about something like this on top (will fold in later)?

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 430055e..9f27258 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -477,15 +477,17 @@ static int kvmppc_prepare_to_enter(struct kvm_vcpu =
*vcpu)
                        continue;
                }
=20
+               if (signal_pending(current)) {
+                       r =3D 1;
+                       break;
+               }
+
                if (kvmppc_core_prepare_to_enter(vcpu)) {
                        /* interrupts got enabled in between, so we
                           are back at square 1 */
                        continue;
                }
=20
-               if (signal_pending(current))
-                       r =3D 1;
-
                break;
        }
=20

Alex

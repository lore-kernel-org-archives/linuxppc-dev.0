Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1B2F2C0205
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 03:53:31 +1000 (EST)
Subject: Re: [RFC PATCH 06/17] KVM: PPC: e500: Add emulation helper for
 getting instruction ea
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF15B1B3@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 11 Jul 2012 19:53:23 +0200
Message-Id: <FE1AF4F0-65E7-491B-A839-7A33D64F13BC@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-7-git-send-email-mihai.caraman@freescale.com>
 <3307E7D5-838B-462D-AFE9-B8BC107496CD@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15B1B3@039-SN2MPN1-013.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
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


On 05.07.2012, at 13:39, Caraman Mihai Claudiu-B02008 wrote:

>> -----Original Message-----
>> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
>> owner@vger.kernel.org] On Behalf Of Alexander Graf
>> Sent: Wednesday, July 04, 2012 4:56 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
>> Subject: Re: [RFC PATCH 06/17] KVM: PPC: e500: Add emulation helper =
for
>> getting instruction ea
>>=20
>>=20
>> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>>=20
>>> Add emulation helper for getting instruction ea and refactor tlb
>> instruction
>>> emulation to use it.
>>>=20
>>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>>> ---
>>> arch/powerpc/kvm/e500.h         |    6 +++---
>>> arch/powerpc/kvm/e500_emulate.c |   21 ++++++++++++++++++---
>>> arch/powerpc/kvm/e500_tlb.c     |   23 ++++++-----------------
>>> 3 files changed, 27 insertions(+), 23 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
>>> index 3e31098..70bfed4 100644
>>> --- a/arch/powerpc/kvm/e500.h
>>> +++ b/arch/powerpc/kvm/e500.h
>>> @@ -130,9 +130,9 @@ int kvmppc_e500_emul_mt_mmucsr0(struct
>> kvmppc_vcpu_e500 *vcpu_e500,
>>> 				ulong value);
>>> int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
>>> int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
>>> -int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int =
rb);
>>> -int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, =
int
>> rb);
>>> -int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
>>> +int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, gva_t ea);
>>> +int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, gva_t =
ea);
>>> +int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea);
>>> int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
>>> void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
>>>=20
>>> diff --git a/arch/powerpc/kvm/e500_emulate.c
>> b/arch/powerpc/kvm/e500_emulate.c
>>> index 8b99e07..81288f7 100644
>>> --- a/arch/powerpc/kvm/e500_emulate.c
>>> +++ b/arch/powerpc/kvm/e500_emulate.c
>>> @@ -82,6 +82,17 @@ static int kvmppc_e500_emul_msgsnd(struct =
kvm_vcpu
>> *vcpu, int rb)
>>> }
>>> #endif
>>>=20
>>> +static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, =
int
>> ra, int rb)
>>> +{
>>> +	ulong ea;
>>> +
>>> +	ea =3D kvmppc_get_gpr(vcpu, rb);
>>> +	if (ra)
>>> +		ea +=3D kvmppc_get_gpr(vcpu, ra);
>>> +
>>> +	return ea;
>>> +}
>>> +
>>=20
>> Please move this one to arch/powerpc/include/asm/kvm_ppc.h.
>=20
> Yep. This is similar with what I had in my internal version before =
emulation
> refactoring took place upstream. The only difference is that I split =
the embedded
> and server implementation touching this files:
> 	arch/powerpc/include/asm/kvm_booke.h
> 	arch/powerpc/include/asm/kvm_book3s.h
>=20
> Which approach do you prefer?

This is generic code to me, so it shouldn't go into booke/book3s =
specific files.

>=20
>>=20
>>> int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu =
*vcpu,
>>>                           unsigned int inst, int *advance)
>>> {
>>> @@ -89,6 +100,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run,
>> struct kvm_vcpu *vcpu,
>>> 	int ra =3D get_ra(inst);
>>> 	int rb =3D get_rb(inst);
>>> 	int rt =3D get_rt(inst);
>>> +	gva_t ea;
>>>=20
>>> 	switch (get_op(inst)) {
>>> 	case 31:
>>> @@ -113,15 +125,18 @@ int kvmppc_core_emulate_op(struct kvm_run =
*run,
>> struct kvm_vcpu *vcpu,
>>> 			break;
>>>=20
>>> 		case XOP_TLBSX:
>>> -			emulated =3D kvmppc_e500_emul_tlbsx(vcpu,rb);
>>> +			ea =3D kvmppc_get_ea_indexed(vcpu, ra, rb);
>>> +			emulated =3D kvmppc_e500_emul_tlbsx(vcpu, ea);
>>> 			break;
>>>=20
>>> 		case XOP_TLBILX:
>>> -			emulated =3D kvmppc_e500_emul_tlbilx(vcpu, rt, =
ra, rb);
>>> +			ea =3D kvmppc_get_ea_indexed(vcpu, ra, rb);
>>> +			emulated =3D kvmppc_e500_emul_tlbilx(vcpu, rt, =
ea);
>>=20
>> What's the point in hiding ra+rb, but not rt? I like the idea of =
hiding
>> the register semantics, but please move rt into a local variable that
>> gets passed as pointer to kvmppc_e500_emul_tlbilx.
>=20
> Why to send it as a pointer? rt which should be rather named t in this =
case
> is an [in] value for tlbilx, according to section 6.11.4.9 in the =
PowerISA 2.06b.

Because usually rt in the PPC ISA denotes a _t_arget _r_egister. The =
field here really is called "T" to denote the _t_ype of the operation =
which you correctly pointed out. Could you please change this misnaming =
along the way and mask it accordingly?


Alex

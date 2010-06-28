Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id F0842B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 16:33:12 +1000 (EST)
Subject: Re: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C282794.1040209@ozlabs.org>
Date: Mon, 28 Jun 2010 08:33:09 +0200
Message-Id: <168E1B5F-44F7-4FF5-80A5-64B0E2E94D68@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-19-git-send-email-agraf@suse.de>
	<4C282794.1040209@ozlabs.org>
To: Matt Evans <matt@ozlabs.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.06.2010, at 06:39, Matt Evans wrote:

> Howdy Alex!
>=20
> Alexander Graf wrote:
>> We will soon start and replace instructions from the text section =
with
>> other, paravirtualized versions. To ease the readability of those =
patches
>> I split out the generic looping and magic page mapping code out.
>>=20
>> This patch still only contains stubs. But at least it loops through =
the
>> text section :).
>>=20
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>> arch/powerpc/kernel/kvm.c |   59 =
+++++++++++++++++++++++++++++++++++++++++++++
>> 1 files changed, 59 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
>> index 2d8dd73..d873bc6 100644
>> --- a/arch/powerpc/kernel/kvm.c
>> +++ b/arch/powerpc/kernel/kvm.c
>> @@ -32,3 +32,62 @@
>> #define KVM_MAGIC_PAGE		(-4096L)
>> #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct =
kvm_vcpu_arch_shared, x)
>>=20
>> +static bool kvm_patching_worked =3D true;
>> +
>> +static void kvm_map_magic_page(void *data)
>> +{
>> +	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
>> +		       KVM_MAGIC_PAGE,  /* Physical Address */
>> +		       KVM_MAGIC_PAGE); /* Effective Address */
>> +}
>> +
>> +static void kvm_check_ins(u32 *inst)
>> +{
>> +	u32 _inst =3D *inst;
>> +	u32 inst_no_rt =3D _inst & ~KVM_MASK_RT;
>> +	u32 inst_rt =3D _inst & KVM_MASK_RT;
>> +
>> +	switch (inst_no_rt) {
>> +	}
>> +
>> +	switch (_inst) {
>> +	}
>> +
>> +	flush_icache_range((ulong)inst, (ulong)inst + 4);
>> +}
>> +
>> +static void kvm_use_magic_page(void)
>> +{
>> +	u32 *p;
>> +	u32 *start, *end;
>> +
>> +	/* Tell the host to map the magic page to -4096 on all CPUs */
>> +
>> +	on_each_cpu(kvm_map_magic_page, NULL, 1);
>> +
>> +	/* Now loop through all code and find instructions */
>> +
>> +	start =3D (void*)_stext;
>> +	end =3D (void*)_etext;
>> +
>> +	for (p =3D start; p < end; p++)
>> +		kvm_check_ins(p);
>> +}
>=20
> Could you do something similar in module_finalize() to patch loaded =
modules' .text sections?

I could, but do we need it? I objdump -d | grep'ed all my modules and =
didn't find any need to do so.


Alex

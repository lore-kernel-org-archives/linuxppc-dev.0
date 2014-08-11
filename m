Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D1671A0884
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 09:53:56 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] KVM: PPC: e500mc: Add support for single threaded vcpus
 on e6500 core
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1407800199.7427.108.camel@snotra.buserror.net>
Date: Tue, 12 Aug 2014 01:53:52 +0200
Message-Id: <3CE03B7F-D9C3-4CD0-8215-9815494A19AF@suse.de>
References: <1407342808-15987-1-git-send-email-mihai.caraman@freescale.com>
 <1407800199.7427.108.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 12.08.2014 um 01:36 schrieb Scott Wood <scottwood@freescale.com>:
>=20
>> On Wed, 2014-08-06 at 19:33 +0300, Mihai Caraman wrote:
>> @@ -390,19 +400,30 @@ static void kvmppc_core_vcpu_free_e500mc(struct kvm=
_vcpu *vcpu)
>>=20
>> static int kvmppc_core_init_vm_e500mc(struct kvm *kvm)
>> {
>> -    int lpid;
>> +    int i, lpid;
>>=20
>> -    lpid =3D kvmppc_alloc_lpid();
>> -    if (lpid < 0)
>> -        return lpid;
>> +    /* The lpid pool supports only 2 entries now */
>> +    if (threads_per_core > 2)
>> +        return -ENOMEM;
>> +
>> +    /* Each VM allocates one LPID per HW thread index */
>> +    for (i =3D 0; i < threads_per_core; i++) {
>> +        lpid =3D kvmppc_alloc_lpid();
>> +        if (lpid < 0)
>> +            return lpid;
>> +
>> +        kvm->arch.lpid_pool[i] =3D lpid;
>> +    }
>=20
> Wouldn't it be simpler to halve the size of the lpid pool that the
> allocator sees, and just OR in the high bit based on the low bit of the
> cpu number?

Heh, I wrote the same and then removed the section from my reply again. It w=
ouldn't really make that much of a difference if you think it through comple=
tely.

But yes, it certainly would be quite a bit more natural. I'm ok either way.


Alex

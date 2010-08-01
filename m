Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 737D9B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 Aug 2010 06:20:42 +1000 (EST)
Subject: Re: [PATCH 4/7] KVM: PPC: Add book3s_32 tlbie flush acceleration
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C557FF1.4000400@redhat.com>
Date: Sun, 1 Aug 2010 22:20:37 +0200
Message-Id: <9F2B6C37-4D0E-46F4-9D15-CC785C2DDBD4@suse.de>
References: <1280408662-10328-1-git-send-email-agraf@suse.de>
	<1280408662-10328-5-git-send-email-agraf@suse.de>
	<4C557FF1.4000400@redhat.com>
To: Avi Kivity <avi@redhat.com>
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


On 01.08.2010, at 16:08, Avi Kivity wrote:

> On 07/29/2010 04:04 PM, Alexander Graf wrote:
>> On Book3s_32 the tlbie instruction flushed effective addresses by the =
mask
>> 0x0ffff000. This is pretty hard to reflect with a hash that hashes =
~0xfff, so
>> to speed up that target we should also keep a special hash around for =
it.
>>=20
>>=20
>>  static inline u64 kvmppc_mmu_hash_vpte(u64 vpage)
>>  {
>>  	return hash_64(vpage&  0xfffffffffULL, HPTEG_HASH_BITS_VPTE);
>> @@ -66,6 +72,11 @@ void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu =
*vcpu, struct hpte_cache *pte)
>>  	index =3D kvmppc_mmu_hash_pte(pte->pte.eaddr);
>>  	=
hlist_add_head_rcu(&pte->list_pte,&vcpu->arch.hpte_hash_pte[index]);
>>=20
>> +	/* Add to ePTE_long list */
>> +	index =3D kvmppc_mmu_hash_pte_long(pte->pte.eaddr);
>> +	hlist_add_head_rcu(&pte->list_pte_long,
>> +			&vcpu->arch.hpte_hash_pte_long[index]);
>> +
>=20
> Isn't it better to make operations on this list conditional on =
Book3s_32?  Hashes are expensive since they usually cost cache misses.

Yes, the same for vpte_long and vpte - book3s_32 guests don't need them =
except for the all flush. The tough part is that this is not host but =
guest dependent, so I need to have different structs for book3s_32 and =
book3s_64 guests. This isn't a big issue, but complicates the code.

> Can of course be done later as an optimization.

Yes, that was the plan. Great to see you got the same feeling there =
though :). To be honest, I even started a book3s_32 host optimization =
patch and threw it away because it made the code less readable. So yes, =
this is on my radar.


Alex

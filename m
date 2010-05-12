Return-Path: <yoshikawa.takuya@oss.ntt.co.jp>
Received: from serv2.oss.ntt.co.jp (serv2.oss.ntt.co.jp [222.151.198.100])
	by ozlabs.org (Postfix) with ESMTP id 348BCB7DBF
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 16:24:02 +1000 (EST)
Message-ID: <4BEA4A62.20100@oss.ntt.co.jp>
Date: Wed, 12 May 2010 15:27:46 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
MIME-Version: 1.0
To: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC][PATCH RFC 10/12] KVM: move dirty bitmaps to user space
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220702.f8ba6ccc.takuya.yoshikawa@gmail.com>
	<20100511032827.GA3458@amt.cnet>
In-Reply-To: <20100511032827.GA3458@amt.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, kvm@vger.kernel.org,
	kvm-ia64@vger.kernel.org, fernando@oss.ntt.co.jp, x86@kernel.org,
	agraf@suse.de, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, avi@redhat.com,
	hpa@zytor.com, tglx@linutronix.de,
	Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>   	r = 0;
>> @@ -1195,11 +1232,16 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
>>   	gfn = unalias_gfn(kvm, gfn);
>>   	memslot = gfn_to_memslot_unaliased(kvm, gfn);
>>   	if (memslot&&  memslot->dirty_bitmap) {
>> -		unsigned long rel_gfn = gfn - memslot->base_gfn;
>> +		int nr = generic_le_bit_offset(gfn - memslot->base_gfn);
>>
>> -		generic___set_le_bit(rel_gfn, memslot->dirty_bitmap);
>> +		if (kvm_set_bit_user(nr, memslot->dirty_bitmap))
>> +			goto out_fault;
>
> mark_page_dirty is called with the mmu_lock spinlock held in set_spte.
> Must find a way to move it outside of the spinlock section.
>

Oh, it's a serious problem. I have to consider it.


Thanks,
   Takuya

Return-Path: <yoshikawa.takuya@oss.ntt.co.jp>
Received: from serv2.oss.ntt.co.jp (serv2.oss.ntt.co.jp [222.151.198.100])
 by ozlabs.org (Postfix) with ESMTP id 5EF92B6FBC
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Dec 2011 16:28:23 +1100 (EST)
Message-ID: <4EF80090.7050008@oss.ntt.co.jp>
Date: Mon, 26 Dec 2011 14:05:20 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] KVM: PPC: Book3s HV: Implement get_dirty_log using
 hardware changed bit
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
 <20111215120322.GE20629@bloggs.ozlabs.ibm.com>
 <C59FE93D-AD1B-4382-BE8B-FF2DDD22930E@suse.de>
 <20111225233524.GA5348@sammy.paulus.ozlabs.org>
In-Reply-To: <20111225233524.GA5348@sammy.paulus.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Takuya Yoshikawa <takuya.yoshikawa@gmail.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2011/12/26 8:35), Paul Mackerras wrote:
> On Fri, Dec 23, 2011 at 02:23:30PM +0100, Alexander Graf wrote:
>
>> So if I read things correctly, this is the only case you're setting
>> pages as dirty. What if you have the following:
>>
>>    guest adds HTAB entry x
>>    guest writes to page mapped by x
>>    guest removes HTAB entry x
>>    host fetches dirty log
>
> In that case the dirtiness is preserved in the setting of the
> KVMPPC_RMAP_CHANGED bit in the rmap entry.  kvm_test_clear_dirty()
> returns 1 if that bit is set (and clears it).  Using the rmap entry
> for this is convenient because (a) we also use it for saving the
> referenced bit when a HTAB entry is removed, and we can transfer both
> R and C over in one operation; (b) we need to be able to save away the
> C bit in real mode, and we already need to get the real-mode address
> of the rmap entry -- if we wanted to save it in a dirty bitmap we'd
> have to do an extra translation to get the real-mode address of the
> dirty bitmap word; (c) to avoid SMP races, if we were asynchronously
> setting bits in the dirty bitmap we'd have to do the double-buffering
> thing that x86 does, which seems more complicated than using the rmap
> entry (which we already have a lock bit for).

 From my x86 dirty logging experience I have some concern about your code:
your code looks slow even when there is no/few dirty pages in the slot.

+	for (i = 0; i < memslot->npages; ++i) {
+		if (kvm_test_clear_dirty(kvm, rmapp))
+			__set_bit_le(i, map);
+		++rmapp;
+	}

The check is being done for each page and this can be very expensive because
the number of pages is not small.

	When we scan the dirty_bitmap 64 pages are checked at once and
	the problem is not so significant.

Though I do not know well what kvm-ppc's dirty logging is aiming at, I guess
reporting cleanliness without noticeable delay to the user-space is important.

	E.g. for VGA most of the cases are clean.  For live migration, the
	chance of seeing complete clean slot is small but almost all cases
	are sparse.

>
>> PS: Always CC kvm@vger for stuff that other might want to review
>> (basically all patches)

(Though I sometimes check kvm-ppc on the archives,)

GET_DIRTY_LOG thing will be welcome.

	Takuya

>
> So why do we have a separate kvm-ppc list then? :)

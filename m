Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8F92B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jul 2011 04:16:42 +1000 (EST)
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Shan Hai <haishan.bai@gmail.com>
In-Reply-To: <4E205A63.90401@gmail.com>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins>  <4E205A63.90401@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jul 2011 17:24:37 +0200
Message-ID: <1310743477.2586.358.camel@twins>
Mime-Version: 1.0
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-15 at 11:18 -0400, Shan Hai wrote:

> >> +	vma =3D find_vma(mm, address);
> > Uhm, find_vma() needs mmap_sem, and futex_atomic_cmpxchg_inatomic() is
> > most certainly not called with that lock held.
> >
>=20
> My fault, that will be fixed in the V2 patch.

But you cannot, the function isn't called _atomic_ just for kicks, its
used while holding spinlocks.

> >> +	if (likely(vma)) {
> >> +		/* only fixup present page */
> >> +		if (follow_page(vma, address, FOLL_WRITE)) {
> >> +			handle_mm_fault(mm, vma, address, FAULT_FLAG_WRITE);
> > So how can this toggle your sw dirty/young tracking, that's pretty much
> > what gup(.write=3D1) does too!
> >
>=20
> because of the kernel read only permission of the page is transparent
> to the follow_page(),  the handle_mm_fault() is not to be activated
> in the __get_use_pages(), so the gup(.write=3D1) could not help to fixup
> the write permission.

So why do you need the vma? Is it like I wrote earlier that you don't
have spare PTE bits and need the vma flags to see if it may become
writable?

gup(.write=3D1) not triggering this is a serious problem though, not
something you can just paper over. I wouldn't be at all surprised to
find there's more things broken because of that.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2552AB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 19:13:50 +1000 (EST)
Subject: Re: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shan Hai <haishan.bai@gmail.com>
In-Reply-To: <4E20037C.5070506@gmail.com>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310718056.2586.275.camel@twins>  <4E1FFC7B.4000209@gmail.com>
	<1310719445.2586.288.camel@twins>  <4E20037C.5070506@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jul 2011 19:12:56 +1000
Message-ID: <1310721176.4968.316.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
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

On Fri, 2011-07-15 at 17:08 +0800, Shan Hai wrote:
> The whole scenario should be,
> - the child process triggers a page fault at the first time access to
>      the lock, and it got its own writable page, but its *clean* for
>      the reason just for checking the status of the lock.
>      I am sorry for above "unbreakable COW".
> - the futex_lock_pi() is invoked because of the lock contention,
>      and the futex_atomic_cmpxchg_inatomic() tries to get the lock,
>      it found out the lock is free so tries to write to the lock for
>      reservation, a page fault occurs, because the page is read only
>      for kernel(e500 specific), and returns -EFAULT to the caller

There is nothing e500 specific about user read only pages being read
only for kernel. All architectures behave the same way here afaik.

_However_ there is something not totally x86-like in the fact that we
require handle_mm_fault() to deal with dirty and young tracking, which
means that we -will- fault for a non-dirty writeable page or for any
non-young page. It's quite possible that the page fault disabling occurs
before that and thus breaks those architectures (it's not only e500 and
afaik not only powerpc) while x86 works fine due to HW update of dirty
and young.

It might be something to look into.

Cheers,
Ben.

> - the fault_in_user_writeable() tries to fix the fault,
>      but from the get_user_pages() view everything is ok, because
>      the COW was already broken, retry futex_lock_pi_atomic()
> - futex_lock_pi_atomic() --> futex_atomic_cmpxchg_inatomic(),
>      another write protection page fault
> - infinite loop
> 
> 

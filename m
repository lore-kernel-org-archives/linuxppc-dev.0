Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1E021A0C45
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 07:02:20 +1100 (AEDT)
Date: Thu, 15 Jan 2015 21:01:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 4/8] x86/spinlock: Leftover conversion
 ACCESS_ONCE->READ_ONCE
Message-ID: <20150115200119.GA29684@redhat.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
 <1421312314-72330-5-git-send-email-borntraeger@de.ibm.com>
 <20150115193839.GA28727@redhat.com> <54B81A37.80109@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54B81A37.80109@de.ibm.com>
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/15, Christian Borntraeger wrote:
>
> Am 15.01.2015 um 20:38 schrieb Oleg Nesterov:
> > On 01/15, Christian Borntraeger wrote:
> >>
> >> --- a/arch/x86/include/asm/spinlock.h
> >> +++ b/arch/x86/include/asm/spinlock.h
> >> @@ -186,7 +186,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> >>  	__ticket_t head = ACCESS_ONCE(lock->tickets.head);
> >>
> >>  	for (;;) {
> >> -		struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
> >> +		struct __raw_tickets tmp = READ_ONCE(lock->tickets);
> >
> > Agreed, but what about another ACCESS_ONCE() above?
> >
> > Oleg.
>
> tickets.head is a scalar type, so ACCESS_ONCE does work fine with gcc 4.6/4.7.
> My goal was to convert all accesses on non-scalar types

I understand, but READ_ONCE(lock->tickets.head) looks better anyway and
arch_spin_lock() already use READ_ONCE() for this.

So why we should keep the last ACCESS_ONCE() in spinlock.h ? Just to make
another cosmetic cleanup which touches the same function later?

Oleg.

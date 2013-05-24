Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 54F8C2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 23:12:06 +1000 (EST)
Date: Fri, 24 May 2013 16:11:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
Message-ID: <20130524131104.GA11462@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
 <201305221559.01806.arnd@arndb.de>
 <20130524130032.GA10167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130524130032.GA10167@redhat.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, microblaze-uclinux@itee.uq.edu.au,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 24, 2013 at 04:00:32PM +0300, Michael S. Tsirkin wrote:
> On Wed, May 22, 2013 at 03:59:01PM +0200, Arnd Bergmann wrote:
> > On Thursday 16 May 2013, Michael S. Tsirkin wrote:
> > > @@ -178,7 +178,7 @@ do {                                                                \
> > >         long __pu_err;                                          \
> > >         __typeof__(*(ptr)) __user *__pu_addr = (ptr);           \
> > >         if (!is_kernel_addr((unsigned long)__pu_addr))          \
> > > -               might_sleep();                                  \
> > > +               might_fault();                                  \
> > >         __chk_user_ptr(ptr);                                    \
> > >         __put_user_size((x), __pu_addr, (size), __pu_err);      \
> > >         __pu_err;                                               \
> > > 
> > 
> > Another observation:
> > 
> > 	if (!is_kernel_addr((unsigned long)__pu_addr))
> > 		might_sleep();
> > 
> > is almost the same as
> > 
> > 	might_fault();
> > 
> > except that it does not call might_lock_read().
> > 
> > The version above may have been put there intentionally and correctly, but
> > if you want to replace it with might_fault(), you should remove the
> > "if ()" condition.
> > 
> > 	Arnd
> 
> Well not exactly. The non-inline might_fault checks the
> current segment, not the address.
> I'm guessing this is trying to do the same just without
> pulling in segment_eq, but I'd like a confirmation
> from more PPC maintainers.
> 
> Guys would you ack
> 
> - 	if (!is_kernel_addr((unsigned long)__pu_addr))
> - 		might_fault();
> + 	might_fault();
> 
> on top of this patch?

OK I spoke too fast: I found this:

    powerpc: Fix incorrect might_sleep in __get_user/__put_user on kernel addresses
    
    We have a case where __get_user and __put_user can validly be used
    on kernel addresses in interrupt context - namely, the alignment
    exception handler, as our get/put_unaligned just do a single access
    and rely on the alignment exception handler to fix things up in the
    rare cases where the cpu can't handle it in hardware.  Thus we can
    get alignment exceptions in the network stack at interrupt level.
    The alignment exception handler does a __get_user to read the
    instruction and blows up in might_sleep().
    
    Since a __get_user on a kernel address won't actually ever sleep,
    this makes the might_sleep conditional on the address being less
    than PAGE_OFFSET.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

So this won't work, unless we add the is_kernel_addr check
to might_fault. That will become possible on top of this patchset
but let's consider this carefully, and make this a separate
patchset, OK?

> Also, any volunteer to test this (not just test-build)?
> 
> -- 
> MST

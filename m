Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7F1EB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 08:58:05 +1000 (EST)
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW
	tracking of dirty & young
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <1311288726.25044.545.camel@pasglop>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins> <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop>
	<4b337921-d430-4b63-bc36-ad31753cf800@email.android.com>
	<1310912990.25044.203.camel@pasglop>
	<1310944453.25044.262.camel@pasglop>
	<1310961691.25044.274.camel@pasglop> <4E23D728.7090406@gmail.com>
	<1310972462.25044.292.camel@pasglop> <4E23E02C.8090401@gmail.com>
	<1310974591.25044.298.camel@pasglop> <4E24FA51.70602@gmail.com>
	<1311049762.25044.392.camel@pasglop>
	<20110721153606.37e6f432.akpm@linux-foundation.org>
	<1311288726.25044.545.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 22 Jul 2011 08:57:33 +1000
Message-ID: <1311289053.25044.550.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Shan Hai <haishan.bai@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-22 at 08:52 +1000, Benjamin Herrenschmidt wrote:

> > um, what problem.  There's no description here of the user-visible
> > effects of the bug hence it's hard to work out what kernel version(s)
> > should receive this patch.
> 
> Shan could give you an actual example (it was in the previous thread),
> but basically, livelock as the kernel keeps trying and trying the
> in_atomic op and never resolves it.
>  
> > What kernel version(s) should receive this patch?
> 
> I haven't dug. Probably anything it applies on as far as we did that
> trick of atomic + gup() for futex.

Oops, I just realize I didn't document the problem at all in the
changelog .. sorry. I meant to say:

On archs who use SW tracking of dirty & young, a page without dirty is
effectively mapped read-only and a page without young unaccessible in
the PTE.

Additionally, some architectures might lazily flush the TLB when
relaxing write protection (by doing only a local flush), and expect a
fault to invalidate the stale entry if it's still present on another
processor.

The futex code assumes that if the "in_atomic()" access -EFAULT's, it
can "fix it up" by causing get_user_pages() which would then be
equivalent to taking the fault.

However that isn't the case. get_user_pages() will not call
handle_mm_fault() in the case where the PTE seems to have the right
permissions, regardless of the dirty and young state. It will eventually
update those bits ... in the struct page, but not in the PTE. 

Additionally, it will not handle the lazy TLB flushing that can be
required by some architectures in the fault case.

Basically, gup is the wrong interface for the job. The patch provides a
more appropriate one which boils down to just calling handle_mm_fault()
since what we are trying to do is simulate a real page fault.

Cheers,
Ben.

> > > since I'm
> > > starting to have the nasty feeling that you are hitting what is
> > > somewhat a subtly different issue or my previous patch should
> > > have worked (but then I might have done a stupid mistake as well)
> > > but let us know anyway.
> > 
> > I assume that Shan reported the secret problem so I added the
> > reported-by to the changelog.
> 
> He did :-) Shan, care to provide a rough explanation of what you
> observed ?
> 
> Also Russell confirmed that ARM should be affected as well.
> 
> Cheers,
> Ben.

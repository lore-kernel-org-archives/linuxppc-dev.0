Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB1CBB6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 09:00:01 +1000 (EST)
Date: Thu, 21 Jul 2011 15:59:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW
	tracking of dirty & young
Message-Id: <20110721155938.2ff2dab5.akpm@linux-foundation.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 22 Jul 2011 08:52:06 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2011-07-21 at 15:36 -0700, Andrew Morton wrote:
> > On Tue, 19 Jul 2011 14:29:22 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > The futex code currently attempts to write to user memory within
> > > a pagefault disabled section, and if that fails, tries to fix it
> > > up using get_user_pages().
> > > 
> > > This doesn't work on archs where the dirty and young bits are
> > > maintained by software, since they will gate access permission
> > > in the TLB, and will not be updated by gup().
> > > 
> > > In addition, there's an expectation on some archs that a
> > > spurious write fault triggers a local TLB flush, and that is
> > > missing from the picture as well.
> > > 
> > > I decided that adding those "features" to gup() would be too much
> > > for this already too complex function, and instead added a new
> > > simpler fixup_user_fault() which is essentially a wrapper around
> > > handle_mm_fault() which the futex code can call.
> > > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > ---
> > > 
> > > Shan, can you test this ? It might not fix the problem
> > 
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

You're not understanding me.

I need a good reason to merge this into 3.0.

The -stable maintainers need even better reasons to merge this into
earlier kernels.

Please provide those reasons!

(Documentation/stable_kernel_rules.txt, 4th bullet)

(And it's not just me and -stable maintainers.  Distro maintainers will
also look at this patch and wonder whether they should merge it)

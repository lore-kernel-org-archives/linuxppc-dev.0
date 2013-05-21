Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42A422C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 22:39:09 +1000 (EST)
Date: Tue, 21 May 2013 13:21:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
Message-ID: <20130521112126.GJ26912@twins.programming.kicks-ass.net>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130519093526.GD19883@redhat.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
 rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
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

On Sun, May 19, 2013 at 12:35:26PM +0300, Michael S. Tsirkin wrote:
> On Thu, May 16, 2013 at 08:40:41PM +0200, Peter Zijlstra wrote:
> > On Thu, May 16, 2013 at 02:16:10PM +0300, Michael S. Tsirkin wrote:
> > > There are several ways to make sure might_fault
> > > calling function does not sleep.
> > > One is to use it on kernel or otherwise locked memory - apparently
> > > nfs/sunrpc does this. As noted by Ingo, this is handled by the
> > > migh_fault() implementation in mm/memory.c but not the one in
> > > linux/kernel.h so in the current code might_fault() schedules
> > > differently depending on CONFIG_PROVE_LOCKING, which is an undesired
> > > semantical side effect.
> > > 
> > > Another is to call pagefault_disable: in this case the page fault
> > > handler will go to fixups processing and we get an error instead of
> > > sleeping, so the might_sleep annotation is a false positive.
> > > vhost driver wants to do this now in order to reuse socket ops
> > > under a spinlock (and fall back on slower thread handler
> > > on error).
> > 
> > Are you using the assumption that spin_lock() implies preempt_disable() implies
> > pagefault_disable()? Note that this assumption isn't valid for -rt where the
> > spinlock becomes preemptible but we'll not disable pagefaults.
> 
> No, I was not assuming that. What I'm trying to say is that a caller
> that does something like this under a spinlock:
> 	preempt_disable
> 	pagefault_disable
> 	error = copy_to_user
> 	pagefault_enable
> 	preempt_enable_no_resched
> 
> is not doing anything wrong and should not get a warning,
> as long as error is handled correctly later.
> Right?

Aside from the no_resched() thing which Steven already explained and my
previous email asking why you need the preempt_disable() at all, that
should indeed work.

The reason I was asking was that I wasn't sure you weren't doing:

  spin_lock(&my_lock);
  error = copy_to_user();
  spin_unlock(&my_lock);

and expecting the copy_to_user() to always take the exception table
route. This works on mainline (since spin_lock implies a preempt disable
and preempt_disable is the same as pagefault_disable). However as should
be clear by now, it doesn't quite work that way for -rt.

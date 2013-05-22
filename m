Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD0B82C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 20:16:49 +1000 (EST)
Date: Wed, 22 May 2013 12:16:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
Message-ID: <20130522101610.GL18810@twins.programming.kicks-ass.net>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <20130521115734.GA9554@twins.programming.kicks-ass.net>
 <20130522094709.GA26451@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130522094709.GA26451@redhat.com>
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

On Wed, May 22, 2013 at 12:47:09PM +0300, Michael S. Tsirkin wrote:
> >  
> > +static inline bool __can_fault(void)
> > +{
> > +	/*
> > +	 * Some code (nfs/sunrpc) uses socket ops on kernel memory while
> > +	 * holding the mmap_sem, this is safe because kernel memory doesn't
> > +	 * get paged out, therefore we'll never actually fault, and the
> > +	 * below annotations will generate false positives.
> > +	 */
> > +	if (segment_eq(get_fs(), KERNEL_DS))
> > +		return false;
> > +
> > +	if (in_atomic() /* || pagefault_disabled() */)
> 
> One question here: I'm guessing you put this comment here
> for illustrative purposes, implying code that will
> be enabled in -rt?
> We don't want it upstream I think, right?

Right, and as a reminder that when we do this we need to add a patch to
-rt. But yeah, we should have a look and see if its worth pulling those
patches from -rt into mainline in some way shape or form. They're big
but trivial IIRC.

I'm fine with you leaving that comment out though.. 

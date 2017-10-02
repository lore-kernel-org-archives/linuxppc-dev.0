Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5Z1g3qhPzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 07:45:43 +1100 (AEDT)
Date: Mon, 2 Oct 2017 22:45:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Don Zickus <dzickus@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC GIT Pull] core watchdog sanitizing
In-Reply-To: <20171002203209.rjug625pfmgh674j@redhat.com>
Message-ID: <alpine.DEB.2.20.1710022243480.2114@nanos>
References: <alpine.DEB.2.20.1710011217510.3874@nanos>
 <CA+55aFxQsmSb=zohGZOZK7eR4n5xOHNArmCa9j1b7+wJ+khQrg@mail.gmail.com>
 <alpine.DEB.2.20.1710021957480.2114@nanos>
 <CA+55aFyVX_aPac8dSJPED-XLTtfQOYe_eCV7HdYKABgGazWHAg@mail.gmail.com>
 <alpine.DEB.2.20.1710022105570.2114@nanos>
 <20171002203209.rjug625pfmgh674j@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2 Oct 2017, Don Zickus wrote:
> On Mon, Oct 02, 2017 at 07:32:57PM +0000, Thomas Gleixner wrote:
> >  static void softlockup_reconfigure_threads(void)
> 
> There is a second copy of ^^^^, you will need to add identical locking there
> too.

Good catch, but then we might move it further out
 
> > +	cpus_read_unlock();
> > +	/*
> > +	 * Must be called outside the cpus locked section to prevent
> > +	 * recursive locking in the perf code.
> > +	 */
> > +	__lockup_detector_cleanup();

Or not due to this ....

Thanks,

	tglx

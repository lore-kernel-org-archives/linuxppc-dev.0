Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 940972C03F1
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 04:44:16 +1100 (EST)
Date: Wed, 30 Oct 2013 18:44:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131030174402.GP16117@laptop.programming.kicks-ass.net>
References: <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <OFF6C78E48.E477DB1E-ON42257C14.0050F9B3-42257C14.0051AC6D@il.ibm.com>
 <20131030153931.GM16117@laptop.programming.kicks-ass.net>
 <OFCA1DB4AC.7D4F6EEE-ON42257C14.0056F77D-42257C14.005EB5EA@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFCA1DB4AC.7D4F6EEE-ON42257C14.0056F77D-42257C14.005EB5EA@il.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 30, 2013 at 07:14:29PM +0200, Victor Kaplansky wrote:
> We need a complete rmb() here IMO. I think there is a fundamental
> difference between load and stores in this aspect. Load are allowed to
> be hoisted by compiler or executed speculatively by HW. To prevent
> load "*(ubuf->data + tail)" to be hoisted beyond "ubuf->head" load you
> would need something like this:

Indeed, we could compute and load ->data + tail the moment we've
completed the tail load but before we've completed the head load and
done the comparison.

So yes, full rmb() it is.

> void
> ubuf_read(void)
> {
>         u64 head, tail;
> 
>         tail = ubuf->tail;
>         head = ACCESS_ONCE(ubuf->head);
> 
>         /*
>          * Ensure we read the buffer boundaries before the actual buffer
>          * data...
>          */
> 
>         while (tail != head) {
> 		    smp_read_barrier_depends();         /* for Alpha */
>                 obj = *(ubuf->data + head - 128);
>                 /* process obj */
>                 tail += obj->size;
>                 tail %= ubuf->size;
>         }
> 
>         /*
>          * Ensure all data reads are complete before we issue the
>          * ubuf->tail update; once that update hits, kbuf_write() can
>          * observe and overwrite data.
>          */
>         smp_mb();               /* D, matches with A */
> 
>         ubuf->tail = tail;
> }
> 
> (note that "head" is part of address calculation of obj load now).

Right, explicit dependent loads; I was hoping the conditional in between
might be enough, but as argued above it is not. The above cannot work in
our case though, we must use tail to find the obj since we have variable
size objects.

> But, even in this demo example some "smp_read_barrier_depends()" before
> "obj = *(ubuf->data + head - 100);" is required for architectures
> like Alpha. Though, on more sane architectures "smp_read_barrier_depends()"
> will be translated to nothing.

Sure.. I know all about that.

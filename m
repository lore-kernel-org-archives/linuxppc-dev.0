Return-Path: <victork@il.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEC182C0390
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 04:15:58 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Wed, 30 Oct 2013 17:15:55 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id F321C17D805C
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 17:15:26 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UHEPCR61407310
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 17:14:25 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UHEZav015733
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 11:14:37 -0600
In-Reply-To: <20131030153931.GM16117@laptop.programming.kicks-ass.net>
References: <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <OFF6C78E48.E477DB1E-ON42257C14.0050F9B3-42257C14.0051AC6D@il.ibm.com>
 <20131030153931.GM16117@laptop.programming.kicks-ass.net>
Subject: Re: perf events ring buffer memory barrier on powerpc
To: Peter Zijlstra <peterz@infradead.org>
Message-ID: <OFCA1DB4AC.7D4F6EEE-ON42257C14.0056F77D-42257C14.005EB5EA@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Wed, 30 Oct 2013 19:14:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
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

Peter Zijlstra <peterz@infradead.org> wrote on 10/30/2013 05:39:31 PM:

> Although I suppose speculative reads are allowed -- they don't have the
> destructive behaviour speculative writes have -- and thus we could in
> fact get reorder issues.

I agree.

>
> But since it is still a dependent load in that we do that @tail vs @head
> comparison before doing other loads, wouldn't a read_barrier_depends()
> be sufficient? Or do we still need a complete rmb?

We need a complete rmb() here IMO. I think there is a fundamental
difference
between load and stores in this aspect. Load are allowed to be hoisted by
compiler or executed speculatively by HW. To prevent load "*(ubuf->data +
tail)"
to be hoisted beyond "ubuf->head" load you would need something like this:

void
ubuf_read(void)
{
        u64 head, tail;

        tail = ubuf->tail;
        head = ACCESS_ONCE(ubuf->head);

        /*
         * Ensure we read the buffer boundaries before the actual buffer
         * data...
         */

        while (tail != head) {
		    smp_read_barrier_depends();         /* for Alpha */
                obj = *(ubuf->data + head - 128);
                /* process obj */
                tail += obj->size;
                tail %= ubuf->size;
        }

        /*
         * Ensure all data reads are complete before we issue the
         * ubuf->tail update; once that update hits, kbuf_write() can
         * observe and overwrite data.
         */
        smp_mb();               /* D, matches with A */

        ubuf->tail = tail;
}

(note that "head" is part of address calculation of obj load now).

But, even in this demo example some "smp_read_barrier_depends()" before
"obj = *(ubuf->data + head - 100);" is required for architectures
like Alpha. Though, on more sane architectures "smp_read_barrier_depends()"
will be translated to nothing.


Regards,
-- Victor

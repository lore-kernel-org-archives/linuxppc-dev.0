Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF6CF2C0126
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Nov 2013 15:04:40 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 2 Nov 2013 22:04:38 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DE89D19D8041
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 22:04:30 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA344YIU304094
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:04:34 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA347Orv001997
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:07:25 -0600
Date: Sat, 2 Nov 2013 10:28:40 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131102172840.GA3947@linux.vnet.ibm.com>
References: <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <20131031064015.GV4126@linux.vnet.ibm.com>
 <OF2F28411B.D04C5B5A-ON42257C16.004E02C5-42257C16.004F420C@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF2F28411B.D04C5B5A-ON42257C16.004E02C5-42257C16.004F420C@il.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 01, 2013 at 04:25:42PM +0200, Victor Kaplansky wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote on 10/31/2013
> 08:40:15 AM:
> 
> > > void ubuf_read(void)
> > > {
> > >    u64 head, tail;
> > >
> > >    tail = ACCESS_ONCE(ubuf->tail);
> > >    head = ACCESS_ONCE(ubuf->head);
> > >
> > >    /*
> > >     * Ensure we read the buffer boundaries before the actual buffer
> > >     * data...
> > >     */
> > >    smp_rmb(); /* C, matches with B */
> > >
> > >    while (tail != head) {
> > >       obj = ubuf->data + tail;
> > >       /* process obj */
> > >       tail += obj->size;
> > >       tail %= ubuf->size;
> > >    }
> > >
> > >    /*
> > >     * Ensure all data reads are complete before we issue the
> > >     * ubuf->tail update; once that update hits, kbuf_write() can
> > >     * observe and overwrite data.
> > >     */
> > >    smp_mb(); /* D, matches with A */
> > >
> > >    ubuf->tail = tail;
> > > }
> 
> > > Could we replace A and C with an smp_read_barrier_depends()?
> >
> > C, yes, given that you have ACCESS_ONCE() on the fetch from ->tail
> > and that the value fetch from ->tail feeds into the address used for
> > the "obj =" assignment.
> 
> No! You must to have a full smp_rmb() at C. The race on the reader side
> is not between fetch of @tail and read from address pointed by @tail.
> The real race here is between a fetch of @head and read of obj from
> memory pointed by @tail.

I believe you are in fact correct, good catch.

							Thanx, Paul

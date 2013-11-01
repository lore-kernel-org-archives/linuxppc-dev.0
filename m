Return-Path: <victork@il.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp15.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 49A4C2C00C8
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 01:27:10 +1100 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Fri, 1 Nov 2013 14:27:07 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE30F17D805F
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 14:26:39 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA1EPbwF62521544
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 14:25:37 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA1EPmPI029735
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 08:25:49 -0600
In-Reply-To: <20131031064015.GV4126@linux.vnet.ibm.com>
References: <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <20131031064015.GV4126@linux.vnet.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
To: paulmck@linux.vnet.ibm.com
Message-ID: <OF2F28411B.D04C5B5A-ON42257C16.004E02C5-42257C16.004F420C@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Fri, 1 Nov 2013 16:25:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote on 10/31/2013
08:40:15 AM:

> > void ubuf_read(void)
> > {
> >    u64 head, tail;
> >
> >    tail = ACCESS_ONCE(ubuf->tail);
> >    head = ACCESS_ONCE(ubuf->head);
> >
> >    /*
> >     * Ensure we read the buffer boundaries before the actual buffer
> >     * data...
> >     */
> >    smp_rmb(); /* C, matches with B */
> >
> >    while (tail != head) {
> >       obj = ubuf->data + tail;
> >       /* process obj */
> >       tail += obj->size;
> >       tail %= ubuf->size;
> >    }
> >
> >    /*
> >     * Ensure all data reads are complete before we issue the
> >     * ubuf->tail update; once that update hits, kbuf_write() can
> >     * observe and overwrite data.
> >     */
> >    smp_mb(); /* D, matches with A */
> >
> >    ubuf->tail = tail;
> > }

> > Could we replace A and C with an smp_read_barrier_depends()?
>
> C, yes, given that you have ACCESS_ONCE() on the fetch from ->tail
> and that the value fetch from ->tail feeds into the address used for
> the "obj =" assignment.

No! You must to have a full smp_rmb() at C. The race on the reader side
is not between fetch of @tail and read from address pointed by @tail.
The real race here is between a fetch of @head and read of obj from
memory pointed by @tail.

Regards,
-- Victor

Return-Path: <victork@il.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp11.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 064232C00CC
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 00:13:14 +1100 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Fri, 1 Nov 2013 13:13:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D1D23219005C
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 13:13:05 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA1DCrrB64225440
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 13:12:53 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA1DD4XD030107
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 07:13:05 -0600
In-Reply-To: <20131031061602.GU4126@linux.vnet.ibm.com>
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
 <20131031061602.GU4126@linux.vnet.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
To: paulmck@linux.vnet.ibm.com
Message-ID: <OF6655E55D.554B7448-ON42257C16.00442B8B-42257C16.0048995E@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Fri, 1 Nov 2013 15:12:58 +0200
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
08:16:02 AM:

> > BTW, it is why you also don't need ACCESS_ONCE() around @tail, but only
> > around
> > @head read.

Just to be sure, that we are talking about the same code - I was
considering
ACCESS_ONCE() around @tail in point AAA in the following example from
Documentation/circular-buffers.txt for CONSUMER:

        unsigned long head = ACCESS_ONCE(buffer->head);
        unsigned long tail = buffer->tail;      /* AAA */

        if (CIRC_CNT(head, tail, buffer->size) >= 1) {
                /* read index before reading contents at that index */
                smp_read_barrier_depends();

                /* extract one item from the buffer */
                struct item *item = buffer[tail];

                consume_item(item);

                smp_mb(); /* finish reading descriptor before incrementing
tail */

                buffer->tail = (tail + 1) & (buffer->size - 1); /* BBB */
        }

>
> If you omit the ACCESS_ONCE() calls around @tail, the compiler is within
> its rights to combine adjacent operations and also to invent loads and
> stores, for example, in cases of register pressure.

Right. And I was completely aware about these possible transformations when
said that ACCESS_ONCE() around @tail in point AAA is redundant. Moved, or
even
completely dismissed reads of @tail in consumer code, are not a problem at
all,
since @tail is written exclusively by CONSUMER side.


> It is also within
> its rights to do piece-at-a-time loads and stores, which might sound
> unlikely, but which can actually has happened when the compiler figures
> out exactly what is to be stored at compile time, especially on hardware
> that only allows small immediate values.

As for writes to @tail, the ACCESS_ONCE around @tail at point AAA,
doesn't prevent in any way an imaginary super-optimizing compiler
from moving around the store to @tail (which appears in the code at point
BBB).

It is why ACCESS_ONCE at point AAA is completely redundant.

-- Victor

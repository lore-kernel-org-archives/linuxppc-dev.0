Return-Path: <victork@il.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp10.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 301642C037E
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 00:29:07 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Wed, 30 Oct 2013 13:29:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 662C517D8057
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 13:28:35 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UDSmR060948644
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 13:28:48 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UDT01K017103
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 07:29:01 -0600
In-Reply-To: <20131030092725.GL4126@linux.vnet.ibm.com>
References: <12083.1382486094@ale.ozlabs.ibm.com>
 <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
To: paulmck@linux.vnet.ibm.com
Message-ID: <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Wed, 30 Oct 2013 15:28:54 +0200
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

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote on 10/30/2013
11:27:25 AM:

> If you were to back up that insistence with a description of the
orderings
> you are relying on, why other orderings are not important, and how the
> important orderings are enforced, I might be tempted to pay attention
> to your opinion.
>
>                      Thanx, Paul

NP, though, I feel too embarrassed to explain things about memory barriers
when
one of the authors of Documentation/memory-barriers.txt is on cc: list ;-)

Disclaimer: it is anyway impossible to prove lack of *any* problem.

Having said that, lets look into an example in
Documentation/circular-buffers.txt:

> THE PRODUCER
> ------------
>
> The producer will look something like this:
>
>       spin_lock(&producer_lock);
>
>       unsigned long head = buffer->head;
>       unsigned long tail = ACCESS_ONCE(buffer->tail);
>
>       if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
>               /* insert one item into the buffer */
>               struct item *item = buffer[head];
>
>               produce_item(item);
>
>               smp_wmb(); /* commit the item before incrementing the head
*/
>
>               buffer->head = (head + 1) & (buffer->size - 1);
>
>               /* wake_up() will make sure that the head is committed
before
>                * waking anyone up */
>               wake_up(consumer);
>       }
>
>       spin_unlock(&producer_lock);

We can see that authors of the document didn't put any memory barrier
after "buffer->tail" read and before "produce_item(item)" and I think they
have
a good reason.

Lets consider an imaginary smp_mb() right before "produce_item(item);".
Such a barrier will ensure that -

    - the memory read on "buffer->tail" is completed
	before store to memory pointed by "item" is committed.

However, the store to "buffer->tail" anyway cannot be completed before
conditional
branch implied by "if ()" is proven to execute body statement of the if().
And the
latter cannot be proven before read of "buffer->tail" is completed.

Lets see this other way. Lets imagine that somehow a store to the data
pointed by "item"
is completed before we read "buffer->tail". That would mean, that the store
was completed
speculatively. But speculative execution of conditional stores is
prohibited by C/C++ standard,
otherwise any conditional store at any random place of code could pollute
shared memory.

On the other hand, if compiler or processor can prove that condition in
above if() is going
to be true (or if speculative store writes the same value as it was before
write), the
speculative store *is* allowed. In this case we should not be bothered by
the fact that
memory pointed by "item" is written before a read from "buffer->tail" is
completed.

Regards,
-- Victor

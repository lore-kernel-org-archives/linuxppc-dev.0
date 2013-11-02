Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD1BF2C0119
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Nov 2013 15:04:40 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 2 Nov 2013 22:04:38 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2AB3C1FF002C
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 22:04:22 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA344ab2284520
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:04:36 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA347QbD002158
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:07:27 -0600
Date: Sat, 2 Nov 2013 10:26:24 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131102172624.GA4009@linux.vnet.ibm.com>
References: <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <OFF6C78E48.E477DB1E-ON42257C14.0050F9B3-42257C14.0051AC6D@il.ibm.com>
 <20131031061602.GU4126@linux.vnet.ibm.com>
 <OF6655E55D.554B7448-ON42257C16.00442B8B-42257C16.0048995E@il.ibm.com>
 <20131102163618.GK4067@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131102163618.GK4067@linux.vnet.ibm.com>
Cc: mbatty@cantab.net, dhowells@redhat.com, Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 lfomicki@poczta.fm
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Adding David Howells, Lech Fomicki, and Mark Batty on CC for their
  thoughts given previous discussions. ]

On Sat, Nov 02, 2013 at 09:36:18AM -0700, Paul E. McKenney wrote:
> On Fri, Nov 01, 2013 at 03:12:58PM +0200, Victor Kaplansky wrote:
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote on 10/31/2013
> > 08:16:02 AM:
> > 
> > > > BTW, it is why you also don't need ACCESS_ONCE() around @tail, but only
> > > > around
> > > > @head read.
> > 
> > Just to be sure, that we are talking about the same code - I was
> > considering
> > ACCESS_ONCE() around @tail in point AAA in the following example from
> > Documentation/circular-buffers.txt for CONSUMER:
> > 
> >         unsigned long head = ACCESS_ONCE(buffer->head);
> >         unsigned long tail = buffer->tail;      /* AAA */
> > 
> >         if (CIRC_CNT(head, tail, buffer->size) >= 1) {
> >                 /* read index before reading contents at that index */
> >                 smp_read_barrier_depends();
> > 
> >                 /* extract one item from the buffer */
> >                 struct item *item = buffer[tail];
> > 
> >                 consume_item(item);
> > 
> >                 smp_mb(); /* finish reading descriptor before incrementing
> > tail */
> > 
> >                 buffer->tail = (tail + 1) & (buffer->size - 1); /* BBB */
> >         }
> 
> Hmmm...  I believe that we need to go back to the original code in
> Documentation/circular-buffers.txt.  I do so at the bottom of this email.
> 
> > > If you omit the ACCESS_ONCE() calls around @tail, the compiler is within
> > > its rights to combine adjacent operations and also to invent loads and
> > > stores, for example, in cases of register pressure.
> > 
> > Right. And I was completely aware about these possible transformations when
> > said that ACCESS_ONCE() around @tail in point AAA is redundant. Moved, or
> > even
> > completely dismissed reads of @tail in consumer code, are not a problem at
> > all,
> > since @tail is written exclusively by CONSUMER side.
> 
> I believe that the lack of ACCESS_ONCE() around the consumer's store
> to buffer->tail is at least a documentation problem.  In the original
> consumer code, it is trapped between an smp_mb() and a spin_unlock(),
> but it is updating something that is read without synchronization by
> some other thread.
> 
> > > It is also within
> > > its rights to do piece-at-a-time loads and stores, which might sound
> > > unlikely, but which can actually has happened when the compiler figures
> > > out exactly what is to be stored at compile time, especially on hardware
> > > that only allows small immediate values.
> > 
> > As for writes to @tail, the ACCESS_ONCE around @tail at point AAA,
> > doesn't prevent in any way an imaginary super-optimizing compiler
> > from moving around the store to @tail (which appears in the code at point
> > BBB).
> > 
> > It is why ACCESS_ONCE at point AAA is completely redundant.
> 
> Agreed, it is under the lock that guards modifications, so AAA does not
> need ACCESS_ONCE().
> 
> OK, here is the producer from Documentation/circular-buffers.txt, with
> some comments added:
> 
> 	spin_lock(&producer_lock);
> 
> 	unsigned long head = buffer->head;

The above is updated only under producer_lock, which we hold, so no
ACCESS_ONCE() is needed for buffer->head.

> 	unsigned long tail = ACCESS_ONCE(buffer->tail); /* PT */
> 
> 	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
> 		/* insert one item into the buffer */
> 		struct item *item = buffer[head];
> 
> 		produce_item(item); /* PD */
> 
> 		smp_wmb(); /* commit the item before incrementing the head */
> 
> 		buffer->head = (head + 1) & (buffer->size - 1);  /* PH */

The above needs to be something like:

		ACCESS_ONCE(buffer->head) = (head + 1) & (buffer->size - 1);

This is because we are writing to a shared variable that might be being
read concurrently.

> 		/* wake_up() will make sure that the head is committed before
> 		 * waking anyone up */
> 		wake_up(consumer);
> 	}
> 
> 	spin_unlock(&producer_lock);
> 
> And here is the consumer, also from Documentation/circular-buffers.txt:
> 
> 	spin_lock(&consumer_lock);
> 
> 	unsigned long head = ACCESS_ONCE(buffer->head); /* CH */
> 	unsigned long tail = buffer->tail;

The above is updated only under consumer_lock, which we hold, so no
ACCESS_ONCE() is needed for buffer->tail.

> 
> 	if (CIRC_CNT(head, tail, buffer->size) >= 1) {
> 		/* read index before reading contents at that index */
> 		smp_read_barrier_depends();
> 
> 		/* extract one item from the buffer */
> 		struct item *item = buffer[tail]; /* CD */
> 
> 		consume_item(item);
> 
> 		smp_mb(); /* finish reading descriptor before incrementing tail */
> 
> 		buffer->tail = (tail + 1) & (buffer->size - 1); /* CT */

And here, for no-execution-cost documentation, if nothing else:

		ACCESS_ONCE(buffer->tail) = (tail + 1) & (buffer->size - 1);

> 	}
> 
> 	spin_unlock(&consumer_lock);
> 
> Here are the ordering requirements as I see them:
> 
> 1.	The producer is not allowed to clobber a location that the
> 	consumer is in the process of reading from.
> 
> 2.	The consumer is not allowed to read from a location that the
> 	producer has not yet completed writing to.
> 
> #1 is helped out by the fact that there is always an empty element in
> the array, so that the producer will need to produce twice in a row
> to catch up to where the consumer is currently consuming.  #2 has no
> such benefit: The consumer can consume an item that has just now been
> produced.
> 
> #1 requires that CD is ordered before CT in a way that pairs with the
> ordering of PT and PD.  There is of course no effective ordering between
> PT and PD within a given call to the producer, but we only need the
> ordering between the read from PT for one call to the producer and the
> PD of the -next- call to the producer, courtesy of the fact that there
> is always one empty cell in the array.  Therefore, the required ordering
> between PT of one call and PD of the next is provided by the unlock-lock
> pair.  The ordering of CD and CT is of course provided by the smp_mb().
> (And yes, I was missing the unlock-lock pair earlier.  In my defense,
> you did leave this unlock-lock pair out of your example.)
> 
> So ordering requirement #1 is handled by the original, but only if you
> leave the locking in place.  The producer's smp_wmb() does not necessarily
> order prior loads against subsequent stores, and the wake_up() only
> guarantees ordering if something was actually awakened.  As noted earlier,
> the "if" does not necessarily provide ordering.
> 
> On to ordering requirement #2.
> 
> This requires that CH and CD is ordered in a way that pairs with ordering
> between PD and PH.  PD and PH are both writes, so the smp_wmb() does
> the trick there.  The consumer side is a bit strange.  On DEC Alpha,
> smp_read_barrier_dependes() turns into smp_mb(), so that case is covered
> (though by accident).  On other architectures, smp_read_barrier_depends()
> generates no code, and there is no data dependency between the CH and CD.
> The dependency is instead between the read from ->tail and the write,

Sigh.  Make that "The dependency is instead between the read from ->tail
and the read from the array."

> and as you noted, ->tail is written by the consumer, not the producer.

And non-dependent reads -can- be speculated, so the
smp_read_barrier_depends() needs to be at least an smp_rmb().

Again, don't take my word for it, try it with either ppcmem or real
weakly ordered hardware.

I am not 100% confident of the patch below, but am getting there.
If a change is really needed, it must of course be propagated to the
uses within the Linux kernel.

							Thanx, Paul

> But my battery is dying, so more later, including ACCESS_ONCE().

documentation: Fix circular-buffer example.

The code sample in Documentation/circular-buffers.txt appears to have a
few ordering bugs.  This patch therefore applies the needed fixes.

Reported-by: Lech Fomicki <lfomicki@poczta.fm>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/circular-buffers.txt b/Documentation/circular-buffers.txt
index 8117e5bf6065..a36bed3db4ee 100644
--- a/Documentation/circular-buffers.txt
+++ b/Documentation/circular-buffers.txt
@@ -170,7 +170,7 @@ The producer will look something like this:
 
 		smp_wmb(); /* commit the item before incrementing the head */
 
-		buffer->head = (head + 1) & (buffer->size - 1);
+		ACCESS_ONCE(buffer->head) = (head + 1) & (buffer->size - 1);
 
 		/* wake_up() will make sure that the head is committed before
 		 * waking anyone up */
@@ -183,9 +183,14 @@ This will instruct the CPU that the contents of the new item must be written
 before the head index makes it available to the consumer and then instructs the
 CPU that the revised head index must be written before the consumer is woken.
 
-Note that wake_up() doesn't have to be the exact mechanism used, but whatever
-is used must guarantee a (write) memory barrier between the update of the head
-index and the change of state of the consumer, if a change of state occurs.
+Note that wake_up() does not guarantee any sort of barrier unless something
+is actually awakened.  We therefore cannot rely on it for ordering.  However,
+there is always one element of the array left empty.  Therefore, the
+producer must produce two elements before it could possibly corrupt the
+element currently being read by the consumer.  Therefore, the unlock-lock
+pair between consecutive invocations of the consumer provides the necessary
+ordering between the read of the index indicating that the consumer has
+vacated a given element and the write by the producer to that same element.
 
 
 THE CONSUMER
@@ -200,7 +205,7 @@ The consumer will look something like this:
 
 	if (CIRC_CNT(head, tail, buffer->size) >= 1) {
 		/* read index before reading contents at that index */
-		smp_read_barrier_depends();
+		smp_rmb();
 
 		/* extract one item from the buffer */
 		struct item *item = buffer[tail];
@@ -209,7 +214,7 @@ The consumer will look something like this:
 
 		smp_mb(); /* finish reading descriptor before incrementing tail */
 
-		buffer->tail = (tail + 1) & (buffer->size - 1);
+		ACCESS_ONCE(buffer->tail) = (tail + 1) & (buffer->size - 1);
 	}
 
 	spin_unlock(&consumer_lock);
@@ -223,7 +228,10 @@ Note the use of ACCESS_ONCE() in both algorithms to read the opposition index.
 This prevents the compiler from discarding and reloading its cached value -
 which some compilers will do across smp_read_barrier_depends().  This isn't
 strictly needed if you can be sure that the opposition index will _only_ be
-used the once.
+used the once.  Similarly, ACCESS_ONCE() is used in both algorithms to
+write the thread's index.  This documents the fact that we are writing
+to something that can be read concurrently and also prevents the compiler
+from tearing the store.
 
 
 ===============

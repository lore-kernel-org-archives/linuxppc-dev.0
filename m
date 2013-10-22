Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Frederic Weisbecker <fweisbec@gmail.com>, benh@kernel.crashing.org,
 anton@samba.org, linux-kernel@vger.kernel.org,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, michael@ellerman.id.au
MIME-Version: 1.0
Subject: perf events ring buffer memory barrier on powerpc
Date: Wed, 23 Oct 2013 10:54:54 +1100
Message-ID: <12083.1382486094@ale.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic,

In the perf ring buffer code we have this in perf_output_get_handle():

	if (!local_dec_and_test(&rb->nest))
		goto out;

	/*
	 * Publish the known good head. Rely on the full barrier implied
	 * by atomic_dec_and_test() order the rb->head read and this
	 * write.
	 */
	rb->user_page->data_head = head;

The comment says atomic_dec_and_test() but the code is
local_dec_and_test().

On powerpc, local_dec_and_test() doesn't have a memory barrier but
atomic_dec_and_test() does.  Is the comment wrong, or is
local_dec_and_test() suppose to imply a memory barrier too and we have
it wrongly implemented in powerpc?

My guess is that local_dec_and_test() is correct but we to add an
explicit memory barrier like below:

(Kudos to Victor Kaplansky for finding this)

Mikey

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index cd55144..95768c6 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -87,10 +87,10 @@ again:
 		goto out;
 
 	/*
-	 * Publish the known good head. Rely on the full barrier implied
-	 * by atomic_dec_and_test() order the rb->head read and this
-	 * write.
+	 * Publish the known good head. We need a memory barrier to order the
+	 * order the rb->head read and this write.
 	 */
+	smp_mb ();
 	rb->user_page->data_head = head;
 
 	/*

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s27F54wYtzDrF1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 13:27:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] random: Fix crashes with sparse node ids
In-Reply-To: <CA+55aFxBJO2HLkWM=uLyNxBYQpNY8jf_0oZqFzHNcgQd-VKdAA@mail.gmail.com>
References: <1469888588-5918-1-git-send-email-mpe@ellerman.id.au>
 <CA+55aFxBJO2HLkWM=uLyNxBYQpNY8jf_0oZqFzHNcgQd-VKdAA@mail.gmail.com>
Date: Sun, 31 Jul 2016 13:27:17 +1000
Message-ID: <87y44io5be.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jul 30, 2016 at 7:23 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>  #ifdef CONFIG_NUMA
>> -       pool = kmalloc(num_nodes * sizeof(void *),
>> +       pool = kmalloc(nr_node_ids * sizeof(void *),
>>                        GFP_KERNEL|__GFP_NOFAIL|__GFP_ZERO);
>>         for_each_online_node(i) {
>>                 crng = kmalloc_node(sizeof(struct crng_state),
>
> Ugh. Can we please also just change that kmalloc to kcalloc()? Get rid
> of the odd multiplication and the unusual GFP mask bit crud?
>
> And instead of using "sizeof(void *)", just use the pool entry size,
> ie "sizeof(*pool)". Yes, we have other places where we depend on void
> pointers having the same size as others, but it's the RightThing(tm)
> to do anyway, and it makes more sense when you grep things ("Oh, we're
> allocating 'nr_node_id' copes of *pool entries" even without knowing
> what type is behind the "pool" pointer).
>
> IOW, can you confirm that you could just use
>
>         pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL);
>
> instead? I'd much rather apply that patch.

Dropping NOFAIL means we need to handle allocation failures, which makes
the patch a bit bigger, and less of a pure fix.

Here's a separate patch to do those cleanups, which you can squash with
the first if you prefer.

I did test the allocation failure case for both the whole pool and
individual nodes.

cheers


>From 2f5ab5fa2b9e4997fe01053fc12f689fb2117f45 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sun, 31 Jul 2016 12:54:40 +1000
Subject: [PATCH] random: Clean up NUMA allocations

Use kcalloc(), rather than doing the multiply by hand. Use sizeof(*pool)
rather than assuming it's == sizeof(void *). kcalloc() zeroes by default
so we don't need __GFP_ZERO.

Drop the __GFP_NOFAILs, we can easily handle allocation failures, the
code is already written to cope with a NULL crng_node_pool, or a NULL
entry for a given node in the pool.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/char/random.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ea03dfe2f21c..22c8ac173666 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1666,11 +1666,15 @@ static int rand_initialize(void)
 	crng_initialize(&primary_crng);
 
 #ifdef CONFIG_NUMA
-	pool = kmalloc(nr_node_ids * sizeof(void *),
-		       GFP_KERNEL|__GFP_NOFAIL|__GFP_ZERO);
+	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return 0;
+
 	for_each_online_node(i) {
-		crng = kmalloc_node(sizeof(struct crng_state),
-				    GFP_KERNEL | __GFP_NOFAIL, i);
+		crng = kmalloc_node(sizeof(struct crng_state), GFP_KERNEL, i);
+		if (!crng)
+			continue;
+
 		spin_lock_init(&crng->lock);
 		crng_initialize(crng);
 		pool[i] = crng;
-- 
2.7.4

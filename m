Return-Path: <fweisbec@gmail.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F3452C0335
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Oct 2013 01:19:58 +1100 (EST)
Received: by mail-wg0-f49.google.com with SMTP id x12so871424wgg.28
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Oct 2013 07:19:52 -0700 (PDT)
Date: Wed, 23 Oct 2013 15:19:51 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Michael Neuling <mikey@neuling.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131023141948.GB3566@localhost.localdomain>
References: <12083.1382486094@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12083.1382486094@ale.ozlabs.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 linux-kernel@vger.kernel.org, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 anton@samba.org, Victor Kaplansky <VICTORK@il.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 23, 2013 at 10:54:54AM +1100, Michael Neuling wrote:
> Frederic,
> 
> In the perf ring buffer code we have this in perf_output_get_handle():
> 
> 	if (!local_dec_and_test(&rb->nest))
> 		goto out;
> 
> 	/*
> 	 * Publish the known good head. Rely on the full barrier implied
> 	 * by atomic_dec_and_test() order the rb->head read and this
> 	 * write.
> 	 */
> 	rb->user_page->data_head = head;
> 
> The comment says atomic_dec_and_test() but the code is
> local_dec_and_test().
> 
> On powerpc, local_dec_and_test() doesn't have a memory barrier but
> atomic_dec_and_test() does.  Is the comment wrong, or is
> local_dec_and_test() suppose to imply a memory barrier too and we have
> it wrongly implemented in powerpc?
> 
> My guess is that local_dec_and_test() is correct but we to add an
> explicit memory barrier like below:
> 
> (Kudos to Victor Kaplansky for finding this)
> 
> Mikey
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index cd55144..95768c6 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -87,10 +87,10 @@ again:
>  		goto out;
>  
>  	/*
> -	 * Publish the known good head. Rely on the full barrier implied
> -	 * by atomic_dec_and_test() order the rb->head read and this
> -	 * write.
> +	 * Publish the known good head. We need a memory barrier to order the
> +	 * order the rb->head read and this write.
>  	 */
> +	smp_mb ();
>  	rb->user_page->data_head = head;
>  
>  	/*


I'm adding Peter in Cc since he wrote that code.
I agree that local_dec_and_test() doesn't need to imply an smp barrier.
All it has to provide as a guarantee is the atomicity against local concurrent
operations (interrupts, preemption, ...).

Now I'm a bit confused about this barrier.

I think we want this ordering:

    Kernel                             User

   READ rb->user_page->data_tail       READ rb->user_page->data_head
   smp_mb()                            smp_mb()
   WRITE rb data                       READ rb  data
   smp_mb()                            smp_mb()
   rb->user_page->data_head            WRITE rb->user_page->data_tail

So yeah we want a berrier between the data published and the user data_head.
But this ordering concerns wider layout than just rb->head and rb->user_page->data_head

And BTW I can see an smp_rmb() after we read rb->user_page->data_tail. This is probably the
first kernel barrier in my above example. (not sure if rmb() alone is enough though).

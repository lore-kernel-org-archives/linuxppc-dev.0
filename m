Return-Path: <victork@il.ibm.com>
Received: from e06smtp18.uk.ibm.com (e06smtp18.uk.ibm.com [195.75.94.114])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp18.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 622FC2C0196
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Oct 2013 18:40:05 +1100 (EST)
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Wed, 23 Oct 2013 08:40:01 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CB3022190063
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Oct 2013 08:39:58 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9N7dkeG55836800
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Oct 2013 07:39:46 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9N7dvFc013784
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Oct 2013 01:39:58 -0600
In-Reply-To: <12083.1382486094@ale.ozlabs.ibm.com>
References: <12083.1382486094@ale.ozlabs.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
To: Michael Neuling <mikey@neuling.org>
Message-ID: <OFD776C320.26C485FF-ON43257C0D.00264F32-43257C0D.002A1BA7@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Wed, 23 Oct 2013 10:39:55 +0300
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 linux-kernel@vger.kernel.org, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 anton@samba.org, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See below.

Michael Neuling <mikey@neuling.org> wrote on 10/23/2013 02:54:54 AM:

>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index cd55144..95768c6 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -87,10 +87,10 @@ again:
>        goto out;
>
>     /*
> -    * Publish the known good head. Rely on the full barrier implied
> -    * by atomic_dec_and_test() order the rb->head read and this
> -    * write.
> +    * Publish the known good head. We need a memory barrier to order the
> +    * order the rb->head read and this write.
>      */
> +   smp_mb ();
>     rb->user_page->data_head = head;
>
>     /*

1. As far as I understand, smp_mb() is superfluous in this case, smp_wmb()
should be enough.
   (same for the space between the name of function and open
parenthesis :-) )

2. Again, as far as I understand from ./Documentation/atomic_ops.txt, it is
mistake in architecture independent
   code to rely on memory barriers in atomic operations, all the more so in
"local" operations.

3. The solution above is sub-optimal on architectures where memory barrier
is part of "local", since we are going to execute
   two consecutive barriers. So, maybe, it would be better to use
smp_mb__after_atomic_dec().

4. I'm not sure, but I think there is another, unrelated potential problem
in function perf_output_put_handle()
   - the write to "data_head" -

kernel/events/ring_buffer.c:

 77         /*
 78          * Publish the known good head. Rely on the full barrier
implied
 79          * by atomic_dec_and_test() order the rb->head read and this
 80          * write.
 81          */
 82         rb->user_page->data_head = head;

As data_head is 64-bit wide, the update should be done by an atomic64_set
().

Regards,
-- Victor

Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9AA602C0342
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Oct 2013 21:35:39 +1100 (EST)
Date: Tue, 29 Oct 2013 11:35:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131029103526.GO2490@laptop.programming.kicks-ass.net>
References: <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131029102131.GA16117@laptop.programming.kicks-ass.net>
 <20131029103057.GN2490@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131029103057.GN2490@laptop.programming.kicks-ass.net>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
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

On Tue, Oct 29, 2013 at 11:30:57AM +0100, Peter Zijlstra wrote:
> @@ -154,9 +175,11 @@ int perf_output_begin(struct perf_output
>  		 * Userspace could choose to issue a mb() before updating the
>  		 * tail pointer. So that all reads will be completed before the
>  		 * write is issued.
> +		 *
> +		 * See perf_output_put_handle().
>  		 */
>  		tail = ACCESS_ONCE(rb->user_page->data_tail);
> -		smp_rmb();
> +		smp_mb();
>  		offset = head = local_read(&rb->head);
>  		head += size;
>  		if (unlikely(!perf_output_space(rb, tail, offset, head)))

That said; it would be very nice to be able to remove this barrier. This
is in every event write path :/

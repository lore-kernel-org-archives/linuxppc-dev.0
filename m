Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E0D412C00BA
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Oct 2013 20:23:16 +1100 (EST)
Date: Mon, 28 Oct 2013 10:22:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131028092259.GJ19466@laptop.lan>
References: <12083.1382486094@ale.ozlabs.ibm.com>
 <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
 <OF1519E98D.692AF083-ON42257C11.002E693E-42257C11.00317D48@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF1519E98D.692AF083-ON42257C11.002E693E-42257C11.00317D48@il.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linux-kernel@vger.kernel.org,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, anton@samba.org,
 Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 27, 2013 at 11:00:33AM +0200, Victor Kaplansky wrote:
> Peter Zijlstra <peterz@infradead.org> wrote on 10/25/2013 07:37:49 PM:
> 
> > I would argue for:
> >
> >   READ ->data_tail         READ ->data_head
> >     smp_rmb()   (A)          smp_rmb()   (C)
> >   WRITE $data              READ $data
> >     smp_wmb()   (B)          smp_mb()   (D)
> >   STORE ->data_head        WRITE ->data_tail
> >
> > Where A pairs with D, and B pairs with C.
> 
> 1. I agree. My only concern is that architectures which do use atomic
> operations
> with memory barriers, will issue two consecutive barriers now, which is
> sub-optimal.

Yeah, although that would be fairly easy to optimize by the CPUs itself;
not sure they actually do this though.

But we don't really have much choice aside of introducing things like:

smp_wmb__after_local_$op; and I'm fairly sure people won't like adding a
ton of conditional barriers like that either.


> 2. I think the comment in "include/linux/perf_event.h" describing
> "data_head" and
> "data_tail" for user space need an update as well. Current version -

Oh, indeed. Thanks; I'll update that too!

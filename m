Return-Path: <James.Hogan@imgtec.com>
Received: from multi.imgtec.com (multi.imgtec.com [194.200.65.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.imgtec.com",
 Issuer "DigiCert High Assurance CA-3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 994182C0388
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 23:05:57 +1100 (EST)
Message-ID: <5270F21C.3080805@imgtec.com>
Date: Wed, 30 Oct 2013 11:48:44 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
References: <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131029102131.GA16117@laptop.programming.kicks-ass.net>
 <20131029103057.GN2490@laptop.programming.kicks-ass.net>
 <alpine.DEB.2.02.1310291524240.6608@pianoman.cluster.toy>
 <20131030104246.GH16117@laptop.programming.kicks-ass.net>
In-Reply-To: <20131030104246.GH16117@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Vince Weaver <vince@deater.net>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-metag <linux-metag@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On 30/10/13 10:42, Peter Zijlstra wrote:
> Subject: perf, tool: Add required memory barriers
> 
> To match patch bf378d341e48 ("perf: Fix perf ring buffer memory
> ordering") change userspace to also adhere to the ordering outlined.
> 
> Most barrier implementations were gleaned from
> arch/*/include/asm/barrier.h and with the exception of metag I'm fairly
> sure they're correct.

Yeh...

Short answer:
For Meta you're probably best off assuming
CONFIG_METAG_SMP_WRITE_REORDERING=n and just using compiler barriers.

Long answer:
The issue with write reordering between Meta's hardware threads beyond
the cache is only with a particular SoC, and SMP is not used in
production on it.
It is possible to make the LINSYSEVENT_WR_COMBINE_FLUSH register
writable to userspace (it's in a non-mappable region already) but even
then the write to that register needs odd placement to be effective
(before the shmem write rather than after - which isn't a place any
existing barriers are guaranteed to be placed). I'm fairly confident we
get away with it in the kernel, and userland normally just uses linked
load/store instructions for atomicity which works fine.

Cheers
James

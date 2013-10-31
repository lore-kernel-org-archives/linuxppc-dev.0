Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 88E452C00E9
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 22:15:45 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 1 Nov 2013 07:15:41 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 004F338C803B
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 07:15:38 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA1BFcAv8520094
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 11:15:38 GMT
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA1BISV9009061
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 05:18:29 -0600
Date: Wed, 30 Oct 2013 23:16:02 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131031061602.GU4126@linux.vnet.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFF6C78E48.E477DB1E-ON42257C14.0050F9B3-42257C14.0051AC6D@il.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 30, 2013 at 04:52:05PM +0200, Victor Kaplansky wrote:
> Peter Zijlstra <peterz@infradead.org> wrote on 10/30/2013 01:25:26 PM:
> 
> > Also, I'm not entirely sure on C, that too seems like a dependency, we
> > simply cannot read the buffer @tail before we've read the tail itself,
> > now can we? Similarly we cannot compare tail to head without having the
> > head read completed.
> 
> No, this one we cannot omit, because our problem on consumer side is not
> with @tail, which is written exclusively by consumer, but with @head.
> 
> BTW, it is why you also don't need ACCESS_ONCE() around @tail, but only
> around
> @head read.

If you omit the ACCESS_ONCE() calls around @tail, the compiler is within
its rights to combine adjacent operations and also to invent loads and
stores, for example, in cases of register pressure.  It is also within
its rights to do piece-at-a-time loads and stores, which might sound
unlikely, but which can actually has happened when the compiler figures
out exactly what is to be stored at compile time, especially on hardware
that only allows small immediate values.

So the ACCESS_ONCE() calls are not optional, the current contents of
Documentation/circular-buffers.txt notwithstanding.

							Thanx, Paul

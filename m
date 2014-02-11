Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DF7362C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 14:40:05 +1100 (EST)
Message-ID: <1392089915.3996.60.camel@pasglop>
Subject: Re: [PATCH v2] powerpc ticket locks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 11 Feb 2014 14:38:35 +1100
In-Reply-To: <20140211025645.GJ18016@ZenIV.linux.org.uk>
References: <20140207165801.GC2107@lst.de>
 <1392001823.3996.21.camel@pasglop> <20140210155217.GF2107@lst.de>
 <1392086660.3996.50.camel@pasglop>
 <20140211025645.GJ18016@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>, Torsten Duwe <duwe@lst.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-11 at 02:56 +0000, Al Viro wrote:
> > So the question is, is it reasonable to have the ref smaller than
> > 32-bit...
> 
> Every time you open a file, you bump dentry refcount.  Something like
> libc or ld.so will be opened on just about every execve(), so I'd say
> that 16 bits is far too low.  If nothing else, 32 bits might be too
> low on 64bit boxen...

So back to square 1 ... we can't implement together lockref, ticket
locks, and our lock confer mechanism within 64-bit.

I see two options at this stage. Both require a custom implementation
of lockref for powerpc, so some ifdef's such that we can replace the
generic implementation completely.

 - We can use a small ref, and when it's too big, overflow into a larger
one, falling back to the "old style" lock + ref (an overflow bit or a
compare with ffff)

 - We can have lockref "build" it's own lock out of the ticketpair and
ref, keeping the owner in a separate word. The owner doesn't strictly
need to be atomic.

Both are gross though :(

Anybody has a better idea ?

Ben.

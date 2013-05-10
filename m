Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB7C32C00E3
 for <linuxppc-dev@ozlabs.org>; Fri, 10 May 2013 21:52:18 +1000 (EST)
Message-ID: <1368186695.4524.27.camel@pasglop>
Subject: Re: Invalid perf_branch_entry.to entries question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Fri, 10 May 2013 21:51:35 +1000
In-Reply-To: <CAEjGV6x1=6iFUwQs6=5GY75-J9ZZzs8=CKE=+MGxdwoKycs9jA@mail.gmail.com>
References: <25394.1367890528@ale.ozlabs.ibm.com>
 <20130508155929.GA8459@dyad.programming.kicks-ass.net>
 <14691.1368052755@ale.ozlabs.ibm.com>
 <20130510104352.GF31235@dyad.programming.kicks-ass.net>
 <CAEjGV6x1=6iFUwQs6=5GY75-J9ZZzs8=CKE=+MGxdwoKycs9jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 eranian@google.com, Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-10 at 20:50 +1000, Michael Neuling wrote:
> The buffer is in the core (not main memory) and hence only has limited
> entries.  So skipping entries that can hopefully be determined in
> other ways means we can log more branches.
> 
> That being said, it's a PITA for the kernel ;-)

I would suggest flagging them. As you mention, the code might have been
modified since the sample was taken. Even if it still looks like a
branch and you can compute the "To" address it might not be the right
one ... at least userspace should be notified that this specific sample
is to handle with care.

And if you just can't read the instruction or it's not a branch anymore,
then stick a -1 in there, no way it can be a valid branch address :-)

Cheers,
Ben.

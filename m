Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk
 (7.3.c.8.2.a.e.f.f.f.8.1.0.3.2.0.9.6.0.7.2.3.f.b.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:bf32:7069:230:18ff:fea2:8c37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B1D31A0077
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 09:24:52 +1000 (EST)
Date: Mon, 15 Sep 2014 00:24:27 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140915002427.6ce18965@alan.etchedpixels.co.uk>
In-Reply-To: <5411FFB6.2080702@hurleysoftware.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.7080100@zytor.com>
 <5409D76D.2070203@hurleysoftware.com> <5409D9C0.7030403@zytor.com>
 <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
 <540DEE6C.2060904@zytor.com> <540E3207.7090007@hurleysoftware.com>
 <20140911110411.2de01944@alan.etchedpixels.co.uk>
 <5411FFB6.2080702@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> So a problem that no one has ever complained about on _any_ arch is suddenly
> a problem on a subset of Alpha cpus, but a problem I know exists on Alpha
> isn't important because no one's filed a bug about it?

Yes - because if you think about it that tells you that nobody is hitting
it with the old code and it probably doesn't matter.
 
> The only Alpha person in this discussion has come out clearly in favor
> of dropping EV4/5 support.

That's not a statistically valid sample size btw

Plus as I pointed out (and you ignored) you are shutting out any future
processors with this kind of oddity, and you have not audited all the
embedded devices we support or may support in future.
 
> The fact is that the kernel itself is much more parallel than it was
> 15 years ago, and that trend is going to continue. Paired with the fact
> that the Alpha is the least-parallel-friendly arch, makes improving
> parallelism and correctness even harder within kernel subsystems; harder
> than it has to be and harder than it should be.
> 
> Linus has repeatedly stated that non-arch code should be as
> arch-independent as possible

That's why many many years ago we added set_bit() and the other bit
functions. On sane processors they are very fast. On insane ones they
work. They understand byte tearing, they understand store ordering (which
a simple variable does not so you've got to audit all your memory
barriers too). In many cases they are faster than using memory barriers
to guide the compiler because they invalidate less and allow the compiler
more freedom.

All this started because I suggested you use set_bit and friends and for
some reason you've decided to try and find another way to do it. We have
the bit operations for a reason. On x86 they are very very fast, on
uniprocessor anything they are very fast, on multiprocessor in general
they are very fast, or you are dealing with boxes that have sanity
problems of other kinds.

Alan

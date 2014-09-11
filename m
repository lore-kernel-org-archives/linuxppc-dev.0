Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D78941A05A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 02:22:28 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 11 Sep 2014 10:22:25 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9C978C40003
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 10:22:20 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8BEIIOk6816072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 16:18:18 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s8BGQjYk011247
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 10:26:46 -0600
Date: Thu, 11 Sep 2014 09:16:53 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: bit fields && data tearing
Message-ID: <20140911161653.GA4775@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.7080100@zytor.com>
 <5409D76D.2070203@hurleysoftware.com> <5409D9C0.7030403@zytor.com>
 <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
 <540DEE6C.2060904@zytor.com> <540E3207.7090007@hurleysoftware.com>
 <20140911110411.2de01944@alan.etchedpixels.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140911110411.2de01944@alan.etchedpixels.co.uk>
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Peter Hurley <peter@hurleysoftware.com>, linux-alpha@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
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

On Thu, Sep 11, 2014 at 11:04:11AM +0100, One Thousand Gnomes wrote:
> > > Is *that* what we are talking about?  I was added to this conversation
> > > in the middle where it had already generalized, so I had no idea.
> > 
> > No, this is just what brought this craziness to my attention.
> 
> None of it is craziness. It's the real world leaking into the crazy
> delusional world of sequential programming. Machines are going to get
> more not less parallel.

Amen to that!!!

> > For example, byte- and short-sized circular buffers could not possibly
> > be safe either, when the head nears the tail.
> > 
> > Who has audited global storage and ensured that _every_ byte-sized write
> > doesn't happen to be adjacent to some other storage that may not happen
> > to be protected by the same (or any) lock?
> 
> Thats a meaningless question. Have you audited it all for correctness of
> any other form. Have you mathematically verified the functionality as a
> set of formal proofs ? If you can't prove its formally mathematically
> functionally correct why are you worried about this ?
> 
> Alpha works, maybe it has a near theoretical race on that point. It's not
> any worse than it was 15 years ago and nobody has really hit a problem
> with it. So from that you can usefully infer that those buffer cases are
> not proving a real problem.

Fair enough, I guess.

But Alpha's limitations were given as a reason to restrict
smp_store_release() and smp_load_acquire() from providing one-byte and
two-byte variants.  Of course, I am OK "probabilistically supporting"
pre-EV56 Alpha CPUs, but only if they don't get in the way of us doing
smp_store_release() and smp_load_acquire() on chars and shorts.  So if
pre-EV56 support has to go in order to allow smp_store_release() and
smp_load_acquire() on small data types, then pre-EV56 support simply
has to go.

Alternatively, one way to support this old hardware on a more
deterministic basis is to make the compiler use ll/sc sequences to do
byte and short accesses.  That would be fine as well.

						Thanx, Paul

> The tty locks together on the other hand are asking to hit it, and the
> problem you were trying to fix were the ones that need set_bit() to make
> the guarantees.
> 
> Alan
> 

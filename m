Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B16ED2C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 23:42:59 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 07:42:56 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E2D7D1FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 07:42:46 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r91DgrUv344438
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 07:42:53 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r91DjvXr010920
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 07:45:58 -0600
Date: Tue, 1 Oct 2013 06:42:52 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Avoiding the dentry d_lock on final dput(), part deux:
 transactional memory
Message-ID: <20131001134251.GA5534@linux.vnet.ibm.com>
References: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
 <1380581522.6396.20.camel@pasglop>
 <23118.1380587771@ale.ozlabs.ibm.com>
 <CA+55aFwi5sZK4mFxs3PT1wU4_vNzsLOFiocqi3g14fPamKXYsw@mail.gmail.com>
 <1380593103.6396.38.camel@pasglop>
 <20131001031356.GP19582@linux.vnet.ibm.com>
 <CAEjGV6xuscOh=t6BhbdRKAPcZ1DOJkD6ZcB1wgTf9-AedKSaxA@mail.gmail.com>
 <20131001121654.GX19582@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131001121654.GX19582@linux.vnet.ibm.com>
Cc: Waiman Long <Waiman.Long@hp.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, George Spelvin <linux@horizon.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chandramouleeswaran,
 Aswin" <aswin@hp.com>, "Norton, Scott J" <scott.norton@hp.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 01, 2013 at 05:16:54AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 01, 2013 at 02:52:28PM +1000, Michael Neuling wrote:
> > >> Well we don't have to, I think Mikey wasn't totally clear about that
> > >> "making all registers volatile" business :-) This is just something we
> > >> need to handle in assembly if we are going to reclaim the suspended
> > >> transaction.
> > 
> > Yeah, sorry.  The slow path with all registers as volatile is only
> > needed if we get pre-empted during the transaction.
> > 
> > >>
> > >> So basically, what we need is something along the lines of
> > >> enable_kernel_tm() which checks if there's a suspended user transaction
> > >> and if yes, kills/reclaims it.
> > >>
> > >> Then we also need to handle in our interrupt handlers that we have an
> > >> active/suspended transaction from a kernel state, which we don't deal
> > >> with at this point, and do whatever has to be done to kill it... we
> > >> might get away with something simple if we can state that we only allow
> > >> kernel transactions at task level and not from interrupt/softirq
> > >> contexts, at least initially.
> > >
> > > Call me a coward, but this is starting to sound a bit scary.  ;-)
> > 
> > We are just wanting to prototype it for now to see if we could make it
> > go faster.  If it's worth it, then we'd consider the additional
> > complexity this would bring.
> > 
> > I don't think it'll be that bad, but I'd certainly want to make sure
> > it's worth it before trying :-)
> 
> OK, fair point.  ;-)

That is, a fair point -assuming- that we also try the memory-barrier-free
cmpxchg that Linus suggested...

							Thanx, Paul

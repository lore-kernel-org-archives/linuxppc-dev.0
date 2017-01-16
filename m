Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v23ts5bPKzDqZc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:56:53 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id d140so12131702wmd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 22:56:53 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 16 Jan 2017 07:56:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
 tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
 dhowells@redhat.com, edumazet@google.com, dvhart@linux.intel.com,
 fweisbec@gmail.com, oleg@redhat.com, bobby.prani@gmail.com,
 will.deacon@arm.com, boqun.feng@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH tip/core/rcu 2/3] srcu: Force full grace-period ordering
Message-ID: <20170116065647.GA29538@gmail.com>
References: <1484385601-23379-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170114093550.GB14970@gmail.com>
 <20170114195417.GW5238@linux.vnet.ibm.com>
 <20170114214159.GA7098@linux.vnet.ibm.com>
 <20170115071123.GB26581@gmail.com>
 <20170115074034.GE5238@linux.vnet.ibm.com>
 <20170115075711.GA19506@gmail.com>
 <20170115092454.GF5238@linux.vnet.ibm.com>
 <20170115094058.GB28621@gmail.com>
 <20170115194526.GH5238@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170115194526.GH5238@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> On Sun, Jan 15, 2017 at 10:40:58AM +0100, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > > [sounds of rummaging around in the Git tree]
> > > > 
> > > > I found this commit of yours from ancient history (more than a year ago!):
> > > > 
> > > >   commit 12d560f4ea87030667438a169912380be00cea4b
> > > >   Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > >   Date:   Tue Jul 14 18:35:23 2015 -0700
> > > > 
> > > >     rcu,locking: Privatize smp_mb__after_unlock_lock()
> > > >     
> > > >     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
> > > >     likely the only thing that ever will use it, so this commit makes this
> > > >     macro private to RCU.
> > > >     
> > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > >     Cc: Will Deacon <will.deacon@arm.com>
> > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > >     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > >     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> > > > 
> > > > So I concur and I'm fine with your patch - or with the status quo code as well.
> > > 
> > > I already have the patch queued, so how about I keep it if I get an ack
> > > from the powerpc guys and drop it otherwise?
> > 
> > Yeah, sounds good! Your patch made me look up 'RelAcq' so it has documentation 
> > value as well ;-)
> 
> ;-) ;-) ;-)
> 
> Looking forward, my guess would be that if some other code needs
> smp_mb__after_unlock_lock() or if some other architecture needs
> non-smb_mb() special handling, I should consider making it work the
> same as smp_mb__after_atomic() and friends.  Does that seem like a
> reasonable thought?

Yeah, absolutely - it's just that the pattern triggered the 'this looks a bit too 
specialized' response in me, but after seeing the details (again ...) I agree that 
this time is different!

Thanks,

	Ingo

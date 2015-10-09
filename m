Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6A711A0389
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 18:29:40 +1100 (AEDT)
Date: Fri, 9 Oct 2015 09:29:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009072931.GT3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008214439.GE3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2015 at 02:44:39PM -0700, Paul E. McKenney wrote:

> > > > I am with Peter -- we do need the benchmark results for PPC.
> > > 
> > > Urgh, sorry guys. I have been slowly doing some benchmarks, but time is not
> > > plentiful at the moment.
> > > 
> > > If we do a straight lwsync -> sync conversion for unlock it looks like that
> > > will cost us ~4.2% on Anton's standard context switch benchmark.
> > 
> > And that does not seem to agree with Paul's smp_mb__after_unlock_lock()
> > usage and would not be sufficient for the same (as of yet unexplained)
> > reason.
> > 
> > Why does it matter which of the LOCK or UNLOCK gets promoted to full
> > barrier on PPC in order to become RCsc?
> 
> You could do either.  However, as I understand it, there is hardware for
> which bc;isync is faster than lwsync.  For such hardware, it is cheaper
> to upgrade the unlock from lwsync to sync than to upgrade the lock from
> bc;isync to sync.  If I recall correctly, the kernel rewrites itself at
> boot to select whichever of lwsync or bc;isync is better for the hardware
> at hand.

Fair enough. I'll go wake up and think about the other issue ;-)

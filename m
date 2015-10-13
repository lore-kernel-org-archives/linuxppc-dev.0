Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 35AAF1A0297
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 02:04:29 +1100 (AEDT)
Date: Tue, 13 Oct 2015 16:04:27 +0100
From: Will Deacon <will.deacon@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 6/6] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151013150427.GP21550@arm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-7-git-send-email-boqun.feng@gmail.com>
 <20151013132404.GI21550@arm.com>
 <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
 <20151013144333.GN21550@arm.com>
 <20151013145830.GC23991@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151013145830.GC23991@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 10:58:30PM +0800, Boqun Feng wrote:
> On Tue, Oct 13, 2015 at 03:43:33PM +0100, Will Deacon wrote:
> > Putting a barrier in the middle of that critical section is probably a
> > terrible idea, and that's why I thought you were avoiding it (hence my
> 
> The fact is that I haven't thought of that way to implement
> cmpxchg_release before you ask that question ;-) And I'm not going to do
> that for now and probably not in the future.
> 
> > original question). Perhaps just add a comment to that effect, since I
> 
> Are you suggesting if I put a barrier in the middle I'd better to add a
> comment, right? So if I don't do that, it's OK to let this patch as it.

No, I mean put a comment in your file to explain the reason why you
override _relaxed and _acquire, but not _release (because overriding
_release would introduce this weird barrier in the middle of the critical
section, which would likely cause the conditional store to fail).

Will

Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 273CD1A1F58
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 20:31:27 +1000 (AEST)
Date: Thu, 3 Sep 2015 11:31:23 +0100
From: Will Deacon <will.deacon@arm.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150903103123.GD877@arm.com>
References: <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
 <20150901190027.GP1612@arm.com>
 <20150901214540.GI4029@linux.vnet.ibm.com>
 <20150902095906.GC25720@arm.com> <55E7145C.7050505@gmail.com>
 <CAJhHMCAVUzxQLyOnntd75LP4xvLGREBOx38BYFVqLLU-pNH5bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJhHMCAVUzxQLyOnntd75LP4xvLGREBOx38BYFVqLLU-pNH5bQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 02, 2015 at 04:36:09PM +0100, Pranith Kumar wrote:
> On Wed, Sep 2, 2015 at 11:23 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> > On 09/02/2015 05:59 AM, Will Deacon wrote:
> >> I just thought it was worth making this point, because it is prohibited
> >> in SC and I don't want people to think that our RELEASE/ACQUIRE operations
> >> are SC (even though they happen to be on arm64).
> >
> > This is interesting information. Does that mean that the following patch
> > should work? (I am not proposing to use it, just trying to understand if
> > REL+ACQ will act as a full barrier on ARM64, which you say it does).
> >
> > Thanks,
> > Pranith.
> >
> > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > index d8c25b7..14a1b35 100644
> > --- a/arch/arm64/include/asm/cmpxchg.h
> > +++ b/arch/arm64/include/asm/cmpxchg.h
> > @@ -68,8 +68,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
> >                 BUILD_BUG();
> >         }
> >
> > -       smp_mb();
> > -       return ret;
> > +       return smp_load_acquire(ret);
> 
> I meant 'smp_load_acquire(&ret);'

Yes, I think that would work on arm64, but it's not portable between
architectures.

Will

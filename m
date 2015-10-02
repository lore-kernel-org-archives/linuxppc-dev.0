Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB90A1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 15:31:08 +1000 (AEST)
Date: Fri, 2 Oct 2015 07:25:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Waiman Long <waiman.long@hp.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC v2 6/7] powerpc: atomic: Make atomic{,64}_xchg and xchg a
 full barrier
Message-ID: <20151002052542.GZ3816@twins.programming.kicks-ass.net>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-7-git-send-email-boqun.feng@gmail.com>
 <20151001122802.GR2881@worktop.programming.kicks-ass.net>
 <CAL0jBu_=w-GDtg6B+YXLmEn=Qac0mnWaWzS6NvLC9KMcNSj8=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAL0jBu_=w-GDtg6B+YXLmEn=Qac0mnWaWzS6NvLC9KMcNSj8=w@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 02, 2015 at 07:19:04AM +0800, Boqun Feng wrote:
> Hi Peter,
> 
> Please forgive me for the format of my reply. I'm travelling,
> and replying from my phone.
> 
> 2015年10月1日 下午7:28，"Peter Zijlstra" <peterz@infradead.org>写道：
> >
> > On Wed, Sep 16, 2015 at 11:49:34PM +0800, Boqun Feng wrote:
> > > According to memory-barriers.txt, xchg and its atomic{,64}_ versions
> > > need to imply a full barrier, however they are now just RELEASE+ACQUIRE,
> > > which is not a full barrier.
> > >
> > > So remove the definition of xchg(), and let __atomic_op_fence() build
> > > the full-barrier versions of these operations.
> >
> > Do you want to do a patch for -stable fixing the current implementation?
> 
> Good idea! I didn't think of this before, and I'd love to do the patch,
> but thing is that I'm not able to use my laptop until Oct 10th.
> I will send the patch once I'm back.
> Does that work for you?

Sure, no hurry.

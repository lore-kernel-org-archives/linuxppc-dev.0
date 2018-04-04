Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40GKrV5qJNzDqwb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 19:08:41 +1000 (AEST)
Date: Wed, 4 Apr 2018 10:08:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Message-ID: <20180404090831.62dtaqo4ojrmozj7@lakrids.cambridge.arm.com>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180327102116.GA2464@arm.com>
 <20180401111108.mudkiewzn33sifvk@yury-thinkpad>
 <20180403134832.2cdae64uwuot6ryz@lakrids.cambridge.arm.com>
 <20180404033625.gkn4q7kb2xf6d6mo@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180404033625.gkn4q7kb2xf6d6mo@yury-thinkpad>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2018 at 06:36:25AM +0300, Yury Norov wrote:
> On Tue, Apr 03, 2018 at 02:48:32PM +0100, Mark Rutland wrote:
> > On Sun, Apr 01, 2018 at 02:11:08PM +0300, Yury Norov wrote:
> > > @@ -840,8 +861,10 @@ el0_svc:
> > >  	mov	wsc_nr, #__NR_syscalls
> > >  el0_svc_naked:					// compat entry point
> > >  	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
> > > +	isb_if_eqs
> > >  	enable_dbg_and_irq
> > > -	ct_user_exit 1
> > > +	ct_user_exit
> > 
> > I don't think this is safe. here we issue the ISB *before* exiting a
> > quiesecent state, so I think we can race with another CPU that calls
> > kick_all_active_cpus_sync, e.g.
> > 
> > 	CPU0				CPU1
> > 
> > 	ISB
> > 					patch_some_text()
> > 					kick_all_active_cpus_sync()
> > 	ct_user_exit
> > 
> > 	// not synchronized!
> > 	use_of_patched_text()
> > 
> > ... and therefore the ISB has no effect, which could be disasterous.
> > 
> > I believe we need the ISB *after* we transition into a non-quiescent
> > state, so that we can't possibly miss a context synchronization event.
>  
> I decided to put isb() in entry because there's a chance that there will
> be patched code prior to exiting a quiescent state.

If we do patch entry text, then I think we have no option but to use
kick_all_active_cpus_sync(), or we risk races similar to the above.

> But after some headscratching, I think it's safe. I'll do like you
> suggested here.

Sounds good.

Thanks,
Mark.

Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtr263J5xzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 01:37:18 +1000 (AEST)
Date: Mon, 25 Apr 2016 17:37:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V3] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160425153710.GG3448@twins.programming.kicks-ass.net>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <20160420142408.GF3430@twins.programming.kicks-ass.net>
 <5718F32B.3050409@linux.vnet.ibm.com>
 <20160421161354.GI3430@twins.programming.kicks-ass.net>
 <571DED2B.8060600@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <571DED2B.8060600@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 25, 2016 at 06:10:51PM +0800, Pan Xinhui wrote:
> > So I'm not actually _that_ familiar with the PPC LL/SC implementation;
> > but there are things a CPU can do to optimize these loops.
> > 
> > For example, a CPU might choose to not release the exclusive hold of the
> > line for a number of cycles, except when it passes SC or an interrupt
> > happens. This way there's a smaller chance the SC fails and inhibits
> > forward progress.

> I am not sure if there is such hardware optimization.

So I think the hardware must do _something_, otherwise competing cores
doing load-exlusive could life-lock a system, each one endlessly
breaking the exclusive ownership of the other and the store-conditional
always failing.

Of course, there are such implementations, and they tend to have to put
in explicit backoff loops; however, IIRC, PPC doesn't need that. (See
ARC for an example that needs to do this.)

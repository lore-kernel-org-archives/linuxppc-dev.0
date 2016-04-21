Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrP2M0d68zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 02:14:03 +1000 (AEST)
Date: Thu, 21 Apr 2016 18:13:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH V3] powerpc: Implement {cmp}xchg for u8 and u16
Message-ID: <20160421161354.GI3430@twins.programming.kicks-ass.net>
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
 <20160420142408.GF3430@twins.programming.kicks-ass.net>
 <5718F32B.3050409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5718F32B.3050409@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2016 at 11:35:07PM +0800, Pan Xinhui wrote:
> yes, you are right. more load/store will be done in C code.
> However such xchg_u8/u16 is just used by qspinlock now. and I did not see any performance regression.
> So just wrote in C, for simple. :)

Which is fine; but worthy of a note in your Changelog.

> Of course I have done xchg tests.
> we run code just like xchg((u8*)&v, j++); in several threads.
> and the result is,
> [  768.374264] use time[1550072]ns in xchg_u8_asm
> [  768.377102] use time[2826802]ns in xchg_u8_c
> 
> I think this is because there is one more load in C.
> If possible, we can move such code in asm-generic/.

So I'm not actually _that_ familiar with the PPC LL/SC implementation;
but there are things a CPU can do to optimize these loops.

For example, a CPU might choose to not release the exclusive hold of the
line for a number of cycles, except when it passes SC or an interrupt
happens. This way there's a smaller chance the SC fails and inhibits
forward progress.

By doing the modification outside of the LL/SC you loose such
advantages.

And yes, doing a !exclusive load prior to the exclusive load leads to an
even bigger window where the data can get changed out from under you.

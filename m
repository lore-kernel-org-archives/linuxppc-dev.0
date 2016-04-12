Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkqFz57p9zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 00:34:47 +1000 (AEST)
Date: Tue, 12 Apr 2016 16:30:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
Message-ID: <20160412143023.GH1087@worktop>
References: <570752AA.9050603@linux.vnet.ibm.com>
 <20160408074744.GU3430@twins.programming.kicks-ass.net>
 <570A6078.2050002@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <570A6078.2050002@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 10, 2016 at 10:17:28PM +0800, Pan Xinhui wrote:
> 
> On 2016年04月08日 15:47, Peter Zijlstra wrote:
> > On Fri, Apr 08, 2016 at 02:41:46PM +0800, Pan Xinhui wrote:
> >> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
> >>
> >> Implement xchg{u8,u16}{local,relaxed}, and
> >> cmpxchg{u8,u16}{,local,acquire,relaxed}.
> >>
> >> Atomic operation on 8-bit and 16-bit data type is supported from power7
> > 
> > And yes I see nothing P7 specific here, this implementation is for
> > everything PPC64 afaict, no?
> > 
> Hello Peter,
> 	No, it's not for every ppc. So yes, I need add #ifdef here. Thanks for pointing it out.
> We might need a new config option and let it depend on POWER7/POWER8_CPU or even POWER9...

Right, I'm not sure if PPC has alternatives, but you could of course
runtime patch the code from emulated with 32bit ll/sc to native 8/16bit
ll/sc if present on the current CPU if you have infrastructure for these
things.

> > Also, note that you don't need explicit 8/16 bit atomics to implement
> > these. Its fine to use 32bit atomics and only modify half the word.
> > 
> That is true. But I am a little worried about the performance. It will
> forbid any other tasks to touch the other half word during the
> load/reserve, right?

Well, not forbid, it would just make the LL/SC fail and try again. Other
archs already implement them this way. See commit 3226aad81aa6 ("sh:
support 1 and 2 byte xchg") for example.

> I am working on the qspinlock implementation on PPC.
> Your and Waiman's patches are so nice. :)

Thanks!, last time I looked at PPC spinlocks they could not use things
like ticket locks because PPC might be a guest and fairness blows etc..

You're making the qspinlock-paravirt thing work on PPC, or doing
qspinlock only for bare-metal PPC?

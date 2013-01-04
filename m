Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD9FB2C0086
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2013 15:43:43 +1100 (EST)
Message-ID: <1357274575.2500.23.camel@pasglop>
Subject: Re: [PATCH v2 1/4] kprobes/powerpc: Do not disable External
 interrupts during single step
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Fri, 04 Jan 2013 15:42:55 +1100
In-Reply-To: <50C6C930.90206@in.ibm.com>
References: <20121203150438.7727.74924.stgit@suzukikp>
 <20121203150720.7727.91582.stgit@suzukikp> <50C6C930.90206@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, bigeasy@linutronix.de, oleg@redhat.com,
 linuxppc-dev@ozlabs.org, anton@redhat.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-12-11 at 11:18 +0530, Suzuki K. Poulose wrote:
> On 12/03/2012 08:37 PM, Suzuki K. Poulose wrote:
> > From: Suzuki K. Poulose <suzuki@in.ibm.com>
> >
> > External/Decrement exceptions have lower priority than the Debug Exception.
> > So, we don't have to disable the External interrupts before a single step.
> > However, on BookE, Critical Input Exception(CE) has higher priority than a
> > Debug Exception. Hence we mask them.

I'm not sure about that one ...

>From memory, 4xx has that interesting issue which is that if you have
single step enabled and an interrupt (of *any kind* occurs), the
processor *will* step into the first instruction of the interrupt
handler. (In fact, some silicons have a bug where it can even be the
*second* instruction of the handler, which can be problematic when the
first one is a branch).

This is why you may notice that whole business we have in the handling
of debug/crit interrupts where we try to figure out if that happened,
and return with DE off if it did.

Now, the above mentioned workaround means we might not need to disable
EE indeed.

However, in any case, I don't see what your patch fixes or improves, nor
do I understand what you mean by "it is possible we'd get the single
step reported for CE". Please explain in more details and describe the
problematic scenario.

Cheers,
Ben.

Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNfX430D8zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 01:59:16 +1000 (AEST)
Date: Mon, 6 Jun 2016 17:59:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, paulus@samba.org,
 mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com
Subject: Re: [PATCH v5 1/6] qspinlock: powerpc support qspinlock
Message-ID: <20160606155907.GH30909@twins.programming.kicks-ass.net>
References: <1464859370-5162-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464859370-5162-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464917520.26773.11.camel@kernel.crashing.org>
 <1464917548.26773.12.camel@au1.ibm.com>
 <57510353.1020209@linux.vnet.ibm.com>
 <1464928427.26773.26.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1464928427.26773.26.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2016 at 02:33:47PM +1000, Benjamin Herrenschmidt wrote:
>  - For the above, can you show (or describe) where the qspinlock
>    improves things compared to our current locks.

So currently PPC has a fairly straight forward test-and-set spinlock
IIRC. You have this because LPAR/virt muck and lock holder preemption
issues etc..

qspinlock is 1) a fair lock (like ticket locks) and 2) provides
out-of-word spinning, reducing cacheline pressure.

Esp. on multi-socket x86 we saw the out-of-word spinning being a big win
over our ticket locks.

And fairness, brought to us by the ticket locks a long time ago,
eliminated starvation issues we had, where a spinner local to the holder
would 'always' win from a spinner further away. So under heavy enough
local contention, the spinners on 'remote' CPUs would 'never' get to own
the lock.

pv-qspinlock tries to preserve the fairness while allowing limited lock
stealing and explicitly managing which vcpus to wake.

>	While there's
>    theory and to some extent practice on x86, it would be nice to
>    validate the effects on POWER.

Right; so that will have to be from benchmarks which I cannot help you
with ;-)

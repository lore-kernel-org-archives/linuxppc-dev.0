Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJ3Qk667czDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 02:24:46 +1000 (AEST)
Message-ID: <1493828669.25766.358.camel@kernel.crashing.org>
Subject: Re: [RFC][PATCH] powerpc/64s: Leave IRQs hard enabled over context
 switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard
 <anton@samba.org>
Date: Wed, 03 May 2017 18:24:29 +0200
In-Reply-To: <87k25yutfw.fsf@concordia.ellerman.id.au>
References: <20170503073414.18776-1-npiggin@gmail.com>
 <1493800107.25766.352.camel@kernel.crashing.org>
 <87k25yutfw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-03 at 20:26 +1000, Michael Ellerman wrote:
> Couldn't we avoid the whole problem by just having two bolted slots for
> the stack, meaning we could have the current and next stack bolted at
> all times.
> 
> That would mean we'd be using 4 slots for bolted entries, which is one
> more than 3 - but it might be a good trade off.
> 
> Or we could make the SLB insertion algorithm smarter so that we could
> later free the slot that was used for previous kernel stack.

Changing the insertion algo is a bit nasty, it's nice and simple as-is,
an option would be to replace the bolted "threshold" by a bolted "map"
with a bit (or a byte) per entry.

Sadly, we have no way that I know of to search an slb entry that tells
you in which slot it is, do we ? So even if the "new" stack is already
somewhere in there, we can't know it and just "mark it bolted". We'd
still have to invalidate just in case before bolting it in.

Ben.

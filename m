Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHJKl6cg2zDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 12:03:07 +1000 (AEST)
Message-ID: <1501034563.2792.16.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 26 Jul 2017 12:02:43 +1000
In-Reply-To: <20170725134715.fjkgaexhjzrkolal@santosiv.in.ibm.com>
References: <20170721090944.16889-1-santosh@fossix.org>
 <20170725065613.7039-1-santosh@fossix.org>
 <1500977248.2792.1.camel@kernel.crashing.org>
 <20170725134715.fjkgaexhjzrkolal@santosiv.in.ibm.com>
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

On Tue, 2017-07-25 at 19:17 +0530, Santosh Sivaraj wrote:
> I get the point. I looked at the generated assembly a bit closer, the update
> count is optimized out. Will send the alternative asm only patch.

We could do it in C the way x86 does it, using some helpers for
begin/end and have either an lwsync (but that would be slower than
the data dependency I think) or carefully crafting the helpers to
create one (make them return the pointer).

If you go down that path though, you need to make sure we do not
generate any TOC reference as the vDSO doesn't have a TOC.

Cheers,
Ben.

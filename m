Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B47FA1A090E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 09:30:32 +1100 (AEDT)
Message-ID: <1424644212.4980.14.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: re-enable dynticks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 23 Feb 2015 09:30:12 +1100
In-Reply-To: <CAFTL4hw_caOPUPwkgDst=gwtT1wh_DUmL-djF43DJC5at=7+Jg@mail.gmail.com>
References: <54DE52BC.3020303@us.ibm.com>
 <1424045319.3018.2.camel@ellerman.id.au>
 <1424059606.21410.41.camel@kernel.crashing.org>
 <CAFTL4hw_caOPUPwkgDst=gwtT1wh_DUmL-djF43DJC5at=7+Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-02-22 at 23:13 +0100, Frederic Weisbecker wrote:
> Yes that should work. After all "self-IPI" is an oxymoron. One would
> expect an IPI to be triggered by an irq controller but if such
> operation isn't supported with the current CPU being both source and
> destination, anything triggering the desired callback in an interrupt
> context in a reasonable amount of time ahead does the job here.

We could do self-IPI on platforms that have an SMP-capable interrupt
controller too but it would probably have higher overhead and would
require verifying that the code for each of our different interrupt
controllers is safe to be called from NMIs (hint: ioremap space isn't
safe to access from NMIs for us on some CPU families...).

We might be able to do better than using the decrementer on some CPUs by
using local doorbells, but for now this will do.

> I thought well that's what powerpc was doing for irq work but I wasn't
> sure I understood the code correctly. I should have pinged people
> about that, sorry.

No worries,

Cheers,
Ben.

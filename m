Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8562BB72F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 17:46:55 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBCA0DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 17:46:54 +1000 (EST)
Message-Id: <5014AA2E-2E85-49BF-8184-54866B067099@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090618034439.0854ADDDB2@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc: Add irqtrace support for 32-bit powerpc (v2)
Date: Fri, 19 Jun 2009 02:46:48 -0500
References: <20090618034439.0854ADDDB2@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 17, 2009, at 10:43 PM, Benjamin Herrenschmidt wrote:

> Based on initial work from: Dale Farnsworth <dale@farnsworth.org>
>
> Add the low level irq tracing hooks for 32-bit powerpc needed
> to enable full lockdep functionality.
>
> The approach taken to deal with the code in entry_32.S is that
> we don't trace all the transitions of MSR:EE when we just turn
> it off to peek at TI_FLAGS without races. Only when we are
> calling into C code or returning from exceptions with a state
> that have changed from what lockdep thinks.
>
> There's a little bugger though: If we take an exception that
> keeps interrupts enabled (such as an alignment exception) while
> interrupts are enabled, we will call trace_hardirqs_on() on the
> way back spurriously. Not a big deal, but to get rid of it would
> require remembering in pt_regs that the exception was one of the
> type that kept interrupts enabled which we don't know at this
> stage. (Well, we could test all cases for regs->trap but that
> sucks too much).
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> This one fixes a bug, trace_hardirqs_on was too late in the
> restore: code path and would clobber things. This boots fine
> now on a PowerBook.

Tested-by: Kumar Gala <galak@kernel.crashing.org>

on SMP e500 based system (8572)

- k

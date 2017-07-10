Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5mdT0hPqzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 23:43:40 +1000 (AEST)
Date: Mon, 10 Jul 2017 08:43:26 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/asm: Mark cr0 as clobbered in mftb()
Message-ID: <20170710134326.GB13471@gate.crashing.org>
References: <20170706084643.22425-1-oohall@gmail.com>
 <8737a4v7dd.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737a4v7dd.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Mon, Jul 10, 2017 at 09:50:06PM +1000, Michael Ellerman wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
> 
> > The workaround for the CELL timebase bug does not correctly mark cr0 as
> > being clobbered. This can result in GCC making some poor^W completely
> > broken optimisations.
> 
> Fruit 'n oats, how did we never notice that? Luck I guess. Or subtle
> breakage that no one could pin down :E

GCC does not use cr0 before it has used cr7, cr5, cr6, cr1 (unless some
instruction _requires_ cr0, like record form ("dot") instructions, which
until recently were disabled when targetting Cell), so it isn't too easy
to hit the problem here.  Maybe Oliver used a very new GCC?  Or he was
unlucky.

> I'll tag it for stable.
> 
> Your change log is not entirely fair, it's not GCC's fault, we changed
> register state without telling it, so it's on us :)  I'll reword it a
> bit here.

Yep, GCC works fine here, GIGO etc.  It isn't feasible to make GCC warn
for most inline asm problems, either (we do not parse the mnemonics in
the asm; this is a fundamental part of the design; you must express all
constraints as, well, constraints).


Segher

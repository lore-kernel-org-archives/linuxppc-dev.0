Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495A41A0B8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 13:00:25 +1100 (AEDT)
Message-ID: <1417140017.2852.20.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: 32 bit getcpu VDSO function uses 64 bit
 instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 28 Nov 2014 13:00:17 +1100
In-Reply-To: <20141127205015.GA10073@gate.crashing.org>
References: <1417036288-22079-1-git-send-email-anton@samba.org>
 <1417041497.12952.2.camel@concordia> <1417045827.16862.32.camel@otta>
 <20141127160829.GA26139@gate.crashing.org> <1417110100.16862.36.camel@otta>
 <20141127205015.GA10073@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-27 at 14:50 -0600, Segher Boessenkool wrote:
> On Thu, Nov 27, 2014 at 11:41:40AM -0600, Peter Bergner wrote:
> > On Thu, 2014-11-27 at 10:08 -0600, Segher Boessenkool wrote:
> > > On Wed, Nov 26, 2014 at 05:50:27PM -0600, Peter Bergner wrote:
> > > > Nope, you don't get a SIGILL when executing 64-bit instructions in
> > > > 32-bit mode, so it'll happily just execute the instruction, doing
> > > > a full 64-bit compare.  I'm guessing that the upper 32-bits of both
> > > > r3 and r4 contain zeros, so we're probably just getting lucky.
> > > 
> > > You will get a SIGILL if you run on 32-bit hardware.
> > 
> > Ha, I completely forgot about 32-bit hardware.  Anyway, I looked
> > at the ISA, and cmpdi and cmpwi are just extended mnemonics for
> > cmpi, with cmpdi setting the L field to 1.  Probably on 32-bit
> > hardware, the hardware is just ignoring the L bit being set and
> > doing a cmpwi for us???
> 
> Huh.  Yes, maybe some implementations do that.
> 
> The good news is that those then compute the correct thing ;-)
> 
> Can QEMU help catch such bugs more reliably?

That's all moot, that piece of code only exist on 64-bit kernels :-)

So the only risk here is the very remote and unlikely case where the
register might contain 0 in the low 32-bits and some garbage in the top.

Cheers,
Ben.

Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc0Z02m1hzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 11:11:04 +1100 (AEDT)
Date: Sun, 5 Mar 2017 18:10:47 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Gabriel Paubert <paubert@iram.es>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero in
 init_cache_info()
Message-ID: <20170306001047.GO31469@gate.crashing.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
 <20170305123737.GM31469@gate.crashing.org>
 <20170305165837.GA2019@visitor2.iram.es>
 <20170305172456.GN31469@gate.crashing.org>
 <1488755341.2870.117.camel@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1488755341.2870.117.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 06, 2017 at 10:09:01AM +1100, Benjamin Herrenschmidt wrote:
> > The compiler can do whatever it likes with code that has undefined
> > behaviour.  With this optimisation it a) can compile the conforming
> > code to something better; and b) undefined behaviour will trap instead
> > of doing something random (which often is exploitable).
> 
> I actually like that feature,

Yeah, me too -- it also (currently) makes *smaller* code than it would
without it.  Win-win-win.

> except it did bite me once or twice in the past
> adding traps to intentional NULL dereferences ;-) Ah the joys of writing
> a firmware where you poke at stuff at fixed addresses in low memory :-)

You cannot really have something at address 0, the way NULL pointers
are represented in GCC.  0 in firmware, so *fun*, especially before the
CFAR was invented.  "Something jumped to 0, CTR is 0 so it's probably
a BCTR, but which one of the 6000?"

What do you have at 0?  Not anything you need often I hope?


Segher

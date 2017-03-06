Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail2.puc.rediris.es (arce.puc.rediris.es
 [IPv6:2001:720:418:ca02::18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcJNk6mMnzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 23:04:06 +1100 (AEDT)
Date: Mon, 6 Mar 2017 13:03:19 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero
 in init_cache_info()
Message-ID: <20170306120319.GA17443@visitor2.iram.es>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
 <20170305123737.GM31469@gate.crashing.org>
 <20170305165837.GA2019@visitor2.iram.es>
 <20170305172456.GN31469@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170305172456.GN31469@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 05, 2017 at 11:24:56AM -0600, Segher Boessenkool wrote:
> On Sun, Mar 05, 2017 at 05:58:37PM +0100, Gabriel Paubert wrote:
> > > > Erk sorry. One of the static checkers spotted it, but I hadn't got
> > > > around to fixing it because it seemed to not actually blow up, guess
> > > > not.
> > > 
> > > The PowerPC divw etc. instructions do not trap by themselves, but recent
> > > GCC inserts trap instructions on code paths that are always undefined
> > > behaviour (like, dividing by zero).
> > 
> > Is it systematic or does it depend from, e.g., optimization levels?
> 
> In this case it needs -fisolate-erroneous-paths-dereference which is
> default at -O2 and higher.

Great, another optimization-dependent behaviour. :-(

But this is not the most serious issue: on PPC, when you #include
<limits>, the numeric_limits<any_integer_type>::traps is false on PPC,
and on no other architecture that I know of (in practice this trap
reflects the hardware behaviour on division by zero).

By generating a trap in this case, I believe that the compiler violates
a contract given by <limits>, and the standard.

I'd certainly prefer a compile time warning, easily convertible to an
error.

> 
> > Is there anything in the standards about this feature?
> 
> The compiler can do whatever it likes with code that has undefined
> behaviour.  With this optimisation it a) can compile the conforming
> code to something better; and b) undefined behaviour will trap instead
> of doing something random (which often is exploitable).

It may be undefined, but I believe that the numeric_limits<>::traps
value clearly prohibits generating a trap in this case.

    Gabriel

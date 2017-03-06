Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcMMB4m32zDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 01:17:58 +1100 (AEDT)
Date: Mon, 6 Mar 2017 08:17:36 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Michael Ellerman <mpe@ellerman.id.au>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero in
 init_cache_info()
Message-ID: <20170306141735.GR31469@gate.crashing.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
 <20170305123737.GM31469@gate.crashing.org>
 <20170305165837.GA2019@visitor2.iram.es>
 <20170305172456.GN31469@gate.crashing.org>
 <20170306120319.GA17443@visitor2.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306120319.GA17443@visitor2.iram.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 06, 2017 at 01:03:19PM +0100, Gabriel Paubert wrote:
> > > > The PowerPC divw etc. instructions do not trap by themselves, but recent
> > > > GCC inserts trap instructions on code paths that are always undefined
> > > > behaviour (like, dividing by zero).
> > > 
> > > Is it systematic or does it depend from, e.g., optimization levels?
> > 
> > In this case it needs -fisolate-erroneous-paths-dereference which is
> > default at -O2 and higher.
> 
> Great, another optimization-dependent behaviour. :-(

It makes the "behaviour" for undefined behaviour *less* surprising.
It does not change anything else: malformed programs stay malformed,
correct programs do exactly what they did before, too.

> But this is not the most serious issue: on PPC, when you #include
> <limits>, the numeric_limits<any_integer_type>::traps is false on PPC,
> and on no other architecture that I know of (in practice this trap
> reflects the hardware behaviour on division by zero).
> 
> By generating a trap in this case, I believe that the compiler violates
> a contract given by <limits>, and the standard.

[ snip ]

I have no idea why you are bringing C++ into this.  Please open a PR
if you think there is a bug in the C++ library.

I'll note that this cannot violate the standard, see the "terms and
definitions":

[defns.undefined]
undefined behavior
behavior for which this International Standard imposes no requirements


Segher

Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61DA71A03A7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 00:52:48 +1000 (AEST)
Date: Sat, 26 Sep 2015 09:52:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Torsten Duwe <duwe@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: -mprofile-kernel vs. notrace in ppc64(le) Linux kernels
Message-ID: <20150926145243.GA14958@gate.crashing.org>
References: <20150926143008.GA14606@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150926143008.GA14606@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 26, 2015 at 04:30:08PM +0200, Torsten Duwe wrote:
> As I mentioned earlier this year, it's a bad idea to call _mcount from
> MMU helper functions (e.g. hash_page...), when the profiling/tracing/
> live-patching/whatever framewok might in turn cause another such fault.
> Jikos suggested to use fine-grained control of these functions with the
> "notrace" keyword in the Linux kernel. It is mapped to GCC's (4.8, FWIW)
> __attribute__((no_instrument_function)), which, to my surprise, works
> for -p and -pg nicely, but does not affect -mprofile-kernel at all!

That is surprising; please file a GCC bug.

> Should we consider this a bug? IMHO it is. I can see in the GCC sources
> that -mprofile-kernel is more like a low-level hack in rs6000.c,
> quite far below the RTL code generator, so the no_instrument_function
> attribute is probably hard to check for.
> 
> What is -mprofile-kernel good for, if it bears such a risk of crashing
> the kernel?

It didn't work when combined with other fringe functionality.  It happens.

> Is it the right hook for ppc64 live patching? How to protect
> those critical functions? Filter -mprofile-kernel for those object files?

That might work.

> Ask the GCC experts to fix this?

Yes please.  You probably need a workaround for released compilers though.


Segher

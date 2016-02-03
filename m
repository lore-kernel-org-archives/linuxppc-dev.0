Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D28A1A0220
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 22:24:53 +1100 (AEDT)
Date: Wed, 3 Feb 2016 12:24:49 +0100
From: Torsten Duwe <duwe@lst.de>
To: Jiri Kosina <jikos@kernel.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20160203112449.GA27247@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de> <56B1AAE5.10500@linaro.org>
 <alpine.LNX.2.00.1602030952220.22727@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1602030952220.22727@cbobk.fhfr.pm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 03, 2016 at 09:55:11AM +0100, Jiri Kosina wrote:
> On Wed, 3 Feb 2016, AKASHI Takahiro wrote:
> > those efforts, we are proposing[1] a new *generic* gcc option, -fprolog-add=N.
> > This option will insert N nop instructions at the beginning of each function.

> The interesting part of the story with ppc64 is that you indeed want to 
> create the callsite before the *most* of the prologue, but not really :) 

I was silently assuming that GCC would do this right on ppc64le; add the NOPs
right after the TOC load. Or after TOC load and LR save? ...

> The part of the prologue where TOC pointer is saved needs to happen before 
> the fentry/profiling call.

Yes, any call, to any profiler/tracer/live patcher is potentially global
and needs the _new_ TOC value.

This proposal, if implemented in a too naive fashion, will worsen the problem
we currently discuss: a few NOPs _never_ cause any global reference. GCC might
be even more inclined to not load a new TOC value. That change would need to be
fairly smart on ppc64le.

	Torsten

Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 675F91A0228
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 19:55:16 +1100 (AEDT)
Date: Wed, 3 Feb 2016 09:55:11 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
cc: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
In-Reply-To: <56B1AAE5.10500@linaro.org>
Message-ID: <alpine.LNX.2.00.1602030952220.22727@cbobk.fhfr.pm>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de> <56B1AAE5.10500@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 3 Feb 2016, AKASHI Takahiro wrote:

> > The gcc switch -mprofile-kernel, available for ppc64 on gcc > 4.8.5,
> > allows to call _mcount very early in the function, which low-level
> > ASM code and code patching functions need to consider.
> > Especially the link register and the parameter registers are still
> > alive and not yet saved into a new stack frame.
> 
> I'm thinking of implementing live patch support *for arm64*, and as part of
> those efforts, we are proposing[1] a new *generic* gcc option, -fprolog-add=N.
> This option will insert N nop instructions at the beginning of each function.
> So we have to initialize those codes at the boot time to later utilize
> them for FTRACE_WITH_REGS. Other than that, it will work similarly
> with -mfentry on x86 (and -mprofile-kernel?).
> 
> I'm totally unfamiliar with ppc architecture, but just wondering
> whether this option will also be useful for other architectures.

The interesting part of the story with ppc64 is that you indeed want to 
create the callsite before the *most* of the prologue, but not really :) 
The part of the prologue where TOC pointer is saved needs to happen before 
the fentry/profiling call.

I don't think this will be an issue on ARM64, but it definitely is 
something that should be taken into account in case the gcc option is 
meant to be really generic.

Thanks,

-- 
Jiri Kosina
SUSE Labs

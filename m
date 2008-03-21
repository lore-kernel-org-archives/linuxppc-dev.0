Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43ACEDE31E
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:24:31 +1100 (EST)
Date: Fri, 21 Mar 2008 11:24:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: [PATCH v2] Make 83xx perfmon support selectable
Message-ID: <20080321162401.GB4170@loki.buserror.net>
References: <1204934343-5235-1-git-send-email-afleming@freescale.com>
	<20080318170542.GA4099@loki.buserror.net>
	<E3C4695C-A2A9-4657-B771-97DFDD3F6ACE@kernel.crashing.org>
	<47E2FA6D.9020200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47E2FA6D.9020200@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Phillips Kim <Kim.Phillips@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 07:59:41PM -0400, Jerry Van Baren wrote:
> Per Andy (and my limited reading of the UMs), some 83xx have the PMR  
> registers and some don't.  The compiler either supports the PMR register  
> or it doesn't.  If you make it runtime configurable, people running CPUs  
> that don't support the specific PMR will have to change compiler  
> configurations in order to compile with the PMR register in there (could  
> have unintended consequences).

I'm not saying make it runtime-only -- you can still have a config option to
determine whether to build a kernel that supports it.  I'm saying there
should be an additional runtime check so that if you run a multiplatform
kernel with perfmon enabled on a chip that doesn't support it, you won't
take a program check.

> Also, if you look at the code (arch/powerpc/kernel/pmc.c), there are  
> several different types of PMR registers, based on the core and flavor  
> of the core.  Finding or making a compiler setup that supports all of  
> the possible PMR registers could be a problem.

It only needs to support all possible registers within a class of hardware
over which we support multiplatform kernels.

> You would still have to make the PMR read/write runtime selectable  
> because the CPUs that don't support that register will raise an  
> exception IIRC (an Really Bad Thing[tm]).

Yes, that was my point.  The changelog on the patch seemed to indicate that
the compile-time option was intended to address this, not just the toolchain
problem.

-Scott

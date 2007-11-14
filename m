Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18235.28312.88899.861687@cargo.ozlabs.ibm.com>
Date: Thu, 15 Nov 2007 08:54:32 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: Kernel locks up after calling kernel_execve()
In-Reply-To: <20071114093939.297890@gmx.net>
References: <20071108214723.135260@gmx.net> <1194564017.6561.21.camel@pasglop>
	<20071109074155.266120@gmx.net> <1194594629.6561.34.camel@pasglop>
	<20071110171130.254580@gmx.net> <1194753340.21340.24.camel@pasglop>
	<20071113212320.85840@gmx.net> <1194990218.28865.1.camel@pasglop>
	<20071113220655.85840@gmx.net> <1194997072.28865.5.camel@pasglop>
	<20071114093939.297890@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard Pircher writes:

> Yeah, the northbridge hates the M bit! Thus the AmigaOne platform code

Wow.

> masks out the CPU_FTR_NEED_COHERENT flag and disables the L2 cache
> prefetch engines (I don't care about the performance loss).
> I couldn't find any other code that sets the M bit, except for huge TLB
> page support, but isn't that only for PPC64?

No it's not just for ppc64.  We had a patch that went in some time ago
to ensure that the M bit was set on various 32-bit platforms because
otherwise we got data corruption (due to a small cache in the
northbridge not being kept coherent with the processor cache).

Look for CPU_FTR_NEED_COHERENT in include/asm-powerpc/cputable.h and
arch/powerpc/mm/*.

Paul.

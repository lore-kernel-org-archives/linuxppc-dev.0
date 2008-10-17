Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56C03DDECF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 11:52:20 +1100 (EST)
Subject: Re: [PATCH] ftrace: powerpc: remove startup functions from tracing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.1.10.0810162046570.20570@gandalf.stny.rr.com>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810162046570.20570@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 11:50:46 +1100
Message-Id: <1224204646.7654.52.camel@pasglop>
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 20:48 -0400, Steven Rostedt wrote:
> 
> The early init code in PowerPC is not mapped to their final locations
> and all jumps and memory references must be done with relative jumps
> and accesses.
> 
> The lib files in the powerpc directory are called in early boot, and
> since mcount will perform direct access to memory, the lib files need
> not be traced.

This is annoying though, because that means things like memcpy,
copy_to_from_user etc... can't be traced. On the other hand a lot
of that is asm and already doesn't call mcount.

Cheers,
Ben.

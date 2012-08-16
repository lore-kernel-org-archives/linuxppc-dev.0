Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C05852C009B
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2012 17:40:29 +1000 (EST)
Message-ID: <1345102812.31459.114.camel@twins>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Michael Neuling <mikey@neuling.org>
Date: Thu, 16 Aug 2012 09:40:12 +0200
In-Reply-To: <28857.1345091034@neuling.org>
References: <28857.1345091034@neuling.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 K Prasad <prasad@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-16 at 14:23 +1000, Michael Neuling wrote:
>=20
> On this second syscall, fetch_bp_busy_slots() sets slots.pinned to be 1,
> despite there being no breakpoint on this CPU.  This is because the call
> the task_bp_pinned, checks all CPUs, rather than just the current CPU.
> POWER7 only has one hardware breakpoint per CPU (ie. HBP_NUM=3D1), so we
> return ENOSPC.

I think this comes from the ptrace legacy, we register a breakpoint on
all cpus because when we migrate a task it cannot fail to migrate the
breakpoint.

Its one of the things I hate most about the hwbp stuff as it relates to
perf.

Frederic knows more...

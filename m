Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEAB22C007E
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2012 00:15:31 +1000 (EST)
Message-ID: <1345126502.29668.36.camel@twins>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 16 Aug 2012 16:15:02 +0200
In-Reply-To: <1345125747.20062.12.camel@concordia>
References: <28857.1345091034@neuling.org>
 <1345102812.31459.114.camel@twins> <20344.1345115849@neuling.org>
 <1345117498.29668.23.camel@twins> <1345125747.20062.12.camel@concordia>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, K Prasad <prasad@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-17 at 00:02 +1000, Michael Ellerman wrote:
> You do want to guarantee that the task will always be subject to the
> breakpoint, even if it moves cpus. So is there any way to guarantee that
> other than reserving a breakpoint slot on every cpu ahead of time?=20

That's not how regular perf works.. regular perf can overload hw
resources at will and stuff is strictly per-cpu.

So the regular perf record has perf_event_attr::inherit enabled by
default, this will result in it creating a per-task-per-cpu event for
each cpu and this will succeed because there's no strict reservation to
avoid/detect starvation against perf_event_attr::pinned events.

For regular (!pinned) events, we'll RR the created events on the
available hardware resources.

HWBP does things completely different and reserves a slot over all CPUs
for everything, thus stuff completely falls apart.

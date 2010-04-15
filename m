Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06581B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 16:52:09 +1000 (EST)
Subject: Re: linux-next: boot failure after merge of the final tree (tip
	related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20100415161214.04637496.sfr@canb.auug.org.au>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Apr 2010 16:48:30 +1000
Message-ID: <1271314110.13059.159.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-15 at 16:12 +1000, Stephen Rothwell wrote:
> 
> Caused by commit bd6d29c25bb1a24a4c160ec5de43e0004e01f72b ("lockstat:
> Make lockstat counting per cpu").  This added a WARN_ON_ONCE to
> debug_atomic_inc() which is called from trace_hardirqs_on_caller()
> with
> irqs enabled.
> 
> Line 2301 is:
> 
>         if (unlikely(curr->hardirqs_enabled)) {
>                 debug_atomic_inc(redundant_hardirqs_on);   <--- 2301
>                 return;
>         }
> 
> This is especially bad since on PowerPC, WARN_ON is a TRAP and the
> return
> path from the TRAP also calls trace_hardirqs_on_caller(), so the TRAP
> recurses ... 

I think this is because our syscall entry pretty much force-enable irqs.

I remember deciding back then that getting lockdep balanced in that area
was tricky and I didn't do it to avoid adding more overhead to the
syscall path but I suppose I could revisit if necessary.

Cheers,
Ben.

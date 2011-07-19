Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 239E7B6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 19:22:09 +1000 (EST)
Subject: Re: [PATCH v2] net: filter: BPF 'JIT' compiler for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <1311066368.2375.13.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
References: <4E23E5C3.1070209@ozlabs.org>  <4E24E867.9050909@ozlabs.org>
	<1311058260.16961.12.camel@edumazet-laptop>
	<1311062135.25044.409.camel@pasglop>
	<1311066368.2375.13.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 19:22:02 +1000
Message-ID: <1311067322.25044.415.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-19 at 11:06 +0200, Eric Dumazet wrote:
> Please Matt add to your next version this check. I dont think I have
> to
> submit a one line patch later...
> 
> On x86_64, cpu_number field is already 32bit, we have some time before
> it becomes 64bit ;)
> 
> We probably should add some extra check to make sure segment doesnt
> change (%gs on x86_64, r13 on ppc64) on a future linux version.

r13 isn't really a "segment" per-se, it can change if you aren't preempt
disabled, it's the PACA pointer, which is basically a low level per-cpu
data structure, so it will change if you migrate around (but if you are
in softirq context like most of the network stack, then it won't
change).

As for the CPU number being 16-bit, this is really due to how our
spinlocks work, using that as a lock token within the same 32-bit word
as the lock flag etc... We can easily fix that later if needed but I
don't see any emergency for us.

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B54CBDDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:22:50 +1100 (EST)
Subject: Re: [PATCH 6/16] powerpc/mm: Split mmu_context handling v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200812151643.44944.arnd@arndb.de>
References: <20081215054530.4835FDE00C@ozlabs.org>
	<200812151643.44944.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 07:20:20 +1100
Message-Id: <1229372420.26324.110.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-15 at 16:43 +0100, Arnd Bergmann wrote:
> Didn't we lift the limit to 30,000 tasks at some point? The comment
> in linux/threads.h mentions that the PID space goes up to 4 million.
> What does actually happen when we increase pid_max to beyond 32768
> on those systems and try to use them? Is there another limit in place?

Well, the mm context allocator for hash based CPUs cannot hand out more
than 32767 contexts. I suspect it's just going to spin in
init_new_context. I could make it fail instead...

Cheers,
Ben.

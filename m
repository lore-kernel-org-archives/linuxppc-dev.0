Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7E1DB6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 19:55:16 +1000 (EST)
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QnpDN-0001Qv-HH
	for linuxppc-dev@lists.ozlabs.org; Mon, 01 Aug 2011 09:55:13 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219]
	helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1QnpDM-0008PA-Vq
	for linuxppc-dev@lists.ozlabs.org; Mon, 01 Aug 2011 09:55:13 +0000
Subject: Re: [PATCH] perf: powerpc: Disable pagefaults during callchain
	stack read
From: Peter Zijlstra <peterz@infradead.org>
To: David Ahern <dsahern@gmail.com>
In-Reply-To: <1312059200-11563-1-git-send-email-dsahern@gmail.com>
References: <1312059200-11563-1-git-send-email-dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Aug 2011 11:59:52 +0200
Message-ID: <1312192792.2617.381.camel@laptop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
	acme@ghostprotocols.net, mingo@elte.hu, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-07-30 at 14:53 -0600, David Ahern wrote:
> A page fault occurred walking the callchain while creating a perf
> sample for the context-switch event. To handle the page fault the
> mmap_sem is needed, but it is currently held by setup_arg_pages.
> (setup_arg_pages calls shift_arg_pages with the mmap_sem held.
> shift_arg_pages then calls move_page_tables which has a cond_resched
> at the top of its for loop - hitting that cond_resched is what caused
> the context switch.)
> 
> This is an extension of Anton's proposed patch:
> https://lkml.org/lkml/2011/7/24/151
> adding case for 32-bit ppc.
> 
> Tested on the system that first generated the panic and then again
> with latest kernel using a PPC VM. I am not able to test the 64-bit
> path - I do not have H/W for it and 64-bit PPC VMs (qemu on Intel)
> is horribly slow.
> 
> Signed-off-by: David Ahern <dsahern@gmail.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Anton Blanchard <anton@samba.org> 

Hmm, Paul, didn't you fix something like this early on? Anyway, I've no
objections since I'm really not familiar enough with the PPC side of
things.

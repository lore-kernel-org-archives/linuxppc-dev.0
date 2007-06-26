Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 457F5DDEFE
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 12:02:02 +1000 (EST)
Date: Mon, 25 Jun 2007 19:00:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] Make jprobes a little safer for users
Message-Id: <20070625190057.c8dcb110.akpm@linux-foundation.org>
In-Reply-To: <7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
	<7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, Christoph,
	linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
	linuxppc-dev@ozlabs.org, Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Jun 2007 11:48:51 +1000 (EST) Michael Ellerman <michael@ellerman.id.au> wrote:

> I realise jprobes are a razor-blades-included type of interface, but
> that doesn't mean we can't try and make them safer to use. This guy I
> know once wrote code like this:
> 
> struct jprobe jp = { .kp.symbol_name = "foo", .entry = "jprobe_foo" };
> 
> And then his kernel exploded. Oops.
> 
> This patch adds an arch hook, arch_deref_entry_point() (I don't like it either)
> which takes the void * in a struct jprobe, and gives back the text address
> that it represents.
> 
> We can then use that in register_jprobe() to check that the entry point
> we're passed is actually in the kernel text, rather than just some random
> value.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/ia64/kernel/kprobes.c    |    7 ++++++-
>  arch/powerpc/kernel/kprobes.c |   11 ++++++++---
>  kernel/kprobes.c              |    9 +++++++++

We're missing a declaration of arch_deref_entry_point() in some header file?

Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FgdS6ZghzDrDJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 23:27:24 +1000 (AEST)
Date: Wed, 19 Sep 2018 08:26:18 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/32: add stack protector support
Message-ID: <20180919132618.GX23155@gate.crashing.org>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <ef8fcc7933d56db6f5f7251cb982ca7131f7408d.1537355312.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ef8fcc7933d56db6f5f7251cb982ca7131f7408d.1537355312.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 11:14:45AM +0000, Christophe Leroy wrote:
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -112,6 +112,10 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
>  KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
>  endif
>  
> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-offset=4

This last line is only correct if !CONFIG_THREAD_INFO_IN_TASK; is that
always true?  Add an assert somewhere maybe?

> +	/*
> +	 * The stack_canary must be located at the offset given to
> +	 * -mstack-protector-guard-offset in the Makefile
> +	 */
> +	BUILD_BUG_ON(offsetof(struct task_struct, stack_canary) != sizeof(long));

Well this will help :-)

It looks like it will be easy to enable on 64 bit as well.

> +	/* Try to get a semi random initial value. */
> +	get_random_bytes(&canary, sizeof(canary));
> +	canary ^= mftb();
> +	canary ^= LINUX_VERSION_CODE;

These last two lines are useless (or worse, they may give people the idea
that they are not!)

You should use wait_for_random_bytes I think.


Segher

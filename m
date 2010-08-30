Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9FC1B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 10:18:28 +1000 (EST)
Subject: Re: [PATCH] powerpc: Check end of stack canary at oops time
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100824231528.GC28360@kryten>
References: <20100824231528.GC28360@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Aug 2010 10:18:19 +1000
Message-ID: <1283127499.1922.66.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-08-25 at 09:15 +1000, Anton Blanchard wrote:

>  	/* Are we prepared to handle this fault?  */
>  	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> @@ -413,5 +415,9 @@ void bad_page_fault(struct pt_regs *regs
>  	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
>  		regs->nip);
>  
> +	stackend = end_of_stack(current);
> +	if (current != &init_task && *stackend != STACK_END_MAGIC)
> +		printk(KERN_ALERT "Thread overran stack, or stack corrupted\n");
> +
>  	die("Kernel access of bad area", regs, sig);
>  }

Is it worth making it a __get_user or similar just in case ? I suppose
if the stack is really busted we wouldn't even have reached that
code ...

Cheers,
Ben.

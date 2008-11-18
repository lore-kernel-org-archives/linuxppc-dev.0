Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA8CBDDDE0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 16:39:58 +1100 (EST)
Subject: Re: Some udbg questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0811171656g5b214c5eqe64b26b8310524f7@mail.gmail.com>
References: <ed82fe3e0811171656g5b214c5eqe64b26b8310524f7@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 16:37:44 +1100
Message-Id: <1226986664.7178.282.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-17 at 18:56 -0600, Timur Tabi wrote:
> I'm adding udbg support to my console driver, and I've noticed that
> there is not much consistency on how the various platforms implement
> udbg support.  So I have a few questions:
> 
> 1. What is the point of implementing udbg_getc?  What does the console
> do with any characters it receives this early?

It's for xmon (and possibly kgdb if we ever hook that up again).

> 2. In my driver's udbg initialization function, should I be able to
> parse the device tree to get parameters?

You can. It depends how late. In many cases, we have 2 stage of udbg,
one very very early that depends on CONFIG_EARLY_DBG_*, and is hard
wired for a given board and config (ie, when enabled, the kernel will
probably not even boot on anything else) and is useful for debugging
very early boot code.

Some stuff also initializes udbg slightly later using the device-tree
etc... to provide a level of console output before the tty drivers are
loaded. This can be left enabled and doesn't conflict with anything.

> 3. What about command-line parameters?

No point. As I said, either hard wire for early debugging or use the
device-tree.

> 4. The LPAR and PMAC platforms call register_early_udbg_console (in
> the udbg_init_debug_lpar and pmac_init_early functions, respectively),
> but none of the other platforms do.  It appears that the other
> platforms rely on setup_32.c and setup_64.c to call this function.
> What's so special about LPAR and PMAC?

That's probably some mess left over from history, we should probably
clean that up. We could probably even make it a console_initcall (that's
currently commented out).

Another reason is it's useful if you install your udbg_putc callback
after register_early_udbg_console was already called, since it won't do
anything, so it needs to be called again.

> 5. Some platforms (like mv64x60) use the ppc_md.init_early function to
> initialize the early console.  Others update function
> udbg_early_init() in udbg.c instead.  Why do some platforms do it one
> way, and other platforms do it the other way?  Which way is preferred?

We should probably clean that up a bit.

udbg_early_init() is called before the device-tree is expanded and
shouldn't realy on anything. it's purely means for debug stuff to be
hard wired for your platform and removed in production.

Some platforms enable udbg in a more "normal" way as a way to have a
console before the main fbdev or tty kicks in.

Cheers,
Ben.

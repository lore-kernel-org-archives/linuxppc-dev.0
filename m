Date: Tue, 4 Sep 2001 22:54:40 +0200
From: Jure Menart <jure@kom.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: kernel course no. 1
Message-ID: <20010904225440.A3144@hannanges.teden-mladih.com>
References: <20010903192322.A1346@hannanges.teden-mladih.com> <20010903193428.1773@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010903193428.1773@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Mon, Sep 03, 2001 at 09:34:28PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
> Beware, when doing such debugging, that the IOs you use for your LED are
> actually mapped in virtual memory space before accessing them.
>
> The head.S entry does approximately this:
>
>  - first it calls early_init(). It does so before touching the MMU
> or changing anything to the CPU setup, it's still running at whatever
> address it was loaded, early_init() handles interaction with the
> firmware, like grabbing the OF device-tree on OF based machines.
[snip]

You are talking about arch/ppc/kernel/head.S, but we're using head_4xx.S,
because we are using IBMs 405gp CPU.
In our case 'early_init()' isn't called before start_here(), but in
start_here(). MMU is initialized before even calling start_here() and is
turned on when 'rfi' is called - at this stage our system freezes.

> So unless you have done some io_block_mapping calls or ioremap calls
> inside MMU_init for your board, your LEDs will not be available neither
> at start_kernel time. You have to ioremap them before use. You may have

When I spoke about my 'hardware debugger' (two LEDs on 0x58000000 physical
address - they are controlled by CPLD which is mapped on CS3) - we were
writing on this address after turning on MMU (after 'rfi' call),
apparently this crashed the system. But the question is - how can I write
to this physical address ( = to which virtual address is CS3 mapped)?

Thanks...

Jure


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

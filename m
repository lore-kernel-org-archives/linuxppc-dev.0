Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB24067BC6
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 03:38:03 +1000 (EST)
Subject: Re: mpic discovery on JS20
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Amos Waterland <apw@us.ibm.com>
In-Reply-To: <20060720231601.GA24736@kvasir.watson.ibm.com>
References: <20060720231601.GA24736@kvasir.watson.ibm.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 13:37:56 -0400
Message-Id: <1153503476.16159.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-07-20 at 19:16 -0400, Amos Waterland wrote:
> Current Linus and Paulus trees do this on JS20 blades with SLOF:

I need a tarball of /proc/device-tree on these. 

>  Failed to locate the MPIC interrupt controller
>  PID hash table entries: 4096 (order: 12, 32768 bytes)
>  Maple: Found RTC at IO 0x1070
>  cpu 0x0: Vector: 700 (Program Check) at [c00000007ef83ab0]
>      pc: c00000000002e0c8: .mpic_request_ipis+0x34/0xc8
>      lr: c00000000036b484: .smp_mpic_probe+0x3c/0x58
>      sp: c00000007ef83d30
>     msr: 9000000000029032
>    current = 0xc00000000194d610
>    paca    = 0xc00000000038f180
>      pid   = 1, comm = swapper
>  kernel BUG in mpic_request_ipis at arch/powerpc/sysdev/mpic.c:1132!
> 
> Doing a git-bisect produces this:
> 
>  0ebfff1491ef85d41ddf9c633834838be144f69f is first bad commit
>  Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>  Date:   Mon Jul 3 21:36:01 2006 +1000
> 
>     [POWERPC] Add new interrupt mapping core and change platforms to use it
>     
>     This adds the new irq remapper core and removes the old one.  Because
>     there are some fundamental conflicts with the old code, like the value
>     of NO_IRQ which I'm now setting to 0 (as per discussions with Linus),
>     etc..., this commit also changes the relevant platform and driver code
>     over to use the new remapper (so as not to cause difficulties later
>     in bisecting).
>     
>     This patch removes the old pre-parsing of the open firmware interrupt
>     tree along with all the bogus assumptions it made to try to renumber
>     interrupts according to the platform. This is all to be handled by the
>     new code now.
>     
>     For the pSeries XICS interrupt controller, a single remapper host is
>     created for the whole machine regardless of how many interrupt
>     presentation and source controllers are found, and it's set to match
>     any device node that isn't a 8259.  That works fine on pSeries and
>     avoids having to deal with some of the complexities of split source
>     controllers vs. presentation controllers in the pSeries device trees.
>     
>     The powerpc i8259 PIC driver now always requests the legacy interrupt
>     range. It also has the feature of being able to match any device node
>     (including NULL) if passed no device node as an input. That will help
>     porting over platforms with broken device-trees like Pegasos who don't
>     have a proper interrupt tree.
>     
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

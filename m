Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the powerpc tree with the arm tree
In-reply-to: <20120308120422.e071cba36425eacbee1f8d98@canb.auug.org.au>
References: <20120308120422.e071cba36425eacbee1f8d98@canb.auug.org.au>
Date: Thu, 08 Mar 2012 13:33:56 +1100
Message-ID: <25744.1331174036@neuling.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Today's linux-next merge of the powerpc tree got a conflict in
> arch/powerpc/Kconfig between commit 2ed86b16eabe ("irq: make SPARSE_IRQ
> an optionally hidden option") from the arm tree and commit ad5b7f1350c2
> ("powerpc: Make SPARSE_IRQ required") from the powerpc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.
> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> diff --cc arch/powerpc/Kconfig
> index bf7dbc2,4eecaaa..0000000
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@@ -133,7 -133,8 +133,8 @@@ config PP
>   	select HAVE_REGS_AND_STACK_ACCESS_API
>   	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>   	select HAVE_GENERIC_HARDIRQS
>  -	select HAVE_SPARSE_IRQ
>  +	select MAY_HAVE_SPARSE_IRQ
> + 	select SPARSE_IRQ

Surely we only need SPARSE_IRQ now and not MAY_HAVE_SPARSE_IRQ.  

In fact, keeping MAY_HAVE_SPARSE_IRQ seems to make SPARSE_IRQ user
selectable, which we don't want anymore since ad5b7f1350c2.

Mikey

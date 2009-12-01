Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F1C0B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 21:51:51 +1100 (EST)
Subject: Re: [RFC PATCH v3 2/3] powerpc: udbg: add fixmap entry for early debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <0a6994b5a257def375c8114b132d044a7f416d11.1259609263.git.albert_herranz@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
	<0a6994b5a257def375c8114b132d044a7f416d11.1259609263.git.albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Dec 2009 21:51:44 +1100
Message-ID: <1259664704.2076.351.camel@pasglop>
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

On Tue, 2009-12-01 at 00:09 +0100, Albert Herranz wrote:
> Add a new entry to the fixmap table to allow low level early udbg drivers
> to safely reserve virtual address space and create their I/O mappings.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
>  arch/powerpc/include/asm/fixmap.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
> index f1f4e23..424e5a6 100644
> --- a/arch/powerpc/include/asm/fixmap.h
> +++ b/arch/powerpc/include/asm/fixmap.h
> @@ -48,6 +48,9 @@ enum fixed_addresses {
>  	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
>  	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
>  #endif
> +#ifdef CONFIG_PPC_EARLY_DEBUG
> +	FIX_EARLY_DEBUG_BASE,
> +#endif
>  	/* FIX_PCIE_MCFG, */
>  	__end_of_fixed_addresses
>  };

Rather than a hook to hop between the BAT and the later single page
mapping, I would have just used the fixmap as a way to reserve virtual
space for the BAT and keep it around.

However, that does mean having more than one entry in the fixmap, in
fact, enough to cope with the BAT min size +/- alignment. Maybe to avoid
the alignment problem, an option would be to always use the top of the
fixmap for the "debug area" and make it always something nice and fat to
fit a BAT, like 128K or whatever is the min size. No need for CONFIG_*
there even, I won't cry for 128K of virtual space reserved there instead
of just one page currently. And we could have good use of it for other
early debug stuff even.

Cheers,
Ben.

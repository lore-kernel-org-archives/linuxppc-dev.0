Date: Sat, 13 Mar 2004 10:07:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Caching in the MPC107, linux 2.6
Message-ID: <20040313170708.GA20738@smtp.west.cox.net>
References: <1079088369.691.43.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1079088369.691.43.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 12, 2004 at 10:46:09AM +0000, Adrian Cox wrote:

> I discovered this problem back in 2002:
>
> http://lists.linuxppc.org/results.html?words=caching+mpc107&method=and&sort=score&restrict=linuxppc-embedded
>
> The 2.6 kernel requires a fix to use a MPC745x along with a MPC107
> bridge. My proposed patch is below - any comments?

How about:
> diff -Nru a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/hashtable.S
> --- a/arch/ppc/mm/hashtable.S	Fri Mar 12 10:43:37 2004
> +++ b/arch/ppc/mm/hashtable.S	Fri Mar 12 10:43:37 2004
> @@ -348,6 +348,13 @@
>  	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
>  #ifdef CONFIG_SMP
>  	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
> +#elif defined(CONFIG_CACHING_HOSTBRIDGE)
> +        /* The MPC107 PCI bridge contains a cache, which must remain
> +           coherent with the CPU cache. This is only necessary for the
> +           MPC745x family, as they support the shared state. */
> +BEGIN_FTR_SECTION
> +	ori	r8,r8,_PAGE_COHERENT
> +END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
>  #endif

Instead do:
BEGIN_FTR_SECTION
	ori	r8,r8,_PAGE_COHERENT
END_FTR_SECTION_IFSET(CPU_FTR_745X_MPC107)

And have the code that sets SPEC7450 also check for an MPC107.

> diff -Nru a/arch/ppc/mm/ppc_mmu.c b/arch/ppc/mm/ppc_mmu.c
> --- a/arch/ppc/mm/ppc_mmu.c	Fri Mar 12 10:43:37 2004
> +++ b/arch/ppc/mm/ppc_mmu.c	Fri Mar 12 10:43:37 2004

And make this depend on the new feature as well.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <paulus@ozlabs.org>
Date: Wed, 7 Aug 2013 18:07:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/4] powerpc: Add new save_tar() register function.
Message-ID: <20130807080744.GA12112@iris.ozlabs.ibm.com>
References: <1375855918-3625-1-git-send-email-mikey@neuling.org>
 <1375855918-3625-2-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375855918-3625-2-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 07, 2013 at 04:11:56PM +1000, Michael Neuling wrote:
> Add save_tar() function to save the Target Address Register (TAR).  This will
> be used in a future patch to save the TAR earlier than it currently is.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/powerpc/include/asm/switch_to.h |  5 +++++
>  arch/powerpc/kernel/entry_64.S       | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> index 49a13e0..4531068 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -15,6 +15,11 @@ extern struct task_struct *__switch_to(struct task_struct *,
>  struct thread_struct;
>  extern struct task_struct *_switch(struct thread_struct *prev,
>  				   struct thread_struct *next);
> +#ifdef CONFIG_PPC_BOOK3S_64
> +extern void _save_tar(struct thread_struct *prev);
> +#else
> +static inline void _save_tar(struct thread_struct *prev) {}
> +#endif
>  
>  extern void giveup_fpu(struct task_struct *);
>  extern void load_up_fpu(void);
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 4674fe6..32e18f3 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -389,6 +389,18 @@ DSCR_DEFAULT:
>  	.tc dscr_default[TC],dscr_default
>  
>  	.section	".text"
> +#ifdef CONFIG_PPC_BOOK3S_64
> +_GLOBAL(_save_tar)
> +	/*
> +	 * Back up the TAR across context switches.  Note that the TAR is not
> +	 * available for use in the kernel.  (To provide this, the TAR should
> +	 * be backed up/restored on exception entry/exit instead, and be in
> +	 * pt_regs.  FIXME, this should be in pt_regs anyway (for debug).)
> +	 */
> +	mfspr	r0,SPRN_TAR
> +	std	r0,THREAD_TAR(r3)
> +	blr
> +#endif

Why not do this in C, as in prev->tar = mfspr(SPRN_TAR); ?

Paul.

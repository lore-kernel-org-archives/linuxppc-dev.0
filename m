Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D25922C009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 13:45:26 +1100 (EST)
Message-ID: <1387334713.3140.8.camel@snotra.buserror.net>
Subject: Re: [v6][PATCH 5/5] powerpc/book3e/kgdb: Fix a single stgep case of
 lazy IRQ
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 20:45:13 -0600
In-Reply-To: <1382520685-11609-6-git-send-email-tiejun.chen@windriver.com>
References: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
 <1382520685-11609-6-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-23 at 17:31 +0800, Tiejun Chen wrote:
> In lazy EE magic, we may have a lazy interrupt occured while
> entering kgdb, but we really don't want to replay that interrupt
> for kgdb, so we have to clear the PACA_IRQ_HARD_DIS force to
> make sure we can exit directly from this debug exception.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

s/stgep/step/ in subject

> ---
>  arch/powerpc/kernel/kgdb.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 447c14b..9872f58 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -185,6 +185,14 @@ static int kgdb_singlestep(struct pt_regs *regs)
>  		/* Restore current_thread_info lastly. */
>  		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
>  
> +#ifdef CONFIG_PPC64
> +	/*
> +	 * Clear the PACA_IRQ_HARD_DIS from the pending mask
> +	 * since we are about to exit this directly from debug
> +	 * exception without any replay interrupt in lazy EE case.
> +	 */
> +	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
> +#endif
>  	return 1;
>  }
>  

What happens to those interrupts you discarded once we get back to a
state when they can be safely replayed?  I don't think just dropping
them is the answer.

I'm not sure what the actual problem is.  I can understand not wanting
kgdb to cause interrupts to appear to run when the interrupted context
has external interrupts disabled, but the replay code in entry_64.S
doesn't run if interrupts are soft-disabled in the context to be
returned to.  What harm does it cause to run the interrupts if we're
returning to an EE=1 context?

Does KGDB enable interrupts in its handler?  If not, how do we even get
into the situation where there are interrupts pending when the
interrupted context has EE soft-enabled (i.e. we went directly from a
context where the interrupt handler should have run, to a hard-disabled
context)?

-Scott

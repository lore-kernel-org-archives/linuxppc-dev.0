Return-Path: <xenidis@gmail.com>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
 [209.85.161.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 26799B6F84
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2011 06:40:46 +1100 (EST)
Received: by ggnk5 with SMTP id k5so4157940ggn.15
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2011 12:40:43 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [1/4] powerpc: Revert show_regs() define for readability
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
Date: Fri, 28 Oct 2011 14:40:40 -0500
Message-Id: <1ADB010A-A48C-4E71-91E0-94D60A3E676F@pobox.com>
References: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 5, 2011, at 9:53 PM, Kumar Gala wrote:

> We had an existing ifdef for 4xx & BOOKE processors that got changed to
> CONFIG_PPC_ADV_DEBUG_REGS.  The define has nothing to do with
> CONFIG_PPC_ADV_DEBUG_REGS.  The define really should be:
> 
> #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> 
> and not
> 
> #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> ---
> arch/powerpc/kernel/process.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 8f53954..a1b5981 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -657,7 +657,7 @@ void show_regs(struct pt_regs * regs)
> 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
> 		printk("CFAR: "REG"\n", regs->orig_gpr3);
> 	if (trap == 0x300 || trap == 0x600)
> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> +#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);

I'll be needing "|| defined(CONFIG_PPC_BOOK3E)" added to this please.
-jx


> #else
> 		printk("DAR: "REG", DSISR: %08lx\n", regs->dar, regs->dsisr);

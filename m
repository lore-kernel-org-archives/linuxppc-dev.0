Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com
	[209.85.219.209]) by ozlabs.org (Postfix) with ESMTP id D5DD4B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 18:32:50 +1100 (EST)
Received: by ewy1 with SMTP id 1so3689627ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Dec 2009 23:32:47 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] show_interrupts: use irq_chip::name if available
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
Date: Wed, 09 Dec 2009 08:32:43 +0100
In-Reply-To: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Tue, 1 Dec 2009 21:48:12 +0100")
Message-ID: <87y6lcmwkk.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

 Peter> struct irq_chip::typename is going away (replaced by name). Use name if
 Peter> set instead of typename in show_interrupt to make ease transition.

Comments?

 Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
 Peter> ---
 Peter>  arch/powerpc/kernel/irq.c |    3 ++-
 Peter>  1 files changed, 2 insertions(+), 1 deletions(-)

 Peter> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
 Peter> index e5d1211..33e1130 100644
 Peter> --- a/arch/powerpc/kernel/irq.c
 Peter> +++ b/arch/powerpc/kernel/irq.c
 Peter> @@ -203,7 +203,8 @@ int show_interrupts(struct seq_file *p, void *v)
 Peter>  		seq_printf(p, "%10u ", kstat_irqs(i));
 Peter>  #endif /* CONFIG_SMP */
 Peter>  		if (desc->chip)
 Peter> -			seq_printf(p, " %s ", desc->chip->typename);
 Peter> +			seq_printf(p, " %s ", desc->chip->name ?
 Peter> +				   desc->chip->name : desc->chip->typename);
 Peter>  		else
 Peter>  			seq_puts(p, "  None      ");
 Peter>  		seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");
 Peter> -- 
 Peter> 1.6.5


-- 
Bye, Peter Korsgaard

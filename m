Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com
 [IPv6:2a00:1450:400c:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71D421A1342
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 10:18:34 +1100 (AEDT)
Received: by mail-wm0-x22b.google.com with SMTP id l126so87935380wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 15:18:34 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1449538707-7867-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449538707-7867-1-git-send-email-paul.gortmaker@windriver.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 21 Dec 2015 18:18:01 -0500
Message-ID: <CAP=VYLq_JQuPwAze73mFYco=9pK=rvYKabsvUewnoPdNVzCXXw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: warn on spurious irq events (but ratelimited)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 7, 2015 at 8:38 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> It might be worth warning on spurious IRQ events; they might
> point someone at a bogus DTS value or similar.
>
> But ratelimit them to ensure we aren't too spammy about it.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/kernel/irq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 290559df1e8b..5c777e3a4c04 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -497,10 +497,12 @@ void __do_irq(struct pt_regs *regs)
>         may_hard_irq_enable();
>
>         /* And finally process it */
> -       if (unlikely(irq == NO_IRQ))
> +       if (unlikely(irq == NO_IRQ)) {
> +               printk_ratelimited(KERN_WARNING "spurious irq on %d\n", irq);

If we did decide we cared about this patch, then no need for "irq" above, as
we already know it is equal to NO_IRQ.

Paul.
--

>                 __this_cpu_inc(irq_stat.spurious_irqs);
> -       else
> +       } else {
>                 generic_handle_irq(irq);
> +       }
>
>         trace_irq_exit(regs);
>
> --
> 2.6.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

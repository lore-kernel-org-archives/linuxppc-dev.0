Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7p9G1QpZzDqpS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 06:59:45 +1000 (AEST)
Message-ID: <1499979576.2865.64.camel@kernel.crashing.org>
Subject: Re: [bug] KVM: Unrecoverable TM Unavailable Exception f60
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, Jan Stancek
 <jstancek@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: Laurent Vivier <lvivier@redhat.com>, David Gibson <dgibson@redhat.com>,
 thuth@redhat.com, Steve Best <sbest@redhat.com>, Paul Mackerras
 <pmac@au1.ibm.com>
Date: Fri, 14 Jul 2017 06:59:36 +1000
In-Reply-To: <596787D5.7000704@linux.vnet.ibm.com>
References: <1184529176.51045609.1499943136316.JavaMail.zimbra@redhat.com>
 <295894956.51100272.1499947620915.JavaMail.zimbra@redhat.com>
 <596787D5.7000704@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-13 at 11:46 -0300, Gustavo Romero wrote:
> Hi Jan
> Looks like that TM unavailable exception will only able to recover
> properly if it comes from problem state and since the trigger comes
> from kernel space (kvm module) it does not match
> "if (user_mode(regs))" in tm_unavailable().
> 
> I'm able to avoid this problem using the following patch:

I think the KVM exit path should be enabling TM if necessary rather
than taking the fault.

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index d4e545d27ef9..1091dc4f4274 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1433,13 +1433,11 @@ void vsx_unavailable_exception(struct pt_regs *regs)
>  static void tm_unavailable(struct pt_regs *regs)
>  {
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -       if (user_mode(regs)) {
> -               current->thread.load_tm++;
> -               regs->msr |= MSR_TM;
> -               tm_enable();
> -               tm_restore_sprs(&current->thread);
> -               return;
> -       }
> +       current->thread.load_tm++;
> +       regs->msr |= MSR_TM;
> +       tm_enable();
> +       tm_restore_sprs(&current->thread);
> +       return;
>  #endif
>         pr_emerg("Unrecoverable TM Unavailable Exception "
>                         "%lx at %lx\n", regs->trap, regs->nip);
> 
> Regards,
> Gustavo

Return-Path: <akpm@osdl.org>
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6])
	by ozlabs.org (Postfix) with ESMTP id D0F352BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Dec 2004 10:26:25 +1100 (EST)
Date: Tue, 30 Nov 2004 15:30:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@linen.sps.mot.com>
Message-Id: <20041130153039.22b36348.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0411301517300.15307@linen.sps.mot.com>
References: <Pine.LNX.4.61.0411301517300.15307@linen.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Performance Monitor/Oprofile support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@linen.sps.mot.com> wrote:
>
> Andrew,
> 
> Adds oprofile support for the e500 PowerPC core.

- arch/ppc/kernel/perfmon_fsl_booke.c has prototypes for init_pmc_stop()
  and friends, but those prototypes are already in
  include/asm-ppc/perfmon.h

- please don't put prototypes and extern declarations in .c files.  Ever.
  It defeats typechecking.  Put them in a header file which is visible to
  all callers/users as well as to the implementation.

- Do these need to be exported to modules?

	+EXPORT_SYMBOL(init_pmc_stop);
	+EXPORT_SYMBOL(set_pmc_event);
	+EXPORT_SYMBOL(set_pmc_user_kernel);
	+EXPORT_SYMBOL(set_pmc_marked);
	+EXPORT_SYMBOL(pmc_start_ctr);
	+EXPORT_SYMBOL(pmc_start_ctrs);
	+EXPORT_SYMBOL(pmc_stop_ctrs);
	+EXPORT_SYMBOL(dump_pmcs);

  and if so, does an EXPORT_SYMBOL_GPL() not suffice?

- This:

	+extern void (*perf_irq)(struct pt_regs *);

  should be in a header file.



I'll queue the patch up.  Fixups relative to this patch would be
appreciated, thanks.

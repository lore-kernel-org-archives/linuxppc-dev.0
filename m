Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CBC81A0C58
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 18:38:38 +1100 (AEDT)
Message-ID: <1421739503.4961.205.camel@freescale.com>
Subject: Re: AW: How to make use of SPE instructions?
From: Scott Wood <scottwood@freescale.com>
To: Markus Stockhausen <stockhausen@collogia.de>
Date: Tue, 20 Jan 2015 01:38:23 -0600
In-Reply-To: <12EF8D94C6F8734FB2FF37B9FBEDD1735F9132C6@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F90DD25@EXCHANGE.collogia.de>
 ,<1421362570.4961.163.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F9132C6@EXCHANGE.collogia.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-01-16 at 05:27 +0000, Markus Stockhausen wrote:
> > Von: Scott Wood [scottwood@freescale.com]
> > Gesendet: Donnerstag, 15. Januar 2015 23:56
> > An: Markus Stockhausen
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Betreff: Re: How to make use of SPE instructions?
> > 
> > On Thu, 2015-01-08 at 09:58 +0000, Markus Stockhausen wrote:
> > > Hello,
> > >
> > > I developed a SHA224/256 kernel crypto module with SPE instructions.
> > > The result looks quite promising (~ +50% speedup). Nevertheless the
> > > flooding of kernel messages "SPE used in kernel" makes me feel
> > > uncomfortable.
> > >
> > > My findings so far:
> > >
> > > - I can configure the kernel with "SPE support".
> > > - arch/powerpc/kernel/head_fsl_booke.S suggests that the message is
> > >   triggerd unconditionally whenwever we make use of SPE in kernel.
> > - There exists a function enable_kernel_spe() but I don't know how
> >   this could help me in my work.
> > >
> > > I guess I need some kind of "brackets" around my coding to make sure
> > > the upper 32 bit of the registers are stored correctly during task switch.
> > > Or is the use of SPE instructions inside the kernel totally forbidden? Any
> > > expert with some helpful advise?
> > 
> > You need to disable preemption, call enable_kernel_spe(), and finish
> > using SPE before you enable preemption.  This assumes that SPE is never
> > used from interrupt context.  Be careful to not disable preemption for
> > too long.
> 
> Thanks for your feedback. That did the trick. I'm currently working on
> a (low power) 800 MHz single core P1014 CPU. That should be the
> cheapest and slowest hardware that is available with SPE.

Some of the mpc85xx chips can go a bit slower than that, e.g. 667 MHz is
the bottom end of the range for MPC8544:

http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC8544E

>  My target is to use the module for calculating hash values of IPsec
> packets. So we are talking about input data of up to ~1500 bytes. 
> 
> I did some tests with the tcrypt module and I get a hashing speed of
> ~ 46MByte/s for 2K data chunks. Stock module gives 29MByte/s. In 
> other words ~22,000 hashes per second. Overhead of the tcrypt data 
> feeder of around 10% included. That are worst case 46us per hash and 
> therefore 46us inside a non preemptive task.

Worst case or average case?  Can chunks be larger?  How long does it
take to do a chunk if you start with a cold cache?  Etc.

> In beetween I spent some time to do the same for SHA-1. There
> we have ~46,000 hashes per second or 21us per 2K data. That are
> +13% compared to the already available PPC assembler module.
> 
> Three questions are left:
> 
> - Does the setup conflict with the mentioned interrupt context?

You didn't say whether you're doing it from interrupt context...

That said, the only current user of enable_kernel_spe() is KVM which
disables interrupts, so it wouldn't bother me to change it to WARN_ON(!
irqs_disabled()) other than that it would deviate from what
enable_kernel_fp does (and that does have users that only disable
preemption).

> - Is that a reasonable time interval for disabling preemption?

It's OK if the worst case is really 46 us, but if you can find a way to
break it up a bit without affecting throughput too much, I'd do so.

> - Should I send the patches to this or to the crypto list?

You can CC this list for broader review, but the crypto list and
maintainer is how changes to the crypto driver would get merged.

-Scott

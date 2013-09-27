Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C4492C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 02:15:24 +1000 (EST)
Message-ID: <1380298512.24959.384.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/mpic: Disable preemption when calling
 mpic_processor_id()
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 27 Sep 2013 11:15:12 -0500
In-Reply-To: <37986E99-BC99-4B67-9327-36CABA8E1A04@kernel.crashing.org>
References: <1380241098-7561-1-git-send-email-scottwood@freescale.com>
 <37986E99-BC99-4B67-9327-36CABA8E1A04@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-27 at 10:52 -0500, Kumar Gala wrote:
> On Sep 26, 2013, at 7:18 PM, Scott Wood wrote:
> 
> > Otherwise, we get a debug traceback due to the use of
> > smp_processor_id() (or get_paca()) inside hard_smp_processor_id().
> > mpic_host_map() is just looking for a default CPU, so it doesn't matter
> > if we migrate after getting the CPU ID.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > arch/powerpc/sysdev/mpic.c | 8 +++++++-
> > 1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 1be54fa..bdcb858 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -1088,8 +1088,14 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
> > 	 * is done here.
> > 	 */
> > 	if (!mpic_is_ipi(mpic, hw) && (mpic->flags & MPIC_NO_RESET)) {
> > +		int cpu;
> > +
> > +		preempt_disable();
> > +		cpu = mpic_processor_id(mpic);
> > +		preempt_enable();
> > +
> 
> Any reason you didn't stick this inside of mpic_processor_id() ?

Because the debug check might be valid for other callers and we don't
want to defeat it.  In this caller it's used only as a heuristic and
thus it doesn't matter if we re-enable preemption before using the
result.

-Scott

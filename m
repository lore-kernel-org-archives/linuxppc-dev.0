Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 06/17] powerpc: Add transactional memory paca scratch
 register to show_regs
In-reply-to: <7B4CE428-128F-43FC-9ABE-CE3728B3CF93@kernel.crashing.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
 <1360729895-304-7-git-send-email-mikey@neuling.org>
 <7B4CE428-128F-43FC-9ABE-CE3728B3CF93@kernel.crashing.org>
Date: Thu, 14 Feb 2013 12:53:41 +1100
Message-ID: <6035.1360806821@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Feb 12, 2013, at 10:31 PM, Michael Neuling wrote:
> 
> > Add transactional memory paca scratch register to show_regs.  This is useful
> > for debugging.
> > 
> > Signed-off-by: Matt Evans <matt@ozlabs.org>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> > arch/powerpc/include/asm/paca.h   |    1 +
> > arch/powerpc/kernel/asm-offsets.c |    1 +
> > arch/powerpc/kernel/entry_64.S    |    4 ++++
> > arch/powerpc/kernel/process.c     |    3 +++
> > 4 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> > index c47d687..07e9851 100644
> > --- a/arch/powerpc/include/asm/paca.h
> > +++ b/arch/powerpc/include/asm/paca.h
> > @@ -137,6 +137,7 @@ struct paca_struct {
> > 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
> > 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
> > 	u64 sprg3;			/* Saved user-visible sprg */
> 
> #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> 
> > +	u64 tm_scratch;                 /* TM scratch area for reclaim */
> 
> #endif

Yep.. thanks again.

Mikey

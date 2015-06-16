Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0105.outbound.protection.outlook.com [157.56.111.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B7931A0252
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 14:33:26 +1000 (AEST)
Message-ID: <1434429190.2353.35.camel@freescale.com>
Subject: Re: [PATCH 08/12] fsl/fman: Add Frame Manager support
From: Scott Wood <scottwood@freescale.com>
To: Bob Cochran <ppc@mindchasers.com>
CC: <madalin.bucur@freescale.com>, <linuxppc-dev@lists.ozlabs.org>, "Igal
 Liberman" <Igal.Liberman@freescale.com>
Date: Mon, 15 Jun 2015 23:33:10 -0500
In-Reply-To: <557F9B3A.2000108@mindchasers.com>
References: <1433949712-5648-1-git-send-email-madalin.bucur@freescale.com>
 <1433949712-5648-2-git-send-email-madalin.bucur@freescale.com>
 <1433949712-5648-3-git-send-email-madalin.bucur@freescale.com>
 <1433949712-5648-4-git-send-email-madalin.bucur@freescale.com>
 <557F9B3A.2000108@mindchasers.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-15 at 23:42 -0400, Bob Cochran wrote:
> On 06/10/2015 11:21 AM, Madalin Bucur wrote:
> > 
> > +#define FM_QMI_NO_ECC_EXCEPTIONS           /* P1 */
> > +#define FM_CSI_CFED_LIMIT                  /* P1 */
> > +#define FM_PEDANTIC_DMA                            /* P1 */
> > +#define FM_QMI_NO_DEQ_OPTIONS_SUPPORT              /* P1 */
> > +#define FM_HAS_TOTAL_DMAS                  /* P1-P5 */
> > +#define FM_DEQ_PIPELINE_PARAMS_FOR_OP              /* P1, T/B */
> > +#define FM_NO_DISPATCH_RAM_ECC                     /* P2-P5 */
> > +#define FM_NO_WATCHDOG                             /* P4 */
> > +#define FM_NO_TNUM_AGING                   /* P2-P5 */
> > +#define FM_NO_BACKUP_POOLS                 /* P2-P5 */
> > +#define FM_NO_OP_OBSERVED_POOLS            /* P2-P5, T/B */
> > +#define FM_NO_ADVANCED_RATE_LIMITER                /* P2-P5 */
> > +#define FM_OP_OPEN_DMA_MIN_LIMIT           /* T/B */
> > +#define FM_NO_RESTRICT_ON_ACCESS_RSRC              /* T/B */
> > +#define FM_FRAME_END_PARAMS_FOR_OP         /* T/B */
> > +#define FM_QMI_NO_SINGLE_ECC_EXCEPTION             /* T/B */
> > +
> > +/* FMan Errata */
> 
> 
> Will there be documentation to let the user know how to turn off and 
> on these errata (code fixes) ?  From reviewing the source for some 
> of the errata fixes, I gather it's not always automatic.  I saw that 
> booleans are sometimes used (e.g, bcb_workaround) along with HW 
> block IP version information to either apply the errata or not.

The above defines need to go.  The driver should support any supported 
chip without compile-time knowledge.  If they're meant to give the 
*option* to optimize away things on chips that don't have certain 
requirements, that should be limited to codepaths where testing shows 
it makes a significant difference, and the choice of supported chips 
(not a list of fman internal knobs) needs to be exposed to kconfig.

> Also, some of the comments and errata names below refer to 
> information that is probably strictly internal to Freescale, so how 
> can I be sure whether to apply these errata or not and their 
> purpose?   My concern is that some of these errata may be applied to 
> my SoC by default when they shouldn't be, and I may not know if it's 
> a potential problem.  I saw this sort of thing in the SDK kernel 
> when FMAN V3H errata fixes were applied to FMAN V3L and wrong values 
> were set due to V3L having lesser capabilities than V3H.

Yes, the SDK kernel has problems with multiplatform support in the 
FMan driver.  We don't want to repeat those problems here.

> +
> > +static inline bool TRY_LOCK(spinlock_t *spinlock, volatile bool 
> > *p_flag)
> > +{
> > +   unsigned long int_flags;
> > +
> > +   if (spinlock)
> > +           spin_lock_irqsave(spinlock, int_flags);
> > +   else
> > +           local_irq_save(int_flags);
> > +
> > +   if (*p_flag) {
> > +           if (spinlock)
> > +                   spin_unlock_irqrestore(spinlock, int_flags);
> > +           else
> > +                   local_irq_restore(int_flags);
> > +           return false;
> > +   }
> > +   *p_flag = true;
> > +
> > +   if (spinlock)
> > +           spin_unlock_irqrestore(spinlock, int_flags);
> > +   else
> > +           local_irq_restore(int_flags);
> > +
> > +   return true;
> > +}
> > +
> > +#define RELEASE_LOCK(_flag) (_flag = false)

Even aside from the question of why this wrapper is needed to begin 
with, this is not a correct implementation of lock release.  There's 
nothing stopping either compiler or hardware reordering of the store 
to _flag relative to any accesses to lock-protected data.

-Scott

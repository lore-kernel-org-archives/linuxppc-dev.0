Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34B1A2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 04:43:19 +1100 (EST)
Message-ID: <1394646185.13761.145.camel@snotra.buserror.net>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 12 Mar 2014 12:43:05 -0500
In-Reply-To: <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Jason.Jin@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 13:57 +0800, Kevin Hao wrote:
> On Tue, Mar 11, 2014 at 08:10:24PM -0500, Scott Wood wrote:
> > > +	FSL_DIS_ALL_IRQ
> > > +
> > > +	/*
> > > +	 * Place DDR controller in self refresh mode.
> > > +	 * From here on, DDR can't be access any more.
> > > +	 */
> > > +	lwz	r10, 0(r13)
> > > +	oris	r10, r10, CCSR_DDR_SDRAM_CFG_2_FRC_SR@h
> > > +	stw	r10, 0(r13)
> > > +
> > > +	/* can't call udelay() here, so use a macro to delay */
> > > +	FSLDELAY(50)
> > 
> > A timebase loop doesn't require accessing DDR.
> > 
> > You also probably want to do a "sync, readback, data dependency, isync"
> > sequence to make sure that the store has hit CCSR before you begin your
> > delay (or is a delay required at all if you do that?).
> 
> Shouldn't we use "readback, sync" here? The following is quoted form t4240RM:
>   To guarantee that the results of any sequence of writes to configuration
>   registers are in effect, the final configuration register write should be
>   immediately followed by a read of the same register, and that should be
>   followed by a SYNC instruction. Then accesses can safely be made to memory
>   regions affected by the configuration register write.

I agree that the sync before the readback is probably not necessary,
since transactions to the same address should already be ordered.

A sync after the readback helps if you're trying to order the readback
with subsequent memory accesses, though in that case wouldn't a sync
alone (no readback) be adequate?  Though maybe not always -- see the
comment near the end of fsl_elbc_write_buf() in
drivers/mtd/nand_fsl_elbc.c.  I guess the readback does more than just
make sure the device has seen the write, ensuring that the device has
finished the transaction to the point of acting on another one.

The data dependency plus isync sequence, which is done by the normal I/O
accessors used from C code, orders the readback versus all future
instructions (not just I/O).  The delay loop is not I/O.

> > > +	/* Enable SCU15 to trigger on RCPM Concentrator 0 */
> > > +	lwz	r10, 0(r15)
> > > +	oris	r10, r10, DCSR_EPU_EPECR15_IC0@h
> > > +	stw	r10, 0(r15)
> > > +
> > > +	/* put Core0 in PH15 mode, trigger EPU FSM */
> > > +	lwz	r10, 0(r12)
> > > +	ori	r10, r10, CCSR_RCPM_PCPH15SETR_CORE0
> > > +	stw	r10, 0(r12)
> > 
> > Shouldn't there be a sync to ensure that the previous I/O happens before
> > the final store to enter PH15?
> 
> Do we really need a sync here? According to the PowerISA, the above stores
> should be performed in program order.
>   If two Store instructions or two Load instructions
>   specify storage locations that are both Caching
>   Inhibited and Guarded, the corresponding storage
>   accesses are performed in program order with
>   respect to any processor or mechanism.

OK, wasn't aware of that.

-Scott

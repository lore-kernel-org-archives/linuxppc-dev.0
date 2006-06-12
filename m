Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C156367B24
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jun 2006 14:20:21 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k5C5aiQe023958
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jun 2006 23:36:44 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5C4KGe2018453
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jun 2006 23:20:18 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673069759E4@zch01exm40.ap.freescale.net>
From: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
To: Jon Loeliger <jdl@jdl.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: RE: [PATCH 2/10 v2] Add the MPC8641 HPCN platform files. 
Date: Mon, 12 Jun 2006 12:20:15 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, 
> > > +	/* Alloc mpic structure and per isu has 16 INT entries. */
> > > +	mpic1 = mpic_alloc(OpenPIC_PAddr,
> > > +			MPIC_PRIMARY | MPIC_WANTS_RESET | 
> MPIC_BIG_ENDIAN,
> > > +			16, MPC86xx_OPENPIC_IRQ_OFFSET, 0, 250,
> > > +			mpc86xx_hpcn_openpic_initsenses,
> > > +			sizeof(mpc86xx_hpcn_openpic_initsenses),
> > > +			" MPIC     ");
> > > +	BUG_ON(mpic1 == NULL);
> > > +
> > > +	/* 48 Internal Interrupts */
> > > +	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
> > > +	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10400);
> > > +	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10600);
> > 
> > I haven't looked in detail at your memory map, but do you need 
> > separate ISUs ? They seem to be quite close together to me... Also, 
> > you should invent properties in the mpic node for some of those 
> > things, like big-endian (like apple does) indicating it's a 
> big endian 
> > openpic, etc... If you manage to get close enough to spec & common 
> > usage, you might not even need your own init function at all in the 
> > future.
> 
> OK.  We'll work in that direction, but incrementally.
> 
> > > +	/* 16 External interrupts */
> > > +	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10000);
> > 
> > That looks like you used ISUs in order to "re-order" them... why ?
> 
> Heck if I know.  We'll have to ask around some here... :-)

Re-ordering the interrupt is just fit for the practice from MPC85xx platform 
and legacy OpenPIC interrupts order. We put 16 i8259 interrupts to first 0-15
Position, 48 MPC86xx processor internel interrupts to 16-63 and 16 MPC86xx 
External interrupts to 64-79.

Thanks for your feedback!

Best Regards,
ZHANG WEI

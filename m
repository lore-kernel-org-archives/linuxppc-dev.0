Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2662F2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 07:35:06 +1100 (EST)
Message-ID: <1390422892.24905.512.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/3] powerpc/fsl: Use the new interface to save or
 restore registers
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Wed, 22 Jan 2014 14:34:52 -0600
In-Reply-To: <18d3109ac114477a805618829632b463@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-3-git-send-email-dongsheng.wang@freescale.com>
 <1389742224.24905.140.camel@snotra.buserror.net>
 <93a6a30cd8d240109405d45c8e143dea@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842143.24905.195.camel@snotra.buserror.net>
 <18d3109ac114477a805618829632b463@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Zhao
 Chenhui-B35336 <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-01-19 at 23:57 -0600, Wang Dongsheng-B40534 wrote:
> > > > > Use fsl_cpu_state_save/fsl_cpu_state_restore to save/restore registers.
> > > > > Use the functions to save/restore registers, so we don't need to
> > > > > maintain the code.
> > > > >
> > > > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > >
> > > > Is there any functional change with this patchset (e.g. suspend
> > > > supported on chips where it wasn't before), or is it just cleanup?  A
> > > > cover letter would be useful to describe the purpose of the overall
> > > > patchset when it isn't obvious.
> > > >
> > >
> > > Yes, just cleanup..
> > 
> > It seems to be introducing complexity rather than removing it.  Is this
> > cleanup needed to prepare for adding new functionality?
> > 
> > Plus, I'm skeptical that this is functionally equivalent.  It looks like
> > the new code saves a lot more than the old code does.  Why?
> > 
> 
> Actually, I want to take a practical example to push the save/restore patches.
> And this is also reasonable for 32bit-hibernation, the code is more clean. :)
> I think I need to change the description of the patch.
> 
> > > > > +
> > > > > +	/* Restore base register */
> > > > > +	li	r4, 0
> > > > > +	bl	fsl_cpu_state_restore
> > > >
> > > > Why are you calling anything with "fsl" in the name from code that is
> > > > supposed to be for all booke?
> > > >
> > > E200, E300 not support.
> > > Support E500, E500v2, E500MC, E5500, E6500.
> > >
> > > Do you have any suggestions about this?
> > 
> > What about non-FSL booke such as 44x?
> > 
> > Or if this file never supported 44x, rename it appropriately.
> > 
> Currently does not support. ok change the name first, if later support, and
> then again to modify the name of this function.
> 
> How about 85xx_cpu_state_restore?

Symbols can't begin with numbers.  booke_cpu_state_restore would be
better (it would still provide a place for 44x to be added if somebody
actually cared about doing so).

I'm still not convinced that asm code is the place to do this, though.

-Scott

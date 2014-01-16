Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 71E8C2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 14:17:42 +1100 (EST)
Message-ID: <1389842249.24905.196.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore
 the core registers
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Wed, 15 Jan 2014 21:17:29 -0600
In-Reply-To: <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
 <1389743456.24905.143.camel@snotra.buserror.net>
 <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
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

On Tue, 2014-01-14 at 21:30 -0600, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, January 15, 2014 7:51 AM
> > To: Wang Dongsheng-B40534
> > Cc: benh@kernel.crashing.org; Zhao Chenhui-B35336; anton@enomsg.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore the
> > core registers
> > 
> > On Tue, 2014-01-14 at 15:59 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Add fsl_cpu_state_save/fsl_cpu_state_restore functions, used for deep
> > > sleep and hibernation to save/restore core registers. We abstract out
> > > save/restore code for use in various modules, to make them don't need
> > > to maintain.
> > >
> > > Currently supported processors type are E6500, E5500, E500MC, E500v2
> > > and E500v1.
> > >
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > 
> > What is there that is specfic to a particular core type that can't be handled
> > from C code?
> > 
> 
> In the context of the calling, maybe not in C environment.(Deep sleep without
> C environment when calling those interfaces)

Could you provide a concrete example?

> > > +	/*
> > > +	 * Need to save float-point registers if MSR[FP] = 1.
> > > +	 */
> > > +	mfmsr	r12
> > > +	andi.	r12, r12, MSR_FP
> > > +	beq	1f
> > > +	do_sr_fpr_regs(save)
> > 
> > C code should have already ensured that MSR[FP] is not 1 (and thus the FP
> > context has been saved).
> > 
> 
> Yes, right. But I mean if the FP still use in core save flow, we need to save it.
> In this process, i don't care what other code do, we need to focus on not losing
> valuable data.

It is not allowed to use FP at that point.

-Scott

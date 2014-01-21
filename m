Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33D5C2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 12:06:15 +1100 (EST)
Message-ID: <1390266361.24905.399.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore
 the core registers
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Mon, 20 Jan 2014 19:06:01 -0600
In-Reply-To: <6f81ef13c25744b685b99a3fbb304f1b@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
 <1389743456.24905.143.camel@snotra.buserror.net>
 <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842249.24905.196.camel@snotra.buserror.net>
 <6f81ef13c25744b685b99a3fbb304f1b@BN1PR03MB188.namprd03.prod.outlook.com>
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

On Mon, 2014-01-20 at 00:03 -0600, Wang Dongsheng-B40534 wrote:
> > > > > +	/*
> > > > > +	 * Need to save float-point registers if MSR[FP] = 1.
> > > > > +	 */
> > > > > +	mfmsr	r12
> > > > > +	andi.	r12, r12, MSR_FP
> > > > > +	beq	1f
> > > > > +	do_sr_fpr_regs(save)
> > > >
> > > > C code should have already ensured that MSR[FP] is not 1 (and thus the FP
> > > > context has been saved).
> > > >
> > >
> > > Yes, right. But I mean if the FP still use in core save flow, we need to save
> > it.
> > > In this process, i don't care what other code do, we need to focus on not
> > losing
> > > valuable data.
> > 
> > It is not allowed to use FP at that point.
> > 
> If MSR[FP] not active, that is FP not allowed to use.
> But here is a normal judgment, if MSR[FP] is active, this means that the floating
> point module is being used. I offer is a function of the interface, we don't know
> where is the function will be called. Just because we call this function in the
> context of uncertainty, we need this judgment to ensure that no data is lost.

The whole point of calling enable_kernel_fp() in C code before
suspending is to ensure that the FP state gets saved.  If FP is used
after that point it is a bug.  If you're worried about such bugs, then
clear MSR[FP] after calling enable_kernel_fp(), rather than adding
redundant state saving.

-Scott

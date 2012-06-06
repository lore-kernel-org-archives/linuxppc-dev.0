Return-Path: <zch@tx30smr01.freescale.net>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F3F0B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:31:11 +1000 (EST)
Received: from mail15-tx2 (localhost [127.0.0.1])	by mail15-tx2-R.bigfish.com
 (Postfix) with ESMTP id 772AC1E0118	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 09:30:22 +0000 (UTC)
Received: from TX2EHSMHS022.bigfish.com (unknown [10.9.14.242])	by
 mail15-tx2.bigfish.com (Postfix) with ESMTP id BB28E460049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 09:30:19 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q569V03L029482	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 02:31:01 -0700
Date: Wed, 6 Jun 2012 17:31:42 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120606093142.GA23505@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <4FC8E250.9090000@freescale.com>
 <20120605090831.GA21929@localhost.localdomain>
 <4FCE2ECD.4050107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FCE2ECD.4050107@freescale.com>
Sender: <zch@tx30smr01.freescale.net>
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 05, 2012 at 11:07:41AM -0500, Scott Wood wrote:
> On 06/05/2012 04:08 AM, Zhao Chenhui wrote:
> > On Fri, Jun 01, 2012 at 10:40:00AM -0500, Scott Wood wrote:
> >> I know you say this is for dual-core chips only, but it would be nice if
> >> you'd write this in a way that doesn't assume that (even if the
> >> corenet-specific timebase freezing comes later).
> > 
> > At this point, I have not thought about how to implement the cornet-specific timebase freezing.
> 
> I wasn't asking you to.  I was asking you to not have logic that breaks
> with more than 2 CPUs.

These routines only called in the dual-core case. 

> 
> >> Do we need an isync after setting the timebase, to ensure it's happened
> >> before we enable the timebase?  Likewise, do we need a readback after
> >> disabling the timebase to ensure it's disabled before we read the
> >> timebase in give_timebase?
> > 
> > I checked the e500 core manual (Chapter 2.16 Synchronization Requirements for SPRs).
> > Only some SPR registers need an isync. The timebase registers do not.
> 
> I don't trust that, and the consequences of having the sync be imperfect
> are too unpleasant to chance it.
> 
> > I did a readback in mpc85xx_timebase_freeze().
> 
> Sorry, missed that somehow.
> 
> >>> +#ifdef CONFIG_KEXEC
> >>> +	np = of_find_matching_node(NULL, guts_ids);
> >>> +	if (np) {
> >>> +		guts = of_iomap(np, 0);
> >>> +		smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
> >>> +		smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
> >>> +		of_node_put(np);
> >>> +	} else {
> >>> +		smp_85xx_ops.give_timebase = smp_generic_give_timebase;
> >>> +		smp_85xx_ops.take_timebase = smp_generic_take_timebase;
> >>> +	}
> >>
> >> Do not use smp_generic_give/take_timebase, ever.  If you don't have the
> >> guts node, then just assume the timebase is already synced.
> >>
> >> -Scott
> > 
> > smp_generic_give/take_timebase is the default in KEXEC before.
> 
> That was a mistake.
> 
> > If do not set them, it may make KEXEC fail on other platforms.
> 
> What platforms?
> 
> -Scott

Such as P4080, P3041, etc.

-Chenhui

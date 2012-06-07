Return-Path: <zch@az84smr01.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08A84B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 14:06:34 +1000 (EST)
Received: from mail113-db3 (localhost [127.0.0.1])	by
 mail113-db3-R.bigfish.com (Postfix) with ESMTP id 3CB60120255	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 04:05:41 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.251])	by
 mail113-db3.bigfish.com (Postfix) with ESMTP id AEE5C40047	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 04:05:39 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5746JVB030473	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 21:06:20 -0700
Date: Thu, 7 Jun 2012 12:07:01 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120607040701.GA15965@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <4FC8E250.9090000@freescale.com>
 <20120605090831.GA21929@localhost.localdomain>
 <4FCE2ECD.4050107@freescale.com>
 <20120606093142.GA23505@localhost.localdomain>
 <4FCFA0C8.9090800@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FCFA0C8.9090800@freescale.com>
Sender: <zch@az84smr01.freescale.net>
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

On Wed, Jun 06, 2012 at 01:26:16PM -0500, Scott Wood wrote:
> On 06/06/2012 04:31 AM, Zhao Chenhui wrote:
> > On Tue, Jun 05, 2012 at 11:07:41AM -0500, Scott Wood wrote:
> >> On 06/05/2012 04:08 AM, Zhao Chenhui wrote:
> >>> On Fri, Jun 01, 2012 at 10:40:00AM -0500, Scott Wood wrote:
> >>>> I know you say this is for dual-core chips only, but it would be nice if
> >>>> you'd write this in a way that doesn't assume that (even if the
> >>>> corenet-specific timebase freezing comes later).
> >>>
> >>> At this point, I have not thought about how to implement the cornet-specific timebase freezing.
> >>
> >> I wasn't asking you to.  I was asking you to not have logic that breaks
> >> with more than 2 CPUs.
> > 
> > These routines only called in the dual-core case. 
> 
> Come on, you know we have chips with more than two cores.  Why design
> such a limitation into it, just because you're not personally interested
> in supporting anything but e500v2?
> 
> Is it so hard to make it work for an arbitrary number of cores?
> 
> >>> If do not set them, it may make KEXEC fail on other platforms.
> >>
> >> What platforms?
> > 
> > Such as P4080, P3041, etc.
> 
> So we need to wait for corenet timebase sync before we stop causing
> problems in virtualization, simulators, etc. if a kernel has kexec or
> cpu hotplug enabled (whether used or not)?
> 
> Can you at least make sure we're actually in a kexec/hotplug scenario at
> runtime?
> 
> Or just implement corenet timebase sync -- it's not that different.
> 
> -Scott

We also work on the corenet timebase sync. Our plan is first the dual-core case,
then the case of more than 2 cores. We will submit the corenet timebase sync patch soon.

-Chenhui

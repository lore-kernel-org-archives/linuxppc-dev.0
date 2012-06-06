Return-Path: <zch@tx30smr01.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32EDFB6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:58:36 +1000 (EST)
Received: from mail153-ch1 (localhost [127.0.0.1])	by
 mail153-ch1-R.bigfish.com (Postfix) with ESMTP id F2F851802F4	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 09:57:46 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.230])	by mail153-ch1.bigfish.com (Postfix) with ESMTP id
 6E23C260046	for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 09:57:45
 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q569wRev009346	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 02:58:27 -0700
Date: Wed, 6 Jun 2012 17:59:10 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 2/5] powerpc/85xx: add HOTPLUG_CPU support
Message-ID: <20120606095910.GB23505@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-2-git-send-email-chenhui.zhao@freescale.com>
 <4FC933BF.1020901@freescale.com>
 <20120604110444.GA20676@localhost.localdomain>
 <4FCCE32F.1060301@freescale.com>
 <20120605111823.GB22427@localhost.localdomain>
 <4FCE30B8.2070902@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FCE30B8.2070902@freescale.com>
Sender: <zch@tx30smr01.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 05, 2012 at 11:15:52AM -0500, Scott Wood wrote:
> On 06/05/2012 06:18 AM, Zhao Chenhui wrote:
> > On Mon, Jun 04, 2012 at 11:32:47AM -0500, Scott Wood wrote:
> >> On 06/04/2012 06:04 AM, Zhao Chenhui wrote:
> >>> On Fri, Jun 01, 2012 at 04:27:27PM -0500, Scott Wood wrote:
> >>>> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> >>>>> -#ifdef CONFIG_KEXEC
> >>>>> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
> >>>>
> >>>> Let's not grow lists like this.  Is there any harm in building it
> >>>> unconditionally?
> >>>>
> >>>> -Scott
> >>>
> >>> We need this ifdef. We only set give_timebase/take_timebase
> >>> when CONFIG_KEXEC or CONFIG_HOTPLUG_CPU is defined.
> >>
> >> If we really need this to be a compile-time decision, make a new symbol
> >> for it, but I really think this should be decided at runtime.  Just
> >> because we have kexec or hotplug support enabled doesn't mean that's
> >> actually what we're doing at the moment.
> >>
> >> -Scott
> > 
> > If user does not enable kexec or hotplug, these codes are redundant.
> > So use CONFIG_KEXEC and CONFIG_HOTPLUG_CPU to gard them.
> 
> My point is that these lists tend to grow and be a maintenance pain.
> For small things it's often better to not worry about saving a few
> bytes.  For larger things that need to be conditional, define a new
> symbol rather than growing ORed lists like this.
> 
> -Scott

I agree with you in principle. But there are only two config options
in this patch, and it is unlikely to grow. 

-Chenhui

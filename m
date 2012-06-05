Return-Path: <zch@tx30smr01.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B020DB6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 21:17:57 +1000 (EST)
Received: from mail36-db3 (localhost [127.0.0.1])	by mail36-db3-R.bigfish.com
 (Postfix) with ESMTP id B46EA3406B4	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 11:17:09 +0000 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.238])	by
 mail36-db3.bigfish.com (Postfix) with ESMTP id 863A4480045	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 11:17:07 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q55BHiKF017962	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 04:17:44 -0700
Date: Tue, 5 Jun 2012 19:18:23 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 2/5] powerpc/85xx: add HOTPLUG_CPU support
Message-ID: <20120605111823.GB22427@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-2-git-send-email-chenhui.zhao@freescale.com>
 <4FC933BF.1020901@freescale.com>
 <20120604110444.GA20676@localhost.localdomain>
 <4FCCE32F.1060301@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FCCE32F.1060301@freescale.com>
Sender: <zch@tx30smr01.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2012 at 11:32:47AM -0500, Scott Wood wrote:
> On 06/04/2012 06:04 AM, Zhao Chenhui wrote:
> > On Fri, Jun 01, 2012 at 04:27:27PM -0500, Scott Wood wrote:
> >> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> >>> -#ifdef CONFIG_KEXEC
> >>> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
> >>
> >> Let's not grow lists like this.  Is there any harm in building it
> >> unconditionally?
> >>
> >> -Scott
> > 
> > We need this ifdef. We only set give_timebase/take_timebase
> > when CONFIG_KEXEC or CONFIG_HOTPLUG_CPU is defined.
> 
> If we really need this to be a compile-time decision, make a new symbol
> for it, but I really think this should be decided at runtime.  Just
> because we have kexec or hotplug support enabled doesn't mean that's
> actually what we're doing at the moment.
> 
> -Scott

If user does not enable kexec or hotplug, these codes are redundant.
So use CONFIG_KEXEC and CONFIG_HOTPLUG_CPU to gard them.

-Chenhui

Return-Path: <zch@tx30smr01.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0074CB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 20:18:27 +1000 (EST)
Received: from mail45-ch1 (localhost [127.0.0.1])	by mail45-ch1-R.bigfish.com
 (Postfix) with ESMTP id 81965403D1	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 10:17:38 +0000 (UTC)
Received: from CH1EHSMHS008.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.228])	by mail45-ch1.bigfish.com (Postfix) with ESMTP id
 5A0092E0048
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 10:17:36 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q56AIHr7014804	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 03:18:18 -0700
Date: Wed, 6 Jun 2012 18:19:03 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 5/5] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20120606101903.GC23505@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-5-git-send-email-chenhui.zhao@freescale.com>
 <4FC950AF.90007@freescale.com>
 <20120605105929.GA22427@localhost.localdomain>
 <4FCE2CB1.5090308@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FCE2CB1.5090308@freescale.com>
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

On Tue, Jun 05, 2012 at 10:58:41AM -0500, Scott Wood wrote:
> On 06/05/2012 05:59 AM, Zhao Chenhui wrote:
> > On Fri, Jun 01, 2012 at 06:30:55PM -0500, Scott Wood wrote:
> >> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> >>> The jog mode frequency transition process on the MPC8536 is similar to
> >>> the deep sleep process. The driver need save the CPU state and restore
> >>> it after CPU warm reset.
> >>>
> >>> Note:
> >>>  * The I/O peripherals such as PCIe and eTSEC may lose packets during
> >>>    the jog mode frequency transition.
> >>
> >> That might be acceptable for eTSEC, but it is not acceptable to lose
> >> anything on PCIe.  Especially not if you're going to make this "default y".
> > 
> > It is a hardware limitation.
> 
> Then make sure jog isn't used if PCIe is used.
> 
> Maybe you could do something with the suspend infrastructure, but this
> is sufficiently heavyweight that transitions should be manually
> requested, not triggered by the automatic cpufreq governor.
> 
> Does this apply to p1022, or just mpc8536?

Both of them.

> 
> > Peripherals in the platform will not be operating
> > during the jog mode frequency transition process.
> 
> What ensures this?
> 
> -Scott

Hardware ensures it without software intervention.

-Chenhui

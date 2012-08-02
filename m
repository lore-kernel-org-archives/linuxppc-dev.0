Return-Path: <zch@az84smr01.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 677E52C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 20:02:35 +1000 (EST)
Received: from mail116-va3 (localhost [127.0.0.1])	by
 mail116-va3-R.bigfish.com (Postfix) with ESMTP id 6218940242	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 10:02:29 +0000 (UTC)
Received: from VA3EHSMHS032.bigfish.com (unknown [10.7.14.251])	by
 mail116-va3.bigfish.com (Postfix) with ESMTP id 8A9BD1C00ED	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 10:02:26 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q72A2LpN017942	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Aug 2012 03:02:24 -0700
Date: Thu, 2 Aug 2012 18:04:18 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/smp: Do not disable IPI interrupts during suspend
Message-ID: <20120802100418.GA13777@localhost.localdomain>
References: <1342788421-27648-1-git-send-email-chenhui.zhao@freescale.com>
 <5028672F-1873-4E45-AA23-4CA9F191BE77@kernel.crashing.org>
 <1343427631.21647.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1343427631.21647.1.camel@pasglop>
Sender: <zch@az84smr01.freescale.net>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 28, 2012 at 08:20:31AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2012-07-27 at 16:58 -0500, Kumar Gala wrote:
> > On Jul 20, 2012, at 7:47 AM, Zhao Chenhui wrote:
> > 
> > > During suspend, all interrupts including IPI will be disabled. In this case,
> > > the suspend process will hang in SMP. To prevent this, pass the flag
> > > IRQF_NO_SUSPEND when requesting IPI irq.
> > > 
> > > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > ---
> > > arch/powerpc/kernel/smp.c |    2 +-
> > > 1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > BenH,
> > 
> > Can you ack?
> 
> No I'll merge it but not until it's been in next for a bit unless you
> have some strong emergency there, it's on my mental list of things to
> shovel into next after rc1.
> 
> Curiosity: didn't we use to disable all non-boot CPUs on suspend ?
> 
> Cheers,
> Ben.

Yes, we disabled all non-boot CPUs on suspend by calling disable_nonboot_cpus().
The disable_nonboot_cpus() needs IPIs to work. But prior to
calling disable_nonboot_cpus(), the IPIs are disabled in dpm_suspend_noirq().

-Chenhui

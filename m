Return-Path: <zch@tx30smr01.freescale.net>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6ED84B7022
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 20:20:40 +1000 (EST)
Received: from mail98-am1 (localhost [127.0.0.1])	by mail98-am1-R.bigfish.com
 (Postfix) with ESMTP id DAA02C01CB	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 27 Jun 2012 10:18:51 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.234])	by
 mail98-am1.bigfish.com (Postfix) with ESMTP id 05E57380047	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 10:18:49 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q5RAKSoi005118	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 03:20:29 -0700
Date: Wed, 27 Jun 2012 18:21:38 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120627102138.GB10476@localhost.localdomain>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <1340748634.3732.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1340748634.3732.27.camel@pasglop>
Sender: <zch@tx30smr01.freescale.net>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2012 at 08:10:34AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2012-06-26 at 18:25 +0800, Zhao Chenhui wrote:
> > Do hardware timebase sync. Firstly, stop all timebases, and transfer
> > the timebase value of the boot core to the other core. Finally,
> > start all timebases.
> > 
> > Only apply to dual-core chips, such as MPC8572, P2020, etc.
> > 
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Changes for v6:
> >  * added 85xx_TB_SYNC
> >  * added isync() after set_tb()
> >  * removed extra entries from mpc85xx_smp_guts_ids
> 
> What's that CONFIG option for ?
> 
> Cheers,
> Ben.

This option is to guard the timebase sync routines. It is selected
when KEXEC or HOTPLUG_CPU is enabled on Freescale Book-E platforms.

-Chenhui

Return-Path: <zch@az84smr01.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CCB9DB6F77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 13:37:19 +1000 (EST)
Received: from mail70-db3 (localhost [127.0.0.1])	by mail70-db3-R.bigfish.com
 (Postfix) with ESMTP id E459EE02F6	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 28 Jun 2012 03:35:28 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.234])	by
 mail70-db3.bigfish.com (Postfix) with ESMTP id 32DCC260262	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 03:35:26 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5S3b5QO005176	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 20:37:06 -0700
Date: Thu, 28 Jun 2012 11:38:15 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120628033815.GA11387@localhost.localdomain>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <1340748634.3732.27.camel@pasglop>
 <20120627102138.GB10476@localhost.localdomain>
 <1340797732.3732.46.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1340797732.3732.46.camel@pasglop>
Sender: <zch@az84smr01.freescale.net>
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

On Wed, Jun 27, 2012 at 09:48:52PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-06-27 at 18:21 +0800, Zhao Chenhui wrote:
> > > What's that CONFIG option for ?
> > > 
> > > Cheers,
> > > Ben.
> > 
> > This option is to guard the timebase sync routines. It is selected
> > when KEXEC or HOTPLUG_CPU is enabled on Freescale Book-E platforms.
> 
> Any reason not to just make it unconditional ? That sort of config
> option tend to just confuse things and make bug reports harder to sort
> out.... Also you decrease your test coverage.
> 
> Cheers,
> Ben.

The bootloader have done a timebase sync. If we do not need KEXEC or HOTPLUG_CPU feature,
it is unnecessary to do it again at boot time of kernel. I only compile the timebase sync routines
when users enable KEXEC or HOTPLUG_CPU.

-Chenhui

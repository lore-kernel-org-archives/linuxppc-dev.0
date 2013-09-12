Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6449B2C00C0
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 11:15:51 +1000 (EST)
Received: from mail59-ch1 (localhost [127.0.0.1])	by mail59-ch1-R.bigfish.com
 (Postfix) with ESMTP id E8C201201FD	for <linuxppc-dev@ozlabs.org>;
 Thu, 12 Sep 2013 01:15:47 +0000 (UTC)
Received: from CH1EHSMHS018.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail59-ch1.bigfish.com (Postfix) with ESMTP id
 CBB262004D
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 01:15:45 +0000 (UTC)
Message-ID: <1378948542.12204.490.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: DTS - re-organize the SPI partitions
 property
From: Scott Wood <scottwood@freescale.com>
To: Hu Mingkai-B21284 <B21284@freescale.com>
Date: Wed, 11 Sep 2013 20:15:42 -0500
In-Reply-To: <CF6CBFBA8EBBB949B6E321556F6E15090A135F45@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1378454743-17637-1-git-send-email-Mingkai.Hu@freescale.com>
 <1378856005.12204.372.camel@snotra.buserror.net>
 <CF6CBFBA8EBBB949B6E321556F6E15090A135F45@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-10 at 21:07 -0500, Hu Mingkai-B21284 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 11, 2013 7:33 AM
> > To: Hu Mingkai-B21284
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH] powerpc/85xx: DTS - re-organize the SPI partitions
> > property
> > 
> > What happens to exsting users whose flash is laid out the existing way,
> > when they upgrade to these device trees?
> > 
> 
> The SPI flash layout should be mapping the new device tree.
> 
> If the existing device tree is used to deploy the SPI flash, the following issues
> must be run into as the commit message described:
> 
> 1. Kernel images would be overlapped with U-Boot image.
> 2. Kernel images would be overlapped with FMAN ucode.
> 3. Saving environment variables will crash the kernel image.

Has the SPI U-Boot image always been larger than 512K for all these
platforms?  Why, given that we're under 512K for other boot modes?

> > We really should not be putting partition layout info in the device tree
> > to begin with...
> > 
> OK, I will remove the layout diagram in the commit message.

That's not what I meant.  I meant that the dts should be describing
hardware, and this is the sort of trouble we run into when we deviate
from that.  A better way would be to use the mtdparts command line
option.  Even better would be some sort of on-flash partition table.

-Scott

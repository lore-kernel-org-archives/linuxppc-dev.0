Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35C852C00A9
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 05:37:23 +1000 (EST)
Received: from mail87-co9 (localhost [127.0.0.1])	by mail87-co9-R.bigfish.com
 (Postfix) with ESMTP id 854284C0135	for <linuxppc-dev@ozlabs.org>;
 Tue,  1 Oct 2013 19:37:21 +0000 (UTC)
Received: from CO9EHSMHS026.bigfish.com (unknown [10.236.132.235])	by
 mail87-co9.bigfish.com (Postfix) with ESMTP id D59DA22004E	for
 <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 19:37:19 +0000 (UTC)
Message-ID: <1380656236.10618.39.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: DTS - re-organize the SPI partitions
 property
From: Scott Wood <scottwood@freescale.com>
To: Hu Mingkai-B21284 <B21284@freescale.com>
Date: Tue, 1 Oct 2013 14:37:16 -0500
In-Reply-To: <CF6CBFBA8EBBB949B6E321556F6E15090A157023@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1378454743-17637-1-git-send-email-Mingkai.Hu@freescale.com>
 <1378856005.12204.372.camel@snotra.buserror.net>
 <CF6CBFBA8EBBB949B6E321556F6E15090A135F45@039-SN2MPN1-011.039d.mgd.msft.net>
 <1378948542.12204.490.camel@snotra.buserror.net>
 <CF6CBFBA8EBBB949B6E321556F6E15090A14E997@039-SN2MPN1-012.039d.mgd.msft.net>
 <1379977371.24959.57.camel@snotra.buserror.net>
 <CF6CBFBA8EBBB949B6E321556F6E15090A1517D2@039-SN2MPN1-012.039d.mgd.msft.net>
 <1380051431.24959.114.camel@snotra.buserror.net>
 <CF6CBFBA8EBBB949B6E321556F6E15090A157023@039-SN2MPN1-012.039d.mgd.msft.net>
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


On Mon, 2013-09-30 at 03:31 -0500, Hu Mingkai-B21284 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 25, 2013 3:37 AM
> > To: Hu Mingkai-B21284
> > Cc: Wood Scott-B07421; linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH] powerpc/85xx: DTS - re-organize the SPI partitions
> > property
> > 
> > Fixing U-Boot would make the problem go away without any issues with
> > partition compatibility.  Are you sure nobody's using these SPI
> > partitions without booting from SPI?  Even if nobody's using this, it
> > seems a wasteful solution.  These are pretty small flashes.
> > 
> Scott,
> 
> I will submit a patch in U-Boot to fix this issue. Some quick questions:
> 1. Should we set the SPI flash as MTDPARTS_DEFAULT?
> 2. Should we consider the partition for NAND/NOR in mtdparts?
> 3. We need to remove the partition table in device tree, right?

Fixing the U-Boot size problem is separate from changing how we do
partitioning, but yes, we should transition all flashes to using
mtdparts instead of device tree partitions.

As to when to remove them from the device tree, that's a bit tricky.
There's no guarantee when a user updates their U-Boot environment
relative to when they update their device tree.  It's better to have
the partitions appear twice than to not appear at all.  But we do want
to discourage the use of the device tree partitions, and it would be
bad if the descriptions don't match and a user ends up mixing the two.

-Scott

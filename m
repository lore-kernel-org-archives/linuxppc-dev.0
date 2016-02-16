Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2E721A0013
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 11:41:56 +1100 (AEDT)
Message-ID: <1455583310.2463.37.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Raghav Dogra <raghav.dogra@nxp.com>, Brian Norris
 <computersforpeace@gmail.com>, Li Yang <leoli@freescale.com>
Cc: Raghav Dogra <raghav@freescale.com>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,  Prabhakar Kushwaha
 <prabhakar.kushwaha@nxp.com>, Jaiprakash Singh <b44839@freescale.com>
Date: Mon, 15 Feb 2016 18:41:50 -0600
In-Reply-To: <DB4PR04MB3465D14DB9003BF000DFE9889AC0@DB4PR04MB346.eurprd04.prod.outlook.com>
References: <1454481372-10288-1-git-send-email-raghav@freescale.com>
 <CADRPPNTKFA8rkynJR4wCNgAmqvmiwYwTi2Uk9hDUMB4+N7ST_Q@mail.gmail.com>
 <20160212194411.GF21465@google.com>
 <DB4PR04MB3465D14DB9003BF000DFE9889AC0@DB4PR04MB346.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] mtd/ifc: Add support for IFC controller version 2.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-15 at 06:18 +0000, Raghav Dogra wrote:
> 
> > -----Original Message-----
> > From: Brian Norris [mailto:computersforpeace@gmail.com]
> > Sent: Saturday, February 13, 2016 1:14 AM
> > To: Li Yang <leoli@freescale.com>
> > Cc: Raghav Dogra <raghav@freescale.com>; linux-mtd@lists.infradead.org;
> > linuxppc-dev <linuxppc-dev@lists.ozlabs.org>; oss@buserror.net; Prabhakar
> > Kushwaha <prabhakar.kushwaha@nxp.com>; Jaiprakash Singh
> > <b44839@freescale.com>
> > Subject: Re: [PATCH] mtd/ifc: Add support for IFC controller version 2.0
> > 
> > On Thu, Feb 04, 2016 at 05:07:16PM -0600, Li Yang wrote:
> > > On Wed, Feb 3, 2016 at 12:36 AM, Raghav Dogra <raghav@freescale.com>
> > wrote:
> > > > The new IFC controller version 2.0 has a different memory map page.
> > > > Upto IFC 1.4 PAGE size is 4 KB and from IFC2.0 PAGE size is 64KB.
> > > > This patch segregates the IFC global and runtime registers to
> > > > appropriate PAGE sizes.
> > > 
> > > If the global registers and the runtime registers are so independent
> > > that they have to be on different page boundaries, it would make more
> > > sense for them to be defined as separate reg regions in the device
> > > tree at the very beginning.  Then we would only need to change the
> > > device tree now and it would be future proof for any page size.
> > 
> > To be clear: Scott, you were NACK'ing the DT binding change request,
> > right? I
> > though we had an Ack on the previous revision (that Raghav failed to
> > carry).
> > 
> > > > 
> > > > Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> > > > Signed-off-by: Raghav Dogra <raghav@freescale.com>
> > > 
> > > The patch cannot apply on latest 4.5-rc cleanly either.  Otherwise,
> > 
> > Yeah... neither this patch nor its (allegedly) dependent patch [1] apply
> > cleanly.
> > 
> > If you expect me to take this patch via MTD, please rebase to l2-mtd.git
> > as
> > stated here:
> > 
> > http://linux-mtd.infradead.org/source.html
> > 
> I expect Scott to pick this patch, and apply via linuxppc-dev. I will send
> the patch on based on
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Branch "master"

Why are you expecting that, for a patch that touches an MTD driver and doesn't
touch arch/powerpc, and for which I've already given an ack for it to go via
the MTD tree?

What tree did you use to generate this patch?  If there's stuff in the MTD
tree that conflicts, that's all the more reason to send it via the MTD tree
(after rebasing onto it).

-Scott

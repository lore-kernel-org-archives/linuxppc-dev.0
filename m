Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0160DB70D8
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 03:10:17 +1000 (EST)
Subject: Re: [PATCH 1/2] MPC85xx: add definitions for PCI error detection
	soc  part
From: Peter Tyser <ptyser@xes-inc.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
In-Reply-To: <AANLkTikd3pyVa3=V0pqA5uOto+RYWY_0kF_SL0d0B=BD@mail.gmail.com>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279811975.7232.8696.camel@petert>
	<AANLkTikd3pyVa3=V0pqA5uOto+RYWY_0kF_SL0d0B=BD@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Jul 2010 12:09:56 -0500
Message-ID: <1279818596.7232.8785.camel@petert>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>,
	bluesmoke-devel@lists.sourceforge.net, Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > On Thu, 2010-07-22 at 04:03 +0400, Dmitry Eremin-Solenikov wrote:
> >> Add definitions for PCI error detection device to be handled by (already
> >> existing) mpc85xx_edac.c driver.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >>  arch/powerpc/boot/dts/mpc8536ds.dts        |    7 +++++++
> >>  arch/powerpc/boot/dts/mpc8536ds_36b.dts    |    7 +++++++
> >>  arch/powerpc/boot/dts/mpc8540ads.dts       |    8 ++++++++
> >>  arch/powerpc/boot/dts/mpc8541cds.dts       |   14 ++++++++++++++
> >>  arch/powerpc/boot/dts/mpc8544ds.dts        |    7 +++++++
> >>  arch/powerpc/boot/dts/mpc8548cds.dts       |   14 ++++++++++++++
> >>  arch/powerpc/boot/dts/mpc8555cds.dts       |   14 ++++++++++++++
> >>  arch/powerpc/boot/dts/mpc8560ads.dts       |    7 +++++++
> >>  arch/powerpc/boot/dts/mpc8568mds.dts       |    7 +++++++
> >>  arch/powerpc/boot/dts/sbc8548.dts          |    7 +++++++
> >>  arch/powerpc/boot/dts/sbc8560.dts          |    7 +++++++
> >>  arch/powerpc/boot/dts/socrates.dts         |    7 +++++++
> >>  arch/powerpc/boot/dts/stx_gp3_8560.dts     |    7 +++++++
> >>  arch/powerpc/boot/dts/tqm8540.dts          |   10 ++++++++++
> >>  arch/powerpc/boot/dts/tqm8541.dts          |    7 +++++++
> >>  arch/powerpc/boot/dts/tqm8548-bigflash.dts |    7 +++++++
> >>  arch/powerpc/boot/dts/tqm8548.dts          |    7 +++++++
> >>  arch/powerpc/boot/dts/tqm8555.dts          |    7 +++++++
> >>  arch/powerpc/boot/dts/tqm8560.dts          |    7 +++++++
> >>  arch/powerpc/boot/dts/xpedite5200.dts      |    7 +++++++
> >>  arch/powerpc/boot/dts/xpedite5200_xmon.dts |    7 +++++++
> >>  21 files changed, 172 insertions(+), 0 deletions(-)
> >
> > It looks like the dts files for the MPC8572-based boards weren't
> > included in this change despite patch 2/2 adding support for them.  I'd
> > guess some other Freescale CPUs (eg P1020, P2020, etc) could be
> > supported by the same driver if you are inclined to add them to this
> > patch series.
> 
> I just did a quick search for all dts including mpc8540-pci node and added
> respective mpc85xx-pci-error node. Current MPC85xx EDAC driver doesn't
> support error handling on PCI-E busses (which MPC8572 and other CPUs
> you mentioned have). I'll maybe look into PCI-E EDAC later. Also I don't have
> access to P10xx/P20xx manuals, so support for them may require some
> more time.

Thanks for the explanation.  I noticed this because patch 2/2 adds
support for the 8572 to the mpc85xx_pci_err_of_match[] table.  Sounds
like that was the bug instead of my comment above.

Best,
Peter

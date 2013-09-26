Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76F152C0196
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:42:43 +1000 (EST)
Received: from mail224-DB9 (localhost [127.0.0.1])	by
 mail224-DB9-R.bigfish.com (Postfix) with ESMTP id 0B918480091	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 01:42:37 +0000 (UTC)
Received: from DB9EHSMHS025.bigfish.com (unknown [10.174.16.250])	by
 mail224-DB9.bigfish.com (Postfix) with ESMTP id D0E5620044	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 01:42:35 +0000 (UTC)
Message-ID: <1380159752.24959.245.camel@snotra.buserror.net>
Subject: Re: [PATCH v3] powerpc/p1010rdb-pb:make a new dts for p1010rdb-pb
From: Scott Wood <scottwood@freescale.com>
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Date: Wed, 25 Sep 2013 20:42:32 -0500
In-Reply-To: <3F453DDFF675A64A89321A1F35281021ADAA42@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1379480097-11698-1-git-send-email-B45475@freescale.com>
 <3F453DDFF675A64A89321A1F35281021ADAA42@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Zhao Qiang-B45475 <B45475@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-18 at 05:43 +0000, Liu Shengzhou-B36685 wrote:
> 
> > -----Original Message-----
> > From: Zhao Qiang-B45475
> > Sent: Wednesday, September 18, 2013 12:55 PM
> > To: linuxppc-dev@lists.ozlabs.org
> > Cc: Zhao Qiang-B45475; Liu Shengzhou-B36685
> > Subject: [PATCH v3] powerpc/p1010rdb-pb:make a new dts for p1010rdb-pb
> > 
> > P1010RDB-PA and P1010RDB-PB boards use different external PHY interrupt signals.
> > So make a new dts for P1010RDB-PB.
> > 
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > ---
> > Changes for v2:
> > 	-Remove phy interrupts for p1010rdb-pb
> > Changes for v3:
> > 	-Maintain the phy interrupts p1010rdb-pa and make a new device
> > 	tree for p1010rdb-pb
> > 
> >  arch/powerpc/boot/dts/p1010rdb-pa.dtsi | 11 ++++++
> > arch/powerpc/boot/dts/p1010rdb-pb.dts  | 67 ++++++++++++++++++++++++++++++++++
> >  arch/powerpc/boot/dts/p1010rdb-pb.dtsi | 11 ++++++
> >  arch/powerpc/boot/dts/p1010rdb.dts     |  1 +
> >  arch/powerpc/boot/dts/p1010rdb.dtsi    |  3 --
> >  arch/powerpc/platforms/85xx/p1010rdb.c | 29 +++++++++++++++
> >  6 files changed, 119 insertions(+), 3 deletions(-)  create mode 100644
> > arch/powerpc/boot/dts/p1010rdb-pa.dtsi
> >  create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
> >  create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dtsi
> > 
> 
> Don't touch p1010rdb.c, create two p1010rdb-pa.dts and p1010rdb-pb.dts, which include the common p1010rdb.dtsi.
> Combine original p1010rdb.dts and p1010rdb.dtsi into new p1010rdb.dtsi with removing compatible part.
> Place phy node and following part in p1010rdb-pa.dts and p1010rdb-pb.dts.
> / {
>         model = "fsl,P1010RDB-PA";
>         compatible = "fsl,P1010RDB";
>   }
> 
> / {
>         model = "fsl,P1010RDB-PB";
>         compatible = "fsl,P1010RDB";
>   }

Model is mainly for human consumption and generally redundant on the
toplevel node...  These boards are obviously not fully compatible and
thus there should be a new "fsl,p1010rdb-pb" with the existing
"fsl,P1010RDB" used to refer to PA since we can't change it now.

-Scott

Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0089.outbound.protection.outlook.com [104.47.1.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sj6Jh4ydzzDrPY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 11:46:43 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Scott Wood <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "pku.leo@gmail.com" <pku.leo@gmail.com>, "X.B. Xie" <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v6,2/2] QE: remove PPCisms for QE
Date: Mon, 26 Sep 2016 01:46:37 +0000
Message-ID: <AM3PR04MB1185D2F7F34FACE514ABE51991CD0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1474597232-33397-2-git-send-email-qiang.zhao@nxp.com>
 <20160925041411.GA16092@home.buserror.net>
 <20160925041906.GA16719@home.buserror.net>
In-Reply-To: <20160925041906.GA16719@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 25, 2016 at 12:19PM -0500, Scott Wood wrote:

> -----Original Message-----
> From: Scott Wood [mailto:oss@buserror.net]
> Sent: Sunday, September 25, 2016 12:19 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: linuxppc-dev@lists.ozlabs.org; pku.leo@gmail.com; X.B. Xie
> <xiaobo.xie@nxp.com>; linux-kernel@vger.kernel.org
> Subject: Re: [v6,2/2] QE: remove PPCisms for QE
>=20
> On Sat, Sep 24, 2016 at 11:14:11PM -0500, Scott Wood wrote:
> > On Fri, Sep 23, 2016 at 10:20:32AM +0800, Zhao Qiang wrote:
> > > QE was supported on PowerPC, and dependent on PPC, Now it is
> > > supported on other platforms. so remove PPCisms.
> > >
> > > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > > ---
> > > Changes for v2:
> > > 	- na
> > > Changes for v3:
> > > 	- add NO_IRQ
> > > Changes for v4:
> > > 	- modify spin_event_timeout to opencoded timeout loop
> > > 	- remove NO_IRQ
> > > 	- modify virq_to_hw to opencoed code Changes for v5:
> > > 	- modify commit msg
> > > 	- modify depends of QUICC_ENGINE
> > > 	- add kerneldoc header for qe_issue_cmd Changes for v6:
> > > 	- add dependency on FSL_SOC and PPC32 for drivers
> > > 	  depending on QUICC_ENGING but not available on ARM
> > >
> > >  drivers/irqchip/qe_ic.c                | 28 +++++++-----
> > >  drivers/net/ethernet/freescale/Kconfig | 10 ++---
> > >  drivers/soc/fsl/qe/Kconfig             |  2 +-
> > >  drivers/soc/fsl/qe/qe.c                | 80 ++++++++++++++++++++----=
----------
> > >  drivers/soc/fsl/qe/qe_io.c             | 42 ++++++++----------
> > >  drivers/soc/fsl/qe/qe_tdm.c            |  8 ++--
> > >  drivers/soc/fsl/qe/ucc.c               | 10 ++---
> > >  drivers/soc/fsl/qe/ucc_fast.c          | 68 ++++++++++++++----------=
-----
> > >  drivers/tty/serial/Kconfig             |  2 +-
> > >  drivers/usb/gadget/udc/Kconfig         |  2 +-
> > >  drivers/usb/host/Kconfig               |  2 +-
> > >  include/soc/fsl/qe/qe.h                |  1 -
> > >  include/soc/fsl/qe/qe_ic.h             | 12 ++---
> > >  13 files changed, 141 insertions(+), 126 deletions(-)
> >
> > I assume this means you'll be updating
> > http://patchwork.ozlabs.org/patch/654473/
> > to be based on top of this...
>=20
> Apparently that assumption was wrong, since I now see that you're patchin=
g
> drivers/irqchip/qe_ic.c rather than drivers/soc/fsl/qe/qe_ic.c.
> Please keep the drivers/irqchip stuff separate and send to the appropriat=
e
> maintainers.
>=20

You means separate drivers/irqchip/qe_ic.c part from this patch and send it=
 with the other qe_ic patches?
Is it acceptable if I modify qe_ic.c with drivers/soc/fsl/qe/qe_ic.c, then =
send qe_ic patches to move qe_ic to drivers/irqchip?

BR
-Zhao Qiang

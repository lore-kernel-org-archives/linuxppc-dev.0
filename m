Return-Path: <B35336@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62C372C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 00:36:51 +1100 (EST)
Received: from mail8-co1 (localhost [127.0.0.1])	by mail8-co1-R.bigfish.com
 (Postfix) with ESMTP id 9C893C40288	for <linuxppc-dev@lists.ozlabs.org>; Thu,
 17 Oct 2013 13:36:46 +0000 (UTC)
Received: from CO1EHSMHS011.bigfish.com (unknown [10.243.78.233])	by
 mail8-co1.bigfish.com (Postfix) with ESMTP id 3CDA238004C	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 13:36:45 +0000 (UTC)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [4/4] powerpc/mpc8548: Add workaround for erratum NMG_SRIO135
Date: Thu, 17 Oct 2013 13:36:43 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA412915@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1331025056-15983-4-git-send-email-chenhui.zhao@freescale.com>,
 <20131016232003.GA27543@home.buserror.net>
In-Reply-To: <20131016232003.GA27543@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A=
OK. I will do.=0A=
=0A=
-Chenhui=0A=
=0A=
________________________________________=0A=
From: Wood Scott-B07421=0A=
Sent: Thursday, October 17, 2013 7:20=0A=
To: Zhao Chenhui-B35336=0A=
Cc: linuxppc-dev@lists.ozlabs.org=0A=
Subject: Re: [4/4] powerpc/mpc8548: Add workaround for erratum NMG_SRIO135=
=0A=
=0A=
On Tue, Mar 06, 2012 at 05:10:56PM +0800, chenhui zhao wrote:=0A=
> From: chenhui zhao <chenhui.zhao@freescale.com>=0A=
>=0A=
> Issue:=0A=
> Applications using lwarx/stwcx instructions in the core to=0A=
> compete for a software lock or semaphore with a device on=0A=
> RapidIO using read atomic set, clr, inc, or dec in a similar=0A=
> manner may falsely result in both masters seeing the lock=0A=
> as "available". This could result in data corruption as=0A=
> both masters try to modify the same piece of data protected=0A=
> by the lock.=0A=
>=0A=
> Workaround:=0A=
> Set bits 13 and 29 of CCSR offset 0x01010 (EEBPCR register=0A=
> of the ECM) during initialization and leave them set=0A=
> indefinitely. This may slightly degrade overall system=0A=
> performance.=0A=
>=0A=
> Refer to SRIO39 in MPC8548 errata document.=0A=
>=0A=
> Signed-off-by: Gong Chen <g.chen@freescale.com>=0A=
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>=0A=
> Signed-off-by: Li Yang <leoli@freescale.com>=0A=
>=0A=
> ---=0A=
> arch/powerpc/sysdev/fsl_rio.c |   44 ++++++++++++++++++++++++++++++++++++=
+++++=0A=
>  1 files changed, 44 insertions(+), 0 deletions(-)=0A=
[snip]=0A=
> @@ -358,6 +391,17 @@ int fsl_rio_setup(struct platform_device *dev)=0A=
>                               dev->dev.of_node->full_name);=0A=
>               return -EFAULT;=0A=
>       }=0A=
> +=0A=
> +     /* Fix erratum NMG_SRIO135 */=0A=
> +     if (fsl_svr_is(SVR_8548) || fsl_svr_is(SVR_8548_E)) {=0A=
> +             rc =3D fixup_erratum_srio135(&dev->dev);=0A=
> +             if (rc) {=0A=
> +                     dev_err(&dev->dev,=0A=
> +                             "Failed to fix the erratum NMG_SRIO135.");=
=0A=
> +                     return rc;=0A=
> +             }=0A=
> +     }=0A=
=0A=
This needs to be respun based on the current tree.=0A=
=0A=
-Scott=0A=

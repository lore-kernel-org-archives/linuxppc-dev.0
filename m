Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95D5B2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2013 13:14:41 +1000 (EST)
Received: from mail117-co9 (localhost [127.0.0.1])	by
 mail117-co9-R.bigfish.com (Postfix) with ESMTP id C55273000FD	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2013 03:14:36 +0000 (UTC)
Received: from CO9EHSMHS005.bigfish.com (unknown [10.236.132.231])	by
 mail117-co9.bigfish.com (Postfix) with ESMTP id 0D58BD80056	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2013 03:14:36 +0000 (UTC)
Date: Sun, 7 Apr 2013 11:15:56 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Subject: Re: [PATCH 08/17] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Message-ID: <20130407031556.GA17885@localhost.localdomain>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
 <1364994565-16010-8-git-send-email-chenhui.zhao@freescale.com>
 <D07C73A334FF604B95B3CBD2A545D07B0B1265B9@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B1265B9@039-SN2MPN1-013.039d.mgd.msft.net>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 07, 2013 at 10:30:41AM +0800, Tang Yuantian-B29983 wrote:
> Also send this patch to cpufreq@vger.kernel.org and linux-pm@vger.kerne=
l.org
> And better to rebase it on git://git.kernel.org/pub/scm/linux/kernel/gi=
t/rafael/linux-pm.git
>=20
> Thanks,
> Yuantian

OK. Thanks.

-Chenhui

>=20
> > -----Original Message-----
> > From: Linuxppc-dev [mailto:linuxppc-dev-
> > bounces+b29983=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Zhao Ch=
enhui
> > Sent: 2013=E5=B9=B44=E6=9C=883=E6=97=A5 21:09
> > To: linuxppc-dev@lists.ozlabs.org
> > Subject: [PATCH 08/17] powerpc/85xx: add support to JOG feature using
> > cpufreq interface
> >=20
> > From: chenhui zhao <chenhui.zhao@freescale.com>
> >=20
> > Some MPC85xx SoCs like MPC8536 and P1022 have a JOG feature, which
> > provides a dynamic mechanism to lower or raise the CPU core clock at
> > runtime.
> >=20
> > This patch adds the support to change CPU frequency using the standar=
d
> > cpufreq interface. The ratio CORE to CCB can be 1:1(except MPC8536), =
3:2,
> > 2:1, 5:2, 3:1, 7:2 and 4:1.
> >=20
> > Two CPU cores on P1022 must not in the low power state during the
> > frequency transition. The driver uses a flag to meet the requirement.
> >=20
> > The jog mode frequency transition process on the MPC8536 is similar t=
o
> > the deep sleep process. The driver need save the CPU state and restor=
e it
> > after CPU warm reset.
> >=20
> > Note:
> >  * The I/O peripherals such as PCIe and eTSEC may lose packets during
> >    the jog mode frequency transition.
> >  * The driver doesn't support MPC8536 Rev 1.0 due to a JOG erratum.
> >    Subsequent revisions of MPC8536 have corrected the erratum.
> >=20
> > Signed-off-by: Dave Liu <daveliu@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>

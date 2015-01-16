Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0148.outbound.protection.outlook.com [207.46.100.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC4211A0D8F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 13:49:40 +1100 (AEDT)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: York Sun <yorksun@freescale.com>, Scott Wood <scottwood@freescale.com>,
 "LeoLi@freescale.com" <LeoLi@freescale.com>
Subject: RE: [PATCH] fsl/smp: add low power boot support to replace spin boot
Date: Fri, 16 Jan 2015 02:49:34 +0000
Message-ID: <BN1PR03MB1886339D240EE7A8E7F65129D4F0@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
 <54B7F414.2020609@freescale.com>
In-Reply-To: <54B7F414.2020609@freescale.com>
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

Thanks for your review.

> -----Original Message-----
> From: Sun York-R58495
> Sent: Friday, January 16, 2015 1:09 AM
> To: Wang Dongsheng-B40534; Wood Scott-B07421; Li Yang-Leo-R58472
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] fsl/smp: add low power boot support to replace spin =
boot
>=20
>=20
>=20
> On 01/14/2015 10:05 PM, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > U-boot put non-boot cpus into an low power state(PW10/PW20 or DOZE)
> > when cpu powered up. To exit low power state kernel will send DOORBELL
> > or MPIC-IPI signal to all those CPUs.
> >
> > e500/e500v2 use mpic to send IPI signal.
> > e500mc and later use doorbell to send IPI signal.
> >
> > This feature tested on:
> > POWER UP TEST:
> > P1022DS(e500v2),96k times.
> > P4080(e500mc),  110k times.
> > T1024(e5500),   83k times.
> > T4240(e6500),   150k times.
> >
> > CPU HOTPLUG TEST:
> > P1022DS(e500v2),1.4 million times.
> > P4080(e500mc),  1.8 million times.
> > T1024(e5500),   1.3 million times.
> > T4240(e6500),   1.1 million times.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
>=20
> This is a very good move. Can you explain what has been tested for 100K t=
imes,
> or over a million times?
>=20
Thanks, I tested linux boot process and cpu hotplug.

For Linux boot process test:
Each CPU can normally be started and random run an application, the applica=
tion
works well.

For cpu hotplug test:
Just plug out and plug in for each cpu. Cpu hotplug test works well.

If I missed some case please let me know.

> Have you verified on older e500v2 platforms, such as MPC8572?
>=20
I haven't tested MPC8572 and Just test P1022DS. Because is e500 and e500v2 =
use the same
Low power boot codes.

I will test this feature on MPC8572 platform.=20

Regards,
-Dongsheng

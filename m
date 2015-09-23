Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0116.outbound.protection.outlook.com [65.55.169.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1D021A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 15:31:10 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Scott Wood <scottwood@freescale.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Hongtao Jia <hongtao.jia@freescale.com>,
 "Marc Zyngier" <marc.zyngier@arm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of
 redundant mpic_irq_set_wake
Date: Wed, 23 Sep 2015 05:31:03 +0000
Message-ID: <SN1PR0301MB1616CF7415825908030E0C829D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
 <1442965805.19102.303.camel@freescale.com>
 <SN1PR0301MB1616AD6C1C410ACB49A5D9279D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1509230545580.5606@nanos>
In-Reply-To: <alpine.DEB.2.11.1509230545580.5606@nanos>
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



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Thomas Gleixner
> Sent: Wednesday, September 23, 2015 11:49 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Sudeep Holla; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Rafael J. Wysocki; Benjamin Herrenschmidt; Paul
> Mackerras; Michael Ellerman; Jia Hongtao-B38951; Marc Zyngier; linuxppc-
> dev@lists.ozlabs.org
> Subject: RE: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE inste=
ad of
> redundant mpic_irq_set_wake
>=20
> On Wed, 23 Sep 2015, Wang Dongsheng wrote:
> > > On Mon, 2015-09-21 at 16:47 +0100, Sudeep Holla wrote:
> > > > mpic_irq_set_wake return -ENXIO for non FSL MPIC and sets IRQF_NO_S=
USPEND
> > > > flag for FSL ones. enable_irq_wake already returns -ENXIO if irq_se=
t_wak
> > > > is not implemented. Also there's no need to set the IRQF_NO_SUSPEND=
 flag
> > > > as it doesn't guarantee wakeup for that interrupt.
> > > >
> >
> > Non-freescale return -ENXIO, is there any issue? If non-freescale
> > platform does not support it, but IPs still use
> > enable/disable_irq_wake, we should return a error number.
>=20
> You can just set IRQCHIP_SKIP_SET_WAKE for FSL chips and not for the
> others.
>=20
> > @Scott:
> > If set this flag we cannot keep a irq as a wakeup source when system go=
ing to
> > SUSPEND or MEM.
> >
> > irq_set_wake() means we can set this irq as a wake source.
> > IRQCHIP_SKIP_SET_WAKE is ignore irq_set_wake() feature.
>=20
> Nonsense. IRQCHIP_SKIP_SET_WAKE merily tells the core not to bail on
> !chip->irq_set_wake(), but its still marking the interrupt as wakeup
> source and therefor not masking it on suspend.
>=20

Sorry, I just check irq_set_irq_wake() code, right, IRQCHIP_SKIP_SET_WAKE a=
lso can
going to irqd_set to mask IRQD_WAKEUP_STATE.

Yes, this flag just skip the irq_set_wake() not this feature.

Regards,
-Dongsheng

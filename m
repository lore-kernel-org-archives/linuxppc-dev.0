Return-Path: <roy.pledge@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95AAF1A2C32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 01:32:18 +1000 (AEST)
From: Roy Pledge <roy.pledge@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v2 04/11] soc/fsl: Introduce drivers for the DPAA QMan
Date: Tue, 15 Sep 2015 15:32:10 +0000
Message-ID: <BN3PR0301MB1267B1FE0917FB456281983F8C5C0@BN3PR0301MB1267.namprd03.prod.outlook.com>
References: <1439410497-19039-1-git-send-email-Roy.Pledge@freescale.com>
 <1439410497-19039-5-git-send-email-Roy.Pledge@freescale.com>
 <20150912011005.GA8796@home.buserror.net>
In-Reply-To: <20150912011005.GA8796@home.buserror.net>
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
> From: Wood Scott-B07421
> Sent: Friday, September 11, 2015 9:10 PM
> To: Pledge Roy-R01356 <roy.pledge@freescale.com>
> Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [v2 04/11] soc/fsl: Introduce drivers for the DPAA QMan
>=20
> On Wed, Aug 12, 2015 at 04:14:50PM -0400, Roy Pledge wrote:
> > +/* Lock/unlock frame queues, subject to the "LOCKED" flag. This is
> > +about
> > + * inter-processor locking only. Note, FQLOCK() is always called
> > +either under a
> > + * local_irq_save() or from interrupt context - hence there's no need
> > +for irq
> > + * protection (and indeed, attempting to nest irq-protection doesn't
> > +work, as
> > + * the "irq en/disable" machinery isn't recursive...). */ #define
> > +FQLOCK(fq) \
> > +	do { \
> > +		struct qman_fq *__fq478 =3D (fq); \
> > +		if (fq_isset(__fq478, QMAN_FQ_FLAG_LOCKED)) \
> > +			spin_lock(&__fq478->fqlock); \
> > +	} while (0)
> > +#define FQUNLOCK(fq) \
> > +	do { \
> > +		struct qman_fq *__fq478 =3D (fq); \
> > +		if (fq_isset(__fq478, QMAN_FQ_FLAG_LOCKED)) \
> > +			spin_unlock(&__fq478->fqlock); \
> > +	} while (0)
> > +
>=20
> I don't see QMAN_FQ_FLAG_LOCKED set anywhere.  What is the use case?

The idea was to allow multiple threads to manipulate the state of a frame q=
ueue at the same time without clobbering each others changes since the oper=
ation is a read/modify/write.  I see two users of this flag in code that ha=
sn't been submitted upstream yet, but I'm not sure if the use is required i=
n those two instances either. At a glance it doesn't seem like it is needed=
 but I would need to follow up with the users to make sure they aren't perf=
orming FQ management commands in multiple threads.

>=20
> -Scott

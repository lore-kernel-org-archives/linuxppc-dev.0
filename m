Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D51BA1A1E3B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 18:58:28 +1000 (AEST)
From: "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [RFC,1/8] soc/fman: Add FMan MURAM support
Date: Mon, 20 Apr 2015 08:58:20 +0000
Message-ID: <DM2PR03MB3835BC56CD47613CB1AD4EBE6E00@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1426050469-12507-1-git-send-email-igal.liberman@freescale.com>
 <32CF85E2-A8AA-454D-A46F-0E778DAF97ED@kernel.crashing.org>
In-Reply-To: <32CF85E2-A8AA-454D-A46F-0E778DAF97ED@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Regards,
Igal Liberman.

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, March 12, 2015 5:57 PM
> To: Liberman Igal-B31950
> Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wood Scott-B07421
> Subject: Re: [RFC,1/8] soc/fman: Add FMan MURAM support
>=20
>=20
> On Mar 11, 2015, at 12:07 AM, Igal.Liberman <igal.liberman@freescale.com>
> wrote:
>=20
> > From: Igal Liberman <Igal.Liberman@freescale.com>
> >
> > Add Frame Manager Multi-User RAM support.
> >
> > Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> > ---
> > drivers/soc/fsl/fman/Kconfig            |    1 +
> > drivers/soc/fsl/fman/Makefile           |    5 +-
> > drivers/soc/fsl/fman/fm_muram.c         |  174
> +++++++++++++++++++++++++++++++
> > drivers/soc/fsl/fman/inc/fm_muram_ext.h |   98 +++++++++++++++++
> > 4 files changed, 276 insertions(+), 2 deletions(-) create mode 100644
> > drivers/soc/fsl/fman/fm_muram.c create mode 100644
> > drivers/soc/fsl/fman/inc/fm_muram_ext.h
> >
>=20
> use lib/genalloc instead of rheap
>=20

Hi Kumar,
I looked into lib/genalloc allocator.
As far as I see, the genalloc allocator doesn't allow to control the memory=
 alignment when you allocate a chunk of memory.
Two important notes regarding MURAM memory:
- The allocated memory chunks should have specific alignment (might be diff=
erent in each chunk).
- The allocations must be efficient, we don't want to "waste" MURAM due to =
alignment issues.

> - k

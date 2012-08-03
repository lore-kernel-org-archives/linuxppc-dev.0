Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 723B12C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 05:16:17 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt support.
Date: Fri, 3 Aug 2012 19:16:07 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D15AAF3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343745764-3788-1-git-send-email-Varun.Sethi@freescale.com>
 <609EA81E-EC64-4539-B36B-E57525CE2492@kernel.crashing.org>
 <501C0007.8070209@freescale.com>
 <8E113655-B8C1-4F77-82DD-4A8460553CCA@kernel.crashing.org>
In-Reply-To: <8E113655-B8C1-4F77-82DD-4A8460553CCA@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Hamciuc Bogdan-BHAMCIU1 <bhamciu1@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Saturday, August 04, 2012 12:43 AM
> To: Wood Scott-B07421
> Cc: Sethi Varun-B16395; Hamciuc Bogdan-BHAMCIU1; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt
> support.
>=20
>=20
> On Aug 3, 2012, at 11:44 AM, Scott Wood wrote:
>=20
> > On 08/03/2012 08:19 AM, Kumar Gala wrote:
> >>
> >> On Jul 31, 2012, at 9:42 AM, Varun Sethi wrote:
> >>> +	/* ioremap'ed base for error interrupt registers */
> >>> +	u32 __iomem	*err_regs;
> >>> +	/* error interrupt config */
> >>> +	u32			err_int_config_done;
> >>> +
> >>
> >> Is this really needed ?
> >
> > Probably a left over from when it was done on demand.
> >
> >>
> >>> 	/* Protected sources */
> >>> 	unsigned long		*protected;
> >>>
> >>> @@ -370,6 +381,8 @@ struct mpic
> >>> #define MPIC_NO_RESET			0x00004000
> >>> /* Freescale MPIC (compatible includes "fsl,mpic") */
> >>> #define MPIC_FSL			0x00008000
> >>> +/* Freescale MPIC supports EIMR (error interrupt mask register)*/
> >>> +#define MPIC_FSL_HAS_EIMR		0x00010000
> >>
> >> Can't we use BRR for this?
> >
> > BRR is used, and this is set as a result.  Better than opencoding a
> > BRR check a bunch of places...
>=20
> I'm fine w/that, but didn't see where MPIC_FSL_HAS_EMIR was being set..
> Just want to avoid the caller of mpic_alloc() having to pass it in.
It's being set in mpic_setup_error_int (called from mpic_alloc)

-Varun

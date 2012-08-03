Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8F7B2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 05:32:42 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt support.
Date: Fri, 3 Aug 2012 19:32:31 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D15AB15@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343745764-3788-1-git-send-email-Varun.Sethi@freescale.com>
 <609EA81E-EC64-4539-B36B-E57525CE2492@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D15AAB5@039-SN2MPN1-013.039d.mgd.msft.net>
 <6291E6E2-0AED-4C8E-AD2F-23802204E575@kernel.crashing.org>
In-Reply-To: <6291E6E2-0AED-4C8E-AD2F-23802204E575@kernel.crashing.org>
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
> Sent: Saturday, August 04, 2012 12:55 AM
> To: Sethi Varun-B16395
> Cc: linuxppc-dev@lists.ozlabs.org; Hamciuc Bogdan-BHAMCIU1
> Subject: Re: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt
> support.
>=20
>=20
> On Aug 3, 2012, at 1:52 PM, Sethi Varun-B16395 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Friday, August 03, 2012 6:49 PM
> >> To: Sethi Varun-B16395
> >> Cc: linuxppc-dev@lists.ozlabs.org; Hamciuc Bogdan-BHAMCIU1
> >> Subject: Re: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt
> >> support.
> >>> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> >>> index 7e32db7..2a0b632 100644
> >>> --- a/arch/powerpc/sysdev/mpic.c
> >>> +++ b/arch/powerpc/sysdev/mpic.c
> >>> @@ -1026,6 +1026,9 @@ static int mpic_host_map(struct irq_domain *h,
> >> unsigned int virq,
> >>> 		return 0;
> >>> 	}
> >>>
> >>> +	if (mpic_map_error_int(mpic, virq, hw))
> >>> +		return 0;
> >>> +
> >>> 	if (hw >=3D mpic->num_sources)
> >>> 		return -EINVAL;
> >>>
> >>> @@ -1085,7 +1088,16 @@ static int mpic_host_xlate(struct irq_domain
> >>> *h,
> >> struct device_node *ct,
> >>> 		 */
> >>> 		switch (intspec[2]) {
> >>> 		case 0:
> >>> -		case 1: /* no EISR/EIMR support for now, treat as shared IRQ
> >> */
> >>> +			break;
> >>> +		case 1:
> >>> +			if (!mpic->err_int_config_done)
> >>> +				break;
> >>> +
> >>
> >> Under what case would we call mpic_host_xlate and have not called
> >> mpic_init?
> >>
> > [Sethi Varun-B16395] Never, but we shouldn't translate the error
> > interrupt specifier If mpic_err_int_init failed.
>=20
> Isnt that true of a 1000 other things.  If init failed we shouldn't even
> call map for other reasons.  I don't think we need a special check here.
[Sethi Varun-B16395] There is no specific check to see if mpic_init failed.
In this particular case if we fail to register the error interrupt handler
we cannot use the error sub interrupts.

-Varun

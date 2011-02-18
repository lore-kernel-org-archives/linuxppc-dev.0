Return-Path: <B32579@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05BD8B70ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Feb 2011 21:17:38 +1100 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Fri, 18 Feb 2011 10:17:25 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741252BE@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1298007298-12511-1-git-send-email-prabhakar@freescale.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC57@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC57@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Kalra Ashish-B00888 <B00888@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks David for review comments!!

Please find my reply in-lined

> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Friday, February 18, 2011 2:12 PM
> To: Kushwaha Prabhakar-B32579; linuxppc-dev@lists.ozlabs.org
> Cc: Kalra Ashish-B00888
> Subject: RE: [PATCH] driver/FSL SATA:Fix wrong Device Error Register=20
> usage
>=20
>=20
> > +			if ((ffs(dereg)-1) < ap->nr_pmp_links) {
> > +				/* array start from 0 */
> > +				link =3D &ap->pmp_link[ffs(dereg)-1];
>=20
> I'd only call ffs() once - it could be a slow library function.

This function is called during error handling. So it won't matter.=20
Anyway, I will update the patch for singe usage of ffs().=20

> Any comment should note that ffs() returns 0 when no bits are set -=20
> rather than anything about array indexes.
>=20
sata_fsl_error_intr() is called during device error.
The mentioned scenario will never comes. It can be observed via code:-
	if (cereg) {   --> cereg is set on command error. Means there is at least =
1 device present.
		abort =3D 1;
		---
		---
		---
		/* find out the offending link and qc */
		if (ap->nr_pmp_links) {  --> if Port multiplier=20
			---
			---
			if ((ffs(dereg)-1) < ap->nr_pmp_links) {
		---
		---
		} else {  -->  Single device
			dereg =3D ioread32(hcr_base + DE);
			iowrite32(dereg, hcr_base + DE);
			iowrite32(cereg, hcr_base + CE);

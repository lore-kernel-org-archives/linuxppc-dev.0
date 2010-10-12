Return-Path: <B01044@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2170EB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 04:02:27 +1100 (EST)
Received: from mail47-va3 (localhost.localdomain [127.0.0.1])	by
	mail47-va3-R.bigfish.com (Postfix) with ESMTP id 35FAA187042B	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 12 Oct 2010 17:02:22 +0000 (UTC)
Received: from VA3EHSMHS009.bigfish.com (unknown [10.7.14.239])	by
	mail47-va3.bigfish.com (Postfix) with ESMTP id E07D210055	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 12 Oct 2010 17:02:21 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9CH2Ii2017823	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 10:02:19 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9CH2GZk007926	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 12:02:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] powerpc/fsl: 85xx: add cache-sram support
Date: Tue, 12 Oct 2010 22:32:19 +0530
Message-ID: <72F25CD340E3C147B5A186012F8331E7CB6ECF@zin33exm20.fsl.freescale.net>
In-Reply-To: <04CFEB4E-DFA2-44AB-AD90-859A7D0691A8@kernel.crashing.org>
References: <1286879117-5616-1-git-send-email-harninder.rai@freescale.com>
	<04CFEB4E-DFA2-44AB-AD90-859A7D0691A8@kernel.crashing.org>
From: Rai Harninder-B01044 <B01044@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the design is that we divide the sram portion into 2 equal
parts for AMP
That was the part of initial requirement
Do we want to remove that?


Thanks and Regards
Harry++

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, October 12, 2010 7:40 PM
> To: Rai Harninder-B01044
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/fsl: 85xx: add cache-sram support
>=20
>=20
> On Oct 12, 2010, at 5:25 AM, <harninder.rai@freescale.com>
> <harninder.rai@freescale.com> wrote:
>=20
> >
> > +static int __devinit mpc85xx_l2ctlr_of_probe(struct platform_device
> *dev,
> > +					  const struct of_device_id
*match) {
> > +	long rval;
> > +	unsigned int rem;
> > +	unsigned char ways;
> > +	const unsigned int *prop;
> > +	unsigned int l2cache_size;
> > +	struct device_node *np;
> > +	int i =3D 0;
> > +	bool amp =3D 0;
> > +	struct sram_parameters sram_params;
> > +	static char *compatible_list[] =3D {
> > +					"fsl,MPC85XXRDB-CAMP",
> > +					"fsl,P2020DS-CAMP",
> > +					NULL
> > +				};
> > +
>=20
> Remove this AMP stuff.  We specify the cache-sram-size & cache-sram-
> offset so for the AMP kernels these can be set as needed.
>=20
> - k

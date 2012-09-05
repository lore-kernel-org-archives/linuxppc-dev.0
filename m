Return-Path: <B21989@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 46BD72C0346
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 13:20:11 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, "jgarzik@pobox.com"
 <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on
 freescale V2 controller
Date: Wed, 5 Sep 2012 03:20:04 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079C4915@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6FD6@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6FD6@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Bhartiya Anju-B07263 <B07263@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Tuesday, September 04, 2012 10:51 PM
> To: Xie Shaohui-B21989; jgarzik@pobox.com; linux-ide@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Bhartiya
> Anju-B07263
> Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on
> freescale V2 controller
>=20
> > +	/* Read command completed register */
> > +	done_mask =3D ioread32(hcr_base + CC);
> > +
> > +	if (host_priv->quirks & SATA_FSL_QUIRK_V2_ERRATA) {
> > +		if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> > +			for (tag =3D 0; tag < ATA_MAX_QUEUE; tag++) {
> > +				qc =3D ata_qc_from_tag(ap, tag);
> > +				if (qc && ata_is_atapi(qc->tf.protocol))
> {
> > +					atapi_flag =3D 1;
> > +					break;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	/* Workaround for data length mismatch errata */
> > +	if (atapi_flag) {
>=20
> Seems to me like the conditionals for this code are all in the wrong
> order - adding code to the normal path.
>=20
> The whole lot should probably be inside:
> 	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) { and the
> 'atapi_flag' boolean removed.
[S.H] OK. But I need to move the "done_mask =3D ioread32(hcr_base + CC);" b=
efore these codes,
 because these codes will clean command completed register.

>=20
> I also wonder it this is worthy of an actual quirk?
> Might be worth doing anyway.
[S.H] The quirk is useful for our internal use(there is another errata but =
got fixed by silicon upgrade),
but you are right it's worth doing anyway in upstream, since the upstream c=
ode only handles this errata.

Best Regards,=20
Shaohui Xie

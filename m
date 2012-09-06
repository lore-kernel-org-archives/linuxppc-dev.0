Return-Path: <B21989@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AC222C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 21:57:46 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: RE: [PATCH] [v2] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
Date: Thu, 6 Sep 2012 11:57:37 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079D3C6C@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1346905686-27912-1-git-send-email-Shaohui.Xie@freescale.com>
 <504888F8.5060907@mvista.com>
In-Reply-To: <504888F8.5060907@mvista.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
 Bhartiya Anju-B07263 <B07263@freescale.com>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> >   	hstatus =3D ioread32(hcr_base + HSTATUS);
> >
> >   	sata_fsl_scr_read(&ap->link, SCR_ERROR, &SError);
> >
> > +	/* Read command completed register */
> > +	done_mask =3D ioread32(hcr_base + CC);
> > +
> > +	/* Workaround for data length mismatch errata */
> > +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> > +		for (tag =3D 0; tag < ATA_MAX_QUEUE; tag++) {
> > +			qc =3D ata_qc_from_tag(ap, tag);
> > +			if (qc && ata_is_atapi(qc->tf.protocol)) {
> > +				u32 Hcontrol;
>=20
>     No uppercase in variable names please.=20
[S.H] OK.

Besides, you have 'hstatus'
> variable already and that would be inconsistent.
[S.H] Yes, but I ignored fatal error and device error, so this won't be an =
issue.

>=20
> > +#define HCONTROL_CLEAR_ERROR	(1 << 27)
> > +				/* Set HControl[27] to clear error registers */
> > +				Hcontrol =3D ioread32(hcr_base + HCONTROL);
> > +				iowrite32(Hcontrol | HCONTROL_CLEAR_ERROR,
> > +						hcr_base + HCONTROL);
> > +
> > +				/* Clear HControl[27] */
> > +				iowrite32(Hcontrol & (~HCONTROL_CLEAR_ERROR),
>=20
>     Parens not needed around ~HCONTROL_CLEAR_ERROR.
[S.H] OK.


Best Regards,=20
Shaohui Xie

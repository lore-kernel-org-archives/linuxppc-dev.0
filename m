Return-Path: <B21989@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BC9F2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 12:53:48 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH][v3] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
Date: Mon, 10 Sep 2012 02:53:35 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079D9AB9@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1347012095-4404-1-git-send-email-Shaohui.Xie@freescale.com>
 <82046C25-828E-4E0F-9F86-8E038AE5C93C@kernel.crashing.org>
In-Reply-To: <82046C25-828E-4E0F-9F86-8E038AE5C93C@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Bhartiya Anju-B07263 <B07263@freescale.com>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>,
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

> > +	/* Workaround for data length mismatch errata */
> > +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> > +		for (tag =3D 0; tag < ATA_MAX_QUEUE; tag++) {
> > +			qc =3D ata_qc_from_tag(ap, tag);
> > +			if (qc && ata_is_atapi(qc->tf.protocol)) {
> > +				u32 hcontrol;
> > +#define HCONTROL_CLEAR_ERROR	(1 << 27)
>=20
> shouldn't we have this #define be part of the enum that the other
> HCONTROL_ bits/flags are part of?
[S.H] do you mean this?

#ifdef SATA_FSL_XXX_ERRATUAM
#define HCONTROL_CLEAR_ERROR	(1 << 27)
#endif

Then we need to decide where to put "#define SATA_FSL_XXX_ERRATUAM".

It's only a readable definition of a register bit which avoiding magic numb=
er.


Best Regards,=20
Shaohui Xie

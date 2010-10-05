Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6A823B6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 00:55:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Serial RapidIO Maintaintance read causes lock up
Date: Tue, 5 Oct 2010 06:49:12 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B9AB5@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CAB2729.6080402@freescale.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "John Traill" <john.traill@freescale.com>,
	"Bastiaan Nijkamp" <bastiaan.nijkamp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi John,

John Traill <john.traill@freescale.com> wrote:
> 2. Make sure the target has "Accept All" set - in fsl_rio.c look for
> >        /* Set to receive any dist ID for serial RapidIO controller.
*/
> >         if (port->phy_type =3D=3D RIO_PHY_SERIAL)
> >                 out_be32((priv->regs_win + RIO_ISR_AACR),
RIO_ISR_AACR_AA);
>

Looks like in Bastiaan's case request cannot leave the SRIO controller.
Otherwise he would get a machine check if a response is timed out
(assuming that he did not disable it).

Alex.
=20
=20

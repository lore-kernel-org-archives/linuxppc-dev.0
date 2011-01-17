Return-Path: <B10812@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A9A5B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 22:58:56 +1100 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>, Xu Lei-B33228
	<B33228@freescale.com>
Subject: RE: [PATCH] ATA: Add FSL sata v2 controller support
Date: Mon, 17 Jan 2011 11:58:19 +0000
Message-ID: <45903308677306428B6EE7E6FF5A520408654D@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
	<4D342C6E.6000608@ru.mvista.com>
In-Reply-To: <4D342C6E.6000608@ru.mvista.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"jgarzik@pobox.com" <jgarzik@pobox.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.or=
g
> [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> Sergei Shtylyov
> Sent: Monday, January 17, 2011 5:18 PM
> To: Xu Lei-B33228
> Cc: jgarzik@pobox.com; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> linux-ide@vger.kernel.org
> Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
>=20
> Hello.
>=20
> On 17-01-2011 10:10, Xulei wrote:
>=20
> > In FSL sata v2 block, the snoop bit of PRDT Word3 description
> > information is at bit28 instead of bit22.
>=20
> > This patch adds FSL sata v2 probe and resolve this difference.
>=20
> > Signed-off-by: Xulei <B33228@freescale.com>
>=20
>     AFAIK, full name is required.
>=20
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> [...]
>=20
> > diff --git a/arch/powerpc/boot/dts/p1022ds.dts
> > b/arch/powerpc/boot/dts/p1022ds.dts
> > index 2bbecbb..9ad41dd 100644
> > --- a/arch/powerpc/boot/dts/p1022ds.dts
> > +++ b/arch/powerpc/boot/dts/p1022ds.dts
> > @@ -475,14 +475,14 @@
> >   		};
> >
> >   		sata@18000 {
> > -			compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
> > +			compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";

Can we fix this compatibity at run time by u-boot?

> >   			reg =3D<0x18000 0x1000>;
> >   			cell-index =3D<1>;
> >   			interrupts =3D<74 0x2>;
> >   		};
> >
> >   		sata@19000 {
> > -			compatible =3D "fsl,mpc8536-sata", "fsl,pq-sata";
> > +			compatible =3D "fsl,p1022-sata", "fsl,pq-sata-v2";
> >   			reg =3D<0x19000 0x1000>;
> >   			cell-index =3D<2>;
> >   			interrupts =3D<41 0x2>;
>=20
>     Please put this into the separate patch and push thru the PPC tree.
>=20
> > diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> > b0214d0..a56399a 100644
> > --- a/drivers/ata/sata_fsl.c
> > +++ b/drivers/ata/sata_fsl.c
> [...]
> > @@ -417,7 +420,8 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd
> > *qc)
> >
> >   	if (qc->flags&  ATA_QCFLAG_DMAMAP)
> >   		num_prde =3D sata_fsl_fill_sg(qc, (void *)cd,
> > -					&ttl_dwords, cd_paddr);
> > +					&ttl_dwords, cd_paddr,
> > +					    host_priv->data_snoop);
>=20
>     Please align these lines uniformly.
>=20
> WBR, Sergei
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

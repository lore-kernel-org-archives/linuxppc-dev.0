Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C63AE2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 10:12:06 +1100 (EST)
Date: Mon, 5 Nov 2012 17:11:15 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4 v4] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
To: Timur Tabi <timur@freescale.com>
References: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
 <1352114361-25192-2-git-send-email-Varun.Sethi@freescale.com>
 <1352114361-25192-3-git-send-email-Varun.Sethi@freescale.com>
 <1352114361-25192-4-git-send-email-Varun.Sethi@freescale.com>
 <509845ED.2060904@freescale.com>
In-Reply-To: <509845ED.2060904@freescale.com> (from timur@freescale.com on
 Mon Nov  5 17:04:13 2012)
Message-ID: <1352157075.28279.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Varun Sethi <Varun.Sethi@freescale.com>, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 joerg.roedel@amd.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2012 05:04:13 PM, Timur Tabi wrote:
> Varun Sethi wrote:
> > +	/* PAACE Offset 0x00 */
> > +	u32 wbah;				/* only valid for =20
> Primary PAACE */
> > +	u32 addr_bitfields;		/* See P/S PAACE_AF_* */
> > +
> > +	/* PAACE Offset 0x08 */
> > +	/* Interpretation of first 32 bits dependent on DD above */
> > +	union {
> > +		struct {
> > +			/* Destination ID, see PAACE_DID_* defines */
> > +			u8 did;
> > +			/* Partition ID */
> > +			u8 pid;
> > +			/* Snoop ID */
> > +			u8 snpid;
> > +			/* coherency_required : 1 reserved : 7 */
>=20
> Please use this format, which is easier to read:
>=20
> 			/* 1 =3D=3D coherency required, 7 =3D=3D reserved */
>=20
> Every time I look at this comment, I think you are using bitfields.

It is meant as a pseudo-bitfield.  "7 =3D=3D reserved" doesn't make much =20
sense -- that would leave a lot of other values neither defined nor =20
explicitly reserved.

That said, the "See PAACE_DA_*" comment should be sufficient and avoids =20
making people have to care about what bitfield ordering the comment =20
writer was assuming.

-Scott=

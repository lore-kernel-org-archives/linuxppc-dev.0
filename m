Return-Path: <B43644@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AF8B2C00A6
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 18:02:18 +1000 (EST)
Received: from mail141-db8 (localhost [127.0.0.1])	by
 mail141-db8-R.bigfish.com (Postfix) with ESMTP id 5BD563202A8	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 08:02:14 +0000 (UTC)
Received: from DB8EHSMHS024.bigfish.com (unknown [10.174.8.243])	by
 mail141-db8.bigfish.com (Postfix) with ESMTP id 5DF42180048	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 08:01:22 +0000 (UTC)
From: Liu Po-B43644 <B43644@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [1/4] powerpc/85xx: Add SEC6.0 device tree
Date: Tue, 23 Jul 2013 08:01:17 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E609DAD274@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
 <20130722224110.GA26221@home.buserror.net>
In-Reply-To: <20130722224110.GA26221@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  -----Original Message-----
>  From: Wood Scott-B07421
>  Sent: Tuesday, July 23, 2013 6:41 AM
>  To: Liu Po-B43644
>  Cc: linuxppc-dev@ozlabs.org; Hu Mingkai-B21284
>  Subject: Re: [1/4] powerpc/85xx: Add SEC6.0 device tree
> =20
>  On Thu, Apr 25, 2013 at 09:54:14AM +0800, Po Liu wrote:
>  > From: Mingkai Hu <Mingkai.Hu@freescale.com>
>  >
>  > Add device tree for SEC 6.0 used on C29x silicon.
>  >
>  > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
>  > Singed-off-by: Po Liu <Po.Liu@freescale.com>
> =20
>  I've heard of patches being flamed, but here we want signing, not
>  singeing. :-)
> =20
>  Don't forget that you can use the -s option to have git add the signoff
>  for you.
> =20
>  > ---
>  > Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git
> =20
>  This URL is not accessible outside Freescale, so don't reference it when
>  posting patches publicly.
> =20
>  If your patch is against the latest upstream code, you don't need to say
>  anything special about that.  You only need to make a note when it's
>  against some other yet-to-be-merged tree or patch.
> =20
>  > +	compatible =3D "fsl,sec-v6.0", "fsl,sec-v5.2",
>  > +		     "fsl,sec-v5.0", "fsl,sec-v4.4",
>  > +		     "fsl,sec-v4.0";
>  > +	fsl,sec-era =3D <6>;
>  > +	#address-cells =3D <1>;
>  > +	#size-cells =3D <1>;
>  > +
>  > +	jr@1000 {
>  > +		compatible =3D "fsl,sec-v6.0-job-ring",
>  > +			     "fsl,sec-v5.2-job-ring",
>  > +			     "fsl,sec-v5.0-job-ring",
>  > +			     "fsl,sec-v4.4-job-ring",
>  > +			     "fsl,sec-v4.0-job-ring";
>  > +		reg	   =3D <0x1000 0x1000>;
>  > +	};
>  > +
>  > +	jr@2000 {
>  > +		compatible =3D "fsl,sec-v6.0-job-ring",
>  > +			     "fsl,sec-v5.2-job-ring",
>  > +			     "fsl,sec-v5.0-job-ring",
>  > +			     "fsl,sec-v4.4-job-ring",
>  > +			     "fsl,sec-v4.0-job-ring";
>  > +		reg	   =3D <0x2000 0x1000>;
>  > +	};
> =20
>  You claim compatibility with a bunch of prior SECs, but sec-v5.2 has fou=
r
>  job rings and an rtic node.  Likewise for the previous compatibles liste=
d.
>  This has two job rings and no rtic.
So, shall I remove "fsl,sec-v5.2","fsl,sec-v5.0", "fsl,sec-v4.4", "fsl,sec-=
v4.0" since all other SEC with 4 job rings? and only leave "fsl,sec-v6.0"?
> =20
>  Can you point to where in the SEC v4.0 binding (I don't see a binding fo=
r
>  the subsequent versions), it says that these are optional?
I found SEC V4.0 in file qoriq-sec4.0-0.dtsi. If "fsl,sec-v4.0" not in the =
compatible list, it is no use in this compatible list. But seems keep the "=
fsl,sec-v4.0-job-ring" job ring compatible is ok. Is that what you were ask=
?
> =20
>  -Scott

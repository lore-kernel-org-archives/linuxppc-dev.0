Return-Path: <leoyang.li@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40045.outbound.protection.outlook.com [40.107.4.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxsKd1gB9zDr2Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 02:47:32 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: David Laight <David.Laight@ACULAB.COM>, 'Karim Eshapa'
 <karim.eshapa@gmail.com>, "oss@buserror.net" <oss@buserror.net>
CC: Roy Pledge <roy.pledge@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc/qman: Sleep instead of stuck hacking jiffies.
Date: Tue, 27 Jun 2017 16:47:25 +0000
Message-ID: <AM4PR0401MB1699119BCAAB631C16D86C2D8FDC0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1498403622-2878-1-git-send-email-karim.eshapa@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD002B1A5@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD002B1A5@AcuExch.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+leoli=3Dfreescale.com@lists.ozlabs.org] On Behalf Of David Laight
> Sent: Monday, June 26, 2017 10:55 AM
> To: 'Karim Eshapa' <karim.eshapa@gmail.com>; oss@buserror.net
> Cc: Roy Pledge <roy.pledge@nxp.com>; linux-kernel@vger.kernel.org;
> Claudiu Manoil <claudiu.manoil@nxp.com>; colin.king@canonical.com;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH] soc/qman: Sleep instead of stuck hacking jiffies.
>=20
> From: Karim Eshapa
> > Sent: 25 June 2017 16:14
> > Use msleep() instead of stucking with
> > long delay will be more efficient.
> ...
> > --- a/drivers/soc/fsl/qbman/qman.c
> > +++ b/drivers/soc/fsl/qbman/qman.c
> > @@ -1084,11 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
> >  		 * entries well before the ring has been fully consumed, so
> >  		 * we're being *really* paranoid here.
> >  		 */
> > -		u64 now, then =3D jiffies;
> > -
> > -		do {
> > -			now =3D jiffies;
> > -		} while ((then + 10000) > now);
> > +		msleep(1);
> ...
> How is that in any way equivalent?
> If HZ is 1000 the old code loops for 10 seconds.
> If HZ is 250 (common for some distros) it loops for 40 seconds.
>=20
> Clearly both are horrid, but it isn't at all clear that a 1ms sleep is pe=
rforming
> the same job.
>=20
> My guess is that this code is never called, and broken if actually called=
.

It was indeed broken.  The intent was to wait for 10000 cycles but mistaken=
ly coded as 10000 jiffies.  I think we choose 1ms as it is not too long and=
 almost guarantees the 10000 cycles delay.

Regards,
Leo

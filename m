Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxDC25wzszDr24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 01:54:38 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Karim Eshapa' <karim.eshapa@gmail.com>, "oss@buserror.net"
 <oss@buserror.net>
CC: "roy.pledge@nxp.com" <roy.pledge@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "claudiu.manoil@nxp.com"
 <claudiu.manoil@nxp.com>, "colin.king@canonical.com"
 <colin.king@canonical.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc/qman: Sleep instead of stuck hacking jiffies.
Date: Mon, 26 Jun 2017 15:54:30 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD002B1A5@AcuExch.aculab.com>
References: <1498403622-2878-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <1498403622-2878-1-git-send-email-karim.eshapa@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Karim Eshapa
> Sent: 25 June 2017 16:14
> Use msleep() instead of stucking with
> long delay will be more efficient.
...
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1084,11 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
>  		 * entries well before the ring has been fully consumed, so
>  		 * we're being *really* paranoid here.
>  		 */
> -		u64 now, then =3D jiffies;
> -
> -		do {
> -			now =3D jiffies;
> -		} while ((then + 10000) > now);
> +		msleep(1);
...
How is that in any way equivalent?
If HZ is 1000 the old code loops for 10 seconds.
If HZ is 250 (common for some distros) it loops for 40 seconds.

Clearly both are horrid, but it isn't at all clear that a 1ms sleep
is performing the same job.

My guess is that this code is never called, and broken if actually called.

	David

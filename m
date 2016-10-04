Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spMDx3t0qzDrFn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 01:46:40 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: "'madalin.bucur@nxp.com'" <madalin.bucur@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linuxdev.baldrick@gmail.com" <linuxdev.baldrick@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [net-next 08/13] fsl/fman: check pcsphy pointer before use
Date: Tue, 4 Oct 2016 14:44:12 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB01E2ED3@AcuExch.aculab.com>
References: <1475566379-5078-1-git-send-email-madalin.bucur@nxp.com>
 <1475566379-5078-9-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1475566379-5078-9-git-send-email-madalin.bucur@nxp.com>
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

From: Madalin Bucur
> Sent: 04 October 2016 08:33
> Subject: [net-next 08/13] fsl/fman: check pcsphy pointer before use
..
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -507,6 +507,9 @@ static void setup_sgmii_internal_phy(struct fman_mac =
*memac,
>  {
>  	u16 tmp_reg16;
>=20
> +	if (WARN_ON(!memac->pcsphy))
> +		return;
> +

Why?

Either it can validly be NULL in which case you don't want the message.
Or it shouldn't be NULL in which case you need to find and fix the bug.
The later kernel OOPS will make the bug much easier to find.

	David

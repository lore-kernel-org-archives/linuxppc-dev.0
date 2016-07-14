Return-Path: <wharms@bfs.de>
Received: from mx01-fr.bfs.de (mx01-fr.bfs.de [193.174.231.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqt5700WmzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 20:59:54 +1000 (AEST)
Message-ID: <57876EE0.10603@bfs.de>
Date: Thu, 14 Jul 2016 12:52:16 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Zhao Qiang <qiang.zhao@nxp.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch -next] wan/fsl_ucc_hdlc: info leak in uhdlc_ioctl()
References: <20160714103415.GE18175@mwanda>
In-Reply-To: <20160714103415.GE18175@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 14.07.2016 12:34, schrieb Dan Carpenter:
> There is a 2 byte struct whole after line.loopback so we need to clear
> that out to avoid disclosing stack information.
> 
> Fixes: c19b6d246a35 ('drivers/net: support hdlc function for QE-UCC')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 19174ac..7608561 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -635,6 +635,7 @@ static int uhdlc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  			ifr->ifr_settings.size = size; /* data size wanted */
>  			return -ENOBUFS;
>  		}
> +		memset(&line, 0, sizeof(line));
>  		line.clock_type = priv->clocking;
>  		line.clock_rate = 0;
>  		line.loopback = 0;


In this case
  		line.clock_rate = 0;
 		line.loopback = 0;

are not need any more and can be removed
except like them to have for documentation or so.

re,
 wh

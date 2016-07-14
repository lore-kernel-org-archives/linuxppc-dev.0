Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqtzb1939zDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:40:10 +1000 (AEST)
Message-ID: <1468496402.20552.107.camel@kernel.crashing.org>
Subject: Re: [patch] ide: missing break statement in set_timings_mdma()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, "David S. Miller"
 <davem@davemloft.net>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Date: Thu, 14 Jul 2016 06:40:02 -0500
In-Reply-To: <20160714104802.GI18175@mwanda>
References: <20160714104802.GI18175@mwanda>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-14 at 13:48 +0300, Dan Carpenter wrote:
> There was clearly supposed to be a break statement here.  Currently we
> use the k2 ata timings instead of sh ata ones we intended.  Probably no
> one has this hardware anymore so it likely doesn't make a difference
> beyond the static checker warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Should probably also:

CC: stable@vger.kernel.org

> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index 7f0434f..0c5d3a9 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -707,6 +707,7 @@ set_timings_mdma(ide_drive_t *drive, int intf_type, u32 *timings, u32 *timings2,
>  		*timings = ((*timings) & ~TR_133_PIOREG_MDMA_MASK) | tr;
>  		*timings2 = (*timings2) & ~TR_133_UDMAREG_UDMA_EN;
>  		}
> +		break;
>  	case controller_un_ata6:
>  	case controller_k2_ata6: {
>  		/* 100Mhz cell */

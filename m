Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422TTQ3vDKzF39j
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 18:11:36 +1000 (AEST)
Subject: Re: [PATCH v2 2/6] net/wan/fsl_ucc_hdlc: allow PARITY_CRC16_PR0_CCITT
 parity
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
 <20180829131328.27901-3-david.gounaris@infinera.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <a12f2ec8-77af-6474-d5c9-86ef545f7f8e@c-s.fr>
Date: Sat, 1 Sep 2018 10:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180829131328.27901-3-david.gounaris@infinera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/08/2018 à 15:13, David Gounaris a écrit :
> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 5cf6dcba039c..c8e526bf1130 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -781,7 +781,8 @@ static int ucc_hdlc_attach(struct net_device *dev, unsigned short encoding,
>   
>   	if (parity != PARITY_NONE &&
>   	    parity != PARITY_CRC32_PR1_CCITT &&
> -	    parity != PARITY_CRC16_PR1_CCITT)
> +	    parity != PARITY_CRC16_PR1_CCITT &&
> +	    parity != PARITY_CRC16_PR0_CCITT)

ERROR:TRAILING_WHITESPACE: trailing whitespace
#20: FILE: drivers/net/wan/fsl_ucc_hdlc.c:783:
+^I    parity != PARITY_CRC16_PR1_CCITT && $

Also, you could have left the line 'parity != PARITY_CRC16_PR1_CCITT)' 
as is and just have added 'parity != PARITY_CRC16_PR0_CCITT &&' on the 
previous line, would make more sense to have PR0 before PR1, and instead 
of having 2+1- you would only have 1+

>   		return -EINVAL;
>   
>   	priv->encoding = encoding;
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

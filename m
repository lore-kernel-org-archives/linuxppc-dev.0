Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422TTQ3l92zF39h
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 18:11:36 +1000 (AEST)
Subject: Re: [PATCH v2 1/6] net/wan/fsl_ucc_hdlc: allow ucc index up to 7
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
 <20180829131328.27901-2-david.gounaris@infinera.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <dc81ab3d-221a-ec1a-67cb-39506c168175@c-s.fr>
Date: Sat, 1 Sep 2018 09:58:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180829131328.27901-2-david.gounaris@infinera.com>
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
> There is a need to allow higher indexes to be
> able to support MPC83xx platforms. (UCC1-UCC8)
> 
> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 33df76405b86..5cf6dcba039c 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1016,7 +1016,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
>   	}
>   
>   	ucc_num = val - 1;
> -	if ((ucc_num > 3) || (ucc_num < 0)) {
> +	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0)) {

CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'ucc_num < 0'
#23: FILE: drivers/net/wan/fsl_ucc_hdlc.c:1018:
+	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0)) {


>   		dev_err(&pdev->dev, ": Invalid UCC num\n");
>   		return -EINVAL;
>   	}
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422TTQ41FXzF39k
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 18:11:38 +1000 (AEST)
Subject: Re: [PATCH v2 5/6] net/wan/fsl_ucc_hdlc: GUMR for non tsa mode
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
 <20180829131328.27901-6-david.gounaris@infinera.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <68e2270c-3b61-7721-4200-00bca9815eb0@c-s.fr>
Date: Sat, 1 Sep 2018 10:08:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180829131328.27901-6-david.gounaris@infinera.com>
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
> The following bits in the GUMR is changed for non
> tsa mode: CDS, CTSP and CTSS are set to zero.
> 
> When set, there is no tx interrupts from the controller.
> 
> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index be5b0096af3b..248f1f5bcd04 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -97,6 +97,13 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
>   	if (priv->tsa) {
>   		uf_info->tsa = 1;
>   		uf_info->ctsp = 1;
> +		uf_info->cds = 1;
> +		uf_info->ctss = 1;
> +	}
> +	else {

ERROR:ELSE_AFTER_BRACE: else should follow close brace '}'
#27: FILE: drivers/net/wan/fsl_ucc_hdlc.c:103:
+	}
+	else {

CHECK:BRACES: Unbalanced braces around else statement
#27: FILE: drivers/net/wan/fsl_ucc_hdlc.c:103:
+	else {

Should be:

} else {

> +		uf_info->cds = 0;
> +		uf_info->ctsp = 0;
> +		uf_info->ctss = 0;
>   	}
>   
>   	/* This sets HPM register in CMXUCR register which configures a
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

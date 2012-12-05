Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33A122C018B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2012 10:51:39 +1100 (EST)
Received: by mail-wg0-f47.google.com with SMTP id dq11so3338597wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2012 15:51:36 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH -next] powerpc/85xx: use for_each_compatible_node() macro
To: Wei Yongjun <weiyj.lk@gmail.com>, galak@kernel.crashing.org,
 benh@kernel.crashing.org, paulus@samba.org, rob.herring@calxeda.com
In-Reply-To: <CAPgLHd_esknTwVv4EeehwSJz6ee5eFJ+zf6xntH-vaNwdxkrvg@mail.gmail.com>
References: <CAPgLHd_esknTwVv4EeehwSJz6ee5eFJ+zf6xntH-vaNwdxkrvg@mail.gmail.com>
Date: Wed, 05 Dec 2012 23:51:27 +0000
Message-Id: <20121205235127.DB25F3E0E22@localhost>
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 3 Dec 2012 08:36:03 -0500, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Use for_each_compatible_node() macro instead of open coding it.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index bd12588..a7b3621 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -206,9 +206,7 @@ static void __init mpc85xx_mds_reset_ucc_phys(void)
>  		setbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
>  		clrbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
>  
> -		for (np = NULL; (np = of_find_compatible_node(np,
> -						"network",
> -						"ucc_geth")) != NULL;) {
> +		for_each_compatible_node(np, "network", "ucc_geth") {
>  			const unsigned int *prop;
>  			int ucc_num;
>  
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

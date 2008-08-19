Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DA99DE906
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 23:02:10 +1000 (EST)
Date: Tue, 19 Aug 2008 22:02:00 +0900 (JST)
Message-Id: <20080819.220200.-1300539182.kouish@swc.toshiba.co.jp>
To: roel.kluin@gmail.com
Subject: Re: [PATCH] powerpc, scc: duplicate SCC_UHC_USBCEN
In-Reply-To: <48A9F256.2000901@gmail.com>
From: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Roel,

> untested, is it correct?

Your patch is correct.

Thanks for your pointing it out and sending the patch. I tested your
patch and it works good.

Fortunately, this bug is not fatal because it seems that the SCC-UHC
sets SCC_UHC_USBEN and SCC_UHC_USBCEN at once.


Your patch does not contain 'Signed-off-by' line. Could you re-post it
with your sign?


> ---
> arch/powerpc/platforms/cell/celleb_scc.h:224:
> #define SCC_UHC_USBEN           0x00010000
> #define SCC_UHC_USBCEN          0x00020000
> 
> ---
> diff --git a/arch/powerpc/platforms/cell/celleb_scc_uhc.c b/arch/powerpc/platforms/cell/celleb_scc_uhc.c
> index d63b720..b086f33 100644
> --- a/arch/powerpc/platforms/cell/celleb_scc_uhc.c
> +++ b/arch/powerpc/platforms/cell/celleb_scc_uhc.c
> @@ -31,7 +31,7 @@
>  
>  static inline int uhc_clkctrl_ready(u32 val)
>  {
> -	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
> +	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBEN;
>  	return((val & mask) == mask);
>  }
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Best regards,
Kou Ishizaki

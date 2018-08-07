Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lS1s3ykyzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 07:14:09 +1000 (AEST)
Message-ID: <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org,
 mark.rutland@arm.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org,  devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Cc: robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
 joe@perches.com
Date: Tue, 07 Aug 2018 16:13:58 -0500
In-Reply-To: <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-27 at 15:18 +0530, Bharat Bhushan wrote:
> MPIC on NXP (Freescale) P2020 supports following irq
> ranges:
>   > 0 - 11      (External interrupt)
>   > 16 - 79     (Internal interrupt)
>   > 176 - 183   (Messaging interrupt)
>   > 224 - 231   (Shared message signaled interrupt)

Why don't you convert to the 4-cell interrupt specifiers that make dealing
with these ranges less error-prone?

> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> index 1006950..49ff348 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -57,6 +57,11 @@ void __init mpc85xx_rdb_pic_init(void)
>  			MPIC_BIG_ENDIAN |
>  			MPIC_SINGLE_DEST_CPU,
>  			0, 256, " OpenPIC  ");
> +	} else if (of_machine_is_compatible("fsl,P2020RDB-PC")) {
> +		mpic = mpic_alloc(NULL, 0,
> +		  MPIC_BIG_ENDIAN |
> +		  MPIC_SINGLE_DEST_CPU,
> +		  0, 0, " OpenPIC  ");
>  	} else {
>  		mpic = mpic_alloc(NULL, 0,
>  		  MPIC_BIG_ENDIAN |

I don't think we want to grow a list of every single revision of every board
in these platform files.

-Scott

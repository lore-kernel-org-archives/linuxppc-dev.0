Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 503351A0729
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 04:55:21 +1100 (AEDT)
Message-ID: <1427824493.22867.226.camel@freescale.com>
Subject: Re: [PATCH] powerpc/83xx: add support for mpc8306
From: Scott Wood <scottwood@freescale.com>
To: Filip Brozovic <fbrozovic@gmail.com>
Date: Tue, 31 Mar 2015 12:54:53 -0500
In-Reply-To: <1427561968-32049-1-git-send-email-fbrozovic@gmail.com>
References: <1427561968-32049-1-git-send-email-fbrozovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-03-28 at 17:59 +0100, Filip Brozovic wrote:
> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
> index c2518cd..f967ff6 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -278,12 +278,17 @@ static void qe_snums_init(void)
>  		0xF4, 0xF5, 0xFC, 0xFD,
>  	};
>  	static const u8 snum_init_46[] = {
> +#if !defined(CONFIG_QE_8306)
>  		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
> -		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
> -		0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9, 0xC8, 0xC9,
> -		0xD8, 0xD9, 0xE8, 0xE9, 0x08, 0x09, 0x18, 0x19,
> -		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
> -		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
> +		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35,
> +#endif
> +		0x88, 0x89, 0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9,
> +		0xC8, 0xC9, 0xD8, 0xD9, 0xE8, 0xE9,
> +#if !defined(CONFIG_QE_8306)
> +		0x08, 0x09, 0x18, 0x19, 0x28, 0x29, 0x38, 0x39,
> +		0x48, 0x49, 0x58, 0x59, 0x68, 0x69, 0x78, 0x79,
> +		0x80, 0x81,
> +#endif
>  	};
>  	static const u8 *snum_init;

This breaks multiplatform support.  You need to determine this at
runtime.

-Scott

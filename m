Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D99721007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 10:51:14 +1100 (EST)
Message-ID: <4ED812E4.60905@freescale.com>
Date: Thu, 1 Dec 2011 17:51:00 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2011 05:47 PM, Paul Gortmaker wrote:
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 8c660af..b0f4042 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -18,6 +18,11 @@
>  #define UART_BUG_TXEN	(1 << 1)	/* buggy TX IIR status */
>  #define UART_BUG_NOMSR	(1 << 2)	/* buggy MSR status bits (Au1x00) */
>  #define UART_BUG_THRE	(1 << 3)	/* buggy THRE reassertion */
> +#ifdef CONFIG_PPC32
> +#define UART_BUG_FSLBK	(1 << 4)	/* buggy FSL break IRQ storm */
> +#else	/* help GCC optimize away IRQ handler errata code for ARCH != PPC32 */
> +#define UART_BUG_FSLBK	0
> +#endif

I believe this bug still exists on our 64-bit chips.

-Scott

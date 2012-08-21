Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F28B02C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 12:31:10 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing USB
 PHY clock
Date: Tue, 21 Aug 2012 02:31:01 +0000
Message-ID: <CAOZdJXXFAjCeKMwL1n=7a3+HBrHX+gq+fE0b5MaH8uYzbHuZzw@mail.gmail.com>
References: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1344595712-12804-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1344595712-12804-2-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 10, 2012 at 5:48 AM, Shengzhou Liu
<Shengzhou.Liu@freescale.com> wrote:

> +               for (timeout =3D 1000; timeout > 0; timeout--) {
> +                       /* check PHY_CLK_VALID to get phy clk valid */
> +                       if (in_be32(non_ehci + FSL_SOC_USB_CTRL)
> +                                       & PHY_CLK_VALID)
> +                               break;
> +                       udelay(1);
> +               }

Use spin_event_timeout() instead.

--=20
Timur Tabi
Linux kernel developer at Freescale=

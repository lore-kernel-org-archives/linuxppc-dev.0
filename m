Return-Path: <dedekind1@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CFBE31007DA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 08:04:30 +1100 (EST)
Received: by ggnq2 with SMTP id q2so711221ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 13:04:27 -0800 (PST)
Subject: Re: [PATCH v3 3/3] mtd/nand : workaround for Freescale FCM to
 support large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Tue, 22 Nov 2011 23:04:18 +0200
In-Reply-To: <1321349355-1639-3-git-send-email-b35362@freescale.com>
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
 <1321349355-1639-2-git-send-email-b35362@freescale.com>
 <1321349355-1639-3-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321995862.2222.2.camel@koala>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Liu Shuo <Shuo.Liu@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>, linux-mtd@lists.infradead.org,
 scottwood@freescale.com, akpm@linux-foundation.org, dwmw2@infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-15 at 17:29 +0800, b35362@freescale.com wrote:
> +               /*
> +                * Freescale FCM controller has a 2K size limitation of buffer
> +                * RAM, so elbc_fcm_ctrl->buffer have to be used if writesize
> +                * of chip is greater than 2048.
> +                * We malloc a large enough buffer at this point, because we
> +                * don't know writesize before calling nand_scan(). We will
> +                * re-malloc later if needed.
> +                */
> +               elbc_fcm_ctrl->buffer = kmalloc(4096 * 6, GFP_KERNEL);
> +               if (!elbc_fcm_ctrl->buffer)
> +                       return -ENOMEM; 

Why 4096*6? Judging from the comment it should be 4096.

Artem.

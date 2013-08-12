Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com
 [IPv6:2a00:1450:400c:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1DE32C0103
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 23:38:26 +1000 (EST)
Received: by mail-wg0-f52.google.com with SMTP id b13so5463824wgh.19
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 06:38:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1373803321-11628-2-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
 <1373803321-11628-2-git-send-email-gsi@denx.de>
Date: Mon, 12 Aug 2013 17:38:21 +0400
Message-ID: <CAF0T0X4f9RCjY-tyw9z+X_n7qRxXacKf7FOzT-U_rH0WtLOUHw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/5] dma: mpc512x: re-order mpc8308 specific
 instructions
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone!

2013/7/14 Gerhard Sittig <gsi@denx.de>:
> @@ -50,9 +50,23 @@
>  #define MPC_DMA_DESCRIPTORS    64
>
>  /* Macro definitions */
> -#define MPC_DMA_CHANNELS       64
>  #define MPC_DMA_TCD_OFFSET     0x1000
>
> +/*
> + * the maximum channel count, and specific channels which need
> + * special processing, for individual hardware variants
> + *
> + * and the maximum channel count over all supported controllers,
> + * used for data structure sizes
> + */
> +enum mpc8308_dmachan_id_t {
> +       MPC8308_DMACHAN_MAX = 16,
> +};
> +enum mpc512x_dmachan_id_t {
> +       MPC512x_DMACHAN_MAX = 64,
> +};
> +#define MPC_DMA_CHANNELS       64
> +

I offer to use #define instead of enum here
since individual channels don't require special handling.

Best regards,
Alexander.

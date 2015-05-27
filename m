Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0113.outbound.protection.outlook.com [207.46.100.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC15B1A0D51
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 08:51:30 +1000 (AEST)
Message-ID: <1432767074.4089.51.camel@freescale.com>
Subject: Re: [PATCH 1/2] qe_common: add qe common functions into qe_common.c
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>,
 <R63061@freescale.com>
Date: Wed, 27 May 2015 17:51:14 -0500
In-Reply-To: <1432717920-43563-1-git-send-email-B45475@freescale.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-27 at 17:11 +0800, Zhao Qiang wrote:
> +int qe_muram_init(void)
> +{
> +     struct device_node *np;
> +     struct resource r;
> +     u32 zero[OF_MAX_ADDR_CELLS] = {};
> +     resource_size_t max = 0;
> +     int i = 0;
> +     int ret = 0;
> +
> +     if (muram_pbase)
> +             return 0;
> +
> +     spin_lock_init(&qe_muram_lock);
> +     /* initialize the info header */
> +     rh_init(&qe_muram_info, 1,
> +             sizeof(qe_boot_muram_rh_block) /
> +             sizeof(qe_boot_muram_rh_block[0]),
> +             qe_boot_muram_rh_block);

NACK (see patch 2/2), and even if rheap were acceptable that would 
have needed to come before patches using it outside arch/powerpc.

-Scott

Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0127.outbound.protection.outlook.com [207.46.100.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAE621A1E13
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 10:34:39 +1000 (AEST)
Message-ID: <1441154062.4966.113.camel@freescale.com>
Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Date: Tue, 1 Sep 2015 19:34:22 -0500
In-Reply-To: <1441011520-15424-2-git-send-email-qiang.zhao@freescale.com>
References: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
 <1441011520-15424-2-git-send-email-qiang.zhao@freescale.com>
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

On Mon, 2015-08-31 at 16:58 +0800, Zhao Qiang wrote:

> @@ -187,12 +190,25 @@ static inline int qe_alive_during_sleep(void)
>  }
>  
>  /* we actually use cpm_muram implementation, define this for convenience */
> -#define qe_muram_init cpm_muram_init
> -#define qe_muram_alloc cpm_muram_alloc
> -#define qe_muram_alloc_fixed cpm_muram_alloc_fixed
> -#define qe_muram_free cpm_muram_free
> -#define qe_muram_addr cpm_muram_addr
> -#define qe_muram_offset cpm_muram_offset
> +#define cpm_muram_init qe_muram_init
> +#define cpm_muram_alloc qe_muram_alloc
> +#define cpm_muram_alloc_fixed qe_muram_alloc_fixed
> +#define cpm_muram_free qe_muram_free
> +#define cpm_muram_addr qe_muram_addr
> +#define cpm_muram_offset qe_muram_offset

Why?  This is unnecessary churn.


> @@ -266,6 +282,27 @@ struct qe_bd {
>  #define BD_STATUS_MASK       0xffff0000
>  #define BD_LENGTH_MASK       0x0000ffff
>  
> +/* Buffer descriptor control/status used by serial
> + */
> +
> +#define BD_SC_READY  (0x8000)        /* Transmit is ready */
> +#define BD_SC_WRAP   (0x2000)        /* Last buffer descriptor */
> +#define BD_SC_INTRPT (0x1000)        /* Interrupt on change */
> +#define BD_SC_LAST   (0x0800)        /* Last buffer in frame */
> +#define BD_SC_TC     (0x0400)        /* Transmit CRC */
> +#define BD_SC_CM     (0x0200)        /* Continuous mode */
> +#define BD_SC_ID     (0x0100)        /* Rec'd too many idles */
> +#define BD_SC_P              (0x0100)        /* xmt preamble */
> +#define BD_SC_BR     (0x0020)        /* Break received */
> +#define BD_SC_FR     (0x0010)        /* Framing error */
> +#define BD_SC_PR     (0x0008)        /* Parity error */
> +#define BD_SC_NAK    (0x0004)        /* NAK - did not respond */
> +#define BD_SC_OV     (0x0002)        /* Overrun */
> +#define BD_SC_UN     (0x0002)        /* Underrun */
> +#define BD_SC_CD     (0x0001)        /* */
> +#define BD_SC_CL     (0x0001)        /* Collision */
> +

Why is this being copied rather than moved?


>  
> -int cpm_muram_init(void)
> -{
> -     struct device_node *np;
> -     struct resource r;
> -     u32 zero[OF_MAX_ADDR_CELLS] = {};
> -     resource_size_t max = 0;
> -     int i = 0;
> -     int ret = 0;
> -
> -     if (muram_pbase)
> -             return 0;
> -
> -     spin_lock_init(&cpm_muram_lock);
> -     /* initialize the info header */
> -     rh_init(&cpm_muram_info, 1,
> -             sizeof(cpm_boot_muram_rh_block) /
> -             sizeof(cpm_boot_muram_rh_block[0]),
> -             cpm_boot_muram_rh_block);
> -
> -     np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
> -     if (!np) {
> -             /* try legacy bindings */
> -             np = of_find_node_by_name(NULL, "data-only");
> -             if (!np) {
> -                     printk(KERN_ERR "Cannot find CPM muram data node");
> -                     ret = -ENODEV;
> -                     goto out;
> -             }
> -     }
> -
> -     muram_pbase = of_translate_address(np, zero);
> -     if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
> -             printk(KERN_ERR "Cannot translate zero through CPM muram node");
> -             ret = -ENODEV;
> -             goto out;
> -     }

Did you pass -M -C to git format-patch?

-Scott

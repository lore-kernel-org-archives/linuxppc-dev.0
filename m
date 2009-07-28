Return-Path: <sshtylyov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 620F5B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 23:23:18 +1000 (EST)
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B9C7ADDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 23:23:17 +1000 (EST)
Message-ID: <4A6EFBED.2020204@ru.mvista.com>
Date: Tue, 28 Jul 2009 17:23:57 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: ashish kalra <ashish.kalra@freescale.com>
Subject: Re: [RESEND][PATCH] sata_fsl: hard and soft reset split
References: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
In-Reply-To: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

ashish kalra wrote:

> Split sata_fsl_softreset() into hard and soft resets to make
> error-handling more efficient & device and PMP detection more reliable.

> Also includes fix for PMP support, driver tested with Sil3726, Sil4726 &
> Exar PMP controllers.

> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>

[...]

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 5751145..c8e2fad 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -708,34 +708,17 @@ static unsigned int sata_fsl_dev_classify(struct 
> ata_port *ap)
>      return ata_dev_classify(&tf);
>  }
> 
> -static int sata_fsl_prereset(struct ata_link *link, unsigned long 
> deadline)
> -{
> -    /* FIXME: Never skip softreset, sata_fsl_softreset() is
> -     * combination of soft and hard resets.  sata_fsl_softreset()
> -     * needs to be splitted into soft and hard resets.
> -     */
> -    return 0;
> -}
> -
> -static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
> +static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>                      unsigned long deadline)
>  {
>      struct ata_port *ap = link->ap;
> -    struct sata_fsl_port_priv *pp = ap->private_data;
>      struct sata_fsl_host_priv *host_priv = ap->host->private_data;
>      void __iomem *hcr_base = host_priv->hcr_base;
> -    int pmp = sata_srst_pmp(link);
>      u32 temp;
> -    struct ata_taskfile tf;
> -    u8 *cfis;
> -    u32 Serror;
>      int i = 0;
>      unsigned long start_jiffies;
> 
> -    DPRINTK("in xx_softreset\n");
> -
> -    if (pmp != SATA_PMP_CTRL_PORT)
> -        goto issue_srst;
> +    DPRINTK("in xx_hardreset\n");
> 
>  try_offline_again:
>      /*
> @@ -750,7 +733,7 @@ try_offline_again:
> 
>      if (temp & ONLINE) {
>          ata_port_printk(ap, KERN_ERR,
> -                "Softreset failed, not off-lined %d\n", i);
> +                "Hardreset failed, not off-lined %d\n", i);
> 
>          /*
>           * Try to offline controller atleast twice
> @@ -762,7 +745,7 @@ try_offline_again:
>              goto try_offline_again;
>      }
> 
> -    DPRINTK("softreset, controller off-lined\n");
> +    DPRINTK("hardreset, controller off-lined\n");
>      VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>      VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> 
> @@ -787,11 +770,11 @@ try_offline_again:
> 
>      if (!(temp & ONLINE)) {
>          ata_port_printk(ap, KERN_ERR,
> -                "Softreset failed, not on-lined\n");
> +                "Hardreset failed, not on-lined\n");
>          goto err;
>      }
> 
> -    DPRINTK("softreset, controller off-lined & on-lined\n");
> +    DPRINTK("hardreset, controller off-lined & on-lined\n");
>      VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>      VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> 
> @@ -807,7 +790,7 @@ try_offline_again:
>                  "No Device OR PHYRDY change,Hstatus = 0x%x\n",
>                  ioread32(hcr_base + HSTATUS));
>          *class = ATA_DEV_NONE;
> -        goto out;
> +        return 0;
>      }
> 
>      /*
> @@ -820,11 +803,44 @@ try_offline_again:
>      if ((temp & 0xFF) != 0x18) {
>          ata_port_printk(ap, KERN_WARNING, "No Signature Update\n");
>          *class = ATA_DEV_NONE;
> -        goto out;
> +        goto do_followup_srst;
>      } else {
>          ata_port_printk(ap, KERN_INFO,
>                  "Signature Update detected @ %d msecs\n",
>                  jiffies_to_msecs(jiffies - start_jiffies));
> +        *class = sata_fsl_dev_classify(ap);
> +        return 0;
> +    }
> +
> +do_followup_srst:
> +    /*
> +     * request libATA to perform follow-up softreset
> +     */
> +    return -EAGAIN;
> +
> +err:
> +    return -EIO;

    Why produce unneeded labels and goto's where you can just use return? :-O

MBR, Sergei

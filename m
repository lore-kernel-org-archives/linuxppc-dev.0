Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 242C72C03A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 06:08:57 +1100 (EST)
Received: by mail-pa0-f43.google.com with SMTP id hz1so1389889pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 12:08:54 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <E1VMmAk-0007iq-IU@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMmAk-0007iq-IU@rmk-PC.arm.linux.org.uk>
Date: Wed, 30 Oct 2013 20:08:54 +0100
Message-ID: <CAMuHMdWqAL6MN5VJrpAPC1fq3QtRWZ3UUMG3+6W5vEKSEm5N9g@mail.gmail.com>
Subject: Re: [PATCH 29/51] DMA-API: ata: pata_octeon_cf: convert to use
 dma_coerce_mask_and_coherent()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-nvme@lists.infradead.org,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 driverdevel <devel@driverdev.osuosl.org>, linux-samsung-soc@vger.kernel.org,
 scsi <linux-scsi@vger.kernel.org>, e1000-devel@lists.sourceforge.net,
 Linux-Next <linux-next@vger.kernel.org>, b43-dev@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 devicetree@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>,
 linux-tegra@vger.kernel.org,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>, linux-crypto@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org"
 <uclinux-dist-devel@blackfin.uclinux.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 19, 2013 at 11:54 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index c51bbb9..6231d43 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -1014,8 +1014,9 @@ static int octeon_cf_probe(struct platform_device *pdev)
>         }
>         cf_port->c0 = ap->ioaddr.ctl_addr;
>
> -       pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
> -       pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> +       rv = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +       if (rv)
> +               return ret;

return rv;

http://kisskb.ellerman.id.au/kisskb/buildresult/9959184/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

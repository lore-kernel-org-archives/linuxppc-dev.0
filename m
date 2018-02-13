Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmWj5yhZzF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:23:13 +1100 (AEDT)
Received: by mail-vk0-x243.google.com with SMTP id n132so11006733vke.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:23:13 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180213145120.GA14657@lst.de>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
 <20180213145120.GA14657@lst.de>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 13 Feb 2018 16:22:50 +0100
Message-ID: <CA+7wUsy80+5XJnbt5yXe-GYjD6V7Ea_wrAxu0Gwwh2kLs2fibQ@mail.gmail.com>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
To: Christoph Hellwig <hch@lst.de>
Cc: Meelis Roos <mroos@linux.ee>, iommu@lists.linux-foundation.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Tue, Feb 13, 2018 at 3:51 PM, Christoph Hellwig <hch@lst.de> wrote:
> Does this fix your warning?
>
> diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
> index 62f541f968f6..07074820a167 100644
> --- a/drivers/macintosh/macio_asic.c
> +++ b/drivers/macintosh/macio_asic.c
> @@ -375,6 +375,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
>         dev->ofdev.dev.of_node = np;
>         dev->ofdev.archdata.dma_mask = 0xffffffffUL;
>         dev->ofdev.dev.dma_mask = &dev->ofdev.archdata.dma_mask;
> +       dev->ofdev.dev.coherent_dma_mask = dev->ofdev.archdata.dma_mask;
>         dev->ofdev.dev.parent = parent;
>         dev->ofdev.dev.bus = &macio_bus_type;
>         dev->ofdev.dev.release = macio_release_dev;

Indeed, Thanks much! If needed:

Tested-by: Mathieu Malaterre <malat@debian.org>

System: Mac Mini G4

ref:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg128662.html

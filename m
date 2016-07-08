Return-Path: <m.mizuma@jp.fujitsu.com>
Received: from mgwym02.jp.fujitsu.com (mgwym02.jp.fujitsu.com [211.128.242.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm6Xr5PMPzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 18:07:24 +1000 (AEST)
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local
 (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
 by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D401AC0424
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:55:58 +0900 (JST)
Message-ID: <577F5C4A.8070004@jp.fujitsu.com>
Date: Fri, 8 Jul 2016 16:54:50 +0900
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
MIME-Version: 1.0
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>
CC: Jens Axboe <axboe@fb.com>, Jonathan Corbet <corbet@lwn.net>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Keith Busch
 <keith.busch@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Russell King
 <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] nvme: implement DMA_ATTR_NO_WARN
References: <1467895509-12194-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1467895509-12194-3-git-send-email-mauricfo@linux.vnet.ibm.com>
In-Reply-To: <1467895509-12194-3-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, 7 Jul 2016 09:45:08 -0300 Mauricio Faria De Oliveira wrote:
> Use the DMA_ATTR_NO_WARN attribute on dma_map_sg() calls of nvme driver.
>
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
> ---
> Changelog:
>   v2:
>    - address warnings from checkpatch.pl (line wrapping and typos)
>
>   drivers/nvme/host/pci.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d1a8259..a7ccad8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -18,6 +18,7 @@
>   #include <linux/blk-mq.h>
>   #include <linux/cpu.h>
>   #include <linux/delay.h>
> +#include <linux/dma-attrs.h>
>   #include <linux/errno.h>
>   #include <linux/fs.h>
>   #include <linux/genhd.h>
> @@ -65,6 +66,8 @@ MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
>
>   static struct workqueue_struct *nvme_workq;
>
> +static DEFINE_DMA_ATTRS(nvme_dma_attrs);
> +
>   struct nvme_dev;
>   struct nvme_queue;
>
> @@ -498,7 +501,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
>   		goto out;
>
>   	ret = BLK_MQ_RQ_QUEUE_BUSY;
> -	if (!dma_map_sg(dev->dev, iod->sg, iod->nents, dma_dir))
> +	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
> +				&nvme_dma_attrs))

This change is OK because the return value of nvme_map_data() is
BLK_MQ_RQ_QUEUE_BUSY, so the IO will be requeued.

>   		goto out;
>
>   	if (!nvme_setup_prps(dev, req, size))
> @@ -516,7 +520,8 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
>   		if (rq_data_dir(req))
>   			nvme_dif_remap(req, nvme_dif_prep);
>
> -		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
> +		if (!dma_map_sg_attrs(dev->dev, &iod->meta_sg, 1, dma_dir,
> +					&nvme_dma_attrs))

Here, I think the error messages should not be suppressed because
the return value of nvme_map_data() is BLK_MQ_RQ_QUEUE_ERROR, so
the IO returns as -EIO.

- Masayoshi Mizuma

>   			goto out_unmap;
>   	}
>
> @@ -2118,6 +2123,9 @@ static int __init nvme_init(void)
>   	result = pci_register_driver(&nvme_driver);
>   	if (result)
>   		destroy_workqueue(nvme_workq);
> +
> +	dma_set_attr(DMA_ATTR_NO_WARN, &nvme_dma_attrs);
> +
>   	return result;
>   }
>
>

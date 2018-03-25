Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408YK54pRmzF1tJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 10:24:57 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id 91-v6so3017064pld.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 16:24:57 -0700 (PDT)
Date: Mon, 26 Mar 2018 10:24:46 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linux-nvdimm@lists.01.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/6] libnvdimm: Add nd_region_destroy()
Message-ID: <20180326102446.60358bf6@gmail.com>
In-Reply-To: <20180323081209.31387-2-oohall@gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
 <20180323081209.31387-2-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 23 Mar 2018 19:12:05 +1100
Oliver O'Halloran <oohall@gmail.com> wrote:

> Currently there's no way to remove a region from and nvdimm_bus without
> tearing down the whole bus. This patch adds an API for removing a single
> region from the bus so that we can implement a sensible unbind operation
> for the of_nd_region platform driver.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  drivers/nvdimm/region_devs.c | 6 ++++++
>  include/linux/libnvdimm.h    | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 2f1d5771100e..76f46fd1fae0 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1039,6 +1039,12 @@ struct nd_region *nvdimm_blk_region_create(struct nvdimm_bus *nvdimm_bus,
>  }
>  EXPORT_SYMBOL_GPL(nvdimm_blk_region_create);
>  
> +void nd_region_destroy(struct nd_region *region)
> +{
> +	nd_device_unregister(&region->dev, ND_SYNC);

child_unregister seems to do the same thing, but is expected to be used
as a callback from device_for_each_child()

I'd suggest we merge the two and rename child_unregister and nd_region_unregister

Balbir Singh.

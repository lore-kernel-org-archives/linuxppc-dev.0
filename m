Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYHGD28WMzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 06:03:32 +1000 (AEST)
Date: Thu, 17 Aug 2017 13:16:42 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ashleydlai@gmail.com, peterhuewe@gmx.de, tpmdd@selhorst.net,
 jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH] tpm: vtpm: constify vio_device_id
Message-ID: <20170817191642.GF24735@obsidianresearch.com>
References: <a9ebcd668f5a7293c3805d0b6b21245f15c80212.1502989694.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9ebcd668f5a7293c3805d0b6b21245f15c80212.1502989694.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2017 at 11:04:21PM +0530, Arvind Yadav wrote:
> vio_device_id are not supposed to change at runtime. All functions
> working with vio_device_id provided by <asm/vio.h> work with
> const vio_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

>  drivers/char/tpm/tpm_ibmvtpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index f01d083..d2ce46b 100644
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -32,7 +32,7 @@
>  
>  static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
>  
> -static struct vio_device_id tpm_ibmvtpm_device_table[] = {
> +static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
>  	{ "IBM,vtpm", "IBM,vtpm"},
>  	{ "", "" }
>  };

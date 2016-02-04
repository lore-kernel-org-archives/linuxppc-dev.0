Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3252B1A02D0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 19:45:41 +1100 (AEDT)
Date: Thu, 4 Feb 2016 09:45:36 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: JBottomley@odin.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, hare@suse.de
Subject: Re: [PATCH 4/6] ibmvscsi: Use of_root to access OF device tree root
 node
Message-ID: <20160204084536.GX27969@c203.arch.suse.de>
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1454542114-1797-5-git-send-email-tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1454542114-1797-5-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 03, 2016 at 05:28:32PM -0600, Tyrel Datwyler wrote:
> The root node of the OF device tree is exported as of_root. No need
> to look up the root by path name. Instead just get a reference
> directly via of_root.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvscsi.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index 7e51615..47cfe33 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -248,25 +248,23 @@ static void ibmvscsi_task(void *data)
>  
>  static void gather_partition_info(void)
>  {
> -	struct device_node *rootdn;
> -
>  	const char *ppartition_name;
>  	const __be32 *p_number_ptr;
>  
>  	/* Retrieve information about this partition */
> -	rootdn = of_find_node_by_path("/");
> -	if (!rootdn) {
> +	if (!of_root)
>  		return;
> -	}
>  
> -	ppartition_name = of_get_property(rootdn, "ibm,partition-name", NULL);
> +	of_node_get(of_root);
> +
> +	ppartition_name = of_get_property(of_root, "ibm,partition-name", NULL);
>  	if (ppartition_name)
>  		strncpy(partition_name, ppartition_name,
>  				sizeof(partition_name));
> -	p_number_ptr = of_get_property(rootdn, "ibm,partition-no", NULL);
> +	p_number_ptr = of_get_property(of_root, "ibm,partition-no", NULL);
>  	if (p_number_ptr)
>  		partition_number = of_read_number(p_number_ptr, 1);
> -	of_node_put(rootdn);
> +	of_node_put(of_root);
>  }
>  
>  static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

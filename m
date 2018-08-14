Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qJ0P1FSCzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 13:26:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V2] ocxl: Fix access to the AFU Descriptor Data
In-Reply-To: <1534169362-9394-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1534169362-9394-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Tue, 14 Aug 2018 13:26:06 +1000
Message-ID: <87in4dljch.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

The patch looks fine, just a nit about the change log:

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
> The AFU Information DVSEC capability is a means to extract common,
> general information about all of the AFUs associated with a Function
> independent of the specific functionality that each AFU provides.
>
> This patch fixes the access to the AFU Descriptor Data indexed by the
> AFU Info Index field.

> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
> Cc: stable <stable@vger.kernel.org>     # 4.16
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

When fixing a bug it's always good to describe how the bug manifests.
ie. in this case we are clearly writing to the wrong location in config
space, but what is the consequence of that? Does it kill the device, or
just fails to initialise something correctly? How could I tell if I'm
hitting this bug currently? How would I tell if the fix is applied
correctly?

cheers

> ---
> Changelog[v2]
>  - Rebase to latest upstream.
>  - Use pci_write_config_byte instead of pci_write_config_word
> ---
>  drivers/misc/ocxl/config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 2e30de9..57a6bb1 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -280,7 +280,9 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
>  	u32 val;
>  	int rc, templ_major, templ_minor, len;
>  
> -	pci_write_config_word(dev, fn->dvsec_afu_info_pos, afu_idx);
> +	pci_write_config_byte(dev,
> +			fn->dvsec_afu_info_pos + OCXL_DVSEC_AFU_INFO_AFU_IDX,
> +			afu_idx);
>  	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_VERSION, &val);
>  	if (rc)
>  		return rc;
> -- 
> 2.7.4

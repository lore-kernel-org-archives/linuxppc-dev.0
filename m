Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC3991A0175
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 19:38:38 +1100 (AEDT)
Date: Thu, 4 Feb 2016 09:38:32 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: JBottomley@odin.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, hare@suse.de
Subject: Re: [PATCH 1/6] ibmvscsi: Correct values for several
 viosrp_crq_format enums
Message-ID: <20160204083832.GU27969@c203.arch.suse.de>
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1454542114-1797-2-git-send-email-tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1454542114-1797-2-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 03, 2016 at 05:28:29PM -0600, Tyrel Datwyler wrote:
> The enum values for VIOSRP_LINUX_FORMAT and VIOSRP_INLINE_FORMAT are
> off by one. They are currently defined as 0x06 and 0x07 respetively.
> These values are defined in PAPR correctly as 0x05 and 0x06. This
> inconsistency has gone unnoticed as neither enum is currently used.
> The possible future support of PING messages between the VIOS and
> client adapter relies on VIOSRP_INLINE_FORMAT crq messages.
> Corrected these enum values to match PAPR definitions.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  drivers/scsi/ibmvscsi/viosrp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
> index 1162430..d1044e9 100644
> --- a/drivers/scsi/ibmvscsi/viosrp.h
> +++ b/drivers/scsi/ibmvscsi/viosrp.h
> @@ -56,8 +56,8 @@ enum viosrp_crq_formats {
>  	VIOSRP_MAD_FORMAT = 0x02,
>  	VIOSRP_OS400_FORMAT = 0x03,
>  	VIOSRP_AIX_FORMAT = 0x04,
> -	VIOSRP_LINUX_FORMAT = 0x06,
> -	VIOSRP_INLINE_FORMAT = 0x07
> +	VIOSRP_LINUX_FORMAT = 0x05,
> +	VIOSRP_INLINE_FORMAT = 0x06
>  };
>  
>  enum viosrp_crq_status {
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

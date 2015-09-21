Return-Path: <brking@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 309C81A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:02:46 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 18:02:44 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 54D38C90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 17:53:46 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LM2gjf54788180
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 22:02:42 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LM2eAV001781
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 18:02:42 -0400
Subject: Re: [PATCH v2 18/30] cxlflash: Remove dual port online dependency
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439038-49894-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Brian King <brking@linux.vnet.ibm.com>
Message-ID: <56007E7E.3090804@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2015 17:02:38 -0500
MIME-Version: 1.0
In-Reply-To: <1442439038-49894-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2015 04:30 PM, Matthew R. Ochs wrote:
> At present, both ports must be online for the device to
> configure properly. Remove this dependency and the unnecessary
> internal LUN override logic as well. Additionally, as a refactoring
> measure, change the return code variable name to match that used
> throughout the driver.

Doesn't this also change the behavior to no longer fail init_afu even
if BOTH ports fail to go offline in the reconfig case. Is that OK?

-Brian

> 
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index 74eb742..e2cc410 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -1031,7 +1031,7 @@ static int wait_port_offline(u64 *fc_regs, u32 delay_us, u32 nretry)
>   */
>  static int afu_set_wwpn(struct afu *afu, int port, u64 *fc_regs, u64 wwpn)
>  {
> -	int ret = 0;
> +	int rc = 0;
> 
>  	set_port_offline(fc_regs);
> 
> @@ -1039,33 +1039,26 @@ static int afu_set_wwpn(struct afu *afu, int port, u64 *fc_regs, u64 wwpn)
>  			       FC_PORT_STATUS_RETRY_CNT)) {
>  		pr_debug("%s: wait on port %d to go offline timed out\n",
>  			 __func__, port);
> -		ret = -1; /* but continue on to leave the port back online */
> +		rc = -1; /* but continue on to leave the port back online */
>  	}
> 
> -	if (ret == 0)
> +	if (rc == 0)
>  		writeq_be(wwpn, &fc_regs[FC_PNAME / 8]);
> 
> +	/* Always return success after programming WWPN */
> +	rc = 0;
> +
>  	set_port_online(fc_regs);
> 
>  	if (!wait_port_online(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
>  			      FC_PORT_STATUS_RETRY_CNT)) {
>  		pr_debug("%s: wait on port %d to go online timed out\n",
>  			 __func__, port);
> -		ret = -1;
> -
> -		/*
> -		 * Override for internal lun!!!
> -		 */
> -		if (afu->internal_lun) {
> -			pr_debug("%s: Overriding port %d online timeout!!!\n",
> -				 __func__, port);
> -			ret = 0;
> -		}
>  	}
> 
> -	pr_debug("%s: returning rc=%d\n", __func__, ret);
> +	pr_debug("%s: returning rc=%d\n", __func__, rc);
> 
> -	return ret;
> +	return rc;
>  }
> 
>  /**
> 


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

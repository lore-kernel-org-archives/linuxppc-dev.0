Return-Path: <brking@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAAA11A03D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 11:21:31 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 17 Sep 2015 21:21:29 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2AC976E8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 21:13:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8I1LQBq63635502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 01:21:26 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8I1LPCG030984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 21:21:26 -0400
Subject: Re: [PATCH v2 03/30] cxlflash: Fix read capacity timeout
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442438806-49198-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Manoj Kumar <kumarmn@us.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Brian King <brking@linux.vnet.ibm.com>
Message-ID: <55FB670F.6060208@linux.vnet.ibm.com>
Date: Thu, 17 Sep 2015 20:21:19 -0500
MIME-Version: 1.0
In-Reply-To: <1442438806-49198-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2015 04:26 PM, Matthew R. Ochs wrote:
> @@ -296,7 +296,7 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
>  	int rc = 0;
>  	int result = 0;
>  	int retry_cnt = 0;
> -	u32 tout = (MC_DISCOVERY_TIMEOUT * HZ);
> +	u32 to = (CMD_TIMEOUT * HZ);
> 
>  retry:
>  	cmd_buf = kzalloc(CMD_BUFSIZE, GFP_KERNEL);
> @@ -315,8 +315,7 @@ retry:
>  		retry_cnt ? "re" : "", scsi_cmd[0]);
> 
>  	result = scsi_execute(sdev, scsi_cmd, DMA_FROM_DEVICE, cmd_buf,
> -			      CMD_BUFSIZE, sense_buf, tout, CMD_RETRIES,
> -			      0, NULL);
> +			      CMD_BUFSIZE, sense_buf, to, CMD_RETRIES, 0, NULL);
> 
>  	if (driver_byte(result) == DRIVER_SENSE) {
>  		result &= ~(0xFF<<24); /* DRIVER_SENSE is not an error */
> @@ -1376,8 +1375,8 @@ out_attach:
>  	attach->block_size = gli->blk_len;
>  	attach->mmio_size = sizeof(afu->afu_map->hosts[0].harea);
>  	attach->last_lba = gli->max_lba;
> -	attach->max_xfer = (sdev->host->max_sectors * MAX_SECTOR_UNIT) /
> -		gli->blk_len;
> +	attach->max_xfer = (sdev->host->max_sectors * MAX_SECTOR_UNIT);
> +	attach->max_xfer /= gli->blk_len;

This change and the one above are not really part of the patch. Not a big deal, but
in future would be good to either call out the fact that there are a couple of unrelated
formatting changes, or keep them out and stick them in a separate cleanup patch.

Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD4141A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 21:36:37 +1000 (AEST)
Subject: Re: [PATCH v2 03/30] cxlflash: Fix read capacity timeout
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442438806-49198-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Manoj Kumar <kumarmn@us.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <55FFEBC0.5020507@redhat.com>
Date: Mon, 21 Sep 2015 13:36:32 +0200
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

On 16.9.2015 23:26, Matthew R. Ochs wrote:
> From: Manoj Kumar <kumarmn@us.ibm.com>
>
> The timeout value for read capacity is too small. Certain devices
> may take longer to respond and thus the command may prematurely
> timeout. Additionally the literal used for the timeout is stale.
>
> Update the timeout to 30 seconds (matches the value used in sd.c)
> and rework the timeout literal to a more appropriate description.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Suggested-by: Brian King <brking@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/superpipe.c | 9 ++++-----
>  drivers/scsi/cxlflash/superpipe.h | 2 +-
>  drivers/scsi/cxlflash/vlun.c      | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
> index 7df985d..fa513ba 100644
> --- a/drivers/scsi/cxlflash/superpipe.c
> +++ b/drivers/scsi/cxlflash/superpipe.c
> @@ -296,7 +296,7 @@ static int read_cap16(struct scsi_device *sdev, struct llun_info *lli)
>  	int rc = 0;
>  	int result = 0;
>  	int retry_cnt = 0;
> -	u32 tout = (MC_DISCOVERY_TIMEOUT * HZ);
> +	u32 to = (CMD_TIMEOUT * HZ);

In V3 please remove the parenthesis here^ 

>  
>  retry:
>  	cmd_buf = kzalloc(CMD_BUFSIZE, GFP_KERNEL);
...

> @@ -1376,8 +1375,8 @@ out_attach:
>  	attach->block_size = gli->blk_len;
>  	attach->mmio_size = sizeof(afu->afu_map->hosts[0].harea);
>  	attach->last_lba = gli->max_lba;
> -	attach->max_xfer = (sdev->host->max_sectors * MAX_SECTOR_UNIT) /
> -		gli->blk_len;
> +	attach->max_xfer = (sdev->host->max_sectors * MAX_SECTOR_UNIT);

and here^ too.

Thanks,
Tomas

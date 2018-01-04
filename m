Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBygX3PGmzDqpX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 17:33:59 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w046Wda9068307
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jan 2018 01:33:57 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f9dd9b9ak-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 01:33:56 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 4 Jan 2018 06:33:54 -0000
Subject: Re: [PATCH 1/6] cxlflash: Reset command ioasc
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1515020002-43551-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1515020042-43590-1-git-send-email-ukrishn@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 4 Jan 2018 17:33:48 +1100
MIME-Version: 1.0
In-Reply-To: <1515020042-43590-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <be8c1d08-f78a-a7f0-d912-e638646db80e@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/01/18 09:54, Uma Krishnan wrote:
> In the event of a command failure, cxlflash returns the failure to the
> upper layers to process. After processing the error, when the command is
> queued again, the private command structure will not be zeroed and the
> ioasc could be stale. Per the SISLite specification, the AFU only sets the
> ioasc in the presence of a failure. Thus, even though the original command
> succeeds the second time, the command is considered a failure due to stale
> ioasc. This cycle repeats indefinitely and can cause a hang or IO failure.
> 
> To fix the issue, clear the ioasc before queuing any command.
> 
> Fixes: 479ad8e9d48c ("scsi: cxlflash: Remove zeroing of private command
> data")
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

Should this go to stable?


> ---
>   drivers/scsi/cxlflash/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index 38b3a9c..48d3663 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -620,6 +620,7 @@ static int cxlflash_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scp)
>   	cmd->parent = afu;
>   	cmd->hwq_index = hwq_index;
> 
> +	cmd->sa.ioasc = 0;
>   	cmd->rcb.ctx_id = hwq->ctx_hndl;
>   	cmd->rcb.msi = SISL_MSI_RRQ_UPDATED;
>   	cmd->rcb.port_sel = CHAN2PORTMASK(scp->device->channel);
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

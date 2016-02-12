Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D5D91A0045
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 09:06:03 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 15:06:01 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3104B3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 15:06:00 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CM60N128704898
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 15:06:00 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CM5xNX003419
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 15:05:59 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v2 3/7] ibmvscsi: Replace magic values in
 set_adpater_info() with defines
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, jthumshirn@suse.de
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56BE574C.1090603@linux.vnet.ibm.com>
Date: Fri, 12 Feb 2016 16:06:04 -0600
MIME-Version: 1.0
In-Reply-To: <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar

On 2/10/2016 7:32 PM, Tyrel Datwyler wrote:
> Add defines for mad version and mad os_type, and replace the magic
> numbers in set_adapter_info() accordingly.
>
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>   drivers/scsi/ibmvscsi/ibmvscsi.c | 8 ++++----
>   drivers/scsi/ibmvscsi/viosrp.h   | 3 +++
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index c888ea1..4b09a9b 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -283,8 +283,8 @@ static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
>   	hostdata->madapter_info.partition_number =
>   					cpu_to_be32(partition_number);
>
> -	hostdata->madapter_info.mad_version = cpu_to_be32(1);
> -	hostdata->madapter_info.os_type = cpu_to_be32(2);
> +	hostdata->madapter_info.mad_version = cpu_to_be32(SRP_MAD_VERSION_1);
> +	hostdata->madapter_info.os_type = cpu_to_be32(SRP_MAD_OS_LINUX);
>   }
>
>   /**
> @@ -1398,7 +1398,7 @@ static void adapter_info_rsp(struct srp_event_struct *evt_struct)
>   			hostdata->host->max_sectors =
>   				be32_to_cpu(hostdata->madapter_info.port_max_txu[0]) >> 9;
>   		
> -		if (be32_to_cpu(hostdata->madapter_info.os_type) == 3 &&
> +		if (be32_to_cpu(hostdata->madapter_info.os_type) == SRP_MAD_OS_AIX &&
>   		    strcmp(hostdata->madapter_info.srp_version, "1.6a") <= 0) {
>   			dev_err(hostdata->dev, "host (Ver. %s) doesn't support large transfers\n",
>   				hostdata->madapter_info.srp_version);
> @@ -1407,7 +1407,7 @@ static void adapter_info_rsp(struct srp_event_struct *evt_struct)
>   			hostdata->host->sg_tablesize = MAX_INDIRECT_BUFS;
>   		}
>
> -		if (be32_to_cpu(hostdata->madapter_info.os_type) == 3) {
> +		if (be32_to_cpu(hostdata->madapter_info.os_type) == SRP_MAD_OS_AIX) {
>   			enable_fast_fail(hostdata);
>   			return;
>   		}
> diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
> index 3d20851..d0f689b 100644
> --- a/drivers/scsi/ibmvscsi/viosrp.h
> +++ b/drivers/scsi/ibmvscsi/viosrp.h
> @@ -221,7 +221,10 @@ struct mad_adapter_info_data {
>   	char srp_version[8];
>   	char partition_name[96];
>   	__be32 partition_number;
> +#define SRP_MAD_VERSION_1 1
>   	__be32 mad_version;
> +#define SRP_MAD_OS_LINUX 2
> +#define SRP_MAD_OS_AIX 3
>   	__be32 os_type;
>   	__be32 port_max_txu[8];	/* per-port maximum transfer */
>   };
>

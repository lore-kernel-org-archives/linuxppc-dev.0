Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXXd451PdzDr07
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 08:02:48 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w11L1OGQ066984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Feb 2018 16:02:45 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fv85qp1ra-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Feb 2018 16:02:44 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 1 Feb 2018 14:02:44 -0700
Subject: Re: [PATCH, net] ibmvnic: fix firmware version when no firmware level
 has been provided by the VIOS server
To: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
 netdev@vger.kernel.org
Cc: tlfalcon@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
References: <20180201180430.16950-1-desnesn@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 13:02:38 -0800
MIME-Version: 1.0
In-Reply-To: <20180201180430.16950-1-desnesn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <e82c4a78-37b3-afc5-6250-8ce8bb2ec5ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/01/2018 10:04 AM, Desnes Augusto Nunes do Rosario wrote:
> Older versions of VIOS servers do not send the firmware level in the VPD
> buffer for the ibmvnic driver. Thus, not only the current message is mis-
> leading but the firmware version in the ethtool will be NULL. Therefore,
> this patch fixes the firmware string and its warning.
> 
> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvnic driver")
> 
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index b65f5f3ac034..2b3e71b63a7a 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -3290,7 +3290,11 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
>  	 */
>  	substr = strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
>  	if (!substr) {
> -		dev_info(dev, "No FW level provided by VPD\n");
> +		dev_info(dev, "Warning - No FW level has been provided in the VPD buffer by the VIOS Server\n");
> +		ptr = strncpy((char *)adapter->fw_version, "N/A",

Is "N/A" the right thing to report? Would something like "Unknown" or "Unreported" be better?

> +			      3 * sizeof(char));
> +		if (!ptr)
> +			dev_err(dev, "Failed to inform that firmware version is unavailable to the adapter\n");

The sentence structure here seems awkward. I would probably just get rid of this error and this one later in the function.

	dev_err(dev, "Failed to isolate FW level string\n");

Instead just check and report if adapter->fw_version == NULL in the complete: label section.

-Tyrel

>  		goto complete;
>  	}
> 

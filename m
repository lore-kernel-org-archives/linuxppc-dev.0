Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B756C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 13:38:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BCA2148E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 13:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BCA2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p9gV07WSzDqJc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 00:38:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p9bd1GNFzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 00:34:53 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SDTnxG019002
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 08:34:51 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qa219j3c4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 08:34:50 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 28 Jan 2019 13:34:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 13:34:47 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0SDYk6R60817652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Jan 2019 13:34:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 110EA11C04A;
 Mon, 28 Jan 2019 13:34:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1B8411C050;
 Mon, 28 Jan 2019 13:34:45 +0000 (GMT)
Received: from [9.145.43.137] (unknown [9.145.43.137])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 13:34:45 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] powerpc/powernv: Add support for CXL mode switch
 that need PHB reset
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20190125051131.29351-1-vaibhav@linux.ibm.com>
 <20190125051131.29351-2-vaibhav@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 28 Jan 2019 14:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125051131.29351-2-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012813-4275-0000-0000-00000305E31D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012813-4276-0000-0000-00003813E6B9
Message-Id: <823c21d9-b408-6663-868a-fd87609647fe@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280105
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/01/2019 à 06:11, Vaibhav Jain a écrit :
> Recent updates to OPAL [1] have provided support for new CXL modes on
> PHB that need to force a cold reset on the bridge (CRESET). However
> PHB CRESET is a multi step process and cannot be completed
> synchronously as expected by current kernel implementation that issues
> opal call opal_pci_set_phb_cxl_mode().
> 
> Hence this patch updates pnv_phb_to_cxl_mode() to implement a polling
> loop that handles specific error codes (OPAL_BUSY) returned from
> opal_pci_set_phb_cxl_mode() and drive the OPAL pci-state machine, if the
> requested CXL mode needs a CRESET.
> 
> The patch also updates pnv_phb_to_cxl_mode() to convert and return
> OPAL error codes into kernel error codes. This removes a previous
> issue where callers to this function would have to include
> 'opal-api.h' to check for specific OPAL error codes.
> 
> References:
> [1]: https://lists.ozlabs.org/pipermail/skiboot/2019-January/013063.html
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-cxl.c | 71 +++++++++++++++++++++---
>   1 file changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
> index 1b18111453d7..d33d662c6212 100644
> --- a/arch/powerpc/platforms/powernv/pci-cxl.c
> +++ b/arch/powerpc/platforms/powernv/pci-cxl.c
> @@ -10,6 +10,7 @@
>   #include <linux/module.h>
>   #include <asm/pnv-pci.h>
>   #include <asm/opal.h>
> +#include <linux/delay.h>
>   
>   #include "pci.h"
>   
> @@ -18,21 +19,75 @@ int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
>   	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>   	struct pnv_phb *phb = hose->private_data;
>   	struct pnv_ioda_pe *pe;
> +	unsigned long starttime, endtime;
>   	int rc;
>   
>   	pe = pnv_ioda_get_pe(dev);
>   	if (!pe)
> -		return -ENODEV;
> +		return -ENOENT;
> +
> +	pe_info(pe, "Switching PHB to CXL mode=%d\n", mode);
> +
> +	/*
> +	 * Use a 15 second timeout for mode switch. Value arrived after
> +	 * limited testing and may need more tweaking.
> +	 */
> +	starttime = jiffies;
> +	endtime = starttime + HZ * 15;
> +
> +	do {
> +		rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode,
> +					       pe->pe_number);
> +
> +		/* Wait until mode transistion done */
> +		if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
> +			break;
> +
> +		/* Check if we timedout */
> +		if (time_after(jiffies, endtime)) {
> +			rc = OPAL_TIMEOUT;
> +			break;
> +		}
>   
> -	pe_info(pe, "Switching PHB to CXL\n");
> +		/* Opal Busy with mode switch. Run pci state-machine */
> +		rc = opal_pci_poll(phb->opal_id);
> +		if (rc >= 0) {
> +			/* wait for some time */
> +			if (rc > 0)
> +				msleep(rc);
> +			opal_poll_events(NULL);

Why is a call to opal_poll_events() needed?

   Fred


> +			rc = OPAL_BUSY;
> +			/* Continue with the mode switch */
> +		}
> +	} while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT);
> +
> +	pe_level_printk(pe, KERN_DEBUG, "CXL mode switch finished in %u-msecs.",
> +			jiffies_to_msecs(jiffies - starttime));
>   
> -	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
> -	if (rc == OPAL_UNSUPPORTED)
> -		dev_err(&dev->dev, "Required cxl mode not supported by firmware - update skiboot\n");
> -	else if (rc)
> -		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
> +	/* Check OPAL errors and convert them to kernel error codes */
> +	switch (rc) {
> +	case OPAL_SUCCESS:
> +		return 0;
>   
> -	return rc;
> +	case OPAL_PARAMETER:
> +		dev_err(&dev->dev, "CXL not supported on this PHB\n");
> +		return -ENOENT;
> +
> +	case OPAL_UNSUPPORTED:
> +		dev_err(&dev->dev,
> +			"Required cxl mode not supported by firmware"
> +			" - update skiboot\n");
> +		return -ENODEV;
> +
> +	case OPAL_TIMEOUT:
> +		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode Timedout\n");
> +		return -ETIME;
> +
> +	default:
> +		dev_err(&dev->dev,
> +			"opal_pci_set_phb_cxl_mode failed: %i\n", rc);
> +		return -EIO;
> +	};
>   }
>   EXPORT_SYMBOL(pnv_phb_to_cxl_mode);
>   
> 


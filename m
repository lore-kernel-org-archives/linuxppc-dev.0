Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EBEC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0266620811
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0266620811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pFc81P5tzDqLD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 03:35:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=clombard@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pDyy6TVjzDqLg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 03:06:50 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SG5EwB183225
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 11:06:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qa39gwt4x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 11:06:47 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 28 Jan 2019 16:06:46 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 16:06:44 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0SG6g5A53936356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Jan 2019 16:06:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BC324C05A;
 Mon, 28 Jan 2019 16:06:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4CA74C04A;
 Mon, 28 Jan 2019 16:06:41 +0000 (GMT)
Received: from [9.134.167.118] (unknown [9.134.167.118])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 16:06:41 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] powerpc/powernv: Add support for CXL mode switch
 that need PHB reset
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.ibm.com>
References: <20190125051131.29351-1-vaibhav@linux.ibm.com>
 <20190125051131.29351-2-vaibhav@linux.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 28 Jan 2019 17:06:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125051131.29351-2-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012816-0008-0000-0000-000002B70C8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012816-0009-0000-0000-000022234BFB
Message-Id: <b6f73f05-bdb3-9a4f-bd10-295a3b988643@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280121
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

On 25/01/2019 06:11, Vaibhav Jain wrote:
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

The return code of pnv_phb_to_cxl_mode() is also returned by an api in 
the cxllib librarie. So, hoping that nobody test the value !!

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


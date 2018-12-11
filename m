Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB5C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:22:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D9E205C9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D9E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DLH16DpgzDqc6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:22:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DLDk2b9SzDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 11:20:06 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBB0IPNd116997
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 19:20:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9x6bahtb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 19:20:03 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 11 Dec 2018 00:20:00 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 11 Dec 2018 00:19:58 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBB0Jv5s54919384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 00:19:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BAE4AE058;
 Tue, 11 Dec 2018 00:19:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB033AE051;
 Tue, 11 Dec 2018 00:19:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 11 Dec 2018 00:19:56 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6296CA0173;
 Tue, 11 Dec 2018 11:19:55 +1100 (AEDT)
Subject: Re: [PATCH] ocxl: Clarify error path in setup_xsl_irq()
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
References: <154445509294.867383.14905585855902294361.stgit@bahia.lan>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 11 Dec 2018 11:19:55 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <154445509294.867383.14905585855902294361.stgit@bahia.lan>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 18121100-0012-0000-0000-000002D74393
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121100-0013-0000-0000-0000210CB82D
Message-Id: <4e803758-08af-d774-9e50-1c64fb8545ff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=839 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110002
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
Cc: stable@vger.kernel.org, Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/12/18 2:18 am, Greg Kurz wrote:
> Implementing rollback with goto and labels is a common practice that
> leads to prettier and more maintainable code. FWIW, this design pattern
> is already being used in alloc_link() a few lines below in this file.
> 
> Do the same in setup_xsl_irq().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

This is good, thanks.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/link.c |   23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index eed92055184d..659977a17405 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -273,9 +273,9 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
>   	spa->irq_name = kasprintf(GFP_KERNEL, "ocxl-xsl-%x-%x-%x",
>   				link->domain, link->bus, link->dev);
>   	if (!spa->irq_name) {
> -		unmap_irq_registers(spa);
>   		dev_err(&dev->dev, "Can't allocate name for xsl interrupt\n");
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto err_xsl;
>   	}
>   	/*
>   	 * At some point, we'll need to look into allowing a higher
> @@ -283,11 +283,10 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
>   	 */
>   	spa->virq = irq_create_mapping(NULL, hwirq);
>   	if (!spa->virq) {
> -		kfree(spa->irq_name);
> -		unmap_irq_registers(spa);
>   		dev_err(&dev->dev,
>   			"irq_create_mapping failed for translation interrupt\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto err_name;
>   	}
>   
>   	dev_dbg(&dev->dev, "hwirq %d mapped to virq %d\n", hwirq, spa->virq);
> @@ -295,15 +294,21 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
>   	rc = request_irq(spa->virq, xsl_fault_handler, 0, spa->irq_name,
>   			link);
>   	if (rc) {
> -		irq_dispose_mapping(spa->virq);
> -		kfree(spa->irq_name);
> -		unmap_irq_registers(spa);
>   		dev_err(&dev->dev,
>   			"request_irq failed for translation interrupt: %d\n",
>   			rc);
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto err_mapping;
>   	}
>   	return 0;
> +
> +err_mapping:
> +	irq_dispose_mapping(spa->virq);
> +err_name:
> +	kfree(spa->irq_name);
> +err_xsl:
> +	unmap_irq_registers(spa);
> +	return rc;
>   }
>   
>   static void release_xsl_irq(struct link *link)
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited


Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB95C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 17:20:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7B22064D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 17:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7B22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D8x30bWFzDrB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 04:20:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D8t14WrBzDqcq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 04:18:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBAH9dbS079979
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 12:18:15 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9smehgt2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 12:18:14 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 10 Dec 2018 17:18:12 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 17:18:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBAHI94A6881586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 17:18:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6D2742042;
 Mon, 10 Dec 2018 17:18:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EBFD42049;
 Mon, 10 Dec 2018 17:18:08 +0000 (GMT)
Received: from [9.145.161.130] (unknown [9.145.161.130])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 10 Dec 2018 17:18:08 +0000 (GMT)
Subject: Re: [PATCH] ocxl: Clarify error path in setup_xsl_irq()
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
References: <154445509294.867383.14905585855902294361.stgit@bahia.lan>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 10 Dec 2018 18:18:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154445509294.867383.14905585855902294361.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121017-0008-0000-0000-0000029F6B17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121017-0009-0000-0000-00002209E08B
Message-Id: <a1efab95-6256-1af3-e159-3f1fae59883d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100154
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
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/12/2018 à 16:18, Greg Kurz a écrit :
> Implementing rollback with goto and labels is a common practice that
> leads to prettier and more maintainable code. FWIW, this design pattern
> is already being used in alloc_link() a few lines below in this file.
> 
> Do the same in setup_xsl_irq().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

This looks good. I don't have a fixed limit when I start using the "goto 
undo" pattern, so it's likely inconsistent in other places as well. 
Truth is I'm not too fussed either way.

Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>




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


Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17004C282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 21:12:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAA32184C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 21:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAA32184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mWvN5v6RzDqQy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 08:12:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mWsj3RJLzDqQG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 08:11:21 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0PKrXup175733
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 16:11:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q86v485xr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 16:11:18 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Fri, 25 Jan 2019 21:11:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 25 Jan 2019 21:11:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0PLBEUF4850158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Jan 2019 21:11:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 340A6A4059;
 Fri, 25 Jan 2019 21:11:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5B29A4053;
 Fri, 25 Jan 2019 21:11:12 +0000 (GMT)
Received: from [9.85.169.234] (unknown [9.85.169.234])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 25 Jan 2019 21:11:12 +0000 (GMT)
Subject: Re: [PATCH] cxl: Wrap iterations over afu slices inside
 'afu_list_lock'
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20190125044052.32059-1-vaibhav@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 25 Jan 2019 15:11:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125044052.32059-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012521-0020-0000-0000-0000030B86C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012521-0021-0000-0000-0000215CCE2D
Message-Id: <4a90ada0-99dc-df32-7331-ffb3191ebf40@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-25_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250161
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



> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index c79ba1c699ad..28c28bceb063 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c

> @@ -1932,14 +1935,20 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   	 *     * In slot_reset, free the old resources and allocate new ones.
>   	 *     * In resume, clear the flag to allow things to start.
>   	 */
> +
> +	/* Make sure no one else changes the afu list */
> +	spin_lock(&adapter->afu_list_lock);
> +
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
>   
>   		afu_result = cxl_vphb_error_detected(afu, state);
>   
> -		cxl_context_detach_all(afu);
> -		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> -		pci_deconfigure_afu(afu);
> +		if (afu != NULL) {
> +			cxl_context_detach_all(afu);
> +			cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> +			pci_deconfigure_afu(afu);
> +		}

I can see you're also checking if cxl_vphb_error_detected() is called 
with a NULL afu from within the function, but why not move the call to 
cxl_vphb_error_detected() within that "if (afu != NULL)...  " statement? 
Otherwise, it looks suspicious when reading the code.


> @@ -2051,10 +2067,11 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>   	 * This is not the place to be checking if everything came back up
>   	 * properly, because there's no return value: do that in slot_reset.
>   	 */
> +	spin_lock(&adapter->afu_list_lock);
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
>   
> -		if (afu->phb == NULL)
> +		if (afu || afu->phb == NULL)
>   			continue;


if (afu == NULL ...

   Fred

